/*!
 @file          TFBaseViewModel
 @discussion    ARC unsupported, last update tufu_1.1
 @author        shenyin
 */

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

#import "TFModel.h"

#import <objc/runtime.h>

#define raiseSingal(singalObj) (singalObj.singal=!singalObj.singal)
#define canBarrier(singalObj) (singalObj.barrier)
#define raiseBarrier(singalObj) (singalObj.seq == singalObj.barrierBoundary-1)

@interface Singal : NSObject <NSCopying>

@property (nonatomic, assign) BOOL singal;
@property (nonatomic, assign) NSInteger seq;
@property (nonatomic, assign) NSInteger barrierBoundary;
@property (nonatomic, assign) BOOL barrier;
@property (nonatomic, assign) BOOL conditionSent;
@end

@interface SingalBOOL : Singal <NSCopying>
@property (nonatomic, assign) BOOL value;
@end

@interface SingalIngeter : Singal <NSCopying>
@property (nonatomic, assign) NSInteger value;
@end

@interface SingalFloat : Singal <NSCopying>
@property (nonatomic, assign) CGFloat value;
@end

@interface SingalString : Singal <NSCopying>
@property (nonatomic, retain) NSString *value;
@end


extern const char *property_getTypeName(objc_property_t property);

typedef void (^SingalActionBlock)(id target,Singal *singal);

@interface TFViewModel : NSObject<
 TFModelDelegate
>{
    
}



- (TFModel *)mainModel;

/* View渲染入口 */
- (void)render;

/* 请求入口 */
- (void)request;

/* 事件注册入口 */
- (void)eventListen;

/* 不需要在创建时就初始化的类属性集合 */
- (NSDictionary *)doNotInitProperty;

/* 重新刷新页面 */
- (void)reload;

- (void)addSingal:(NSString *)key
           target:(id)target
          keyPath:(NSString *)keyPath
          options:(NSKeyValueObservingOptions)options
     singalAction:(SingalActionBlock)block;



- (void)addSingalBarrier:(NSString *)key
                     seq:(NSInteger)seq
                boundary:(NSInteger)boundary
                  target:(id)target
                 keyPath:(NSString *)keyPath
                 options:(NSKeyValueObservingOptions)options
            singalAction:(SingalActionBlock)block;

- (void)removeSingal:(NSString *)key;
- (void)removeSingalGroup:(NSString *)groupKey;
- (void)removeAllSingal;


@property (nonatomic, assign) UIViewController *controller;

@end
