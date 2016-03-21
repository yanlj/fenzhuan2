//
//  TFCommand.m
//  TfClient
//
//  Created by wuwentao on 12-3-19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "TFCommand.h"
//#import "AppKey.h"
#import "JSON.h"
#import "GTMBase64.h"
#import "TFDeviceInfo.h"
#import "SPSJsonWrapper.h"
#import "TFLocation.h"
#import "OpenUDID.h"
#import "TripleDesTool.h"
//#import "Top.h"
#include <CommonCrypto/CommonDigest.h>

#define kTFCommandKey @"tmadd04142572f626ds0c1egq88e4aa0dff54b20201ef99ab93b3d2561d34df7"

//海淘md5加密
#define kTFMD5Key @"svUsBbxO4P1UFGHbLJPYLXps6yd6SRsj4EFKsUqNqq5cjZmgAg2rOgS0Xiw4JtJX"

//static NSString *kProductVersion = nil;
//static NSString *kProductID = nil;
//static NSString *kChannelID = nil;
//static NSString *kUserAgent = nil;

@implementation NSString (NSString_Encoding)


- (NSString *)URLEncodedString
{
	return [self URLEncodedStringWithCFStringEncoding:kCFStringEncodingUTF8];
}

- (NSString *)URLEncodedStringWithCFStringEncoding:(CFStringEncoding)encoding
{
	return [(NSString *) CFURLCreateStringByAddingPercentEscapes(NULL, (CFStringRef)[[self mutableCopy] autorelease], NULL, CFSTR("￼!*'();:@&=+$,/?%#[]"), encoding) autorelease];
}

@end

@implementation TFCommand

//+ (TFCommand *)shared{
//    static TFCommand *k_command = nil;
//    @synchronized(self){
//        if (nil == k_command) {
//            k_command = [[TFCommand alloc] init];
//            
//            [k_command getPublic];
//        }
//    }
//    return k_command;
//}
//
//+ (NSString *)gateway:(NSString *)jsonRepresentation{
//    NSString *session = [self do_MD5_String:[NSString stringWithFormat:@"%@%@",jsonRepresentation,kTFCommandKey]];
//    NSString *ret = [NSString stringWithFormat:@"requestData=%@&session=%@&api=api2",[jsonRepresentation URLEncodedString],session];
//    
//    return ret;
//}
//
//
//- (NSMutableDictionary *)getPublic{
//
//    self.clientId = [TFDeviceInfo getClientID];
//    
//    self.mobileId = [TFDeviceInfo getMobileId];
//    
//    self.ifa = [TFDeviceInfo getIFA];
//    
//    self.deviceId = [NSString stringWithFormat:@"000000000000000|000000000000000|%@",self.clientId];
//    
//    Top *mTop = [Top sharedTop];
//    self.userId = [TFCommand setValue:mTop._userId];
//    self.outerCode = [TFCommand setValue:mTop._outerCode];
//    self.topSession = [TFCommand setValue:mTop._topSession];
//    
//    
//    AppKey *appKey = [AppKey ShareAppKey];
//    self.deviceToken = [TFCommand setValue:appKey._deviceToken];
//    self.nick = [TFCommand setValue:appKey._nick];
//    self.cookie = [TFCommand setValue:appKey.cookie];
//    
//    NSString *tmpModel = [TFDeviceInfo platformString];
//    self.model = [TFCommand setValue:tmpModel];
//    self.os = [TFCommand setValue:[[UIDevice currentDevice] systemVersion]];
//    
//    self.productId = [TFCommand getProductID];
//    self.productVersion = [TFCommand getProductVersion];
//    self.channelId = [TFCommand getChannelID];
//    self.userAgent = [TFCommand getUserAgent];
//    
//    self.lat = [TFLocation getLat];
//    self.lng = [TFLocation getLng];
//    
//    self.retina = @"NO";
//    if ([TFDeviceInfo isRetinaDisplay]){
//        id netType = [[NSUserDefaults standardUserDefaults] objectForKey:@"LongLivedVariablesNetType"];
//        if (netType) {
//            if (0==[netType intValue]) {
//                self.retina = @"YES";
//            }
//            else{
//                id thrift = [[NSUserDefaults standardUserDefaults] objectForKey:@"LongLivedVariablesThrift"];
//                if (thrift) {
//                    self.retina = [thrift intValue]==0?@"YES":@"NO";
//                }
//                else{
//                    self.retina = @"YES";
//                }
//            }
//        }
//        else{
//            if ([TFDeviceInfo checkWifi]) {
//                self.retina = @"YES";
//            }
//            else{
//                id thrift = [[NSUserDefaults standardUserDefaults] objectForKey:@"LongLivedVariablesThrift"];
//                if (thrift) {
//                    self.retina = [thrift intValue]==0?@"YES":@"NO";
//                }
//                else{
//                    self.retina = @"YES";
//                }
//            }
//        }
//    }
//    else {
////        if (TF_IS_IPAD) {
////            self.retina = @"YES";
////        }
//    }
//    
//#ifdef __IPHONE_8_0
//    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
//        CGFloat nativeScale = [[UIScreen mainScreen] nativeScale];
//        if (nativeScale == 3.0) {
//            self.display = @"high";
//        }
//        else if (nativeScale == 2.0) {
//            self.display = @"middle";
//        }
//        else if (nativeScale == 1.0) {
//            self.display = @"low";
//        }
//        else {
//            self.display = @"middle";
//        }
//    }
//    else
//#endif
//    {
//        if ([TFDeviceInfo isRetinaDisplay]) {
//            self.display = @"middle";
//        }
//        else {
//            self.display = @"low";
//        }
//    }
//    
//    id thrift = [[NSUserDefaults standardUserDefaults] objectForKey:@"LongLivedVariablesThrift"];
//    if (thrift && [thrift intValue]==1 && ![TFDeviceInfo checkWifi]) {
//        self.display = @"low";// 开启节能模式时，如果在非wifi状态下，获取低清图片
//    }
//
//    
//    if ([TFDeviceInfo checkWifi]) {
//        self.network = @"wifi";
//    }
//    else{
//        if ([TFDeviceInfo checkChinaMobile]) {
//            self.network = @"2g";
//        }
//        else{
//            self.network = @"3g";
//        }
//    }
//    
//    if ([TFDeviceInfo isRoot]) {
//        self.isRoot = @"YES";
//    }
//    else {
//        self.isRoot = @"NO";
//    }
//    
////#warning test
////    self.isRoot = @"YES";
//    
//    NSMutableDictionary *publicDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:
//                                       self.mobileId?self.mobileId:@"",@"mobileId",
//                                       self.network?self.network:@"",@"network",
//                                       self.clientId?self.clientId:@"",@"clientID",
//                                       self.model?self.model:@"",@"model",
//                                       self.os?self.os:@"",@"os",
//                                       self.productId?self.productId:@"",@"productID",
//                                       self.channelId?self.channelId:@"",@"channelID",
//                                       self.productVersion?self.productVersion:@"",@"productVersion",
//                                       self.deviceToken?self.deviceToken:@"",@"deviceToken",
//                                       self.nick?self.nick:@"",@"nick",
//                                       self.outerCode?self.outerCode:@"",@"outerCode",
//                                       self.userAgent?self.userAgent:@"",@"userAgent",
//                                       self.userId?self.userId:@"",@"userId",
//                                       self.topSession?self.topSession:@"",@"topSession",
//                                       self.retina?self.retina:@"",@"retina",
//                                       self.display?self.display:@"", @"display",
//                                       self.deviceId?self.deviceId:@"",@"deviceId",
//                                       self.cookie?self.cookie:@"",@"cookie",
//                                       self.lat?self.lat:@"",@"lat",
//                                       self.lng?self.lng:@"",@"lng",
//                                       self.ifa?self.ifa:@"",@"ifa",
//                                       self.isRoot?self.isRoot:@"",@"isRoot",
////#warning test
////                                       @"refresh",@"cmd",
//                                       
//                                       nil];
//    
//#ifdef __IPHONE_8_0
//    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
//        [self saveSharedData];
//    }
//#endif
//    return publicDict;
//}
//
//- (void)saveSharedData
//{
//    TFCommand *command = self;
//    
//    NSUserDefaults *sharedDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.com.taofen8.TfClient"];
//    
//    [sharedDefaults setObject:command.clientId?command.clientId:@"" forKey:@"clientId"];
//    [sharedDefaults setObject:command.userId?command.userId:@"" forKey:@"userId"];
//    [sharedDefaults setObject:command.nick?command.nick:@"" forKey:@"nick"];
//    [sharedDefaults setObject:command.model?command.model:@"" forKey:@"model"];
//    [sharedDefaults setObject:command.os?command.os:@"" forKey:@"os"];
//    [sharedDefaults setObject:command.productId?command.productId:@"" forKey:@"productId"];
//    [sharedDefaults setObject:command.channelId?command.channelId:@"" forKey:@"channelId"];
//    [sharedDefaults setObject:command.productVersion?command.productVersion:@"" forKey:@"productVersion"];
//    [sharedDefaults setObject:command.deviceToken?command.deviceToken:@"" forKey:@"deviceToken"];
//    [sharedDefaults setObject:command.userAgent?command.userAgent:@"" forKey:@"userAgent"];
//    [sharedDefaults setObject:command.topSession?command.topSession:@"" forKey:@"topSession"];
//    [sharedDefaults setObject:command.outerCode?command.outerCode:@"" forKey:@"outerCode"];
//    [sharedDefaults setObject:command.retina?command.retina:@"" forKey:@"retina"];
//    [sharedDefaults setObject:command.display?command.display:@"" forKey:@"display"];
//    [sharedDefaults setObject:command.deviceId?command.deviceId:@"" forKey:@"deviceId"];
//    [sharedDefaults setObject:command.cookie?command.cookie:@"" forKey:@"cookie"];
//    [sharedDefaults setObject:command.mobileId?command.mobileId:@"" forKey:@"mobileId"];
//    [sharedDefaults setObject:command.ifa?command.ifa:@"" forKey:@"ifa"];
//    [sharedDefaults setObject:command.isRoot?command.isRoot:@"" forKey:@"isRoot"];
//#pragma mark - memory optimization by limq
//    [sharedDefaults release];
//}
//
//+ (NSString *)getProductVersion{
//    @synchronized(self){
//        if (nil == kProductVersion) {
//            kProductVersion = [[NSString alloc] initWithFormat:@"%@%@",
//                               [[NSBundle mainBundle] objectForInfoDictionaryKey:@"Product version"],
//                               [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]];
//        }
//        
//    }
//    return kProductVersion;
//}
//
//+ (NSString *)getProductID{
//    @synchronized(self){
//        if (nil == kProductID) {
//            kProductID = [[NSString alloc] initWithFormat:@"%@",[[NSBundle mainBundle] objectForInfoDictionaryKey:@"Product id"]];
//        }
//    }
//    return kProductID;
//    
//}
//
//+ (NSString *)getChannelID{
//    @synchronized(self){
//        if (nil == kChannelID) {
//            kChannelID = [[NSString alloc] initWithFormat:@"%@",[[NSBundle mainBundle] objectForInfoDictionaryKey:@"Channel"]];
//        }
//    }
//    return kChannelID;
//}
//
//+ (NSString *)getUserAgent{
//    @synchronized(self){
//        if (nil == kUserAgent) {
//            kUserAgent = [[NSString alloc] initWithFormat:@"%@",[[NSBundle mainBundle] objectForInfoDictionaryKey:@"User agent"]];
//        }
//    }
//    return kUserAgent;
//}

