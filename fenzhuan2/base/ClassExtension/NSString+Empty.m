//
//  NSString+Empty.m
//  TfClient
//
//  Created by crazycao on 15/1/22.
//
//

#import "NSString+Empty.h"

@implementation NSString (Empty)

+ (BOOL)checkEmpty:(NSString *)string;
{
    if (string == nil) {
        return YES;
    }
    if ([string isEqual:[NSNull null]]) {
        return YES;
    }
    if (![string isKindOfClass:[NSString class]]) {
        return YES;
    }
    if ([string isEqualToString:@""]) {
        return YES;
    }
    return NO;
}

@end
