//
//  TFCrashHandler.h
//  tfcommon
//
//  Created by yin shen on 8/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TFCommonDefine.h"
typedef void (*TFC_PREFIX(HandleExceptions))(NSException *exception);
typedef void (*TFC_PREFIX(SignalHandler))(int sig);

@interface TFCrashHandler : NSObject

+(void)setException:(TFC_PREFIX(HandleExceptions))eFuncPtr signal:(TFC_PREFIX(SignalHandler))sFuncPtr;

@end