+ (NSString *)currentTime
{
    NSDate          *date = [NSDate date];
    NSTimeInterval  timeInterval = [date timeIntervalSince1970];
    NSString        *valueCount = [NSString stringWithFormat:@"%.0f", timeInterval];
    
    return valueCount;
}

+ (NSString *)currentDate
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *strDate = [dateFormatter stringFromDate:[NSDate date]];
    return strDate;
}

+(NSString *)TFSignMd5:(NSString *)requestType time:(NSString *)time
{
    NSString *temp = [requestType stringByAppendingString:time];
    return [self do_MD5_String:temp];
}

+ (NSString *)do_SHA_String:(NSString *)body{
    const char      *cStr = [body UTF8String];
    unsigned char   result[CC_SHA256_DIGEST_LENGTH];
    
    CC_SHA256(cStr, strlen(cStr), result);
    
    NSMutableString *hash = [NSMutableString string];
    
    for (int i = 0; i < CC_SHA256_DIGEST_LENGTH; i++) {
        [hash appendFormat:@"%02X", result[i]];
    }
    
    return [hash lowercaseString];
}

+(NSString *)setValue:(NSString *)value
{
    if (value) {
        return value;
    }else {
        return @"";
    }
}


+ (NSString *)do_MD5_String:(NSString *)body{
    
    const char *cStr = [body UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, strlen(cStr), result );
    
    NSMutableString *hash = [NSMutableString string];
    for(int i=0;i<CC_MD5_DIGEST_LENGTH;i++)
    {
        [hash appendFormat:@"%02X",result[i]];
    }
    return [hash lowercaseString];
}

//query app key

/*
+(NSString *)queryAppKey
{
    NSString *time = [Top currentTime];
    NSString *sign = [TFCommand TFSignMd5:@"queryAppKey" time:time];
    
    NSMutableDictionary *publicDict = [[TFCommand shared] getPublic];
    
    NSMutableDictionary *mutableRequest = [NSMutableDictionary dictionaryWithDictionary:publicDict];
    [mutableRequest setObject:@"queryAppKey" forKey:@"operationType"];
    [mutableRequest setObject:@"" forKey:@"smsc"];
    [mutableRequest setObject:@"" forKey:@"cellId"];
    [mutableRequest setObject:time forKey:@"time"];
    [mutableRequest setObject:sign forKey:@"sign"];
    
    NSString *temp = [SPSJsonWrapper jsonRepresentation:mutableRequest];
	return [TFCommand gateway:temp];
}


//query home page
+(NSString *)queryHomePage{return NULL;}


+(NSString *)queryMemberList:(NSString *)pageArgument pageNo:(NSString *)pageNo cid:(NSString *)cid
{
    NSString *time = [Top currentTime];
    NSString *sign = [TFCommand TFSignMd5:@"queryMemberList" time:time];
    
    NSMutableDictionary *publicDict = [[TFCommand shared] getPublic];
    
    
    NSMutableDictionary *mutableRequest = [NSMutableDictionary dictionaryWithDictionary:publicDict];
    [mutableRequest setObject:@"queryMemberList" forKey:@"operationType"];
    [mutableRequest setObject:time forKey:@"time"];
    [mutableRequest setObject:sign forKey:@"sign"];
    
    [mutableRequest setObject:@"12" forKey:@"pageSize"];
    [mutableRequest setObject:pageNo forKey:@"pageNo"];
    [mutableRequest setObject:pageArgument forKey:@"pageArgument"];
    [mutableRequest setObject:cid forKey:@"cid"];
	
    NSString *temp = [SPSJsonWrapper jsonRepresentation:mutableRequest];
	return [TFCommand gateway:temp];
}


+(NSString *)getUserId:(NSString *)nick topSession:(NSString *)topSession{return NULL;}

+(NSString *)getExUserId:(NSString *)userId userNick:(NSString *)nick topSession:(NSString *)topSession{
    
    NSString *time = [Top currentTime];
    NSString *sign = [TFCommand TFSignMd5:@"getExUserId" time:time];

    NSMutableDictionary *publicDict = [[TFCommand shared] getPublic];

    NSString *_nick = [TFCommand setValue:nick];
//    NSString *_topSession = [TFCommand setValue:topSession];
//    NSString *_userId = [TFCommand setValue:userId];
    
//    [publicDict setObject:_nick forKey:@"nick"];
//    [publicDict setObject:_topSession forKey:@"topSession"];
//    [publicDict setObject:_userId forKey:@"userId"];//这三个都是是公共参数了
    
    NSMutableDictionary *mutableRequest = [NSMutableDictionary dictionaryWithDictionary:publicDict];
    [mutableRequest setObject:@"getExUserId" forKey:@"operationType"];
    [mutableRequest setObject:time forKey:@"time"];
    [mutableRequest setObject:sign forKey:@"sign"];
    [mutableRequest setObject:_nick forKey:@"buyerNick"];
    
    NSString *temp = [SPSJsonWrapper jsonRepresentation:mutableRequest];
	return [TFCommand gateway:temp];
}


+(NSString *)queryItemDetail:(NSString *)itemId
{
    NSString *time = [Top currentTime];
    NSString *sign = [TFCommand TFSignMd5:@"queryItemDetail" time:time];
    
    
    NSMutableDictionary *publicDict = [[TFCommand shared] getPublic];
    
    NSMutableDictionary *mutableRequest = [NSMutableDictionary dictionaryWithDictionary:publicDict];
    [mutableRequest setObject:@"queryItemDetail" forKey:@"operationType"];
    [mutableRequest setObject:time forKey:@"time"];
    [mutableRequest setObject:sign forKey:@"sign"];
    
    [mutableRequest setObject:itemId forKey:@"itemId"];
	
    NSString *temp = [SPSJsonWrapper jsonRepresentation:mutableRequest];
	return [TFCommand gateway:temp];
}

+(NSString *)queryItemDetail:(NSString *)itemId from:(NSString *)from
{
    NSString *time = [Top currentTime];
    NSString *sign = [TFCommand TFSignMd5:@"queryItemDetail" time:time];
    
    
    NSMutableDictionary *publicDict = [[TFCommand shared] getPublic];
    
    NSMutableDictionary *mutableRequest = [NSMutableDictionary dictionaryWithDictionary:publicDict];
    [mutableRequest setObject:@"queryItemDetail" forKey:@"operationType"];
    [mutableRequest setObject:time forKey:@"time"];
    [mutableRequest setObject:sign forKey:@"sign"];
    
    [mutableRequest setObject:itemId?itemId:@"" forKey:@"itemId"];
    [mutableRequest setObject:from?from:@"" forKey:@"mobilePage"];
	
    NSString *temp = [SPSJsonWrapper jsonRepresentation:mutableRequest];
	return [TFCommand gateway:temp];
}


+(NSString *)queryShopDetail:(NSString *)shopNick pageArgument:(NSString *)pageArgument
{

    NSString *time = [Top currentTime];
    NSString *sign = [TFCommand TFSignMd5:@"queryShopDetail" time:time];
    
    NSString *sellerNick = [TFCommand setValue:shopNick];
    
    
    NSMutableDictionary *publicDict = [[TFCommand shared] getPublic];
    
    NSMutableDictionary *mutableRequest = [NSMutableDictionary dictionaryWithDictionary:publicDict];
    [mutableRequest setObject:@"queryShopDetail" forKey:@"operationType"];
    [mutableRequest setObject:time forKey:@"time"];
    [mutableRequest setObject:sign forKey:@"sign"];
    
    [mutableRequest setObject:sellerNick forKey:@"sellerNick"];
    [mutableRequest setObject:pageArgument forKey:@"pageArgument"];
    
    NSString *temp = [SPSJsonWrapper jsonRepresentation:mutableRequest];
	return [TFCommand gateway:temp];
}


+(NSString *)queryItemByShopCategory:(NSString *)shopNick cid1:(NSString *)cid1 cid2:(NSString *)cid2 pageNo:(NSString *)pageNo
{
    NSString *time = [Top currentTime];
    NSString *sign = [TFCommand TFSignMd5:@"queryItemByShopCategory" time:time];
    
    NSString *sellerNick = [TFCommand setValue:shopNick];
    NSString *_cid1 = [TFCommand setValue:cid1];
    NSString *_cid2 = [TFCommand setValue:cid2];
    
    
    NSMutableDictionary *publicDict = [[TFCommand shared] getPublic];
    
    NSMutableDictionary *mutableRequest = [NSMutableDictionary dictionaryWithDictionary:publicDict];
    [mutableRequest setObject:@"queryItemByShopCategory" forKey:@"operationType"];
    [mutableRequest setObject:time forKey:@"time"];
    [mutableRequest setObject:sign forKey:@"sign"];
    
    [mutableRequest setObject:@"12" forKey:@"pageSize"];
    [mutableRequest setObject:_cid1 forKey:@"shopCid1"];
    [mutableRequest setObject:_cid2 forKey:@"shopCid2"];
    [mutableRequest setObject:pageNo forKey:@"pageNo"];
    [mutableRequest setObject:sellerNick forKey:@"sellerNick"];
    
    NSString *temp = [SPSJsonWrapper jsonRepresentation:mutableRequest];
	return [TFCommand gateway:temp];
}
 */


