//
//  Top.h
//  TfClient
//
//  Created by wuwentao on 12-3-4.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppKey.h"

#define LOGIN_TYPE_FROM_TAOBAO @"taobao"
#define LOGIN_TYPE_FROM_MOBILE @"mobile"

@interface Top : NSObject
{
    NSString *_nick;
    NSString *_topSession;
    NSString *_token;
    NSString *_ecode;
    NSString *_userId;
    NSString *_outerCode;
    NSString *_updateUrl;
    NSString *_bindKey;
    NSString *_bindString;
    NSString *_refreshToken;
    NSString *_mobileToken;
    NSString *_refreshToken2;
}

@property (nonatomic,retain)NSString *_userId;
@property (nonatomic,retain)NSString *_nick;
@property (nonatomic,retain)NSString *_loginType;
@property (nonatomic,retain)NSString *_topSession;
@property (nonatomic,retain)NSString *_token;
@property (nonatomic,retain)NSString *_ecode;
@property (nonatomic,retain)NSString *_outerCode;
@property (nonatomic,retain)NSString *_bindKey;
@property (nonatomic,retain)NSString *_bindString;
@property (nonatomic,retain)NSString *_refreshToken;
@property (nonatomic,retain)NSString *_refreshToken2;
@property (nonatomic,retain)NSString *_mobileToken;


+(Top *)sharedTop;
- (BOOL)checkLogin;
//- (void)saveAll:(NSString *)nick token:(NSString *)token ecode:(NSString *)ecode topSession:(NSString *)topSession;
//- (void)saveRefreshToken:(NSString *)nick refreshToken:(NSString *)refreshToken topSession:(NSString *)topSession;
//- (void)saveRefreshToken:(NSString *)nick refreshToken:(NSString *)refreshToken topSession:(NSString *)topSession mobileToken:(NSString *)mobileToken;
//- (void)saveRefreshToken2:(NSString *)nick refreshToken:(NSString *)refreshToken topSession:(NSString *)topSession mobileToken:(NSString *)mobileToken;

- (void)saveNick:(NSString *)nick;
- (void)saveUserId:(NSString *)userId;
- (void)saveRefreshToken:(NSString *)refreshToken;
- (void)saveTopSession:(NSString *)topSession;
- (void)saveLoginType:(NSString *)loginType;
- (void)saveOuterCode:(NSString *)outerCode;
//- (void)saveRateUrl:(NSString *)url;
//- (void)saveBind:(NSString *)bindString bindKey:(NSString *)bindKey;
- (void)clearAll;


+(NSString *)convertUrl:(NSString *)url;
+(NSString *)replaceString:(NSString *)url SrcString:(NSString *)src Replace:(NSString *)str;



+(NSString *)do_MD5_String:(NSString *)body;
+(NSString *)currentTime;
+(NSNumber *)NString2NSNumber:(NSString *)num;

+ (NSString *)gateway:(NSString *)jsonRepresentation;


@end
