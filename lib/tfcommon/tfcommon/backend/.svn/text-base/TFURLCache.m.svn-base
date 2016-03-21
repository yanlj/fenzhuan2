//
//  TFURLCache.m
//  tfcommon
//
//  Created by yin shen on 6/20/14.
//
//

#import "TFURLCache.h"

@interface TFURLCacheData : NSObject

@property (nonatomic, retain) NSData *data;
@property (nonatomic, assign) double timeout;

+ (TFURLCacheData *)quickWithData:(NSData *)d timeout:(double)t;
- (NSUInteger)length;
@end

@implementation TFURLCacheData

+ (TFURLCacheData *)quickWithData:(NSData *)d timeout:(double)t{
    TFURLCacheData *cacheData = [[TFURLCacheData alloc] init];
    cacheData.data = d;
    cacheData.timeout = t;
    return [cacheData autorelease];
}

- (NSUInteger)length{
    return self.data.length;
}

@synthesize data;
@synthesize timeout;
@end


typedef enum {
    TFURLCacheModeLocal,    ///default
    TFURLCacheModeRemote,   ///unimplement
    TFURLCacheModeMix       ///unimplement
}TFURLCacheMode;

///digest format
///operationtype_digest

@interface TFURLCache ()

@property (nonatomic, assign) NSUInteger memoryCapacity;
@property (nonatomic, assign) NSUInteger currentMemoryOccupied;
@property (nonatomic, retain) NSMutableDictionary *memoryDict;
@end

#define kCacheTimeoutSec (5*60)

static NSString *kOperateionTypeFilter = @"\\b(queryRingDetail|queryMyFansList)\\b";


@implementation TFURLCache

@synthesize memoryCapacity;
@synthesize memoryDict;

static inline NSRegularExpression * TFURLCacheOperationTypeFilterRegex() {
    static NSRegularExpression *_TFURLCacheOperationTypeFilterRegex = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _TFURLCacheOperationTypeFilterRegex = [[NSRegularExpression alloc] initWithPattern:kOperateionTypeFilter
                                                                                   options:NSRegularExpressionCaseInsensitive
                                                                                     error:nil];
    });
    
    return _TFURLCacheOperationTypeFilterRegex;
}


+ (TFURLCache *)shareDefaultCache
{
    static TFURLCache *instance = nil;
    
    if (instance == nil) {
        instance = [[TFURLCache alloc] initWithMemoryCapacity:2*1024*1024
                                                 diskCapacity:0
                                                     diskPath:nil];
    }
    
    return instance;
}

- (id)initWithMemoryCapacity:(NSUInteger)aMemoryCapacity
                diskCapacity:(NSUInteger)aDiskCapacity
                    diskPath:(NSString *)path{
    self = [super init];
    if (self) {
        self.memoryCapacity = aMemoryCapacity;
        self.memoryDict = [NSMutableDictionary dictionary];
    }
    
    return self;
}


- (NSString *)_getOperationType:(NSString *)stamp{
    NSArray *ret = [stamp componentsSeparatedByString:@"_"];

    NSString *op = ret.count>0?ret[0]:@"";
    return op;
}

- (NSString *)_getDigest:(NSString *)stamp{
    NSArray *ret = [stamp componentsSeparatedByString:@"_"];
    
    NSString *digest = ret.count>1?ret[1]:@"";
    return digest;
}


- (NSString *)createURLCacheStampWithOpType:(NSString *)opType
                                     digest:(NSString *)digest{
    
//    NSRegularExpression *regex = TFURLCacheOperationTypeFilterRegex();
//    NSRange stringRange = NSMakeRange(0, [opType length]);
//    NSArray *ret = [regex matchesInString:opType
//                                   options:0
//                                     range:stringRange];
//    
//    if (ret==nil
//        ||[ret count]==0) {
//        return  nil;
//    }
    
    return [NSString stringWithFormat:@"%@_%@",opType,digest];
}

- (void)cacheResponse:(NSData *)response stamp:(NSString *)stamp timeout:(int)timeout{
    
    if (stamp==nil
        ||[stamp isEqualToString:@""]) {
        return;
    }
    
    if (0 == timeout) {
        return;
    }
    
    if ([self.memoryDict objectForKey:stamp]) {
        return;
    }
    
    if ([response length]+self.currentMemoryOccupied>self.memoryCapacity) {
        [self _removeMemoryOccupiedToSatisfy:[response length]];
    }
    else{
        
        NSLog(@"{ cache response for stamp %@}",stamp);
        self.currentMemoryOccupied+=[response length];
        [self.memoryDict setValue:[TFURLCacheData quickWithData:response
                                                        timeout:[[NSDate date] timeIntervalSince1970]+timeout]
                           forKey:stamp];
    }
}

- (void)_removeMemoryOccupiedToSatisfy:(NSUInteger)addingSize{
    @synchronized(self.memoryDict){
    
        __block NSUInteger blockAddingSize = addingSize;
        [self.memoryDict enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            
            if (blockAddingSize<=0) {
                *stop=YES;
            }
            
            if ([obj isKindOfClass:[TFURLCacheData class]]) {
                blockAddingSize-=[obj length];
                self.currentMemoryOccupied-=[obj length];
                [self.memoryDict removeObjectForKey:key];
            }
        }];
        
    }
}

- (NSData *)cachedResponseForRequestStamp:(NSString *)stamp{
        
    TFURLCacheData *cacheData = [self.memoryDict objectForKey:stamp];
    
    if (cacheData) {
        if (cacheData.timeout - [[NSDate date] timeIntervalSince1970]>0) {
            NSLog(@"{ get cached response by stamp %@}",stamp);
            return cacheData.data;
        }
        else{ ///缓存超时 剔除当前stamp缓存
            [self.memoryDict removeObjectForKey:stamp];
            return nil;
        }
    }
    else{
        return nil;
    }
}

- (void)cleanCachedReponseForOperationType:(NSString *)operationType{
    @synchronized(self.memoryDict){
        
        [self.memoryDict enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            
            if ([key hasPrefix:operationType]) {
                self.currentMemoryOccupied-=[obj length];
                [self.memoryDict removeObjectForKey:key];
                *stop = YES;
            }
        }];
        
    }
}

- (void)cleanAllCachedResponse{
    @synchronized(self.memoryDict){
        [self.memoryDict removeAllObjects];
        self.currentMemoryOccupied = 0;
    }
}

@end
