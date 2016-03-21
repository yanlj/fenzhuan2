//
//  TFCache.m
//  tfcommon
//
//  Created by yin shen on 8/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TFCache.h"
#import "tfthreadpool.h"
#include <sys/stat.h>
#include <dirent.h>

@interface TFCache ()
- (void)_cacheObjectToDisk:(id)aObj key:(NSString *)aKey;
- (void)_setCacheMapObject:(id)aObj key:(NSString *)aKey;
@end

@implementation TFCache

//static NSString *documentsPath();

//static NSString *tmpPath();

#define TFMEMCACHE_MAX_COUNT 8
static TFCache *kCache = nil;

static tfthreadpool_t *cachethreadpool = NULL;

+ (TFCache *)shared
{
    @synchronized(self) {
        if (nil == kCache) {
            kCache = [[TFCache alloc] init];
        }
    }
    return kCache;
}

+(void)initialize{
    if (self == [TFCache self]) {
        if (NULL == cachethreadpool) {
            cachethreadpool = (tfthreadpool_t *)malloc(sizeof(tfthreadpool_t));
            cachethreadpool->name = "pink_io";
            cachethreadpool->threads = NULL;
            tfthreadpool_init(cachethreadpool, 2);
        }
    }
}

+ (void)destoryNetPool
{
    tfthreadpool_free(cachethreadpool);
}

- (void)dealloc
{
    [self cleanDisk];
    
    
    
    [_cacheMap release], _cacheMap = nil;
    [_dayCacheMap release], _dayCacheMap = nil;
    [_funcTimeMap release], _funcTimeMap = nil;
    [_keys release], _keys = nil;
    [_writingList release], _writingList = nil;
    
    self.diskPath = nil;
    self.mediaPath = nil;
    
    [super dealloc];
}

- (id)init
{
    self = [super init];

    if (self) {
        _cacheMap = [[NSMutableDictionary alloc] initWithCapacity:TFMEMCACHE_MAX_COUNT];
        _dayCacheMap = [[NSMutableDictionary alloc] init];
        _funcTimeMap = [[NSMutableDictionary alloc] init];
        _keys = [[NSMutableArray alloc] init];
        _writingList = [[NSMutableDictionary alloc] init];

        [self initDisk];
    }

    return self;
}

- (void)cacheMediaObject:(id)anObj key:(NSString *)aKey{
    if ((nil == anObj) || (nil == aKey) || [aKey isEqualToString:@""]) {
        return;
    }
    
    NSString *tmpKey = [TFCache getKey:aKey];
    
    if ([_writingList objectForKey:tmpKey]
        ||[self cachedMediaObjectToDiskForKey:tmpKey]) {
        return;
    }
    
    [self _cacheMediaObjectToDisk:anObj key:tmpKey];
}

- (void)synCacheMediaObject:(id)anObj key:(NSString *)aKey{
    
    NSString *path = [TFCache getKey:aKey];
    
    if ([_writingList objectForKey:path]
        ||[self cachedMediaObjectToDiskForKey:path]) {
        return;
    }
    
    NSString *cachePath = [self.mediaPath stringByAppendingPathComponent:path];
    
    [anObj   writeToFile :cachePath
            atomically  :NO];
}

- (void)cacheObject:(id)aObj key:(NSString *)aKey where:(E_TFCacheWhere)aPlace
{
    if ((nil == aObj) || (nil == aKey) || [aKey isEqualToString:@""]) {
        return;
    }

    NSString *tmpKey = [TFCache getKey:aKey];

    if ([_writingList objectForKey:tmpKey]
        || [self cachedObjectToDiskForKey:tmpKey]) {
        NSLog(@"{ `tag`cache already cache on the disk,return }");
        return;
    }

    switch (aPlace) {
        case E_TFCacheWhereBoth:
            {
                [self _setCacheMapObject:aObj key:tmpKey];
                [self _cacheObjectToDisk:aObj key:tmpKey];
            } break;

        case E_TFCacheWhereMem:
            {
                // [self _setCacheMapObject:aObj key:tmpKey];
            } break;

        case E_TFCacheWhereDisk:
            {
                [self _cacheObjectToDisk:aObj key:tmpKey];
            } break;

        default:
            {
                // [self _setCacheMapObject:aObj key:tmpKey];
                [self _cacheObjectToDisk:aObj key:tmpKey];
            } break;
    }
}

