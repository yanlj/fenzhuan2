//
//  AppKey.h
//  HorizontalScrollViewTest
//
//  Created by wuwentao on 12-3-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kTaobaoAppKey    @"TaoBaoAppKey"
#define kTaobaoAppSecret @"TaoBaoAppSecret"
#define kTaobaoTTID      @"TaoBaoTTID"
#define kUserNick       @"TaoBaoNick"
#define kTopSession     @"TaoBaoTopSession"
#define kRefreshToken   @"TaoBaoRefreshToken"
#define kRefreshToken2   @"TaoBaoRefreshToken2"
#define kMobileToken    @"TaoBaoMobileToken"
#define kEcode          @"TaoBaoEcode"
#define kToken          @"TaoBaoToken"
#define kSaveTime       @"AppKeySaveTime"
#define kDeviceToken    @"DeviceToken"
#define kFirstRunning   @"FirstRunning"

#define kAppConfig      @"TaoBaoConfig"
#define kUserId       @"TaoBaoUserId"
#define kTaofen8Cookie @"Taofen8Cookie"

#define kLoginType      @"LoginType"


@interface AppKey : NSObject
{
    NSString *_appKey;
    NSString *_appSecret;
    NSString *_nick;
    NSString *_topSession;
    NSString *_ecode;
    NSString *_token;
    NSString *_saveTime;
    NSString *_ttid;
    NSString *_deviceToken;
    NSString *_refreshToken;
    NSString *_mobileToken;
    NSString *_firstRunning;
    NSString *_refreshToken2;
    NSString *_cookie;
}

@property (nonatomic,retain) NSString *_appKey;
@property (nonatomic,retain) NSString *_appSecret;
@property (nonatomic,retain) NSString *_nick;
@property (nonatomic,retain) NSString *_topSession;
@property (nonatomic,retain) NSString *_ecode;
@property (nonatomic,retain) NSString *_token;
@property (nonatomic,retain) NSString *_saveTime;
@property (nonatomic,retain) NSString *_ttid;
@property (nonatomic,retain) NSString *_deviceToken;

@property (nonatomic,retain) NSString *_firstRunning;

@property (nonatomic,retain) NSString *_refreshToken;
@property (nonatomic,retain) NSString *_mobileToken;
@property (nonatomic, retain) NSString *_userId;
@property (nonatomic, retain) NSString *_refreshToken2;
@property (nonatomic, retain, readonly) NSString *cookie;
@property (nonatomic, retain) NSString *_loginType;


+ (id)ShareAppKey;
- (BOOL)checkAutoLogin;
- (BOOL)checkAutoLogin2;
- (void)saveKey:(NSString *)appKey appSecret:(NSString *)appSecret ttid:(NSString *)ttid;
//- (void)saveNickAndSession:(NSString *)nick session:(NSString *)topSession;
- (void)saveAutoLogin:(NSString *)nick token:(NSString *)token ecode:(NSString *)ecode;
//- (void)saveAll:(NSString *)nick token:(NSString *)token ecode:(NSString *)ecode topSession:(NSString *)topSession;
//- (void)saveToken:(NSString *)nick refreshToken:(NSString *)refreshToken topSession:(NSString *)topSession mobileToken:(NSString *)mobileToken;

- (void)clearLoginAll;
- (void)saveTime:(NSString *)time;
- (void)saveDeviceToken:(NSString *)deviceToken;
- (void)saveFile:(NSString *)data  fileName:(NSString *)fileName;
- (NSString *)readFile:(NSString *)fileName;
- (void)saveFirstRunning;
- (void)removeDeviceToken;
- (void)saveUserId:(NSString *)aUserId;
- (void)saveNick:(NSString *)aNick;
- (void)saveLoginType:(NSString *)aLoginType;
- (void)saveCookie:(NSString *)aCookie;
- (void)clearCookie;

- (void)saveRefreshToken:(NSString *)refreshToken;
- (void)saveTopSession:(NSString *)topSession;
//- (void)saveToken2:(NSString *)nick refreshToken:(NSString *)refreshToken topSession:(NSString *)topSession mobileToken:(NSString *)mobileToken;
@end
