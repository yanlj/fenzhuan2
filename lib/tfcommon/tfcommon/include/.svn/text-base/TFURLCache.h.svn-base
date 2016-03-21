//
//  TFURLCache.h
//  tfcommon
//
//  Created by yin shen on 6/20/14.
//
//

#import <Foundation/Foundation.h>

@interface TFURLCache : NSObject

- (id)initWithMemoryCapacity:(NSUInteger)memoryCapacity
                diskCapacity:(NSUInteger)diskCapacity
                    diskPath:(NSString *)path;

+ (TFURLCache *)shareDefaultCache;

- (NSString *)createURLCacheStampWithOpType:(NSString *)opType
                               digest:(NSString *)digest;

- (void)cacheResponse:(NSData *)response stamp:(NSString *)stamp timeout:(int)timeout;

- (NSData *)cachedResponseForRequestStamp:(NSString *)stamp;
- (void)cleanCachedReponseForOperationType:(NSString *)operationType;
- (void)cleanAllCachedResponse;
@end
