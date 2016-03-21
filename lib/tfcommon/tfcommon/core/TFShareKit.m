//
//  TFShareKit.m
//  tfcommon
//
//  Created by yin shen on 9/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TFShareKit.h"

//release版本屏蔽log
#ifdef DEBUG
#else
#define printf(...)
#define NSLog(...)
#define TFLog(...)
#define TFNetLog(...)
#endif

@interface TFShareKit()

@property (nonatomic, retain) NSMutableDictionary *shareKitDict;
@end

NSString *kQQSpace_AccessToken = @"kQQSpace_AccessToken";
NSString *kQQSpace_OpenId = @"kQQSpace_OpenId";
NSString *kQQSpace_ExpireDate = @"kQQSpace_ExpireDate";

@implementation TFShareKit

+ (TFShareKit *)shared{
    static TFShareKit *kShareKit = nil;
    @synchronized(self) {
        if (nil == kShareKit) {
            kShareKit = [[TFShareKit alloc] init];
        }
    }
    return kShareKit;
}

- (id)init{
    self = [super init];
    
    if (self) {
        self.shareKitDict = [[[NSMutableDictionary alloc] 
                              initWithCapacity:TFShareKitKey_count] autorelease];
    }
    
    return self;
}

- (void)createAuthInstanceBindKey:(TFShareKitKey)aKey{
    NSLog(@"%s", __func__);
    id instance = nil;
    
    switch (aKey) {
        case TFShareKitKey_qqspace:{
            instance = [self qqSpacePrepare];
        }
            break;
        case TFShareKitKey_sinaweibo:{
            instance = [self sinaWeiBoPrepare];
        }
            break;
        case TFShareKitKey_renren:{
            instance = [self renRenPrepare];
        }
            break;
        case TFShareKitKey_weixin:{
            instance = [self weixinPrepare];
        }
        case TFShareKitKey_tengxunweibo:{
            instance = [self tengxunWeiBoPrepare];
        }
            break;
        default:
            break;
    }
    
    if (instance) {
        [self.shareKitDict setObject:instance 
                              forKey:[NSNumber numberWithInt:aKey]];
    }
}

- (id)getAuthInstanceViaKey:(TFShareKitKey)aKey{
    NSLog(@"%s", __func__);
    return [self.shareKitDict objectForKey:[NSNumber numberWithInt:aKey]];
}

- (id)getAuthInstanceUsefulViaKey:(TFShareKitKey)aKey{
    NSLog(@"%s", __func__);
    
    id instance = [self.shareKitDict objectForKey:[NSNumber numberWithInt:aKey]];
    switch (aKey) {
        case TFShareKitKey_qqspace: return [self beautyQQSpaceInstance:instance];
        case TFShareKitKey_sinaweibo:return [self beautySinaWeiBoInstance:instance];
        case TFShareKitKey_renren:return [self beautyRenRenInstance:instance];
        case TFShareKitKey_weixin:return [self beautyWeiXinInstance:instance];
        case TFShareKitKey_tengxunweibo:return [self beautyTengxunWeiBoInstance:instance];
        default:
            break;
    }
    return nil;
}

- (void)dealloc{
    NSLog(@"%s", __func__);
    self.shareKitDict = nil;
    [super dealloc];
}

- (id)qqSpacePrepare{return nil;}
- (id)sinaWeiBoPrepare{return nil;}
- (id)renRenPrepare{return nil;}
- (id)weixinPrepare{return nil;}
- (id)tengxunWeiBoPrepare{return nil;}

- (id)beautyQQSpaceInstance:(id)aInstance{return nil;}
- (id)beautySinaWeiBoInstance:(id)aInstance{return nil;}
- (id)beautyRenRenInstance:(id)aInstance{return nil;}
- (id)beautyWeiXinInstance:(id)aInstance{return nil;}
- (id)beautyTengxunWeiBoInstance:(id)aInstance{return nil;}

- (void)qqLogin{}
- (void)sinaWeiBoLogin{}
- (void)renRenLogin{}
- (void)weixinLogin{}
- (void)tengxunWeiBoLogin{}

@synthesize shareKitDict = _shareKitDict;
@end
