//
//  TFCache.h
//  tfcommon
//
//  Created by yin shen on 8/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TFCommonDefine.h"

/*!
 *   @file          TFCache
 *   @discussion    ARC unsupported, last update tufu1.1
 *   @author        shenyin
 */

/*!
 *   @enum          E_TFCacheWhere
 *   @abstract      Values for controlling the saving data place.
 *   @constant      E_TFCacheWhereBoth  Save to the mem meantime save to the disk
 *   @constant      E_TFCacheWhereMem   Save to mem
 *   @constant      E_TFCacheWhereDisk  Save to disk
 */
typedef enum {
    E_TFCacheWhereBoth = 0x0,
    E_TFCacheWhereMem,
    E_TFCacheWhereDisk
} E_TFCacheWhere;

/*!
 *   @class         TFCache
 *
 *   @abstract      The TFCache class provides an interface for cache image data to disk or memory,also can
 *                cache a function return value in cache for some day.
 *
 *   @discussion    The TFCache is main cache center in tufu lib, should call 'initDisk' in app delegate launch,
 *                and call 'cleanDisk' when terminal.
 *
 *                It is generally best to hold onto a long-lived instance of an event cache, most likely as a
 *                singleton instance in your application.
 *
 */
@interface TFCache : NSObject {
    @private
    NSMutableDictionary *_cacheMap;
    NSMutableArray      *_keys;

    ///function ret cache
    NSMutableDictionary *_dayCacheMap;
    NSMutableDictionary *_funcTimeMap;

    NSString *diskPath;

    BOOL _ioSuspend;
}

@property (atomic, retain) NSMutableDictionary *writingList;

@property (nonatomic, retain) NSString *diskPath;
@property (nonatomic, retain) NSString *mediaPath;
@property (nonatomic, retain) NSString *msgPath;

+ (TFCache *)shared;
- (void)initDisk;
- (void)cleanDisk;
- (void)cleanMsgCache;
- (NSString *)pathForKey:(NSString *)aKey;

- (id)objectForKey:(NSString *)aKey;
- (id)mediaObjectForKey:(NSString *)aKey;
- (NSString *)mediaPathForKey:(NSString *)aKey;
- (void)cacheObject:(id)aObj key:(NSString *)aKey where:(E_TFCacheWhere)aPlace;
- (void)cacheMediaObject:(id)anObj key:(NSString *)aKey;

- (id)func:(NSString *)aFunc objectForKey:(NSString *)aKey;
- (void)cacheFunc:(NSString *)aFuc ret:(id)aObj key:(NSString *)aKey day:(int)aDay;
- (void)cleanMem;

- (BOOL)cacheObjectToDisk:(id)aObj forKey:(NSString *)aKey TF_DEPRECATED(tufu_1 .0 #funcion_update);

- (BOOL)cachedObjectToDiskForKey:(NSString *)aKey;

- (void)suspendIO;
- (void)resumeIO;

- (void)synCacheMediaObject:(id)anObj key:(NSString *)aKey;

- (float)cacheSize;

- (BOOL)mediaFileExistForKey:(NSString *)aKey;

@end

#define TF_FUNC_CACHE_BEGIN(KEY_, FUNC_)            do {id obj = [[TFCache shared] objectForKey:KEY_]; \
                                                        if (NULL != obj) {                             \
                                                            return obj;                                \
                                                        }                                              \
} while (0)
#define TF_FUNC_CACHE_END(FUNC_, RET_, KEY_, DAY_)  [[TFCache shared] cacheFunc : FUNC_ ret : RET_ key : KEY_ day : DAY_];

#define TF_FUNC_CACHE_SPLIT @"##"