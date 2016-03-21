//
//  TFNetExecutor.m
//  tfcommon
//
//  Created by yin shen on 6/15/15.
//
//

#import "TFNetExecutor.h"

#import "TFHTTP.h"
#import "TFModel.h"
#import "TFCommand.h"
#import "TFURLCache.h"
#import "TFHTTPData.h"
#include "tfthreadpool.h"
#import "TFURLConnection.h"
#import <objc/runtime.h>

//Class object_getClass(id obj);

@interface TFNetExecutor()<
 TFHTTPDataDelegate
>

@end

static tfthreadpool_t *netthreadpool = NULL;

@implementation TFNetExecutor

/*! 
 初始化网络请求线程池 */
+ (void)initialize{
    if (self == [TFNetExecutor self]) {
        netthreadpool = (tfthreadpool_t *)malloc(sizeof(tfthreadpool_t));
        netthreadpool->name = "net";
        netthreadpool->threads = NULL;
        tfthreadpool_init(netthreadpool, 1);
    }
}

+ (void)destoryNetPool { tfthreadpool_free(netthreadpool); }

+ (void)suspend{ tfthreadpool_suspend(netthreadpool); }

+ (void)resume{ tfthreadpool_resume(netthreadpool); }

- (void)dealloc{
    _delegate = nil;
    
    [super dealloc];
}

- (void)post:(NSString *)url body:(NSMutableDictionary *)process{
//    [UIApplication sharedApplication].networkActivityIndicatorVisible=YES;
    
//    NSDictionary *process = [TFCommand htQueryWithParam:body];
    
    TFNetLog(@"\n{\nREQUEST\n%@?%@\n}\n", url, [process[@"data"] URLDecodedString]);
    TFHTTPData *httpData = [[TFHTTPData alloc] init];
    httpData.delegate = self;
    httpData.rc4Crypt = YES;
    httpData.isHaihuReq = YES;
    httpData.cacheStamp = process[@"stamp"];
    httpData.cachedTimeout = process[@"cachedTimeout"];
    httpData.postData = [process[@"data"] dataUsingEncoding:NSUTF8StringEncoding];
    httpData.url = url;
    httpData.gzipResponse = NO;
    tfthreadpool_eat2(netthreadpool, TFHTTPNet2, httpData);
}



- (void)get:(NSString *)url{
    TFNetLog(@"\n{\nREQUEST\n%@}\n", [url URLDecodedString]);
    TFHTTPData *httpData = [[TFHTTPData alloc] init];
    httpData.delegate = self;
    httpData.postData = nil;
    httpData.url = url;
    
    tfthreadpool_eat2(netthreadpool, TFHTTPNet2, httpData);
}

- (void)postLogin:(NSString *)url body:(NSString *)data
{
//    self.httpStatus = MODEL_HTTP_PROCESS;
    
    TFNetLog(@"\n{\nREQUEST\n%@?%@\n}\n", url, [data URLDecodedString]);
    TFHTTPData *httpData = [[TFHTTPData alloc] init];
    httpData.delegate = self;
    httpData.postData = [data dataUsingEncoding:NSUTF8StringEncoding];
    httpData.url = url;
    
    tfthreadpool_eat2(netthreadpool, TFHTTPNet2, httpData);
}

- (void)upload:(NSString *)url body:(NSDictionary *)body{
//    [UIApplication sharedApplication].networkActivityIndicatorVisible=YES;
    TFNetLog(@"\n{\nREQUEST\n%@\n}\n", [url URLDecodedString]);
    TFHTTPData *httpData = [[TFHTTPData alloc] init];
    httpData.delegate = self;
    NSData *a = [httpData covertMultiPart:body];
    httpData.postData = a;
    httpData.url = url;
    httpData.timeout = 90.;
    httpData.gzipResponse = NO;
    
    z_o_t *upload_cancel_point = (z_o_t *)calloc(4, 0);
    tfthread_once(TFHTTPNet4, httpData, upload_cancel_point);
}

- (void)connection:(TFURLConnection *)connection
   didSendBodyData:(NSInteger)bytesWritten
 totalBytesWritten:(NSInteger)totalBytesWritten
totalBytesExpectedToWrite:(NSInteger)totalBytesExpectedToWrite{
    
    ///consider _upload_cancel_point release when in runpool
    //    if (*_upload_cancel_point) {
    //       // [connection cancel];
    //        NSLog(@"~~~~~~~~~~~here");
    //    }
    if (_delegate != nil) {
        Class currentClass = object_getClass(_delegate);
        
        if (_originalClass == currentClass) {
            if ([_delegate respondsToSelector:@selector(httpSendPercent:identifier:)]) {
                [_delegate httpSendPercent:(float)totalBytesWritten/totalBytesExpectedToWrite
                                identifier:connection.httpData.uploadIdentifier];
            } else if ([_delegate respondsToSelector:@selector(httpSendPercent:)]) {
                [_delegate httpSendPercent:(float)totalBytesWritten/totalBytesExpectedToWrite];
            }
            
        } else {
            NSLog(@"maybe crash");
        }
    } else {
        NSLog(@"Delegate is nil");
    }
    
}

