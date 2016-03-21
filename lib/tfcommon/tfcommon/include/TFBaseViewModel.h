////
////  TFBaseViewModel.h
////  tfcommon
////
////  Created by yin shen on 8/3/12.

/*!
 @file          TFBaseViewModel
 @discussion    ARC unsupported, last update tufu_1.1
 @author        shenyin
 */

#import <Foundation/Foundation.h>
#import "TFDataModel.h"
#import "TFCommonDefine.h"
#import "TFNetExecutor.h"

/*!
 @protocol  TFBaseViewModelDelegate
 @function  modelEverythingFine:    call when every status ok
 @function  modelSomethingWrong:    call when net error or data parse error
 */
@protocol TFBaseViewModelDelegate;

/*!
 @constant MODEL_HTTP_SUC
 @constant MODEL_HTTP_FAL
 @constant MODEL_HTTP_INIT
 @constant MODEL_HTTP_PROCESS
 */
extern int MODEL_HTTP_SUC;
extern int MODEL_HTTP_FAL;
extern int MODEL_HTTP_INIT;
extern int MODEL_HTTP_PROCESS;

/*!
 @constant MODEL_DATA_SUC
 @constant MODEL_DATA_JSON_FAL
 @constant MODEL_DATA_STRUCT_FAL
 */
extern int MODEL_DATA_SUC;
extern int MODEL_DATA_JSON_FAL;
extern int MODEL_DATA_STRUCT_FAL;


/*!
 @interface     TFBaseViewModel
 @abstract      The TFBaseViewModel provides net,data operation and use TFBaseViewModelDelegate
                to connect the controller
 @discussion    The TFBaseViewModel is a base model,only provide the basic property,you should
                inherit it,to expand functions and properties, and the child class only need 
                write net request assemble method,and parse the return dictionary in function
                "_productModelItem:"
 */
@interface TFBaseViewModel : NSObject<
 TFNetExecutorDelegate
>{
    int netStatus;
    int dataStatus;
    
    NSString *memo;
    int resultStatus;

    Class _originalClass;
    
    __unsafe_unretained id<TFBaseViewModelDelegate> _tfDelegate;
    
    NSString *controllerTag;
}

@property (nonatomic, retain) TFNetExecutor *net;
@property (nonatomic, assign) int netStatus;
@property (nonatomic, assign) int dataStatus;

@property (nonatomic, retain) NSString *memo;
@property (nonatomic, assign) int resultStatus;

@property (nonatomic, assign) __unsafe_unretained id <TFBaseViewModelDelegate> tfDelegate;
- (void)setDelegate:(id<TFBaseViewModelDelegate>)delegate;

@property (nonatomic, retain) NSString *controllerTag TF_DEPRECATED(tufu_1.1#no_used);

- (void)process;
- (void)processWithDict:(NSDictionary *)dict;

- (void)postDictionary:(NSMutableDictionary *)postDictionary toUrl:(NSString *)url;
- (void)postDictionaryAndCancelPreRequest:(NSMutableDictionary *)postDictionary toUrl:(NSString *)url;

/**
 *  @brief  子类请重载以下方法
 */
- (BOOL)_productModelItem:(NSDictionary *)data;

@end

@protocol TFBaseViewModelDelegate
- (void)modelEverythingFine:(TFBaseViewModel *)model;
- (void)modelSomethingWrong:(TFBaseViewModel *)model;
@end