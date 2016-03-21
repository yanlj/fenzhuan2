//
//  TF8PublicData.h
//  TfClient
//
//  Created by 吕红鹏 on 16/2/25.
//
//

#import <Foundation/Foundation.h>

@interface TF8PublicData : NSObject


+ (TF8PublicData *)shared;

- (NSMutableDictionary *)getPublic;

@property (nonatomic, retain) NSString *clientId;
@property (nonatomic, retain) NSString *userId;
@property (nonatomic, retain) NSString *loginType;
@property (nonatomic, retain) NSString *nick;
@property (nonatomic, retain) NSString *model;
@property (nonatomic, retain) NSString *os;
@property (nonatomic, retain) NSString *productId;
@property (nonatomic, retain) NSString *channelId;
@property (nonatomic, retain) NSString *productVersion;
@property (nonatomic, retain) NSString *deviceToken;
@property (nonatomic, retain) NSString *userAgent;
@property (nonatomic, retain) NSString *topSession;
@property (nonatomic, retain) NSString *outerCode;
@property (nonatomic, retain) NSString *retina;
@property (nonatomic, retain) NSString *display;
@property (nonatomic, retain) NSString *deviceId;
@property (nonatomic, retain) NSString *cookie;
@property (nonatomic, retain) NSString *lat;
@property (nonatomic, retain) NSString *lng;
@property (nonatomic, retain) NSString *mobileId;
@property (nonatomic, retain) NSString *ifa;
@property (nonatomic, retain) NSString *network;
@property (nonatomic, retain) NSString *isRoot;

@end