- (void)connection:(TFURLConnection *)connection didReceiveData:(NSData *)data{
    [connection.httpData.responseData appendData:data];
}


- (void)connectionDidFinishLoading:(TFURLConnection *)connection{
    connection.httpData.statusCode = HTTP_OK;
    
    [connection unscheduleFromRunLoop:[NSRunLoop currentRunLoop]
                              forMode:NSDefaultRunLoopMode];
    
    //[connection.httpData release];
    [self httpFinished:connection.httpData];
    
    
}

- (void)connection:(TFURLConnection *)connection didFailWithError:(NSError *)error{
    connection.httpData.statusCode = HTTP_STREAM_ERROR;
    
    [connection unscheduleFromRunLoop:[NSRunLoop currentRunLoop]
                              forMode:NSDefaultRunLoopMode];
    
    //[connection.httpData release];
    [self httpFinished:connection.httpData];
    
    
}


- (void)setDelegate:(id <TFNetExecutorDelegate>)delegate
{
    _delegate = delegate;
    _originalClass = object_getClass(_delegate);
}

- (void)httpFinished:(TFHTTPData *)httpData
{
    if (HTTP_OK == httpData.statusCode) {

        NSString *value = [[httpData responseString] retain];
        TFNetLog(@"\n{\nRESPONSE\nurl: %@\nresponse: %@\n}\n", [[httpData url] URLDecodedString], value);
        
        if (_delegate != nil) {
            Class currentClass = object_getClass(_delegate);
            
            if (_originalClass == currentClass
                ||_originalClass == [currentClass superclass]) { ///fix NSKVONotifiying_
                
                
                [_delegate httpSuccess:httpData];
            } else {
                NSLog(@"maybe crash");
            }
        } else {
            NSLog(@"Delegate is nil");
        }
        
        [value release];
    } else {

        NSString *value = [[httpData responseString] retain];
        TFNetLog(@"\n{\nRESPONSE\nurl: %@\nresponse: %@\n}\n", [httpData url], value);
        
        if (_delegate != nil) {
            Class currentClass = object_getClass(_delegate);
            
            if (_originalClass == currentClass) {
                TF_CAST(TFModel,_delegate).err = httpData.err;
                [_delegate httpFail:value];
            } else {
                NSLog(@"maybe crash");
            }
        } else {
            NSLog(@"Delegate is nil");
        }
        
        [value release];
    }
//    [UIApplication sharedApplication].networkActivityIndicatorVisible=NO;
    [httpData release], httpData = nil;
}

- (void)httpCanceled:(TFHTTPData *)httpData{}

#pragma mark - from TFNetModel


- (void)postRequest:(NSString *)url body:(NSString *)data
{
    TFNetLog(@"\n{\nREQUEST\n%@?%@\n}\n", url, data);

    TFHTTPData *httpData = [[TFHTTPData alloc] init];
    httpData.delegate = self;
//#ifdef EncryptAndGZip
    httpData.rc4Crypt = YES;
    httpData.gzipResponse = YES;
//#endif
    httpData.postData = [data dataUsingEncoding:NSUTF8StringEncoding];
    httpData.url = url;
    tfthreadpool_eat2(netthreadpool, TFHTTPNet2, httpData);
}

- (void)postRequestNoCancel:(NSString *)url body:(NSString *)data
{
    
    TFNetLog(@"\n{\nREQUEST\n%@?%@\n}\n", url, data);

    TFHTTPData *httpData = [[TFHTTPData alloc] init];
    httpData.delegate = self;
//#ifdef EncryptAndGZip
    httpData.rc4Crypt = YES;
    httpData.gzipResponse = YES;
//#endif
    httpData.postData = [data dataUsingEncoding:NSUTF8StringEncoding];
    httpData.url = url;
    tfthreadpool_eat2(netthreadpool, TFHTTPNet2, httpData);
}

- (void)getRequest:(NSString *)url
{
    TFNetLog(@"\n{\nREQUEST\n%@}\n", [url URLDecodedString]);
    TFHTTPData *httpData = [[TFHTTPData alloc] init];
    httpData.delegate = self;
    httpData.postData = nil;
    httpData.url = url;
    
    tfthreadpool_eat2(netthreadpool, TFHTTPNet2, httpData);
}
@end

//@implementation TFNetExecutor(TFNetModelDeprecated)
//
//- (void)postRequest:(NSString *)url body:(NSDictionary *)body{
//    [self post:url body:body];
//}
//
////- (void)postRequestNoCancel:(NSString *)url body:(NSDictionary *)body{ return; }
//
//- (void)postRequest:(NSString *)url body:(NSString *)data withProcess:(BOOL)process{ return; }
//
//- (void)getRequest:(NSString *)url{
//    [self get:url];
//}
//
//+ (void)suspendNet{
//    [TFNetExecutor suspend];
//}
//
//+ (void)resumeNet{
//    [TFNetExecutor resume];
//}
//
//@end