//+(NSString *)queryMyFanli:(NSString *)pageNo alipay:(NSString *)alipay
//{
//    Top *mTop = [Top sharedTop];
//    NSString *buyerNick = [TFCommand setValue:mTop._nick];
//    
//    NSString *time = [Top currentTime];
//    NSString *sign = [TFCommand TFSignMd5:@"queryMyFanli" time:time];
//    
//    
//    NSMutableDictionary *publicDict = [[TFCommand shared] getPublic];
//    
//    NSMutableDictionary *mutableRequest = [NSMutableDictionary dictionaryWithDictionary:publicDict];
//    [mutableRequest setObject:@"queryMyFanli" forKey:@"operationType"];
//    [mutableRequest setObject:time forKey:@"time"];
//    [mutableRequest setObject:sign forKey:@"sign"];
//    
//    [mutableRequest setObject:@"12" forKey:@"pageSize"];
//    [mutableRequest setObject:pageNo forKey:@"pageNo"];
//    [mutableRequest setObject:buyerNick forKey:@"buyerNick"];
//    [mutableRequest setObject:alipay forKey:@"alipay"];
//
//    NSString *temp = [SPSJsonWrapper jsonRepresentation:mutableRequest];
//	return [TFCommand gateway:temp];
//}

//+(NSString *)queryMyCollection:(NSString *)pageNo
//{
//    
//    Top *mTop = [Top sharedTop];
//    NSString *buyerNick = [TFCommand setValue:mTop._nick];
//    
//    NSString *time = [Top currentTime];
//    NSString *sign = [TFCommand TFSignMd5:@"queryMyCollection" time:time];
//    
//
//    NSMutableDictionary *publicDict = [[TFCommand shared] getPublic];
//    
//    NSMutableDictionary *mutableRequest = [NSMutableDictionary dictionaryWithDictionary:publicDict];
//    [mutableRequest setObject:@"queryMyCollection" forKey:@"operationType"];
//    [mutableRequest setObject:time forKey:@"time"];
//    [mutableRequest setObject:sign forKey:@"sign"];
//    
//    [mutableRequest setObject:pageNo forKey:@"pageNo"];
//    [mutableRequest setObject:@"12" forKey:@"pageSize"];
//    [mutableRequest setObject:buyerNick forKey:@"buyerNick"];
//    
//    NSString *temp = [SPSJsonWrapper jsonRepresentation:mutableRequest];
//	return [TFCommand gateway:temp];
//}

//+(NSString *)queryFanliSuper:(NSString *)pageNo{return NULL;}


//+(NSString *)recommendation:(NSString *)content
//{
//    NSString *time = [Top currentTime];
//    NSString *sign = [TFCommand TFSignMd5:@"recommendation" time:time];
//    
//    
//    NSMutableDictionary *publicDict = [[TFCommand shared] getPublic];
//    
//    NSMutableDictionary *mutableRequest = [NSMutableDictionary dictionaryWithDictionary:publicDict];
//    [mutableRequest setObject:@"recommendation" forKey:@"operationType"];
//    [mutableRequest setObject:time forKey:@"time"];
//    [mutableRequest setObject:sign forKey:@"sign"];
//    
//    [mutableRequest setObject:content forKey:@"content"];
//	
//    NSString *temp = [SPSJsonWrapper jsonRepresentation:mutableRequest];
//	return [TFCommand gateway:temp];
//}


//+(NSString *)updateClickMark:(NSString *)visitTime
//                      itemId:(NSString *)itemId
//                    clickUrl:(NSString *)clickUrl
//                      tkRate:(NSString *)tkRate
//{
//    NSString *time = [Top currentTime];
//    NSString *sign = [TFCommand TFSignMd5:@"updateClickMark" time:time];
//    NSString *base64Url = [GTMBase64 stringByEncodingData:[clickUrl dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    
//    NSString *_itemId = [TFCommand setValue:itemId];
//    NSString *_tkRate = [TFCommand setValue:tkRate];
//    
//    NSMutableDictionary *publicDict = [[TFCommand shared] getPublic];
//    
//    NSMutableDictionary *mutableRequest = [NSMutableDictionary dictionaryWithDictionary:publicDict];
//    [mutableRequest setObject:@"updateClickMark" forKey:@"operationType"];
//    [mutableRequest setObject:time forKey:@"time"];
//    [mutableRequest setObject:sign forKey:@"sign"];
//    
//    [mutableRequest setObject:visitTime forKey:@"visitTime"];
//    [mutableRequest setObject:base64Url forKey:@"clickUrl"];
//    [mutableRequest setObject:_tkRate forKey:@"tkRate"];
//    [mutableRequest setObject:_itemId forKey:@"itemId"];
//    
//    NSString *temp = [SPSJsonWrapper jsonRepresentation:mutableRequest];
//	return [TFCommand gateway:temp];
//}

//+(NSString *)updateClickUrl:(NSString *)itemId mobilePage:(NSString *)mobilePage{
//    NSString *time = [Top currentTime];
//    NSString *sign = [TFCommand TFSignMd5:@"updateClickUrl" time:time];
//    
//    NSMutableDictionary *publicDict = [[TFCommand shared] getPublic];
//    
//    NSMutableDictionary *mutableRequest = [NSMutableDictionary dictionaryWithDictionary:publicDict];
//    [mutableRequest setObject:@"updateClickUrl" forKey:@"operationType"];
//    [mutableRequest setObject:time forKey:@"time"];
//    [mutableRequest setObject:sign forKey:@"sign"];
//    
//    [mutableRequest setObject:itemId forKey:@"itemId"];
//    
//    [mutableRequest setObject:mobilePage?mobilePage:@"" forKey:@"mobilePage"];
//    
//    
//    NSString *temp = [SPSJsonWrapper jsonRepresentation:mutableRequest];
//	return [TFCommand gateway:temp];
//}

//+(NSString *)updateClickUrl:(NSString *)itemId
//{
//    NSString *time = [Top currentTime];
//    NSString *sign = [TFCommand TFSignMd5:@"updateClickUrl" time:time];
//    
//    NSMutableDictionary *publicDict = [[TFCommand shared] getPublic];
//    
//    NSMutableDictionary *mutableRequest = [NSMutableDictionary dictionaryWithDictionary:publicDict];
//    [mutableRequest setObject:@"updateClickUrl" forKey:@"operationType"];
//    [mutableRequest setObject:time forKey:@"time"];
//    [mutableRequest setObject:sign forKey:@"sign"];
//    
//    [mutableRequest setObject:itemId forKey:@"itemId"];
//    
//    NSString *temp = [SPSJsonWrapper jsonRepresentation:mutableRequest];
//	return [TFCommand gateway:temp];
//}


//+(NSString *)queryRateList:(NSString *)itemId seller_nick:(NSString *)nick pageNo:(NSString *)pageNo
//{
//    NSString *time = [Top currentTime];
//    NSString *sign = [TFCommand TFSignMd5:@"queryRateList" time:time];
//    
//    NSMutableDictionary *publicDict = [[TFCommand shared] getPublic];
//    
//    NSMutableDictionary *mutableRequest = [NSMutableDictionary dictionaryWithDictionary:publicDict];
//    [mutableRequest setObject:@"queryRateList" forKey:@"operationType"];
//    [mutableRequest setObject:time forKey:@"time"];
//    [mutableRequest setObject:sign forKey:@"sign"];
//    
//    [mutableRequest setObject:itemId forKey:@"itemId"];
//    [mutableRequest setObject:nick forKey:@"sellerNick"];
//    [mutableRequest setObject:@"10" forKey:@"pageSize"];
//    [mutableRequest setObject:pageNo forKey:@"pageNo"];
//    
//    NSString *temp = [SPSJsonWrapper jsonRepresentation:mutableRequest];
//	return [TFCommand gateway:temp];
//}

