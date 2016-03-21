//
//  TFLocation.h
//  tfcommon
//
//  Created by yin shen on 9/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface TFLocation : NSObject<
 CLLocationManagerDelegate
>{
    double latitude;
    double longitude;
}

@property (nonatomic, assign) double latitude;
@property (nonatomic, assign) double longitude;

+ (void)switchModeForBackground;
+ (void)switchModeForForeground;

+ (TFLocation *)shared;

+ (NSString *)getLat;
+ (NSString *)getLng;
@end
