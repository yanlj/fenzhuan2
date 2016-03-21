//
//  AppKey.m
//  HorizontalScrollViewTest
//
//  Created by wuwentao on 12-3-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "AppKey.h"
#import "TripleDesTool.h"
#import "TFCommonDefine.h"

@implementation AppKey

@synthesize _appKey;
@synthesize _appSecret;
@synthesize _nick;
@synthesize _topSession;
@synthesize _ecode;
@synthesize _token;
@synthesize _saveTime;
@synthesize _ttid;
@synthesize _deviceToken;
@synthesize _firstRunning;
@synthesize _refreshToken;
@synthesize _refreshToken2;
@synthesize _mobileToken;
///add for login trans
@synthesize _userId;
@synthesize cookie = _cookie;

- (void)dealloc
{
    
    TF_RELEASE(_appKey);
    TF_RELEASE(_appSecret);
    TF_RELEASE(_nick);
    TF_RELEASE(_topSession);
    TF_RELEASE(_token);
    TF_RELEASE(_ecode);
    TF_RELEASE(_saveTime);
    TF_RELEASE(_ttid);
    TF_RELEASE(_deviceToken);
    TF_RELEASE(_firstRunning);
    TF_RELEASE(_refreshToken);
    TF_RELEASE(_mobileToken);
    self._userId = nil;
    self._refreshToken2 = nil;
    _cookie = nil;
    self._loginType = nil;
    [super dealloc];
}


+(id)ShareAppKey {
    static AppKey *instance = nil;
    
    if (instance == nil) 
    {
        instance = [[AppKey alloc] init];
        [instance  getAllKey];
    }
    
    return instance;
}

- (void)getAllKey
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *appkey = [defaults objectForKey:kTaobaoAppKey];
    NSString *appSecret = [defaults objectForKey:kTaobaoAppSecret];
    
    if (appkey && appSecret) {
        NSString *decodeAppkey = [TripleDesTool TripleDES:appkey encryptOrDecrypt:kCCDecrypt key:kTaoFen8LocalDes];
        NSString *decodeAppSecret = [TripleDesTool TripleDES:appSecret encryptOrDecrypt:kCCDecrypt key:kTaoFen8LocalDes];
        self._appKey = decodeAppkey;//[defaults objectForKey:kTaobaoAppKey];
        self._appSecret = decodeAppSecret;//[defaults objectForKey:kTaobaoAppSecret];
    }
    
    self._nick = [defaults objectForKey:kUserNick];
    self._topSession = [defaults objectForKey:kTopSession];
    self._ecode = [defaults objectForKey:kEcode];
    //self._token = [defaults objectForKey:kToken];
    self._token = [self readFile:kToken];
    self._ttid = [defaults objectForKey:kTaobaoTTID];
    self._saveTime = [defaults objectForKey:kSaveTime];
    self._deviceToken = [defaults objectForKey:kDeviceToken];
    self._firstRunning = [defaults objectForKey:kFirstRunning];
    self._refreshToken = [defaults objectForKey:kRefreshToken];
    self._refreshToken2 = [defaults objectForKey:kRefreshToken2];
    self._mobileToken = [defaults objectForKey:kMobileToken];
    self._userId = [defaults objectForKey:kUserId];
    self._loginType = [defaults objectForKey:kLoginType];
    
    NSString *encryptedCookie = [defaults objectForKey:kTaofen8Cookie];
    
    if (encryptedCookie) {
        NSString *decodeCookie = [TripleDesTool TripleDES:encryptedCookie encryptOrDecrypt:kCCDecrypt key:kTaoFen8LocalDes];
        _cookie = decodeCookie;
    }
}

- (void)clearCookie
{
    _cookie = nil;
    [self saveCookie:@""];
}

- (void)saveCookie:(NSString *)aCookie{
    if (nil == aCookie) {
        return;
    }
    
    if (![self.cookie isEqualToString:aCookie]) {
        NSString *encodeCookie = [TripleDesTool TripleDES:aCookie encryptOrDecrypt:kCCEncrypt key:kTaoFen8LocalDes];
        [[NSUserDefaults standardUserDefaults] setObject:encodeCookie forKey:kTaofen8Cookie];
        [[NSUserDefaults standardUserDefaults] synchronize];
        _cookie = aCookie;
    }
}

- (void)saveUserId:(NSString *)aUserId{
    if (nil == aUserId) {
        return;
    }
    
    if (![self._userId isEqualToString:aUserId]) {
        [[NSUserDefaults standardUserDefaults] setObject:aUserId forKey:kUserId];
        [[NSUserDefaults standardUserDefaults] synchronize];
        self._userId = aUserId;
    }
}