//+(NSString *)queryItemDetailDes:(NSString *)itemId
//{
//    NSString *time = [Top currentTime];
//    NSString *sign = [TFCommand TFSignMd5:@"queryItemDetailDes" time:time];
//    
//    NSMutableDictionary *publicDict = [[TFCommand shared] getPublic];
//    
//    NSMutableDictionary *mutableRequest = [NSMutableDictionary dictionaryWithDictionary:publicDict];
//    [mutableRequest setObject:@"queryItemDetailDes" forKey:@"operationType"];
//    [mutableRequest setObject:time forKey:@"time"];
//    [mutableRequest setObject:sign forKey:@"sign"];
//    
//    [mutableRequest setObject:itemId forKey:@"itemId"];
//   
//    NSString *temp = [SPSJsonWrapper jsonRepresentation:mutableRequest];
//	return [TFCommand gateway:temp];
//}

//+(NSString *)querySearchShopGoodsResultPage:(NSString *)pageNo
//                                    keyWord:(NSString *)keyWord
//                                    orderBy:(NSString *)orderBy
//                                 startPrice:(NSString *)startPrice
//                                   endPrice:(NSString *)endPrice
//                                    isTmall:(NSString *)isTmall
//                                 sellerNick:(NSString *)sellerNick
//{
//    NSString *time = [Top currentTime];
//    NSString *sign = [TFCommand TFSignMd5:@"searchShopGoods" time:time];
//    
//    
//    NSMutableDictionary *publicDict = [[TFCommand shared] getPublic];
//    
//    NSMutableDictionary *mutableRequest = [NSMutableDictionary dictionaryWithDictionary:publicDict];
//    [mutableRequest setObject:@"searchShopGoods" forKey:@"operationType"];
//    [mutableRequest setObject:time forKey:@"time"];
//    [mutableRequest setObject:sign forKey:@"sign"];
//    [mutableRequest setObject:sellerNick forKey:@"sellerNick"];
//    [mutableRequest setObject:keyWord forKey:@"keyWord"];
//    [mutableRequest setObject:pageNo forKey:@"pageNo"];
//    [mutableRequest setObject:@"12" forKey:@"pageSize"];
//    [mutableRequest setObject:orderBy forKey:@"orderBy"];
//    if (startPrice) {
//        [mutableRequest setObject:startPrice forKey:@"start_price"];
//    }
//    if (endPrice) {
//        [mutableRequest setObject:endPrice forKey:@"end_price"];
//    }
//    if (isTmall) {
//        [mutableRequest setObject:isTmall forKey:@"isTmall"];
//    }
//    
//    NSString *temp = [SPSJsonWrapper jsonRepresentation:mutableRequest];
//	return [TFCommand gateway:temp];
//}


//+(NSString *)searchGoods:(NSString *)pageNo
//                           keyWord:(NSString *)keyWord
//                           orderBy:(NSString *)orderBy
//                        startPrice:(NSString *)startPrice
//                          endPrice:(NSString *)endPrice
//                           isTmall:(NSString *)isTmall
//                            itemId:(NSString *)itemId
//                            searchFlag:(NSString *)searchFlag
//{
//    NSString *time = [Top currentTime];
//    NSString *sign = [TFCommand TFSignMd5:@"searchGoods" time:time];
//    
//
//    NSMutableDictionary *publicDict = [[TFCommand shared] getPublic];
//    
//    NSMutableDictionary *mutableRequest = [NSMutableDictionary dictionaryWithDictionary:publicDict];
//    [mutableRequest setObject:@"searchGoods" forKey:@"operationType"];
//    [mutableRequest setObject:time forKey:@"time"];
//    [mutableRequest setObject:sign forKey:@"sign"];
//    
//    [mutableRequest setObject:keyWord forKey:@"keyWord"];
//    [mutableRequest setObject:pageNo forKey:@"pageNo"];
//    [mutableRequest setObject:@"12" forKey:@"pageSize"];
//    [mutableRequest setObject:orderBy forKey:@"orderBy"];
//    if (startPrice) {
//        [mutableRequest setObject:startPrice forKey:@"start_price"];
//    }
//    if (endPrice) {
//        [mutableRequest setObject:endPrice forKey:@"end_price"];
//    }
//    if (isTmall) {
//        [mutableRequest setObject:isTmall forKey:@"isTmall"];
//    }
//    if (itemId) {
//        [mutableRequest setObject:itemId forKey:@"itemId"];
//    }
//    if (searchFlag) {
//        [mutableRequest setObject:searchFlag forKey:@"searchFlag"];
//    }
//    
//    NSString *temp = [SPSJsonWrapper jsonRepresentation:mutableRequest];
//	return [TFCommand gateway:temp];
//}

//+(NSString *)querySearchResultPage:(NSString *)pageNo
//                           keyWord:(NSString *)keyWord
//                           orderBy:(NSString *)orderBy{
//    NSString *time = [Top currentTime];
//    NSString *sign = [TFCommand TFSignMd5:@"searchGoods" time:time];
//    
//    
//    NSMutableDictionary *publicDict = [[TFCommand shared] getPublic];
//    
//    NSMutableDictionary *mutableRequest = [NSMutableDictionary dictionaryWithDictionary:publicDict];
//    [mutableRequest setObject:@"searchGoods" forKey:@"operationType"];
//    [mutableRequest setObject:time forKey:@"time"];
//    [mutableRequest setObject:sign forKey:@"sign"];
//    
//    [mutableRequest setObject:keyWord forKey:@"keyWord"];
//    [mutableRequest setObject:pageNo forKey:@"pageNo"];
//    [mutableRequest setObject:@"12" forKey:@"pageSize"];
//    [mutableRequest setObject:orderBy forKey:@"orderBy"];
//   
//    
//    NSString *temp = [SPSJsonWrapper jsonRepresentation:mutableRequest];
//	return [TFCommand gateway:temp];
//}

//商品分类
//+(NSString *)queryItemCategory
//{
//    NSString *time = [Top currentTime];
//    NSString *sign = [TFCommand TFSignMd5:@"queryItemCategory" time:time];
//    
//    
//    NSMutableDictionary *publicDict = [[TFCommand shared] getPublic];
//    
//    NSMutableDictionary *mutableRequest = [NSMutableDictionary dictionaryWithDictionary:publicDict];
//    [mutableRequest setObject:@"queryItemCategory" forKey:@"operationType"];
//    [mutableRequest setObject:time forKey:@"time"];
//    [mutableRequest setObject:sign forKey:@"sign"];
//    
//    NSString *temp = [SPSJsonWrapper jsonRepresentation:mutableRequest];
//	return [TFCommand gateway:temp];
//}

//+(NSString *)queryKingShop
//{
//    NSString *time = [Top currentTime];
//    NSString *sign = [TFCommand TFSignMd5:@"queryKingShop" time:time];
//    
//    NSMutableDictionary *publicDict = [[TFCommand shared] getPublic];
//    
//    NSMutableDictionary *mutableRequest = [NSMutableDictionary dictionaryWithDictionary:publicDict];
//    [mutableRequest setObject:@"queryKingShop" forKey:@"operationType"];
//    [mutableRequest setObject:time forKey:@"time"];
//    [mutableRequest setObject:sign forKey:@"sign"];
//   
//    NSString *temp = [SPSJsonWrapper jsonRepresentation:mutableRequest];
//	return [TFCommand gateway:temp];
//}

//+(NSString *)queryDefaultAttention
//{
//    NSString *time = [Top currentTime];
//    NSString *sign = [TFCommand TFSignMd5:@"queryDefaultAttention" time:time];
// 
//    NSMutableDictionary *publicDict = [[TFCommand shared] getPublic];
//    
//    NSMutableDictionary *mutableRequest = [NSMutableDictionary dictionaryWithDictionary:publicDict];
//    [mutableRequest setObject:@"queryDefaultAttention" forKey:@"operationType"];
//    [mutableRequest setObject:time forKey:@"time"];
//    [mutableRequest setObject:sign forKey:@"sign"];
//    
//    NSString *temp = [SPSJsonWrapper jsonRepresentation:mutableRequest];
//	return [TFCommand gateway:temp];
//}


//+(NSString *)queryUserAttention
//{
//    NSString *time = [Top currentTime];
//    NSString *sign = [TFCommand TFSignMd5:@"queryUserAttention" time:time];
//   
//    NSMutableDictionary *publicDict = [[TFCommand shared] getPublic];
//    
//    NSMutableDictionary *mutableRequest = [NSMutableDictionary dictionaryWithDictionary:publicDict];
//    [mutableRequest setObject:@"queryUserAttention" forKey:@"operationType"];
//    [mutableRequest setObject:time forKey:@"time"];
//    [mutableRequest setObject:sign forKey:@"sign"];
//    
//    NSString *temp = [SPSJsonWrapper jsonRepresentation:mutableRequest];
//	return [TFCommand gateway:temp];
//}


//+(NSString *)deleteUserAttention:(NSString *)focusId
//{
//    NSString *time = [Top currentTime];
//    NSString *sign = [TFCommand TFSignMd5:@"deleteUserAttention" time:time];
//    
//    NSMutableDictionary *publicDict = [[TFCommand shared] getPublic];
//    
//    NSMutableDictionary *mutableRequest = [NSMutableDictionary dictionaryWithDictionary:publicDict];
//    [mutableRequest setObject:@"deleteUserAttention" forKey:@"operationType"];
//    [mutableRequest setObject:time forKey:@"time"];
//    [mutableRequest setObject:sign forKey:@"sign"];
//    
//    [mutableRequest setObject:focusId forKey:@"focusId"];
//    
//    NSString *temp = [SPSJsonWrapper jsonRepresentation:mutableRequest];
//	return [TFCommand gateway:temp];
//}


