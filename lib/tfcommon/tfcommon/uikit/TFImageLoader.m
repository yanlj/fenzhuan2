//
//  TFImageLoader.m
//  tfcommon
//
//  Created by yin shen on 8/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TFImageLoader.h"


#define TFC_NORMAL_IMAGE(path) [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:path]]

#define TFC_BUNDLE_NAME @"tfbundle4iphone.bundle"   
#define TFC_BUNDLE_PATH [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:TFC_BUNDLE_NAME]
#define TFC_BUNDLE [NSBundle bundleWithPath:TFC_BUNDLE_PATH]

#define TFC_IMAGE_NAME_FROM_BUNDLE(path) [UIImage imageWithContentsOfFile:[[TFC_BUNDLE resourcePath] stringByAppendingPathComponent:path]]

#define TFC_FILE_NAME_FROM_BUNDLE(path) [NSString stringWithContentsOfFile:[[TFC_BUNDLE resourcePath] stringByAppendingPathComponent:path] encoding:NSUTF8StringEncoding error:nil]


#define TFC_IMAGE_PATH_FROM_BUNDLE(path) [[TFC_BUNDLE resourcePath] stringByAppendingPathComponent:path]

@implementation TFImageLoader

+ (UIImage *)fromBundleStretch:(NSString *)fileName{
    UIImage *ret = TFC_IMAGE_NAME_FROM_BUNDLE(fileName);
    float param = (ret.size.width-1)/2;
#if __IPHONE_VERSION_MIN_REQUIRED < 5000
    ret = [ret stretchableImageWithLeftCapWidth:param topCapHeight:param];
#else
    ret = [ret resizableImageWithCapInsets:UIEdgeInsetsMake(param, param, 0, 0)];
#endif
    
    return ret;
}

+ (UIImage *)stretch:(NSString *)fileName{
    UIImage *ret = [UIImage imageNamed:fileName];
    float param = (ret.size.width-1)/2;
#if __IPHONE_VERSION_MIN_REQUIRED < 5000
    ret = [ret stretchableImageWithLeftCapWidth:param topCapHeight:param];
#else
    ret = [ret resizableImageWithCapInsets:UIEdgeInsetsMake(param, param, 0, 0)];
#endif
    
    return ret;
}

+ (NSString *)pathFromBundle:(NSString *)filename{
    return TFC_IMAGE_PATH_FROM_BUNDLE(filename);
}

+ (UIImage *)fromBundleNormal:(NSString *)fileName{
    UIImage *ret = TFC_IMAGE_NAME_FROM_BUNDLE(fileName);
    return ret;
}

+ (UIImage *)normal:(NSString *)fileName{
    UIImage *ret = TFC_NORMAL_IMAGE(fileName);
    return ret;
}

+ (NSString *)csvStrFromBundle:(NSString *)fileName{
    NSString *ret = TFC_FILE_NAME_FROM_BUNDLE(fileName);
    return ret;
}

+ (UIImage *)imageNoCache:(NSString *)filename{
    
    UIImage *ret = [UIImage imageWithContentsOfFile:
                    [[NSBundle mainBundle] pathForResource:filename ofType:@"png"]];
    return ret;
}

@end