- (void)saveNick:(NSString *)aNick{
    if (nil == aNick) {
        return;
    }
    
    if (![self._nick isEqualToString:aNick]) {
        [[NSUserDefaults standardUserDefaults] setObject:aNick forKey:kUserNick];
        [[NSUserDefaults standardUserDefaults] synchronize];
        self._nick = aNick;
    }
}

- (void)saveLoginType:(NSString *)aLoginType {
    if (nil == aLoginType) {
        return;
    }
    
    if (![self._loginType isEqualToString:aLoginType]) {
        [[NSUserDefaults standardUserDefaults] setObject:aLoginType forKey:kLoginType];
        [[NSUserDefaults standardUserDefaults] synchronize];
        self._userId = aLoginType;
    }
}

- (void)saveRefreshToken:(NSString *)refreshToken {
    if (nil == refreshToken) {
        return;
    }
    
    if (![self._refreshToken isEqualToString:refreshToken]) {
        [[NSUserDefaults standardUserDefaults] setObject:refreshToken forKey:kRefreshToken];
        [[NSUserDefaults standardUserDefaults] synchronize];
        self._refreshToken = refreshToken;
    }
}

- (void)saveTopSession:(NSString *)topSession {
    if (nil == topSession) {
        return;
    }
    
    if (![self._topSession isEqualToString:topSession]) {
        [[NSUserDefaults standardUserDefaults] setObject:topSession forKey:kTopSession];
        [[NSUserDefaults standardUserDefaults] synchronize];
        self._topSession = topSession;
    }
}

- (void)saveKey:(NSString *)appKey appSecret:(NSString *)appSecret ttid:(NSString *)ttid
{
    if (appKey == nil || appSecret == nil || ttid == nil) {
        return ;
    }
    
    if (![self._appKey isEqualToString:appKey] || ![self._appSecret isEqualToString:appSecret]) 
    {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSString *encodeAppkey = [TripleDesTool TripleDES:appKey encryptOrDecrypt:kCCEncrypt key:kTaoFen8LocalDes];
        NSString *encodeAppSecret = [TripleDesTool TripleDES:appSecret encryptOrDecrypt:kCCEncrypt key:kTaoFen8LocalDes];
        [defaults setObject:encodeAppkey forKey:kTaobaoAppKey];
        [defaults setObject:encodeAppSecret forKey:kTaobaoAppSecret];  
        [defaults setObject:ttid forKey:kTaobaoTTID]; 
        [defaults synchronize];
        
        self._appKey = appKey;
        self._appSecret = appSecret;
        self._ttid = ttid;
    }
}


- (void)saveNickAndSession:(NSString *)nick session:(NSString *)topSession
{
    if (nick == nil || topSession == nil) {
        return ;
    }
    
    if (![self._nick isEqualToString:nick] || ![self._topSession isEqualToString:topSession]) 
    {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:nick forKey:kUserNick];
        [defaults setObject:topSession forKey:kTopSession];
        [defaults synchronize];
        
        self._nick = nick;
        self._topSession = topSession;
    }
}

- (void)saveAutoLogin:(NSString *)nick token:(NSString *)token ecode:(NSString *)ecode
{
    if (nick == nil || token == nil || ecode == nil) {
        return ;
    }
    
    if (![self._nick isEqualToString:nick] || ![self._token isEqualToString:token] || ![self._ecode isEqualToString:ecode]) 
    {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:nick forKey:kUserNick];
        [defaults setObject:ecode forKey:kEcode];
        //[defaults setObject:token forKey:kToken];
        [self saveFile:token fileName:kToken];
        [defaults synchronize];
        
        self._nick = nick;
        self._ecode = ecode;
        self._token = token;

    }
}

- (void)saveAll:(NSString *)nick token:(NSString *)token ecode:(NSString *)ecode topSession:(NSString *)topSession
{
    if (nick == nil || ecode == nil) {
        return ;
    }
    
    if (![self._nick isEqualToString:nick] || ![self._token isEqualToString:token] || ![self._ecode isEqualToString:ecode]) 
    {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:nick forKey:kUserNick];
        [defaults setObject:ecode forKey:kEcode];
        [self saveFile:token fileName:kToken];
        [defaults setObject:topSession forKey:kTopSession];
        [defaults synchronize];
        
        self._nick = nick;
        self._ecode = ecode;
        self._token = token;
        self._topSession = topSession;
    }
}

