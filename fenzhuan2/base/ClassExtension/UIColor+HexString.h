//
//  UIColor+HexString.h
//  SPComponentsDemo
//
//  Created by hanjie on 10-8-20.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface UIColor (UIColor_HexString)

+ (BOOL) validHexColorString:(NSString *) hexColorString;
+ (UIColor *) colorWithHexColorString:(NSString *) hexColorString;

@end
