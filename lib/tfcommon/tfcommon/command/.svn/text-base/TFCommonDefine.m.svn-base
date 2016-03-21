//
//  abc.m
//  tfcommon
//
//  Created by yin shen on 8/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TFCommonDefine.m"


void TFNetLog(NSString *format, ...) {
    va_list arg;
    va_start(arg, format);
    NSLogv(format, arg);
    va_end(arg);
}

void TFLog(NSString *format, ...) {
    format = [NSString stringWithFormat:@"\n{\n\tTFLog:\n\t!!!%@\n}\n",format];
    va_list arg;
    va_start(arg, format);
    NSLogv(format, arg);
    va_end(arg);
}