- (void)saveToken:(NSString *)nick refreshToken:(NSString *)refreshToken topSession:(NSString *)topSession mobileToken:(NSString *)mobileToken
{
    if (nick == nil || refreshToken == nil) {
        return ;
    }
    
    if (![self._nick isEqualToString:nick] || ![self._refreshToken isEqualToString:refreshToken] || ![self._topSession isEqualToString:topSession]) 
    {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:nick forKey:kUserNick];
        [defaults setObject:refreshToken forKey:kRefreshToken];
        [defaults setObject:topSession forKey:kTopSession];
        [defaults setObject:mobileToken forKey:kMobileToken];
        [defaults synchronize];
        
        self._nick = nick;
        self._refreshToken = refreshToken;
        self._topSession = topSession;
        self._mobileToken = mobileToken;
    }
}

- (void)saveToken2:(NSString *)nick refreshToken:(NSString *)refreshToken topSession:(NSString *)topSession mobileToken:(NSString *)mobileToken
{
    if (nick == nil || refreshToken == nil) {
        return ;
    }
    
    if (![self._nick isEqualToString:nick] || ![self._refreshToken2 isEqualToString:refreshToken] || ![self._topSession isEqualToString:topSession])
    {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:nick forKey:kUserNick];
        [defaults setObject:refreshToken forKey:kRefreshToken2];
        [defaults setObject:topSession forKey:kTopSession];
        [defaults setObject:mobileToken forKey:kMobileToken];
        [defaults synchronize];
        
        self._nick = nick;
        self._refreshToken2 = refreshToken;
        self._topSession = topSession;
        self._mobileToken = mobileToken;
    }
}

- (void)clearLoginAll
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:kUserNick];
    [defaults removeObjectForKey:kEcode];
    [defaults removeObjectForKey:kRefreshToken];
    [defaults removeObjectForKey:kRefreshToken2];
    [defaults removeObjectForKey:kUserId];
    //[defaults removeObjectForKey:kToken];
    [defaults removeObjectForKey:kTopSession];
    [defaults removeObjectForKey:kLoginType];
    
    [defaults synchronize];
    

    TF_RELEASE(_nick);
    TF_RELEASE(_topSession);
    TF_RELEASE(_token);
    TF_RELEASE(_ecode);
    TF_RELEASE(_refreshToken);
    TF_RELEASE(_refreshToken2);
    self._userId = nil;
    self._loginType = nil;
}

- (BOOL)checkAutoLogin
{
    //if (self._ecode != nil && self._nick != nil && self._token != nil) {
    if (self._refreshToken != nil) {
        return YES;
    }
    
    return NO;
}

- (BOOL)checkAutoLogin2{
    if (self._refreshToken2 != nil) {
        return YES;
    }
    
    return NO;
}


- (void)saveTime:(NSString *)time
{
    if (time == nil) {
        return ;
    }
    
    if (![self._saveTime isEqualToString:time])
    {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:time forKey:kSaveTime];
        [defaults synchronize];
        
        self._saveTime = time;
        
    }
}

- (void)saveFirstRunning
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:@"YES" forKey:kFirstRunning];
    [defaults synchronize];   
}

- (void)saveDeviceToken:(NSString *)deviceToken
{
    if (deviceToken == nil) {
        return ;
    }
    
    if ([self._deviceToken isKindOfClass:[NSString class]]) {
        if (![self._deviceToken isEqualToString:deviceToken])
        {
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setObject:deviceToken forKey:kDeviceToken];
            [defaults synchronize];
            
            self._deviceToken = deviceToken;
        }
    }
    else{ //4.00浮点数遗留bug fix
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:deviceToken forKey:kDeviceToken];
        [defaults synchronize];
        
        self._deviceToken = deviceToken;
    }
    
//    if (![self._deviceToken isEqualToString:deviceToken])
//    {
//        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//        [defaults setObject:deviceToken forKey:kDeviceToken];
//        [defaults synchronize];
//        
//        self._deviceToken = deviceToken;
//    }
}

- (void)removeDeviceToken
{
    if (_deviceToken == nil) {
        return ;
    }
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:kDeviceToken];
    [defaults synchronize];
    
    TF_RELEASE(_deviceToken);
}

- (void)saveFile:(NSString *)data  fileName:(NSString *)fileName
{
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* documentsDirectory = [paths objectAtIndex:0];
    NSString* path = [documentsDirectory stringByAppendingPathComponent:fileName];
    [data writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:nil];
}

- (NSString *)readFile:(NSString *)fileName
{
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* documentsDirectory = [paths objectAtIndex:0];
    NSString* path = [documentsDirectory stringByAppendingPathComponent:fileName];
    NSString *data = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    return data;
}

- (void)deleteFile:(NSString *)fileName
{
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* documentsDirectory = [paths objectAtIndex:0];
    NSString* path = [documentsDirectory stringByAppendingPathComponent:fileName];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager removeItemAtPath:path error:nil];    
}

@end