void DiskWrite(void *objs, short *cancel_point)
{
    NSAutoreleasePool   *pool = [[NSAutoreleasePool alloc] init];
    NSData              *data = [TF_CAST (NSArray, objs) objectAtIndex:0];
    NSString            *key = [TF_CAST (NSArray, objs) objectAtIndex:1];
    NSString            *diskPath = [TF_CAST (NSArray, objs) objectAtIndex:2];
    NSMutableDictionary *writingList = [TF_CAST (NSArray, objs) objectAtIndex:3];

    [writingList removeObjectForKey:key];

    NSString *cachePath = [diskPath stringByAppendingPathComponent:key];

    NSLog(@"{ `tag`cache writing io data %@ }", key);

    [data   writeToFile :cachePath
            atomically  :NO];

    [TF_CAST (NSArray, objs)release], objs = nil;
    [pool release];
}

- (void)_cacheObjectToDisk:(id)aObj key:(NSString *)aKey
{

    int count = tfthreadpool_task_count(cachethreadpool);

    if (count >= 10) {
        NSLog(@"{ `tag`cache total task count >= 10}");
        return;
    } else {
        NSLog(@"{ `tag`cache total task count %d }", count);
    }

    [_writingList setObject:@"1" forKey:aKey];

//    tfcancel_flag   cancel_point = (tfcancel_flag)calloc(4, 0);
    NSArray         *diskInfo = [[NSArray alloc] initWithObjects:aObj, aKey, self.diskPath, _writingList, nil];
    tfthreadpool_eat2(cachethreadpool, DiskWrite, diskInfo);
}

- (void)_cacheMediaObjectToDisk:(id)anObj key:(NSString *)aKey{
    
    int count = tfthreadpool_task_count(cachethreadpool);
    
    if (count >= 10) {
        NSLog(@"{ `tag`cache total task count >= 10}");
        return;
    } else {
        NSLog(@"{ `tag`cache total task count %d }", count);
    }
    
    [_writingList setObject:@"1" forKey:aKey];
    
    //    tfcancel_flag   cancel_point = (tfcancel_flag)calloc(4, 0);
    NSArray         *diskInfo = [[NSArray alloc] initWithObjects:anObj, aKey, self.mediaPath, _writingList, nil];
    tfthreadpool_eat2(cachethreadpool, DiskWrite, diskInfo);
}

- (void)suspendIO
{
    if (_ioSuspend) {
        return;
    }

    _ioSuspend = YES;
    tfthreadpool_suspend(cachethreadpool);
}

- (void)resumeIO
{
    if (!_ioSuspend) {
        return;
    }

    _ioSuspend = NO;
    tfthreadpool_resume(cachethreadpool);
}

- (void)cleanMem
{
    NSLog(@"{ `tag`cache remove all cached mem }");
    [_cacheMap removeAllObjects];
    [_keys removeAllObjects];
}

- (void)_setCacheMapObject:(id)aObj key:(NSString *)aKey
{
    if ([_keys count] == TFMEMCACHE_MAX_COUNT) {
        NSLog(@"{ `tag`cache mem cached large than %d, remove first }", TFMEMCACHE_MAX_COUNT);
        NSString *key = [_keys objectAtIndex:0];
        [_cacheMap removeObjectForKey:key];
        [_keys removeObjectAtIndex:0];

        [_cacheMap setObject:aObj forKey:aKey];
        [_keys addObject:aKey];
    } else {
        [_cacheMap setObject:aObj forKey:aKey];
        [_keys addObject:aKey];
    }
}

+ (NSString *)getKey:(NSString *)url
{
    NSArray *sepStr = [url componentsSeparatedByString:@"/"];

    if ((nil == sepStr) || ([sepStr count] < 2)) {
        return @"";
    }

    url = [NSString stringWithFormat:@"%@%@", [sepStr objectAtIndex:[sepStr count] - 2], [sepStr objectAtIndex:[sepStr count] - 1]];

    return url;
}

