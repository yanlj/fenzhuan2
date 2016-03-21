//
//  TF8PublicData.m
//  TfClient
//
//  Created by 吕红鹏 on 16/2/25.
//
//

#import "TF8PublicData.h"

static NSString *kProductVersion = nil;
static NSString *kProductID = nil;
static NSString *kChannelID = nil;
static NSString *kUserAgent = nil;



@implementation TF8PublicData

+ (TF8PublicData *)shared{
    static TF8PublicData *shared = nil;
    @synchronized(self) {
        if (nil == shared){
            shared = [[TF8PublicData alloc]init];
            [shared getPublic];
        }
    }
    return shared;
}



- (NSMutableDictionary *)getPublic{
    
    self.clientId = [TFDeviceInfo getClientID];
    
    self.mobileId = [TFDeviceInfo getMobileId];
    
    self.ifa = [TFDeviceInfo getIFA];
    
    self.deviceId = [NSString stringWithFormat:@"000000000000000|000000000000000|%@",self.clientId];
    
    Top *mTop = [Top sharedTop];
    self.userId = [TFCommand setValue:mTop._userId];
    self.outerCode = [TFCommand setValue:mTop._outerCode];
    self.topSession = [TFCommand setValue:mTop._topSession];
    self.loginType = [TFCommand setValue:mTop._loginType];
    
    AppKey *appKey = [AppKey ShareAppKey];
    self.deviceToken = [TFCommand setValue:appKey._deviceToken];
    self.nick = [TFCommand setValue:appKey._nick];
    self.cookie = [TFCommand setValue:appKey.cookie];
    
    NSString *tmpModel = [TFDeviceInfo platformString];
    self.model = [TFCommand setValue:tmpModel];
    self.os = [TFCommand setValue:[[UIDevice currentDevice] systemVersion]];
    
    self.productId = [TF8PublicData getProductID];
    self.productVersion = [TF8PublicData getProductVersion];
    self.channelId = [TF8PublicData getChannelID];
    self.userAgent = [TF8PublicData getUserAgent];
    
    self.lat = [TFLocation getLat];
    self.lng = [TFLocation getLng];
    
    self.retina = @"NO";
    if ([TFDeviceInfo isRetinaDisplay]){
        id netType = [[NSUserDefaults standardUserDefaults] objectForKey:@"LongLivedVariablesNetType"];
        if (netType) {
            if (0==[netType intValue]) {
                self.retina = @"YES";
            }
            else{
                id thrift = [[NSUserDefaults standardUserDefaults] objectForKey:@"LongLivedVariablesThrift"];
                if (thrift) {
                    self.retina = [thrift intValue]==0?@"YES":@"NO";
                }
                else{
                    self.retina = @"YES";
                }
            }
        }
        else{
            if ([TFDeviceInfo checkWifi]) {
                self.retina = @"YES";
            }
            else{
                id thrift = [[NSUserDefaults standardUserDefaults] objectForKey:@"LongLivedVariablesThrift"];
                if (thrift) {
                    self.retina = [thrift intValue]==0?@"YES":@"NO";
                }
                else{
                    self.retina = @"YES";
                }
            }
        }
    }
    else {
        //        if (TF_IS_IPAD) {
        //            self.retina = @"YES";
        //        }
    }
    
#ifdef __IPHONE_8_0
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        CGFloat nativeScale = [[UIScreen mainScreen] nativeScale];
        if (nativeScale == 3.0) {
            self.display = @"high";
        }
        else if (nativeScale == 2.0) {
            self.display = @"middle";
        }
        else if (nativeScale == 1.0) {
            self.display = @"low";
        }
        else {
            self.display = @"middle";
        }
    }
    else
