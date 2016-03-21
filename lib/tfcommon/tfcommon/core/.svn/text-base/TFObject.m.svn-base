//
//  TFObject.m
//  w
//
//  Created by yin shen on 7/19/13.
//  Copyright (c) 2013 yin shen. All rights reserved.
//

#import "TFObject.h"
#include <objc/runtime.h>


@implementation NSObject(TFObject)

//
//- (id)objectTag {
//    return objc_getAssociatedObject(self, ObjectTagKey);
//}
//
//- (void)setObjectTag:(id)newObjectTag {
//    objc_setAssociatedObject(self, ObjectTagKey, newObject, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//}

//+ (void)load{
//    kCachingProtocol = objc_getProtocol("TFCaching");
//}





id tfobjc_msgSend(void *sender,SEL cmd,...){
    va_list arg_ptr;
    
    va_start(arg_ptr, cmd);

    id arg;
    
    
    NSMethodSignature *signature = [(NSObject *)sender methodSignatureForSelector:cmd];
    NSInvocation *invocation  = [NSInvocation invocationWithMethodSignature:signature];
    [invocation setTarget:sender];
    [invocation setSelector:cmd];
    
    
    int index = 2;
    while((arg = va_arg(arg_ptr,id))){
        [invocation setArgument:&arg atIndex:index++];
    }
   
    
    va_end(arg_ptr);
    
    [invocation invoke];
    int methodReturnLength = [signature methodReturnLength];
    if (methodReturnLength>0) {
        void *returnValue = NULL;
        [invocation getReturnValue:&returnValue];
        return returnValue;
    }
    else
        return NULL;
    
   
}

void tfobjc_msgHandler(){
    
}

@end
