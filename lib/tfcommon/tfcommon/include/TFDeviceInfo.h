//
//  TFTFDeviceInfo.h
//  tfcommon
//
//  Created by yin shen on 9/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TFDeviceInfo : NSObject

+(TFDeviceInfo *)sharedTFDeviceInfo;

+ (void)printfDeviceInfo;

+ (NSString *)getUDID;
+ (NSString *)getSID;

+ (NSString *)getImei;
+ (NSString *)getImsi;
+ (NSString *)getClientID;

+ (NSString *) platform;
+ (NSString *) platformString;

+ (BOOL)isRoot;
+ (BOOL)isRetinaDisplay;
+ (BOOL)checkWifi;
+ (BOOL)checkChinaMobile;

+ (NSString *)getMobileId;
+ (NSString *)getIFA;

+ (NSString *)getDeviceId;
@end