//+(NSString *)addUserAttention:(NSString *)focusId shopName:(NSString *)shopName logo:(NSString *)logo shopLevel:(NSString *)shopLevel
//{
//    NSString *time = [Top currentTime];
//    NSString *sign = [TFCommand TFSignMd5:@"addUserAttention" time:time];
//    
//    NSMutableDictionary *publicDict = [[TFCommand shared] getPublic];
//    
//    NSMutableDictionary *mutableRequest = [NSMutableDictionary dictionaryWithDictionary:publicDict];
//    [mutableRequest setObject:@"addUserAttention" forKey:@"operationType"];
//    [mutableRequest setObject:time forKey:@"time"];
//    [mutableRequest setObject:sign forKey:@"sign"];
//    
//    [mutableRequest setObject:focusId forKey:@"focusId"];
//    [mutableRequest setObject:shopName forKey:@"shopName"];
//    [mutableRequest setObject:logo forKey:@"logo"];
//    [mutableRequest setObject:shopLevel forKey:@"shopLevel"];
//    
//    NSString *temp = [SPSJsonWrapper jsonRepresentation:mutableRequest];
//	return [TFCommand gateway:temp];
//}


//+(NSString *)queryTopicStreet:(NSString *)pageNo
//{
//    NSString *time = [Top currentTime];
//    NSString *sign = [TFCommand TFSignMd5:@"queryTopicStreet" time:time];
//    
//    NSMutableDictionary *publicDict = [[TFCommand shared] getPublic];
//    
//    NSMutableDictionary *mutableRequest = [NSMutableDictionary dictionaryWithDictionary:publicDict];
//    [mutableRequest setObject:@"queryTopicStreet" forKey:@"operationType"];
//    [mutableRequest setObject:time forKey:@"time"];
//    [mutableRequest setObject:sign forKey:@"sign"];
//    
//    [mutableRequest setObject:pageNo forKey:@"pageNo"];
//    [mutableRequest setObject:@"12" forKey:@"pageSize"];
//    
//    NSString *temp = [SPSJsonWrapper jsonRepresentation:mutableRequest];
//	return [TFCommand gateway:temp];
//}


//+(NSString *)queryHotShop:(NSString *)pageNo
//{
//    NSString *time = [Top currentTime];
//    NSString *sign = [TFCommand TFSignMd5:@"queryHotShop" time:time];
//    
//    NSMutableDictionary *publicDict = [[TFCommand shared] getPublic];
//    
//    NSMutableDictionary *mutableRequest = [NSMutableDictionary dictionaryWithDictionary:publicDict];
//    [mutableRequest setObject:@"queryHotShop" forKey:@"operationType"];
//    [mutableRequest setObject:time forKey:@"time"];
//    [mutableRequest setObject:sign forKey:@"sign"];
//    
//    [mutableRequest setObject:pageNo forKey:@"pageNo"];
//    [mutableRequest setObject:@"12" forKey:@"pageSize"];
//    
//    NSString *temp = [SPSJsonWrapper jsonRepresentation:mutableRequest];
//	return [TFCommand gateway:temp];
//}


//+(NSString *)searchHotShop:(NSString *)keyword pageNo:(NSString *)pageNo
//{
//    NSString *time = [Top currentTime];
//    NSString *sign = [TFCommand TFSignMd5:@"searchHotShop" time:time];
//    
//    NSMutableDictionary *publicDict = [[TFCommand shared] getPublic];
//    
//    NSMutableDictionary *mutableRequest = [NSMutableDictionary dictionaryWithDictionary:publicDict];
//    [mutableRequest setObject:@"searchHotShop" forKey:@"operationType"];
//    [mutableRequest setObject:time forKey:@"time"];
//    [mutableRequest setObject:sign forKey:@"sign"];
//    
//    [mutableRequest setObject:keyword forKey:@"keyword"];
//    [mutableRequest setObject:pageNo forKey:@"pageNo"];
//    [mutableRequest setObject:@"12" forKey:@"pageSize"];
//    
//    NSString *temp = [SPSJsonWrapper jsonRepresentation:mutableRequest];
//	return [TFCommand gateway:temp];
//}

//+(NSString *)queryHadFanliOrders:(NSString *)pageNo
//{
//    NSString *time = [Top currentTime];
//    NSString *sign = [TFCommand TFSignMd5:@"queryHadFanliOrders" time:time];
//    
//    NSMutableDictionary *publicDict = [[TFCommand shared] getPublic];
//    
//    NSMutableDictionary *mutableRequest = [NSMutableDictionary dictionaryWithDictionary:publicDict];
//    [mutableRequest setObject:@"queryHadFanliOrders" forKey:@"operationType"];
//    [mutableRequest setObject:time forKey:@"time"];
//    [mutableRequest setObject:sign forKey:@"sign"];
//    
//    [mutableRequest setObject:pageNo forKey:@"pageNo"];
//    [mutableRequest setObject:@"12" forKey:@"pageSize"];
//    
//    NSString *temp = [SPSJsonWrapper jsonRepresentation:mutableRequest];
//	return [TFCommand gateway:temp];       
//}

//+(NSString *)queryFanliConfirm:(NSString *)pageNo code:(NSString *)code{
//    NSString *time = [Top currentTime];
//    NSString *sign = [TFCommand TFSignMd5:@"queryFanliList" time:time];
//    
//    NSMutableDictionary *publicDict = [[TFCommand shared] getPublic];
//    
//    NSMutableDictionary *mutableRequest = [NSMutableDictionary dictionaryWithDictionary:publicDict];
//    [mutableRequest setObject:@"queryFanliList" forKey:@"operationType"];
//    [mutableRequest setObject:time forKey:@"time"];
//    [mutableRequest setObject:sign forKey:@"sign"];
//    
//    [mutableRequest setObject:pageNo forKey:@"pageNo"];
//    [mutableRequest setObject:code?code:@"" forKey:@"code"];
//    [mutableRequest setObject:@"12" forKey:@"pageSize"];
//    
//    NSString *temp = [SPSJsonWrapper jsonRepresentation:mutableRequest];
//	return [TFCommand gateway:temp];
//}

//+(NSString *)shakePrize:(NSString *)shakeChannel shakeToken:(NSString *)shakeToken shakeTime:(NSString *)shakeTime shakeMode:(NSString *)shakeMode
//{
//    NSString *time = [Top currentTime];
//    NSString *sign = [TFCommand TFSignMd5:@"shakeExPrize" time:time];
//    
//    
//    NSMutableDictionary *publicDict = [[TFCommand shared] getPublic];
//    
//    NSMutableDictionary *mutableRequest = [NSMutableDictionary dictionaryWithDictionary:publicDict];
//    [mutableRequest setObject:@"shakeExPrize" forKey:@"operationType"];
//    [mutableRequest setObject:time forKey:@"time"];
//    [mutableRequest setObject:sign forKey:@"sign"];
//    
//    [mutableRequest setObject:shakeChannel?shakeChannel:@"" forKey:@"shakeChannel"];
//    [mutableRequest setObject:shakeToken?shakeToken:@"" forKey:@"shakeToken"];
//    [mutableRequest setObject:shakeTime?shakeTime:@"" forKey:@"shakeTime"];
//    [mutableRequest setObject:shakeMode?shakeMode:@"" forKey:@"shakeMode"];
//    
//    NSString *temp = [SPSJsonWrapper jsonRepresentation:mutableRequest];
//	return [TFCommand gateway:temp];      
//}

//+(NSString *)shareFriend:(NSString *)body
//{
//    NSString *time = [Top currentTime];
//    NSString *sign = [TFCommand TFSignMd5:@"shareFriend" time:time];
//  
//    NSMutableDictionary *publicDict = [[TFCommand shared] getPublic];
//    
//    NSMutableDictionary *mutableRequest = [NSMutableDictionary dictionaryWithDictionary:publicDict];
//    [mutableRequest setObject:@"shareFriend" forKey:@"operationType"];
//    [mutableRequest setObject:time forKey:@"time"];
//    [mutableRequest setObject:sign forKey:@"sign"];
//    
//    [mutableRequest setObject:body forKey:@"mobile"];
//    
//    NSString *temp = [SPSJsonWrapper jsonRepresentation:mutableRequest];
//	return [TFCommand gateway:temp];      
//}

//+(NSString *)updateMyTaobao:(NSString *)body tbNick:(NSString *)tbNick
//{
//    NSString *time = [Top currentTime];
//    NSString *sign = [TFCommand TFSignMd5:@"updateMyTaobao" time:time];
//    
//    NSMutableDictionary *publicDict = [[TFCommand shared] getPublic];
//    
//    NSMutableDictionary *mutableRequest = [NSMutableDictionary dictionaryWithDictionary:publicDict];
//    [mutableRequest setObject:@"updateMyTaobao" forKey:@"operationType"];
//    [mutableRequest setObject:time forKey:@"time"];
//    [mutableRequest setObject:sign forKey:@"sign"];
//    
//    [mutableRequest setObject:body forKey:@"body"];
//    [mutableRequest setObject:tbNick forKey:@"tbNick"];
//	
//    NSString *temp = [SPSJsonWrapper jsonRepresentation:mutableRequest];
//	return [TFCommand gateway:temp];      
//}

