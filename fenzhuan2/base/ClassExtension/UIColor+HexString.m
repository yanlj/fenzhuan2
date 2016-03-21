//
//  UIColor+HexString.m
//  SPComponentsDemo
//
//  Created by hanjie on 10-8-20.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "UIColor+HexString.h"
#import "NSNumber+HexString.h"


@implementation UIColor (UIColor_HexString)

+ (BOOL) validHexColorString:(NSString *) hexColorString
{
    if ([hexColorString hasPrefix:@"#"]) {
        hexColorString = [hexColorString substringFromIndex:1];
    }
	
    NSString *lowerCaseHexColorString = [hexColorString lowercaseString];
	if ([lowerCaseHexColorString length] != 6)
	{
		return NO;
	}
	
	for (int i = 0; i < 6; i++)
	{
		NSString *aChar = [lowerCaseHexColorString substringWithRange:NSMakeRange(i, 1)];
		if ([aChar isEqualToString:@"0"] || [aChar isEqualToString:@"1"]
			|| [aChar isEqualToString:@"2"] || [aChar isEqualToString:@"3"]
			|| [aChar isEqualToString:@"4"] || [aChar isEqualToString:@"5"]
			|| [aChar isEqualToString:@"6"] || [aChar isEqualToString:@"7"]
			|| [aChar isEqualToString:@"8"] || [aChar isEqualToString:@"9"]
			|| [aChar isEqualToString:@"a"] || [aChar isEqualToString:@"b"]
			|| [aChar isEqualToString:@"c"] || [aChar isEqualToString:@"d"]
			|| [aChar isEqualToString:@"e"] || [aChar isEqualToString:@"f"])
		{
			//是合法的表示颜色的16进制字符串
		}
		else
		{
			return NO;
		}
	}
	
	return YES;
}

+ (UIColor *) colorWithHexColorString:(NSString *) hexColorString
{
    if (![self validHexColorString:hexColorString]) {
        return [self colorWithHexColorString:@"f14c84"];
    }
    
    if ([hexColorString hasPrefix:@"#"]) {
        hexColorString = [hexColorString substringFromIndex:1];
    }
    
	NSString *lowerCaseHexColorString = [hexColorString lowercaseString];
	NSString *redString = [lowerCaseHexColorString substringWithRange:NSMakeRange(0, 2)];
	NSInteger redValue = [[NSNumber numberWithHexString:redString] intValue];
	NSString *greenString = [lowerCaseHexColorString substringWithRange:NSMakeRange(2, 2)];
	NSInteger greenValue = [[NSNumber numberWithHexString:greenString] intValue];
	NSString *blueString = [lowerCaseHexColorString substringWithRange:NSMakeRange(4, 2)];
	NSInteger blueValue = [[NSNumber numberWithHexString:blueString] intValue];
	UIColor *color = [UIColor colorWithRed:(float)redValue/255.0 green:(float)greenValue/255.0 blue:(float)blueValue/255.0 alpha:1.0];
    return color;
}

@end
