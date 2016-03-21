//
//  TripleDesTool.h
//  GZipTest
//
//  Created by wentaowu on 11-10-13.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <CommonCrypto/CommonCryptor.h>


@interface TripleDesTool: NSObject {

}

+(NSString *)TripleDES:(NSString*)plainText encryptOrDecrypt:(CCOperation)encryptOrDecrypt key:(NSString*)akey;
+(NSData *)TripleNSDataDES:(NSData*)plainText encryptOrDecrypt:(CCOperation)encryptOrDecrypt key:(NSData*)akey;
+(unsigned char*)TripleCharDES:(NSString*)plainText key:(NSString*)akey;

@end