- (id)objectForKey:(NSString *)aKey
{
    id ret = [_cacheMap objectForKey:[TFCache getKey:aKey]];

    if (ret) {
        NSLog(@"{ `tag`cache good,cache it in memory }");
        return ret;
    } else {
        NSString *cachePath = [self.diskPath stringByAppendingPathComponent:[TFCache getKey:aKey]];
        return [NSData dataWithContentsOfFile:cachePath];
    }
}

- (id)mediaObjectForKey:(NSString *)aKey{
    NSString *cachePath = [self.mediaPath stringByAppendingPathComponent:[TFCache getKey:aKey]];
    return [NSData dataWithContentsOfFile:cachePath];
}

- (NSString *)pathForKey:(NSString *)aKey
{
    NSString *fileKey = [TFCache getKey:aKey];
    if ([fileKey isEqualToString:@""]) {
        return @"";
    }
    else{
        NSString *cachePath = [self.diskPath stringByAppendingPathComponent:[TFCache getKey:aKey]];
        
        return cachePath;
    }
}

- (NSString *)mediaPathForKey:(NSString *)aKey
{
    NSString *fileKey = [TFCache getKey:aKey];
    if ([fileKey isEqualToString:@""]) {
        return @"";
    }
    else{
        NSString *cachePath = [self.mediaPath stringByAppendingPathComponent:[TFCache getKey:aKey]];
        
        return cachePath;
    }
}

- (BOOL)mediaFileExistForKey:(NSString *)aKey{
    NSString *fileKey = [TFCache getKey:aKey];
    if ([fileKey isEqualToString:@""]) {
        return NO;
    }
    else{
        NSString *cachePath = [self.mediaPath stringByAppendingPathComponent:[TFCache getKey:aKey]];
        
        return [[NSFileManager defaultManager] fileExistsAtPath:cachePath];
    }
}

///unused func documentsPath, tmpPath
//static NSString *documentsPath()
//{
//    NSString *path = [NSHomeDirectory () stringByAppendingPathComponent:@"Documents"];
//
//    return path;
//}
//
//static NSString *tmpPath()
//{
//    NSString *path = [NSHomeDirectory () stringByAppendingPathComponent:@"tmp"];
//
//    return path;
//}

- (void)initDisk
{
    NSURLCache *sharedCache = [[NSURLCache alloc]   initWithMemoryCapacity  :0
                                                    diskCapacity            :0
                                                    diskPath                :nil];

    [NSURLCache setSharedURLCache:sharedCache];
    [sharedCache release];

    /* prepare to use our own on-disk cache */
    NSError *error;
    /* create path to cache directory inside the application's Documents directory */
    // NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);

    NSString *path = [NSHomeDirectory () stringByAppendingPathComponent:@"tmp"];
    self.diskPath = [[path stringByAppendingPathComponent:@"ImageCache"] retain];

    if (![[NSFileManager defaultManager]    createDirectoryAtPath       :self.diskPath
                                            withIntermediateDirectories :NO
                                            attributes                  :nil
                                            error                       :&error]) {
        //return;
    }
    
    self.mediaPath = [[path stringByAppendingPathComponent:@"MediaCache"] retain];
    
    if (![[NSFileManager defaultManager]    createDirectoryAtPath       :self.mediaPath
                                            withIntermediateDirectories :NO
                                            attributes                  :nil
                                            error                       :&error]) {
       // return;
    }
    
    self.msgPath = [[path stringByAppendingPathComponent:@"MsgCache"] retain];
    
    if (![[NSFileManager defaultManager]    createDirectoryAtPath       :self.msgPath
                                            withIntermediateDirectories :NO
                                            attributes                  :nil
                                            error                       :&error]) {
       // return;
    }
}

- (void)cleanDisk
{
    NSError *error;

    /* check for existence of cache directory */
    if ([[NSFileManager defaultManager] fileExistsAtPath:self.diskPath]) {
        [[NSFileManager defaultManager] removeItemAtPath:self.diskPath error:&error];
        // return;
    }
}

- (void)cleanMsgCache
{
    NSError *error;
    
    /* check for existence of cache directory */
    if ([[NSFileManager defaultManager] fileExistsAtPath:self.msgPath]) {
        [[NSFileManager defaultManager] removeItemAtPath:self.msgPath error:&error];
        // return;
    }
}

