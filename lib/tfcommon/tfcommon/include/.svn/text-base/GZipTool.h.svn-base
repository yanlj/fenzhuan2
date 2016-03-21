//
//  GZipTool.h
//  GZipTest
//
//  Created by wentaowu on 11-10-13.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "zlib.h"

//const int MAXSIZE = 500*1024;
#define MAXSIZE 500*1024


@interface GZipTool : NSObject {

}

+ (NSData *)compressBytes:(Bytef *)bytes length:(NSUInteger)length error:(NSError **)err shouldFinish:(BOOL)shouldFinish;

+ (NSData *)uncompressBytes:(Bytef *)bytes length:(NSUInteger)length;

@end
