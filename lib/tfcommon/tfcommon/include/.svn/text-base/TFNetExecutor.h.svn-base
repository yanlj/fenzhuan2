/*!
 @file          TFNetExecutor
 @discussion    ARC unsupported, create at tufu_1.2
 @author        shenyin
 */

#import <Foundation/Foundation.h>
#import "TFCommonDefine.h"
@class TFHTTPData;

/*!
@protocol  TFNetModelDelegate
@function  httpSuccess: http网络请求成功 原样返回网络数据
@function  httpFail: http网络请求失败 原样返回网络数据
*/
@protocol TFNetExecutorDelegate <NSObject>

@optional

- (void)httpSuccess:(TFHTTPData *)httpData;
- (void)httpFail:(NSString *)data;
- (void)httpSendPercent:(float)percent;
- (void)httpSendPercent:(float)percent identifier:(NSString *)identifier;

@end


/*!
 @interface     TFNetExecutor
 @abstract      集成在“TFModel”中的网络模块，负责处理网络请求和返回，其中搭载@file tfthreadpool
 线程池
 @discussion    由于支持全界面无等待加载，需要处理回调的delegate已经释放的情况
 */
@interface TFNetExecutor : NSObject{
    __weak id<TFNetExecutorDelegate> _delegate;
    Class _originalClass;
}

/*!
 @function      post:body:
 @abstract      post请求
 @param         url             请求地址
 @param         body            post body*/
- (void)post:(NSString *)url body:(NSDictionary *)body;

/*!
 @function      get:
 @abstract      get请求
 @param         url             请求地址*/
- (void)get:(NSString *)url;


/*!
 @function      upload:
 @abstract      upload请求
 @param         url             请求地址
 @param         body            post body*/
- (void)upload:(NSString *)url body:(NSDictionary *)body;

/*!
 @function      setDelegate:
 @abstract      upload请求
 @param         delegate        @protocol TFNetExecutorDelegate*/
- (void)setDelegate:(id<TFNetExecutorDelegate>)delegate;

/*!
 @function      suspend
 @abstract      挂起网络请求线程池*/
+ (void)suspend;

/*!
 @function      resume
 @abstract      恢复网络请求线程池*/
+ (void)resume;

/*!
 @function      destoryNetPool
 @abstract      销毁网络请求线程池*/
+ (void)destoryNetPool;

- (void)postLogin:(NSString *)url body:(NSString *)data;

- (void)postRequestNoCancel:(NSString *)url body:(NSString *)data;

- (void)postRequest:(NSString *)url body:(NSString *)data;

- (void)getRequest:(NSString *)url;

@end

//@interface TFNetExecutor(TFNetModelDeprecated)
//
//- (void)postRequest:(NSString *)url body:(NSDictionary *)body TF_DEPRECATED(tufu_1_2_0#instead post:body:);
//- (void)postRequestNoCancel:(NSString *)url body:(NSDictionary *)body TF_DEPRECATED(tufu_1_2_0#abandon);
//- (void)postRequest:(NSString *)url body:(NSString *)data withProcess:(BOOL)process TF_DEPRECATED(tufu_1_2_0#abandon);
//- (void)getRequest:(NSString *)url TF_DEPRECATED(tufu_1_2_0#instead get);
//+ (void)suspendNet TF_DEPRECATED(tufu_1_2_0#instead suspend:);
//+ (void)resumeNet TF_DEPRECATED(tufu_1_2_0#instead resume:);
//
//@end