- (id)func:(NSString *)aFunc objectForKey:(NSString *)aKey
{
    NSString *funcTimeAndVaildDayStr = [_funcTimeMap objectForKey:aFunc];

    if (funcTimeAndVaildDayStr) {
        NSArray *funcTimeAndVaildDayArr = [funcTimeAndVaildDayStr componentsSeparatedByString:TF_FUNC_CACHE_SPLIT];
        double  funcStartTime = [[funcTimeAndVaildDayArr objectAtIndex:0] doubleValue];
        int     dayLive = [[funcTimeAndVaildDayArr objectAtIndex:1] intValue];

        NSDate  *date = [NSDate date];
        double  nowTime = [date timeIntervalSince1970];

        int days = (int)(nowTime - funcStartTime) / (3600 * 24);

        if (days > dayLive) { // 大于存活时间 返回空 重新取值
            [_dayCacheMap removeObjectForKey:[NSString stringWithFormat:@"%@%@", aFunc, aKey]];
            return NULL;
        } else {
            return [_dayCacheMap objectForKey:[NSString stringWithFormat:@"%@%@", aFunc, aKey]];
        }
    } else {
        return NULL;
    }
}

- (void)cacheFunc:(NSString *)aFunc ret:(id)aObj key:(NSString *)aKey day:(int)aDay
{
    if (NULL == aObj) {
        return;
    }

    NSDate  *date = [NSDate date];
    double  nowTime = [date timeIntervalSince1970];

    [_funcTimeMap   setObject   :[NSString stringWithFormat:@"%lf##%d", nowTime, aDay]
                    forKey      :aFunc];
    [_dayCacheMap   setObject   :aObj
                    forKey      :[NSString stringWithFormat:@"%@%@", aFunc, aKey]];
}

- (BOOL)cachedObjectToDiskForKey:(NSString *)aKey
{
    NSString *cachePath = [self.diskPath stringByAppendingPathComponent:aKey];

    if ([[NSFileManager defaultManager] fileExistsAtPath:cachePath]) {
        return YES;
    }

    return NO;
}

- (BOOL)cachedMediaObjectToDiskForKey:(NSString *)aKey{
    NSString *cachePath = [self.mediaPath stringByAppendingPathComponent:aKey];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:cachePath]) {
        return YES;
    }
    
    return NO;
}

- (float)cacheSize
{
    long long size = [self folderSizeAtPath:self.diskPath.UTF8String];
    return size / 1024.f / 1024.f;
}

- (long long)folderSizeAtPath:(const char*)folderPath
{
    long long folderSize = 0;
    DIR* dir = opendir(folderPath);
    if (dir == NULL) return 0;
    struct dirent* child;
    while ((child = readdir(dir))!=NULL) {
        if (child->d_type == DT_DIR && (
                                        (child->d_name[0] == '.' && child->d_name[1] == 0) || // 忽略目录 .
                                        (child->d_name[0] == '.' && child->d_name[1] == '.' && child->d_name[2] == 0) // 忽略目录 ..
                                        )) continue;
        
        int folderPathLength = strlen(folderPath);
        char childPath[1024]; // 子文件的路径地址
        stpcpy(childPath, folderPath);
        if (folderPath[folderPathLength-1] != '/'){
            childPath[folderPathLength] = '/';
            folderPathLength++;
        }
        stpcpy(childPath+folderPathLength, child->d_name);
        childPath[folderPathLength + child->d_namlen] = 0;
        if (child->d_type == DT_DIR){ // directory
            folderSize += [self folderSizeAtPath:childPath]; // 递归调用子目录
            // 把目录本身所占的空间也加上
            struct stat st;
            if(lstat(childPath, &st) == 0) folderSize += st.st_size;
        }else if (child->d_type == DT_REG || child->d_type == DT_LNK){ // file or link
            struct stat st;
            if(lstat(childPath, &st) == 0) folderSize += st.st_size;
        }
    }
    return folderSize;
}

@synthesize diskPath;

#pragma mark -
#pragma mark DEPRECATED
- (BOOL)cacheObjectToDisk:(id)aObj forKey:(NSString *)aKey
{
    NSString *cachePath = [self.diskPath stringByAppendingPathComponent:
        [TFCache getKey:aKey]];
    BOOL ret = [(NSData *) aObj writeToFile :cachePath
                                atomically  :YES];

    return ret;
}

@synthesize mediaPath;
@end