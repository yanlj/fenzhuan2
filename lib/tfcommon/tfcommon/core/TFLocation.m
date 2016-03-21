//
//  TFLocation.m
//  tfcommon
//
//  Created by yin shen on 9/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TFLocation.h"

@interface TFLocation ()
@property (nonatomic, retain) CLLocationManager *locationManager;

@end

static TFLocation *kLocation = nil;
@implementation TFLocation

+ (TFLocation *)shared{
    
    @synchronized(self){
        if (nil == kLocation) {
            kLocation = [[TFLocation alloc] init];
        }
    }
    return kLocation;
}

+ (NSString *)getLat{
    if (nil == kLocation) {
        return @"";
    }
    else{
        return [NSString stringWithFormat:@"%f",kLocation.latitude];
    }
}

+ (NSString *)getLng{
    if (nil == kLocation) {
        return @"";
    }
    else{
       return [NSString stringWithFormat:@"%f",kLocation.longitude];
    }
}

- (id)init{
    self = [super init];
    if (self) {
        self.locationManager =  [[[CLLocationManager alloc] init] autorelease];
        // 如果可以利用本地服务时
        if([CLLocationManager locationServicesEnabled]){
            // 接收事件的实例
            self.locationManager.delegate = self;
            // 发生事件的的最小距离间隔（缺省是不指定）
            self.locationManager.distanceFilter = kCLDistanceFilterNone;
            // 精度 (缺省是Best)
            self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
            // 开始测量
            [self.locationManager startUpdatingLocation];
        }
    }
    return self;
}

+ (void)switchModeForBackground{
    if (kLocation) {
        if ([CLLocationManager significantLocationChangeMonitoringAvailable])
        {
            [kLocation.locationManager stopUpdatingLocation];
            [kLocation.locationManager startMonitoringSignificantLocationChanges];
        }
        else
        {
            NSLog(@"Significant location change monitoring is not available.");
        }
 
    }
    
}

+ (void)switchModeForForeground{
    if (kLocation) {
        if ([CLLocationManager significantLocationChangeMonitoringAvailable])
        {
            [kLocation.locationManager stopMonitoringSignificantLocationChanges];
            [kLocation.locationManager startUpdatingLocation];
        }
        else
        {
            NSLog(@"Significant location change monitoring is not available.");
        }
    }
    
}

- (void)updatingLocation{
    [self.locationManager startUpdatingLocation];
    
}

#define kEARTH_RADIUS 6378.137 //地球半径

double rad(double d)
{
    return d*M_PI/180.0;
}

double getDistance(double lat1, double lng1, double lat2, double lng2)
{
    double radLat1 = rad(lat1);
    double radLat2 = rad(lat2);
    double a = radLat1 - radLat2;
    double b = rad(lng1) - rad(lng2);
    double s = 2 * asin(sqrt((pow(sin(a/2),2) +cos(radLat1)*cos(radLat2)*pow(sin(b/2),2))));
    s = s * kEARTH_RADIUS;
    //s = round(s * 10000) / 10000*1000;
    s = s*1000;
    return s;
}


// 如果GPS测量成果以下的函数被调用
- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation{
    
    // 取得经纬度
    CLLocationCoordinate2D coordinate = newLocation.coordinate;
    self.latitude = coordinate.latitude;
    self.longitude = coordinate.longitude;
//    // 取得精度
//    CLLocationAccuracy horizontal = newLocation.horizontalAccuracy;
//    CLLocationAccuracy vertical = newLocation.verticalAccuracy;
//    // 取得高度
//    CLLocationDistance altitude = newLocation.altitude;
//    // 取得时刻
//    NSDate *timestamp = [newLocation timestamp];
    
    // 以下面的格式输出 format: <latitude>, <longitude>> +/- <accuracy>m @ <date-time>
   // NSLog(@"%@",[newLocation description]);
    
    // 与上次测量地点的间隔距离
//    if(oldLocation != nil){
//        CLLocationDistance d = [newLocation distanceFromLocation:oldLocation];
//        
//       // double c = getDistance(self.latitude, self.longitude, oldLocation.coordinate.latitude, oldLocation.coordinate.longitude);
//        
//       // NSLog(@"%@",[NSString stringWithFormat:@"%f", d]);
//    }
    
}


- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error{
    NSLog(@"%@",[error localizedDescription]);
}

- (void)dealloc{
    self.locationManager = nil;
    [super dealloc];
}

@synthesize latitude;
@synthesize longitude;
@synthesize locationManager = _locationManager;
@end
