//
//  SPSKeychain.h
//  KeychainShare
//
//  Created by Jing Wen on 5/14/12.
//  Copyright (c) 2012 Alipay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KeychainItemWrapper.h"

@interface TFKeychain : NSObject{
    KeychainItemWrapper *keychainItem;
   
}

 

@property (retain) KeychainItemWrapper *keychainItem;
+ (TFKeychain *)shared;
- (NSString *)getDeviceIdFromKeychain;
- (void)writeDeviceIdToKeychain:(NSString *)deviceId;
@end