//+ (NSString *)queryShakeMoney:(NSString *)pageNo pageSize:(NSString *)pageSize{
//
//    NSString *time = [Top currentTime];
//    NSString *sign = [TFCommand TFSignMd5:@"queryShakeMoney" time:time];
//    
//    NSMutableDictionary *publicDict = [[TFCommand shared] getPublic];
//    
//    NSMutableDictionary *mutableRequest = [NSMutableDictionary dictionaryWithDictionary:publicDict];
//    [mutableRequest setObject:@"queryShakeMoney" forKey:@"operationType"];
//    [mutableRequest setObject:time forKey:@"time"];
//    [mutableRequest setObject:sign forKey:@"sign"];
//    
//    [mutableRequest setObject:pageNo forKey:@"pageNo"];
//    [mutableRequest setObject:pageSize?pageSize:@"12" forKey:@"pageSize"];
//    
//
//    NSString *temp = [SPSJsonWrapper jsonRepresentation:mutableRequest];
//	return [TFCommand gateway:temp];       
//
//}

//+ (NSString *)queryShopHomePage:(NSString *)aPage 
//                       pageSize:(NSString *)aSize 
//                         shopId:(NSString *)aId 
//                     updateTime:(NSString *)aUpdateTime{
//
//    NSString *time = [Top currentTime];
//    NSString *sign = [TFCommand TFSignMd5:@"queryShopHomePage" time:time];
//    
//    NSMutableDictionary *publicDict = [[TFCommand shared] getPublic];
//    
//    NSMutableDictionary *mutableRequest = [NSMutableDictionary dictionaryWithDictionary:publicDict];
//    [mutableRequest setObject:@"queryShopHomePage" forKey:@"operationType"];
//    [mutableRequest setObject:time forKey:@"time"];
//    [mutableRequest setObject:sign forKey:@"sign"];
//    
//    [mutableRequest setObject:aPage forKey:@"pageNo"];
//    [mutableRequest setObject:aId forKey:@"shopId"];
//    [mutableRequest setObject:aSize?aSize:@"12" forKey:@"pageSize"];
//    [mutableRequest setObject:aUpdateTime?aUpdateTime:@"" forKey:@"updateTime"];
//	
//    NSString *temp = [SPSJsonWrapper jsonRepresentation:mutableRequest];
//	return [TFCommand gateway:temp];       
//}

//+ (NSString *)queryHotDetail:(NSString *)hotId shopId:(NSString *)shopId{
//    NSString *time = [Top currentTime];
//    NSString *sign = [TFCommand TFSignMd5:@"queryHotDetail" time:time];
//    
//    NSMutableDictionary *publicDict = [[TFCommand shared] getPublic];
//    
//    NSMutableDictionary *mutableRequest = [NSMutableDictionary dictionaryWithDictionary:publicDict];
//    [mutableRequest setObject:@"queryHotDetail" forKey:@"operationType"];
//    [mutableRequest setObject:hotId forKey:@"hotId"];
//    [mutableRequest setObject:shopId  forKey:@"shopId"];
//    [mutableRequest setObject:time forKey:@"time"];
//    [mutableRequest setObject:sign forKey:@"sign"];
//	
//    NSString *temp = [SPSJsonWrapper jsonRepresentation:mutableRequest];
//	return [TFCommand gateway:temp];
//}


///上传点击记录
//+ (NSString *)updateUserClickUrl:(NSString *)itemId
//                           price:(NSString *)price
//                          tkRate:(NSString *)tkRate
//                      mobileTime:(NSString *)mobileTime
//                        clickUrl:(NSString *)clickUrl{
//    
//    NSString *time = [Top currentTime];
//    NSString *sign = [TFCommand TFSignMd5:@"updateUserClickUrl" time:time];
//    NSString *base64Url = [GTMBase64 stringByEncodingData:[clickUrl dataUsingEncoding:NSUTF8StringEncoding]];
//        
//    NSMutableDictionary *publicDict = [[TFCommand shared] getPublic];
//    
//    NSMutableDictionary *mutableRequest = [NSMutableDictionary dictionaryWithDictionary:publicDict];
//    [mutableRequest setObject:@"updateUserClickUrl" forKey:@"operationType"];
//    [mutableRequest setObject:time forKey:@"time"];
//    [mutableRequest setObject:sign forKey:@"sign"];
//    
//    assert(itemId != nil);
//    [mutableRequest setObject:itemId?itemId:@"" forKey:@"itemId"];
//    assert(price != nil);
//    [mutableRequest setObject:price?price:@"" forKey:@"price"];
//    [mutableRequest setObject:tkRate?tkRate:@"" forKey:@"tkRate"];
//    [mutableRequest setObject:mobileTime forKey:@"mobileTime"];
//    [mutableRequest setObject:base64Url forKey:@"clickUrl"];
//    
//    NSString *temp = [SPSJsonWrapper jsonRepresentation:mutableRequest];
//	return [TFCommand gateway:temp];
//}

///上传下单记录
//+ (NSString *)updateUserOrder:(NSString *)itemId
//                        price:(NSString *)price
//                       tkRate:(NSString *)tkRate
//                   mobileTime:(NSString *)mobileTime
//                     clickUrl:(NSString *)clickUrl
//                      orderNo:(NSString *)orderNo{
//
//    NSString *time = [Top currentTime];
//    NSString *sign = [TFCommand TFSignMd5:@"updateUserOrder" time:time];
//    NSString *base64Url = [GTMBase64 stringByEncodingData:[clickUrl dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    
//    NSMutableDictionary *publicDict = [[TFCommand shared] getPublic];
//    
//    NSMutableDictionary *mutableRequest = [NSMutableDictionary dictionaryWithDictionary:publicDict];
//    [mutableRequest setObject:@"updateUserOrder" forKey:@"operationType"];
//    [mutableRequest setObject:time forKey:@"time"];
//    [mutableRequest setObject:sign forKey:@"sign"];
//    
//    [mutableRequest setObject:itemId forKey:@"itemId"];
//    [mutableRequest setObject:price forKey:@"price"];
//    [mutableRequest setObject:tkRate forKey:@"tkRate"];
//    [mutableRequest setObject:mobileTime forKey:@"mobileTime"];
//    [mutableRequest setObject:base64Url forKey:@"clickUrl"];
//    [mutableRequest setObject:orderNo forKey:@"orderNo"];
//
//    NSString *temp = [SPSJsonWrapper jsonRepresentation:mutableRequest];
//	return [TFCommand gateway:temp];
//}


//+ (NSString *)queryUserItemHistory:(NSString *)pageNo
//                          pageSize:(NSString *)pageSize{
//
//    NSString *time = [Top currentTime];
//    NSString *sign = [TFCommand TFSignMd5:@"queryUserItemHistory" time:time];
//    
//    NSMutableDictionary *publicDict = [[TFCommand shared] getPublic];
//    
//    NSMutableDictionary *mutableRequest = [NSMutableDictionary dictionaryWithDictionary:publicDict];
//    [mutableRequest setObject:@"queryUserItemHistory" forKey:@"operationType"];
//    [mutableRequest setObject:time forKey:@"time"];
//    [mutableRequest setObject:sign forKey:@"sign"];
//    
//    [mutableRequest setObject:pageNo forKey:@"pageNo"];
//    [mutableRequest setObject:pageSize forKey:@"pageSize"];
//    
//    
//    NSString *temp = [SPSJsonWrapper jsonRepresentation:mutableRequest];
//	return [TFCommand gateway:temp];
//}

//+ (NSString *)queryIPadItemDetail:(NSString *)itemId{
//    
//    NSString *time = [Top currentTime];
//    NSString *sign = [TFCommand TFSignMd5:@"queryIPadItemDetail" time:time];
//    
//    
//    NSMutableDictionary *publicDict = [[TFCommand shared] getPublic];
//    
//    NSMutableDictionary *mutableRequest = [NSMutableDictionary dictionaryWithDictionary:publicDict];
//    [mutableRequest setObject:@"queryIPadItemDetail" forKey:@"operationType"];
//    [mutableRequest setObject:time forKey:@"time"];
//    [mutableRequest setObject:sign forKey:@"sign"];
//    
//    [mutableRequest setObject:itemId forKey:@"itemId"];
//	
//	NSString *temp = [mutableRequest JSONRepresentation];
//	return [TFCommand gateway:temp];
//
//}

//+ (NSString *)queryIPadItemDetail:(NSString *)itemId from:(NSString *)from{
//    
//    NSString *time = [Top currentTime];
//    NSString *sign = [TFCommand TFSignMd5:@"queryIPadItemDetail" time:time];
//    
//    
//    NSMutableDictionary *publicDict = [[TFCommand shared] getPublic];
//    
//    NSMutableDictionary *mutableRequest = [NSMutableDictionary dictionaryWithDictionary:publicDict];
//    [mutableRequest setObject:@"queryIPadItemDetail" forKey:@"operationType"];
//    [mutableRequest setObject:time forKey:@"time"];
//    [mutableRequest setObject:sign forKey:@"sign"];
//    
//    [mutableRequest setObject:itemId forKey:@"itemId"];
//    [mutableRequest setObject:from?from:@"" forKey:@"mobilePage"];
//	
//	NSString *temp = [mutableRequest JSONRepresentation];
//	return [TFCommand gateway:temp];
//}


//+ (NSString *)queryIPadItemDetailImageList:(NSString *)itemId{
//    
//    NSString *time = [Top currentTime];
//    NSString *sign = [TFCommand TFSignMd5:@"queryIPadItemDetailImageList" time:time];
//    
//    
//    NSMutableDictionary *publicDict = [[TFCommand shared] getPublic];
//    
//    NSMutableDictionary *mutableRequest = [NSMutableDictionary dictionaryWithDictionary:publicDict];
//    [mutableRequest setObject:@"queryIPadItemDetailImageList" forKey:@"operationType"];
//    [mutableRequest setObject:time forKey:@"time"];
//    [mutableRequest setObject:sign forKey:@"sign"];
//    
//    [mutableRequest setObject:itemId forKey:@"itemId"];
//	
//	NSString *temp = [mutableRequest JSONRepresentation];
//	return [TFCommand gateway:temp];
//}

