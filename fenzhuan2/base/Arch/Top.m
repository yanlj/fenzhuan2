//
//  Top.m
//  TfClient
//
//  Created by wuwentao on 12-3-4.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "Top.h"
#import "TFDeviceInfo.h"
#import "AppKey.h"
#import "TFCommonDefine.h"



#include <CommonCrypto/CommonDigest.h>

#ifndef kTFCommandKey
    #define kTFCommandKey @"tmadd04142572f626ds0c1egq88e4aa0dff54b20201ef99ab93b3d2561d34df7"
#endif

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


@implementation Top

@synthesize _nick;
@synthesize _topSession;
@synthesize _token;
@synthesize _ecode;
@synthesize _userId;
@synthesize _outerCode;
@synthesize _bindKey;
@synthesize _bindString;
@synthesize _refreshToken;
@synthesize _mobileToken;
@synthesize _refreshToken2;

+(Top *)sharedTop {
    static Top *instance = nil;
    
    if (instance == nil) {
        instance = [[Top alloc]init];
        instance._userId = nil;
        instance._nick = nil;
        instance._topSession = nil;
        instance._token = nil;
        instance._ecode = nil;
        instance._outerCode = nil;
        instance._refreshToken = nil;
        instance._refreshToken2 = nil;
        instance._mobileToken = nil;
        
        [instance getAll];
    }
    
    return instance;
}


- (void)dealloc
{
    NSLog(@"%s", __func__);

    TF_RELEASE(_nick);
    TF_RELEASE(_token);
    TF_RELEASE(_ecode);
    TF_RELEASE(_userId);
    TF_RELEASE(_outerCode);
    TF_RELEASE(_topSession);   
    TF_RELEASE(_bindKey);
    TF_RELEASE(_bindString);
    TF_RELEASE(_refreshToken);
    TF_RELEASE(_mobileToken);
    self._refreshToken2 = nil;
    
    [super dealloc];
}


- (BOOL)checkLogin
{
    if ((self._nick != nil||self._userId != nil) && self._topSession != nil && (self._refreshToken != nil ||self._refreshToken2 !=nil))
    {
        return YES;
    }
    
    return NO;
}

- (void)getAll
{
    AppKey *mAppKey = [AppKey ShareAppKey];
    
    self._nick = mAppKey._nick;
    self._topSession = mAppKey._topSession;
    self._token = mAppKey._token;
    self._ecode = mAppKey._ecode;
    self._userId = mAppKey._userId;
    self._refreshToken = mAppKey._refreshToken;
    self._refreshToken2 = mAppKey._refreshToken2;
    self._mobileToken = mAppKey._mobileToken;
    self._loginType = mAppKey._loginType;
}

- (void)clearAll
{
    NSLog(@"%s", __func__);
    
    TF_RELEASE(_nick);
    TF_RELEASE(_token);
    TF_RELEASE(_ecode);
    TF_RELEASE(_topSession); 
    TF_RELEASE(_userId);
    TF_RELEASE(_outerCode);
    TF_RELEASE(_refreshToken);
    TF_RELEASE(_refreshToken2);
    self._loginType = nil;
    
    AppKey *_mAppKey = [AppKey ShareAppKey];
    [_mAppKey clearLoginAll];
}

