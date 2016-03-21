//
//  CONSTANT.h
//  fenzhuan2
//
//  Created by 颜梁坚 on 16/3/18.
//  Copyright © 2016年 yanlj. All rights reserved.
//

#ifndef CONSTANT_h
#define CONSTANT_h

#define RGBCOLOR(r,g,b)             [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]
#define RGBACOLOR(r,g,b,a)          [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
#define COLOR_CSS(__hex__)  [UIColor colorWithRed:((float)((__hex__ & 0xFF0000) >> 16))/255.0 \
green:((float)((__hex__ & 0xFF00) >> 8))/255.0 \
blue:((float)(__hex__ & 0xFF))/255.0 \
alpha:1.0]

#define FONT_BOLD(__size__) [UIFont boldSystemFontOfSize:__size__]
#define FONT_SYSTEM(__size__) [UIFont systemFontOfSize:__size__]

#define CREAT_XIB(__xibname__)  {[[[NSBundle mainBundle] loadNibNamed:__xibname__ owner:nil options:nil] objectAtIndex:0]}

#define APP_DELEGATE (Appdelegate *)[[UIApplication sharedApplication] delegate]

#define APP_BUILD_VERSION [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleVersionKey]
#define APP_VERSION [[NSBundle mainBundle] objectForInfoDictionaryKey: @"CFBundleShortVersionString"]

#define IS_IOS6_OR_LOWER (([[[UIDevice currentDevice] systemVersion] doubleValue] < 7.0) ? YES : NO)
#define IS_IOS7_OR_GREATER (([[[UIDevice currentDevice] systemVersion] doubleValue] >= 7.0) ? YES : NO)
#define IS_IOS7_OR_LOWER (([[[UIDevice currentDevice] systemVersion] doubleValue] < 8.0) ? YES : NO)
#define IS_IOS7 (([[[UIDevice currentDevice] systemVersion] doubleValue] >= 7.0 && [[[UIDevice currentDevice] systemVersion] doubleValue] < 8.0) ? YES : NO)
#define IS_IOS8_OR_GREATER (([[[UIDevice currentDevice] systemVersion] doubleValue] >= 8.0) ? YES : NO)
#define STATUS_BAR_HEIGHT ((IS_IOS7_OR_GREATER)?20:0)

#define DEVICE_MAINSCREEN [UIScreen mainScreen].bounds
#define DEVICE_MAINSCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define DEVICE_MAINSCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define DEVICE_SCREEN_SCALE [UIScreen mainScreen].bounds.size.width/320.0

#define STATUS_BAR_HEIGHT ((IS_IOS7_OR_GREATER)?20:0)
#define BACK_IMG_HEIGHT ((IS_IOS7_OR_GREATER)?0:20)
#define NAV_BAR_HEIGHT ((IS_IOS7_OR_GREATER)?64:44)

#define IS_IPHONE4S_OR_LOWER    ([Util phoneInch] == IPhoneInchType_3_5)
#define IS_IPHONE5              ([Util phoneInch] == IPhoneInchType_4_0)
#define IS_IPHONE6              ([Util phoneInch] == IPhoneInchType_4_7)
#define IS_IPHONE6_PLUS         ([Util phoneInch] == IPhoneInchType_5_5)
#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

#define SINGLETON_CLASS(classname) \
\
+ (classname *)shared##classname \
{\
static dispatch_once_t pred = 0; \
__strong static id _shared##classname = nil; \
dispatch_once(&pred,^{ \
_shared##classname = [[self alloc] init]; \
});  \
return _shared##classname; \
}

#endif /* CONSTANT_h */
