//
//  SPSKeychain.m
//  KeychainShare
//
//  Created by Jing Wen on 5/14/12.
//  Copyright (c) 2012 Alipay. All rights reserved.
//

#import "TFKeychain.h"
#import "TFCommonDefine.h"


@interface TFKeychain()
//TF_SINGLE_INSTANCE_INTERFACE(TFKeychain)
@end

@implementation TFKeychain

TF_SINGLE_INSTANCE_IMPLEMENTION(TFKeychain)

- (id)init{
    if (self = [super init]) {
        [self createKeychainWarpper];
    }
    return self;
}





- (void)writeDeviceIdToKeychain:(NSString *)deviceId{
    [self.keychainItem setObject:deviceId forKey:(id)kSecAttrAccount];
}



- (NSString *)getDeviceIdFromKeychain{
    NSString *deviceId = [self.keychainItem objectForKey:(id)kSecAttrAccount];
    return deviceId;
}




- (void)createKeychainWarpper{
    KeychainItemWrapper *wrapper = [[KeychainItemWrapper alloc] initWithIdentifier:@"taofen8-device-udid1" accessGroup:nil];
    
    self.keychainItem = wrapper;
    [wrapper release];
}

- (void)destoryKeychainWarpper{
    self.keychainItem = nil;
}

- (void)dealloc{
    if (self.keychainItem) {
        self.keychainItem = nil;
    }
    [super dealloc];
}

@synthesize keychainItem;
@end