//+(NSString *)queryHotWord
//{
//    NSString *time = [Top currentTime];
//    NSString *sign = [TFCommand TFSignMd5:@"queryHotWord" time:time];
//
//    
//    NSMutableDictionary *publicDict = [[TFCommand shared] getPublic];
//    
//    NSMutableDictionary *mutableRequest = [NSMutableDictionary dictionaryWithDictionary:publicDict];
//    [mutableRequest setObject:@"queryHotWord" forKey:@"operationType"];
//    [mutableRequest setObject:time forKey:@"time"];
//    [mutableRequest setObject:sign forKey:@"sign"];
//	
//	NSString *temp = [mutableRequest JSONRepresentation];
//	return [TFCommand gateway:temp];
//}

//+ (NSString *)checkUpdate{
//    NSString *time = [Top currentTime];
//    NSString *sign = [TFCommand TFSignMd5:@"checkUpdate" time:time];
//    
//    
//    NSMutableDictionary *publicDict = [[TFCommand shared] getPublic];
//    
//    NSMutableDictionary *mutableRequest = [NSMutableDictionary dictionaryWithDictionary:publicDict];
//    [mutableRequest setObject:@"checkUpdate" forKey:@"operationType"];
//    [mutableRequest setObject:time forKey:@"time"];
//    [mutableRequest setObject:sign forKey:@"sign"];
//
//	
//	NSString *temp = [SPSJsonWrapper jsonRepresentation:mutableRequest];
//	return [TFCommand gateway:temp];
//
//}


//+ (NSString *)queryInvite:(int)pageNo
//                 pageSize:(int)pageSize{
//    
//    NSString *time = [Top currentTime];
//    NSString *sign = [TFCommand TFSignMd5:@"queryInvite" time:time];
//    
//    NSMutableDictionary *publicDict = [[TFCommand shared] getPublic];
//    
//    NSMutableDictionary *mutableRequest = [NSMutableDictionary dictionaryWithDictionary:publicDict];
//    [mutableRequest setObject:@"queryInvite" forKey:@"operationType"];
//    [mutableRequest setObject:time forKey:@"time"];
//    [mutableRequest setObject:sign forKey:@"sign"];
//    
//    [mutableRequest setObject:[NSString stringWithFormat:@"%d",pageNo] forKey:@"pageNo"];
//    [mutableRequest setObject:[NSString stringWithFormat:@"%d",pageSize] forKey:@"pageSize"];
//    
//    
//    NSString *temp = [SPSJsonWrapper jsonRepresentation:mutableRequest];
//	return [TFCommand gateway:temp];
//}

#pragma mark - 积分墙相关

//+ (NSString *)queryAdFeed:(int)pageNo
//                 pageSize:(int)pageSize {
//    NSString *time = [Top currentTime];
//    NSString *sign = [TFCommand TFSignMd5:@"queryAdFeed" time:time];
//    
//    NSMutableDictionary *publicDict = [[TFCommand shared] getPublic];
//    
//    NSMutableDictionary *mutableRequest = [NSMutableDictionary dictionaryWithDictionary:publicDict];
//    [mutableRequest setObject:@"queryAdFeed" forKey:@"operationType"];
//    [mutableRequest setObject:time forKey:@"time"];
//    [mutableRequest setObject:sign forKey:@"sign"];
//    
//    [mutableRequest setObject:[NSString stringWithFormat:@"%d",pageNo] forKey:@"pageNo"];
//    [mutableRequest setObject:[NSString stringWithFormat:@"%d",pageSize] forKey:@"pageSize"];
//    
//    NSString *systemVersion = [[UIDevice currentDevice] systemVersion];
//    NSString *rawOSVersion = [[systemVersion componentsSeparatedByString:@"."] objectAtIndex:0];
//    [mutableRequest setObject:[NSString stringWithFormat:@"iOS%@",rawOSVersion]  forKey:@"rawOSInfo"];
//    
//    NSString *deviceModel = [[UIDevice currentDevice] model];
//    NSString *rawDeviceInfo = @"iPhone";
//    if ([deviceModel hasPrefix:@"iPad"]) {
//        rawDeviceInfo = @"iPad";
//    }
//    [mutableRequest setObject:rawDeviceInfo forKey:@"rawDeviceInfo"];
//    
//    NSString *mac = [TFDeviceInfo getClientID];
//    [mutableRequest setObject:mac forKey:@"mac"];
//    
//    NSString *oid = [OpenUDID value];
//    [mutableRequest setObject:oid forKey:@"oid"];
//    
//    NSString *temp = [SPSJsonWrapper jsonRepresentation:mutableRequest];
//	return [TFCommand gateway:temp];
//}

//+ (NSString *)updateAdClick:(NSString *)clickUrl
//                         ad:(NSString *)ad
//                      price:(NSString *)price
//                      point:(NSString *)point
//                       adid:(NSString *)adid
//                  outerCode:(NSString *)outerCode {
//    NSString *time = [Top currentTime];
//    NSString *sign = [TFCommand TFSignMd5:@"updateAdClick" time:time];
//    NSString *base64Url = [GTMBase64 stringByEncodingData:[clickUrl dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    NSMutableDictionary *publicDict = [[TFCommand shared] getPublic];
//    
//    NSMutableDictionary *mutableRequest = [NSMutableDictionary dictionaryWithDictionary:publicDict];
//    [mutableRequest setObject:@"updateAdClick" forKey:@"operationType"];
//    [mutableRequest setObject:time forKey:@"time"];
//    [mutableRequest setObject:sign forKey:@"sign"];
//    
//    [mutableRequest setObject:adid forKey:@"adid"];
//    [mutableRequest setObject:ad forKey:@"ad"];
//    [mutableRequest setObject:price forKey:@"price"];
//    [mutableRequest setObject:point forKey:@"point"];
//    [mutableRequest setObject:base64Url forKey:@"clickUrl"];
//    [mutableRequest setObject:outerCode forKey:@"outerCode"];
//    
//    NSString *temp = [SPSJsonWrapper jsonRepresentation:mutableRequest];
//	return [TFCommand gateway:temp];
//}

//+ (NSString *)queryAdResult:(NSString *)adid {
//    NSString *time = [Top currentTime];
//    NSString *sign = [TFCommand TFSignMd5:@"queryAdResult" time:time];
//    
//    NSMutableDictionary *publicDict = [[TFCommand shared] getPublic];
//    
//    NSMutableDictionary *mutableRequest = [NSMutableDictionary dictionaryWithDictionary:publicDict];
//    [mutableRequest setObject:@"queryAdResult" forKey:@"operationType"];
//    [mutableRequest setObject:time forKey:@"time"];
//    [mutableRequest setObject:sign forKey:@"sign"];
//    
//    [mutableRequest setObject:adid forKey:@"adid"];
//    
//    NSString *temp = [SPSJsonWrapper jsonRepresentation:mutableRequest];
//	return [TFCommand gateway:temp];
//}

//+ (NSString *)queryAdRecord:(int)pageNo
//                 pageSize:(int)pageSize {
//    NSString *time = [Top currentTime];
//    NSString *sign = [TFCommand TFSignMd5:@"queryAdRecord" time:time];
//    
//    NSMutableDictionary *publicDict = [[TFCommand shared] getPublic];
//    
//    NSMutableDictionary *mutableRequest = [NSMutableDictionary dictionaryWithDictionary:publicDict];
//    [mutableRequest setObject:@"queryAdRecord" forKey:@"operationType"];
//    [mutableRequest setObject:time forKey:@"time"];
//    [mutableRequest setObject:sign forKey:@"sign"];
//    
//    [mutableRequest setObject:[NSString stringWithFormat:@"%d",pageNo] forKey:@"pageNo"];
//    [mutableRequest setObject:[NSString stringWithFormat:@"%d",pageSize] forKey:@"pageSize"];
//    
//    
//    NSString *temp = [SPSJsonWrapper jsonRepresentation:mutableRequest];
//	return [TFCommand gateway:temp];
//}

#pragma mark - 新首页

//+ (NSString *)queryNewHome {
//    NSString *time = [Top currentTime];
//    NSString *sign = [TFCommand TFSignMd5:@"queryNewHome" time:time];
//    
//    NSMutableDictionary *publicDict = [[TFCommand shared] getPublic];
//    
//    NSMutableDictionary *mutableRequest = [NSMutableDictionary dictionaryWithDictionary:publicDict];
//    [mutableRequest setObject:@"queryNewHome" forKey:@"operationType"];
//    [mutableRequest setObject:time forKey:@"time"];
//    [mutableRequest setObject:sign forKey:@"sign"];
//   
//    NSString *temp = [SPSJsonWrapper jsonRepresentation:mutableRequest];
//	return [TFCommand gateway:temp];
//}