#endif
    {
        if ([TFDeviceInfo isRetinaDisplay]) {
            self.display = @"middle";
        }
        else {
            self.display = @"low";
        }
    }
    
    id thrift = [[NSUserDefaults standardUserDefaults] objectForKey:@"LongLivedVariablesThrift"];
    if (thrift && [thrift intValue]==1 && ![TFDeviceInfo checkWifi]) {
        self.display = @"low";// 开启节能模式时，如果在非wifi状态下，获取低清图片
    }
    
    
    if ([TFDeviceInfo checkWifi]) {
        self.network = @"wifi";
    }
    else{
        if ([TFDeviceInfo checkChinaMobile]) {
            self.network = @"2g";
        }
        else{
            self.network = @"3g";
        }
    }
    
    if ([TFDeviceInfo isRoot]) {
        self.isRoot = @"YES";
    }
    else {
        self.isRoot = @"NO";
    }
    
    //#warning test
    //    self.isRoot = @"YES";
    
    NSMutableDictionary *publicDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                       self.mobileId?self.mobileId:@"",@"mobileId",
                                       self.network?self.network:@"",@"network",
                                       self.clientId?self.clientId:@"",@"clientID",
                                       self.model?self.model:@"",@"model",
                                       self.os?self.os:@"",@"os",
                                       self.productId?self.productId:@"",@"productID",
                                       self.channelId?self.channelId:@"",@"channelID",
                                       self.productVersion?self.productVersion:@"",@"productVersion",
                                       self.deviceToken?self.deviceToken:@"",@"deviceToken",
                                       self.nick?self.nick:@"",@"nick",
                                       self.outerCode?self.outerCode:@"",@"outerCode",
                                       self.userAgent?self.userAgent:@"",@"userAgent",
                                       self.userId?self.userId:@"",@"userId",
                                       self.loginType?self.loginType:@"", @"loginType",
                                       self.topSession?self.topSession:@"",@"topSession",
                                       self.retina?self.retina:@"",@"retina",
                                       self.display?self.display:@"", @"display",
                                       self.deviceId?self.deviceId:@"",@"deviceId",
                                       self.cookie?self.cookie:@"",@"cookie",
                                       self.lat?self.lat:@"",@"lat",
                                       self.lng?self.lng:@"",@"lng",
                                       self.ifa?self.ifa:@"",@"ifa",
                                       self.isRoot?self.isRoot:@"",@"isRoot",
                                       //#warning test
                                       //                                       @"refresh",@"cmd",
                                       
                                       nil];
    
#ifdef __IPHONE_8_0
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        [self saveSharedData];
    }
#endif
    return publicDict;
}

- (void)saveSharedData
{
    TF8PublicData *command = self;
    
    NSUserDefaults *sharedDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.com.taofen8.TfClient"];
    
    [sharedDefaults setObject:command.clientId?command.clientId:@"" forKey:@"clientId"];
    [sharedDefaults setObject:command.userId?command.userId:@"" forKey:@"userId"];
    [sharedDefaults setObject:command.nick?command.nick:@"" forKey:@"nick"];
    [sharedDefaults setObject:command.model?command.model:@"" forKey:@"model"];
    [sharedDefaults setObject:command.os?command.os:@"" forKey:@"os"];
    [sharedDefaults setObject:command.productId?command.productId:@"" forKey:@"productId"];
    [sharedDefaults setObject:command.channelId?command.channelId:@"" forKey:@"channelId"];
    [sharedDefaults setObject:command.productVersion?command.productVersion:@"" forKey:@"productVersion"];
    [sharedDefaults setObject:command.deviceToken?command.deviceToken:@"" forKey:@"deviceToken"];
    [sharedDefaults setObject:command.userAgent?command.userAgent:@"" forKey:@"userAgent"];
    [sharedDefaults setObject:command.topSession?command.topSession:@"" forKey:@"topSession"];
    [sharedDefaults setObject:command.outerCode?command.outerCode:@"" forKey:@"outerCode"];
    [sharedDefaults setObject:command.retina?command.retina:@"" forKey:@"retina"];
    [sharedDefaults setObject:command.display?command.display:@"" forKey:@"display"];
    [sharedDefaults setObject:command.deviceId?command.deviceId:@"" forKey:@"deviceId"];
    [sharedDefaults setObject:command.cookie?command.cookie:@"" forKey:@"cookie"];
    [sharedDefaults setObject:command.mobileId?command.mobileId:@"" forKey:@"mobileId"];
    [sharedDefaults setObject:command.ifa?command.ifa:@"" forKey:@"ifa"];
    [sharedDefaults setObject:command.isRoot?command.isRoot:@"" forKey:@"isRoot"];
    [sharedDefaults synchronize];

}


+ (NSString *)getProductID{
    @synchronized(self){
        if (nil == kProductID) {
            kProductID = [[NSString alloc] initWithFormat:@"%@",[[NSBundle mainBundle] objectForInfoDictionaryKey:@"Product id"]];
        }
    }
    return kProductID;
    
}

+ (NSString *)getChannelID{
    @synchronized(self){
        if (nil == kChannelID) {
            kChannelID = [[NSString alloc] initWithFormat:@"%@",[[NSBundle mainBundle] objectForInfoDictionaryKey:@"Channel"]];
        }
    }
    return kChannelID;
}

+ (NSString *)getUserAgent{
    @synchronized(self){
        if (nil == kUserAgent) {
            kUserAgent = [[NSString alloc] initWithFormat:@"%@",[[NSBundle mainBundle] objectForInfoDictionaryKey:@"User agent"]];
        }
    }
    return kUserAgent;
}

+ (NSString *)getProductVersion{
    @synchronized(self){
        if (nil == kProductVersion) {
            kProductVersion = [[NSString alloc] initWithFormat:@"%@%@",
                               [[NSBundle mainBundle] objectForInfoDictionaryKey:@"Product version"],
                               [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]];
        }
        
    }
    return kProductVersion;
}



@end
