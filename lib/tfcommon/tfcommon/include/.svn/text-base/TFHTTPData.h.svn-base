//
//  TFHTTPData.h
//  tfcommon
//
//  Created by yin shen on 2/22/13.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@protocol TFHTTPDataDelegate;

extern int  HTTP_OK;
extern int  HTTP_HEADER_ERROR;
extern int  HTTP_STREAM_ERROR;
extern int  HTTP_STREAM_TIMEOUT;

enum{
    TFHTTPDataTypeProtocol,
    TFHTTPDataTypeJpgOrPng,
    TFHTTPDataTypeWebP,
    TFHTTPDataTypeGif
};

@interface TFHTTPData : NSObject

@property (nonatomic, retain) NSData        *postData;
@property (nonatomic, assign) int type;
@property (atomic, retain) NSMutableData    *responseData;
@property (nonatomic, retain) NSString      *url;
@property (nonatomic, assign) int           statusCode;
@property (nonatomic, assign) double        timeout;
@property (nonatomic, assign) BOOL          noPersistent;
@property (nonatomic, assign) BOOL gzipResponse;
@property (nonatomic, assign) BOOL rc4Crypt;
@property (nonatomic, retain) NSString *cacheStamp;
@property (nonatomic, retain) NSString *cachedTimeout;
@property (nonatomic, retain) NSError *err;
@property (nonatomic, copy) NSString *uploadIdentifier;
@property (nonatomic, retain) id extra;
@property (nonatomic, assign) BOOL isHaihuReq;

@property (retain) id <TFHTTPDataDelegate>  delegate;
- (NSString *)responseString;
- (NSData *)covertMultiPart:(NSDictionary *)dict;
@end

@protocol TFHTTPDataDelegate
- (void)httpFinished:(TFHTTPData *)httpData;
- (void)httpCanceled:(TFHTTPData *)httpData;
@end