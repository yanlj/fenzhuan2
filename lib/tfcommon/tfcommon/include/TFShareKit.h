//
//  TFShareKit.h
//  tfcommon
//
//  Created by yin shen on 9/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kWeiXin_AppId       @"wxe04e0f20d5f1986a"
#define kWeixin_MchId              @"1263267001"
#define kWeixin_PartnerId   @"b733dfd2e29dc1bbdda365f425f3972e"
#define kWeiXin_AppIdLogin       @"wxe7f43a1695c57313"
#define kWeiXin_AppSecretLogin   @"26a8b1c14e6b121a1c0cfaa14d128f6d"


typedef enum {
    TFShareKitKey_qqspace=0x0,
    TFShareKitKey_sinaweibo,
    TFShareKitKey_renren,
    TFShareKitKey_weixin,
    TFShareKitKey_tengxunweibo,
    TFShareKitKey_count
}TFShareKitKey;

extern NSString *kQQSpace_AccessToken;
extern NSString *kQQSpace_OpenId;
extern NSString *kQQSpace_ExpireDate;


@interface TFShareKit : NSObject

+ (TFShareKit *)shared;

- (void)createAuthInstanceBindKey:(TFShareKitKey)aKey;
- (id)getAuthInstanceUsefulViaKey:(TFShareKitKey)aKey;
- (id)getAuthInstanceViaKey:(TFShareKitKey)aKey;

///virtual
///在创建成功的instance 附加accesstoken openid 可以保证用户
///不需要登陆也可以分享
///该函数在调用的时候已经保证 本地已经有accesstoken等数据
///具体附加什么值 以每个开放平台的说明为主
- (id)beautyQQSpaceInstance:(id)aInstance;
- (id)beautySinaWeiBoInstance:(id)aInstance;
- (id)beautyRenRenInstance:(id)aInstance;
- (id)beautyWeiXinInstance:(id)aInstance;
- (id)beautyTengxunWeiBoInstance:(id)aInstance;


- (id)qqSpacePrepare;
- (id)sinaWeiBoPrepare;
- (id)renRenPrepare;
- (id)weixinPrepare;
- (id)tengxunWeiBoPrepare;

- (void)qqLogin;
- (void)sinaWeiBoLogin;
- (void)renRenLogin;
- (void)weixinLogin;
- (void)tengxunWeiBoLogin;

@end