//+ (NSString *)queryNewGift:(NSString *)giftToken type:(NSString *)type{
//    NSString *time = [Top currentTime];
//    NSString *sign = [TFCommand TFSignMd5:@"queryNewGift" time:time];
//    
//    NSMutableDictionary *publicDict = [[TFCommand shared] getPublic];
//    
//    NSMutableDictionary *mutableRequest = [NSMutableDictionary dictionaryWithDictionary:publicDict];
//    [mutableRequest setObject:@"queryNewGift" forKey:@"operationType"];
//    [mutableRequest setObject:time forKey:@"time"];
//    [mutableRequest setObject:sign forKey:@"sign"];
//    
//    NSString *source = [NSString stringWithFormat:@"%@%@%@", giftToken, [TFCommand shared].cookie, time];
//    NSString *encode = [TripleDesTool TripleDES:[Top do_MD5_String:source] encryptOrDecrypt:kCCEncrypt key:@"zjhzleixuntaofen8D601602"];
//    [mutableRequest setObject:giftToken forKey:@"giftToken"];
//    [mutableRequest setObject:encode forKey:@"newerToken"];
//
//    [mutableRequest setObject:type?type:@"" forKey:@"type"];
//    
//    NSString *temp = [SPSJsonWrapper jsonRepresentation:mutableRequest];
//	return [TFCommand gateway:temp];
//}

//+ (NSString *)queryNewGiftState {
//    NSString *time = [Top currentTime];
//    NSString *sign = [TFCommand TFSignMd5:@"queryNewGiftState" time:time];
//    
//    NSMutableDictionary *publicDict = [[TFCommand shared] getPublic];
//    
//    NSMutableDictionary *mutableRequest = [NSMutableDictionary dictionaryWithDictionary:publicDict];
//    [mutableRequest setObject:@"queryNewGiftState" forKey:@"operationType"];
//    [mutableRequest setObject:time forKey:@"time"];
//    [mutableRequest setObject:sign forKey:@"sign"];
//    
//    NSString *temp = [SPSJsonWrapper jsonRepresentation:mutableRequest];
//	return [TFCommand gateway:temp];
//}

//+ (NSString *)queryMSList:(int)pageNo
//                 pageSize:(int)pageSize
//                   itemId:(NSString *)itemId{
//    NSString *time = [Top currentTime];
//    NSString *sign = [TFCommand TFSignMd5:@"queryMSList" time:time];
//    
//    NSMutableDictionary *publicDict = [[TFCommand shared] getPublic];
//    
//    NSMutableDictionary *mutableRequest = [NSMutableDictionary dictionaryWithDictionary:publicDict];
//    [mutableRequest setObject:@"queryMSList" forKey:@"operationType"];
//    [mutableRequest setObject:time forKey:@"time"];
//    [mutableRequest setObject:sign forKey:@"sign"];
//    
//    [mutableRequest setObject:[NSString stringWithFormat:@"%d",pageNo] forKey:@"pageNo"];
//    [mutableRequest setObject:[NSString stringWithFormat:@"%d",pageSize] forKey:@"pageSize"];
//    [mutableRequest setObject:itemId forKey:@"itemId"];
//    
//    NSString *temp = [SPSJsonWrapper jsonRepresentation:mutableRequest];
//	return [TFCommand gateway:temp];
//}

//+ (NSString *)queryInviteTop {
//    NSString *time = [Top currentTime];
//    NSString *sign = [TFCommand TFSignMd5:@"queryInviteTop" time:time];
//    
//    NSMutableDictionary *publicDict = [[TFCommand shared] getPublic];
//    
//    NSMutableDictionary *mutableRequest = [NSMutableDictionary dictionaryWithDictionary:publicDict];
//    [mutableRequest setObject:@"queryInviteTop" forKey:@"operationType"];
//    [mutableRequest setObject:time forKey:@"time"];
//    [mutableRequest setObject:sign forKey:@"sign"];
//    
//    NSString *temp = [SPSJsonWrapper jsonRepresentation:mutableRequest];
//	return [TFCommand gateway:temp];
//}

//+ (NSString *)getSplash {
//    NSString *time = [Top currentTime];
//    NSString *sign = [TFCommand TFSignMd5:@"getSplash" time:time];
//    
//    NSMutableDictionary *publicDict = [[TFCommand shared] getPublic];
//    
//    NSMutableDictionary *mutableRequest = [NSMutableDictionary dictionaryWithDictionary:publicDict];
//    [mutableRequest setObject:@"getSplash" forKey:@"operationType"];
//    [mutableRequest setObject:time forKey:@"time"];
//    [mutableRequest setObject:sign forKey:@"sign"];
//    
//    NSString *temp = [SPSJsonWrapper jsonRepresentation:mutableRequest];
//	return [TFCommand gateway:temp];
//}

#pragma mark -

//+ (NSString *)queryWithParam:(NSDictionary *)param{
//    NSString *operateType = [param objectForKey:@"operationType"];
//    NSString *time = [Top currentTime];
//    NSString *sign = [TFCommand TFSignMd5:operateType time:time];
//    
//    NSMutableDictionary *publicDict = [[TFCommand shared] getPublic];
//    
//    NSMutableDictionary *mutableRequest = [NSMutableDictionary dictionaryWithDictionary:publicDict];
//    
//    [mutableRequest addEntriesFromDictionary:param];
//    
//    [mutableRequest setObject:time forKey:@"time"];
//    [mutableRequest setObject:sign forKey:@"sign"];
//    
//    NSString *temp = [SPSJsonWrapper jsonRepresentation:mutableRequest];
//	return [TFCommand gateway:temp];
// 
//}
//
//+ (NSDictionary *)htQueryWithParam:(NSMutableDictionary *)param{
//    NSMutableDictionary *common = [NSMutableDictionary dictionaryWithDictionary:param[@"common"]];
//    NSString *model = [TFDeviceInfo  platformString];;
//    NSString *os = [UIDevice currentDevice].systemVersion;
//    NSString *deviceID = [TFDeviceInfo getDeviceId];
//    NSMutableDictionary *deviceInf = [NSMutableDictionary dictionaryWithObjectsAndKeys:model?model:@"",@"model",
//            os?os:@"",@"os",
//            deviceID?deviceID:@"",@"device_id",
//            nil];
//    
//    
//    NSString *time = [TFCommand currentTime];
//    
//    [common setObject:time forKey:@"time"];
//    
//    [param setObject:common forKey:@"common"];
//    [param setObject:deviceInf forKey:@"device"];
//    
//    NSString *body = [SPSJsonWrapper jsonRepresentation:param];
//    
//    NSString *cacheStamp = nil;
//    NSNumber *timeout = nil;
//    
//#if kTFEnableURLCache
//    
//    timeout = [param objectForKey:@"cachedTimeout"];
//    
//    NSString *urlCache = [SPSJsonWrapper jsonRepresentation:param];
//    
//    if (timeout) {
//        cacheStamp = [[TFURLCache shareDefaultCache] createURLCacheStampWithOpType:[param objectForKey:@"method"]
//                                                                            digest:[TFCommand do_MD5_String:urlCache]];
//    }
//    
//    
//#endif
//    
//    NSString *sign = [TFCommand do_MD5_String:[NSString stringWithFormat:@"%@%@%@",body,time,kTFMD5Key]];
//    
//    
//    NSString *dataStr = [NSString stringWithFormat:@"requestData=%@&sign=%@",[TFCommand gateway:body],sign];
//    
//    return @{@"stamp":cacheStamp?cacheStamp:@"",@"data":dataStr,@"cachedTimeout":timeout?timeout:@"0"};
//}
//
//+ (NSString *)test{
//    //NSString *operateType = [param objectForKey:@"operationType"];
//    NSString *time = [Top currentTime];
//    NSString *sign = [TFCommand TFSignMd5:@"queryMyFanli" time:time];
//    
//    
//    //NSMutableDictionary *publicDict = [[TFCommand shared] getPublic];
//    
//    NSMutableDictionary *mutableRequest = [NSMutableDictionary dictionary];
//    
//   /// [mutableRequest addEntriesFromDictionary:param];
//    
//    [mutableRequest setObject:@"queryMyFanli" forKey:@"operationType"];
//    
//    [mutableRequest setObject:time forKey:@"time"];
//    [mutableRequest setObject:sign forKey:@"sign"];
//    
//    [mutableRequest setObject:@"2.3.5" forKey:@"os"];
//    [mutableRequest setObject:@"HS-T930" forKey:@"model"];
//    [mutableRequest setObject:@"qianhao7" forKey:@"channelID"];
//    [mutableRequest setObject:@"0" forKey:@"pageSize"];
//    [mutableRequest setObject:@"868295010816822460008733817526" forKey:@"clientID"];
//    [mutableRequest setObject:@"Android_V4.20" forKey:@"productVersion"];
//    [mutableRequest setObject:@"taofen8_Android" forKey:@"productID"];
//    [mutableRequest setObject:@"no" forKey:@"retina"];
//    [mutableRequest setObject:@"好心情19788" forKey:@"nick"];
//    [mutableRequest setObject:@"0" forKey:@"pageNo"];
//    [mutableRequest setObject:@"7a35fd30bf698c2630bd585ed557ea12" forKey:@"deviceToken"];
//    [mutableRequest setObject:@"434891669" forKey:@"userId"];
//    [mutableRequest setObject:@"6100e117749bfbd23c711b477fb2107dc08e1f20a56a56f434891669" forKey:@"topSession"];
//    [mutableRequest setObject:@"" forKey:@"outerCode"];
//    
//    
//    NSString *temp = [SPSJsonWrapper jsonRepresentation:mutableRequest];
//	return [TFCommand gateway:temp];
//}
//
//@synthesize clientId;
//@synthesize userId;
//@synthesize nick;
//@synthesize model;
//@synthesize os;
//@synthesize productId;
//@synthesize channelId;
//@synthesize productVersion;
//@synthesize deviceToken;
//@synthesize userAgent;
//@synthesize topSession;
//@synthesize outerCode;
//@synthesize retina;
//@synthesize display;
//@synthesize deviceId;
//@synthesize cookie;
//@synthesize lat;
//@synthesize lng;
//@synthesize mobileId;
//@synthesize ifa;
@end