//- (void)saveAll:(NSString *)nick token:(NSString *)token ecode:(NSString *)ecode topSession:(NSString *)topSession
//{
//    TF_RELEASE(_nick);
//    TF_RELEASE(_token);
//    TF_RELEASE(_ecode);
//    TF_RELEASE(_topSession); 
//    
//    //save all data to top 
//    self._nick = nick;
//    self._token = token;
//    self._ecode = ecode;
//    self._topSession = topSession;
//    
//    //save all to Appkey for autoLogin
//    AppKey *_mAppKey = [AppKey ShareAppKey];
//    if (token == nil) {
//        self._token = _mAppKey._token;
//    }
//    
//    if (topSession == nil) {
//        self._topSession = _mAppKey._topSession;
//    }
//    
//    [_mAppKey saveAll:nick token:token ecode:ecode topSession:_topSession];
//}
//
//- (void)saveRefreshToken:(NSString *)nick refreshToken:(NSString *)refreshToken topSession:(NSString *)topSession mobileToken:(NSString *)mobileToken
//{
//    NSLog(@"%s", __func__);
//    NSLog(@"nick:%@", nick);
//    NSLog(@"refreshToken:%@", refreshToken);
//    NSLog(@"topSession:%@", topSession);
//    NSLog(@"mobileToke:%@", mobileToken);
//    
//    TF_RELEASE(_nick);
//    TF_RELEASE(_token);
//    TF_RELEASE(_ecode);
//    TF_RELEASE(_topSession); 
//    TF_RELEASE(_refreshToken);
//    TF_RELEASE(_mobileToken);
//    
//    //save all data to top 
//    self._nick = nick;
//    self._topSession = topSession;
//    self._refreshToken = refreshToken;
//    self._mobileToken = mobileToken;
//    
//    //save all to Appkey for autoLogin
//    AppKey *_mAppKey = [AppKey ShareAppKey];
//    if (refreshToken == nil) {
//        self._refreshToken = _mAppKey._refreshToken;
//    }
//    
//    if (topSession == nil) {
//        self._topSession = _mAppKey._topSession;
//    }
//    
//    if (mobileToken == nil) {
//        self._mobileToken = _mAppKey._mobileToken;
//    }
//    
//    [_mAppKey saveToken:nick refreshToken:refreshToken topSession:topSession mobileToken:mobileToken];
//}

//- (void)saveRefreshToken2:(NSString *)nick refreshToken:(NSString *)refreshToken topSession:(NSString *)topSession mobileToken:(NSString *)mobileToken{
//    NSLog(@"%s", __func__);
//    NSLog(@"nick:%@", nick);
//    NSLog(@"refreshToken2:%@", refreshToken);
//    NSLog(@"topSession:%@", topSession);
//    NSLog(@"mobileToke:%@", mobileToken);
//    
//    TF_RELEASE(_nick);
//    TF_RELEASE(_token);
//    TF_RELEASE(_ecode);
//    TF_RELEASE(_topSession);
//    TF_RELEASE(_refreshToken2);
//    TF_RELEASE(_mobileToken);
//    
//    //save all data to top
//    self._nick = nick;
//    self._topSession = topSession;
//    self._refreshToken2 = refreshToken;
//    self._mobileToken = mobileToken;
//    
//    //save all to Appkey for autoLogin
//    AppKey *_mAppKey = [AppKey ShareAppKey];
//    if (refreshToken == nil) {
//        self._refreshToken2 = _mAppKey._refreshToken2;
//    }
//    
//    if (topSession == nil) {
//        self._topSession = _mAppKey._topSession;
//    }
//    
//    if (mobileToken == nil) {
//        self._mobileToken = _mAppKey._mobileToken;
//    }
//    
//    [_mAppKey saveToken2:nick refreshToken:refreshToken topSession:topSession mobileToken:mobileToken];
//}

- (void)saveNick:(NSString *)nick
{
    NSLog(@"%s:%@", __func__, nick);
    
    if (nick == nil || [nick isEqual:[NSNull null]]) {
        return ;
    }
    
    self._nick = nick;
    
    AppKey *_mAppKey = [AppKey ShareAppKey];
    [_mAppKey saveNick:nick];
}

- (void)saveUserId:(NSString *)userId
{
    NSLog(@"%s:%@", __func__, userId);
    
    if (userId == nil || [userId isEqual:[NSNull null]]) {
        return ;
    }
    
    self._userId = userId;
    
    AppKey *_mAppKey = [AppKey ShareAppKey];
    [_mAppKey saveUserId:userId];
}

- (void)saveLoginType:(NSString *)loginType
{
    NSLog(@"%s:%@", __func__, loginType);
    
    if (loginType == nil || [loginType isEqual:[NSNull null]]) {
        return ;
    }
    
    self._loginType = loginType;
    
    AppKey *_mAppKey = [AppKey ShareAppKey];
    [_mAppKey saveLoginType:loginType];
}

