//
//  TFCrashHandler.m
//  tfcommon
//
//  Created by yin shen on 8/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TFCrashHandler.h"

@implementation TFCrashHandler

+(void)setException:(TFC_PREFIX(HandleExceptions))eFuncPtr signal:(TFC_PREFIX(SignalHandler))sFuncPtr{
    // installs HandleExceptions as the Uncaught Exception Handler
    NSSetUncaughtExceptionHandler(eFuncPtr);
    // create the signal action structure 
    struct sigaction newSignalAction;
    // initialize the signal action structure
    memset(&newSignalAction, 0, sizeof(newSignalAction));
    // set SignalHandler as the handler in the signal action structure
    newSignalAction.sa_handler = sFuncPtr;
    // set SignalHandler as the handlers for SIGABRT, SIGILL and SIGBUS
    sigaction(SIGABRT, &newSignalAction, NULL);
    sigaction(SIGILL, &newSignalAction, NULL);
    sigaction(SIGBUS, &newSignalAction, NULL);
    sigaction(SIGINT, &newSignalAction, NULL);
}

@end
