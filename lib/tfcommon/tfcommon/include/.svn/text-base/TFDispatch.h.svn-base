//
// Created by yinshen on 12/15/12.
//
// To change the template use AppCode | Preferences | File Templates.
//

/*!
 @file          TFDispatch
 @discussion    ARC unsupported, last update tufu1.1.1
 @author        shenyin
 */
#import <Foundation/Foundation.h>
#include "tfthreadpool.h"


/*!
 @interface     TFDispatch
 @abstract      tufu框架任务分发前台，负责与objc语言特性做连接
 */

typedef void(^dispatchTaskBlock)(void*,short*);


@interface TFDispatch : NSObject{
    dispatchTaskBlock _taskBlock;
    id _closure;
    short *_cancel_point;
}

+ (TFDispatch *)quick;
- (void)clean;
- (void)cancelTask;
- (void)dispatchTask:(dispatchTaskBlock)taskBlock;
- (void)run;

@end