- (void)saveRefreshToken:(NSString *)refreshToken
{
    NSLog(@"%s:%@", __func__, refreshToken);
    
    if (refreshToken == nil || [refreshToken isEqual:[NSNull null]]) {
        return ;
    }
    
    self._refreshToken = refreshToken;
    
    AppKey *_mAppKey = [AppKey ShareAppKey];
    [_mAppKey saveRefreshToken:refreshToken];
}

//- (void)saveMobileToken:(NSString *)mobileToken;
- (void)saveTopSession:(NSString *)topSession
{
    NSLog(@"%s:%@", __func__, topSession);
    
    if (topSession == nil || [topSession isEqual:[NSNull null]]) {
        return ;
    }
    
    self._topSession = topSession;
    
    AppKey *_mAppKey = [AppKey ShareAppKey];
    [_mAppKey saveTopSession:topSession];
}


- (void)saveOuterCode:(NSString *)outerCode
{
    if (outerCode == nil || [outerCode isEqual:[NSNull null]]) {
        return ;
    }
    
    self._outerCode = outerCode;
}


- (void)saveRateUrl:(NSString *)url
{
    if (url == nil || [url isEqual:[NSNull null]]) {
        return ;
    }
}

- (void)saveBind:(NSString *)bindString bindKey:(NSString *)bindKey
{
    if (bindKey == nil || [bindKey isEqual:[NSNull null]]) {
        return;
    }
    
    if (bindString == nil || [bindString isEqual:[NSNull null]]) {
        return;
    } 
    
    TF_RELEASE(_bindString);
    TF_RELEASE(_bindKey);
    
    self._bindKey = bindKey;
    self._bindString = bindString;
}



+(NSString *)convertUrl:(NSString *)url{
	
	NSString *temp = url;
	
	temp = [self replaceString:temp SrcString:@"\"" Replace:@"%22"];
	temp = [self replaceString:temp SrcString:@"{" Replace:@"%7B"];
	temp = [self replaceString:temp SrcString:@"}" Replace:@"%7D"];
	
	NSString * ret = [NSString stringWithString:temp];
	return ret;
	
}


+(NSString *)replaceString:(NSString *)url SrcString:(NSString *)src Replace:(NSString *)str{
	
	NSString *temp = url;
	NSRange range = [temp rangeOfString:src];
	while (range.length == [src length]) {
		temp = [temp stringByReplacingCharactersInRange:range withString:str];
		range = [temp rangeOfString:src];
	}
	
	NSString * ret = [NSString stringWithString:temp];
	return ret;
    
}

+(NSString *)do_MD5_String:(NSString *)body{  
	
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


+(NSString *)currentTime{
	
	NSDate *date = [NSDate date];
	NSTimeInterval timeInterval = [date timeIntervalSince1970];
	//NSInteger count = (NSInteger)timeInterval;
	NSString *valueCount = [NSString stringWithFormat:@"%f",timeInterval];
	return valueCount;
}


+(NSNumber *)NString2NSNumber:(NSString *)num{
	
	NSNumberFormatter * f = [[NSNumberFormatter alloc] init]; 
	[f setNumberStyle:NSNumberFormatterDecimalStyle]; 
	NSNumber * myNumber = [f numberFromString:num];
	return myNumber;
    
}

+(NSString *)NSInteger2NSString:(NSInteger)num{
    
	NSString *value = [NSString stringWithFormat:@"%d",num];
	return value;
    
}

+ (NSString *)gateway:(NSString *)jsonRepresentation{
    NSString *session = [Top do_MD5_String:[NSString stringWithFormat:@"%@%@",jsonRepresentation,kTFCommandKey]];
    NSString *ret = [NSString stringWithFormat:@"requestData=%@&session=%@&api=api2",[jsonRepresentation URLEncodedString],session];
    
    return ret;
}



@end
