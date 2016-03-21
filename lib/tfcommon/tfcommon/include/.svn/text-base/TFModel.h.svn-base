/*!
 @file          TFModel(old version:TFBaseViewModel)
 @discussion    ARC unsupported, last update tufu_1.2
 @author        shenyin
 */



#import <Foundation/Foundation.h>
#import "TFNetExecutor.h"


/*!
 @protocol  TFModelDelegate
 @function  modelEverythingFine:    call when every status ok
 @function  modelSomethingWrong:    call when net error or data parse error
 */
@protocol TFModelDelegate;

/*!
 @interface     TFModel
 @abstract      The TFModel provides net,data operation and use TFBaseViewModelDelegate
 to connect the controller
 @discussion    The TFModel is a base model,only provide the basic property,you should
 inherit it,to expand functions and properties, and the child class only need
 write net request assemble method,and parse the return dictionary in function
 "_productModelItem:"
 */
@interface TFModel : NSObject<
 TFNetExecutorDelegate
>{
    Class _originalClass;
}

///*!
// 返回说明*/
//@property (nonatomic, retain) NSString *memo;
///*!
// 服务端返回状态*/
//@property (nonatomic, retain) NSString *status;
///*!
// 请求参数缓存*/
//@property (nonatomic, retain) NSMutableDictionary *savedReqDict;
/*!
 返回出错*/
@property (nonatomic, retain) NSError *err;

/*!
 TFModel代理*/
@property (nonatomic, assign) id<TFModelDelegate> delegate;

@property (nonatomic, readonly) TFNetExecutor *netExcutor;


/*!
 @function      _productModelItem:
 @abstract      初始化请求
 @return        返回NO通知参数解析出现错误*/
- (BOOL)_productModelItem:(NSDictionary *)dict;

/*!
 @function      regainNetExcutor
 @abstract      重新获取net excutor*/
- (void)regainNetExcutor;


/*
 @function   根据参数生成请求字符串
 !*/
- (NSString *)makeRequestString:(id)oriData;

@end

@protocol TFModelDelegate
- (void)modelEverythingFine:(TFModel *)model;
- (void)modelSomethingWrong:(TFModel *)model;

@optional
- (void)modelNetBodySending:(id)percent;
@end

@interface TFModel (TFBasedViewModelDeprecated)

- (void)process TF_DEPRECATED(tufu_1_2_0#instead reload);

@end
