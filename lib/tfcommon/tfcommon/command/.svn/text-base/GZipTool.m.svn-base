//
//  GZipTool.m
//  GZipTest
//
//  Created by wentaowu on 11-10-13.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GZipTool.h"
#define DATA_CHUNK_SIZE 262144 // Deal with gzipped data in 256KB chunks
#define COMPRESSION_AMOUNT Z_DEFAULT_COMPRESSION

@implementation GZipTool

+(NSData *)uncompressBytes:(Bytef *)bytes length:(NSUInteger)length
{
    
//	if (length == 0) return nil;
//	
//	NSUInteger halfLength = length/2;
//	NSMutableData *outputData = [NSMutableData dataWithLength:length+halfLength];
//    
//	int status;
//    z_stream zStream;
//    
//    zStream.zalloc = Z_NULL;
//	zStream.zfree = Z_NULL;
//	zStream.opaque = Z_NULL;
//	zStream.avail_in = 0;
//	zStream.next_in = 0;
//	status = inflateInit2(&zStream, (15+32));
//	if (status != Z_OK) {
//		return nil;
//	}
//	
//	zStream.next_in = bytes;
//	zStream.avail_in = (unsigned int)length;
//	zStream.avail_out = 0;
//	
//	NSInteger bytesProcessedAlready = zStream.total_out;
//	while (zStream.avail_in != 0) {
//		
//		if (zStream.total_out-bytesProcessedAlready >= [outputData length]) {
//			[outputData increaseLengthBy:halfLength];
//		}
//		
//		zStream.next_out = [outputData mutableBytes] + zStream.total_out-bytesProcessedAlready;
//		zStream.avail_out = (unsigned int)([outputData length] - (zStream.total_out-bytesProcessedAlready));
//		
//		status = inflate(&zStream, Z_NO_FLUSH);
//		
//		if (status == Z_STREAM_END) {
//			break;
//		} else if (status != Z_OK) {
//			
//			return nil;
//		}
//	}
//	
//	[outputData setLength: zStream.total_out-bytesProcessedAlready];
//    
//    status = inflateEnd(&zStream);
//	if (status != Z_OK) {
//		return nil;
//	}
//    
//	return outputData;
    
    
    if (length == 0 ) return nil;
    
    NSUInteger half_length = length/ 2;
    
    NSMutableData *decompressed = [NSMutableData dataWithLength: length + half_length];
    BOOL done = NO;
    int status;
    
    z_stream strm;
    strm.next_in = bytes;
    strm.avail_in = length;
    strm.total_out = 0;
    strm.zalloc = Z_NULL;
    strm.zfree = Z_NULL;
    
    if (inflateInit2(&strm, (15+32)) != Z_OK) return nil;
    while (!done){
        if (strm.total_out >= [decompressed length])
            [decompressed increaseLengthBy: half_length];
        strm.next_out = [decompressed mutableBytes] + strm.total_out;
        strm.avail_out = [decompressed length] - strm.total_out;
        
        // Inflate another chunk.
        status = inflate (&strm, Z_SYNC_FLUSH);
        if (status == Z_STREAM_END) done = YES;
        else if (status != Z_OK) break;
    }
    if (inflateEnd (&strm) != Z_OK) return nil;
    
    // Set real length.
    if (done){
        [decompressed setLength: strm.total_out];
        return [NSData dataWithData: decompressed];
    }
    return nil;
}

+ (NSData *)compressBytes:(Bytef *)bytes length:(NSUInteger)length error:(NSError **)err shouldFinish:(BOOL)shouldFinish{
    if (length == 0) return nil;
	
	NSUInteger halfLength = length/2;
	
	NSMutableData *outputData = [NSMutableData dataWithLength:length/2];
	
	int status;
    z_stream zStream;
    
    zStream.zalloc = Z_NULL;
	zStream.zfree = Z_NULL;
	zStream.opaque = Z_NULL;
	zStream.avail_in = 0;
	zStream.next_in = 0;
    
    status = deflateInit2(&zStream, COMPRESSION_AMOUNT, Z_DEFLATED, (15+16), 8, Z_DEFAULT_STRATEGY);
	if (status != Z_OK) {
		return nil;
	}

    
    zStream.next_in = bytes;
	zStream.avail_in = (unsigned int)length;
	zStream.avail_out = 0;
    
	NSInteger bytesProcessedAlready = zStream.total_out;
	while (zStream.avail_out == 0) {
		
		if (zStream.total_out-bytesProcessedAlready >= [outputData length]) {
			[outputData increaseLengthBy:halfLength];
		}
		
		zStream.next_out = [outputData mutableBytes] + zStream.total_out-bytesProcessedAlready;
		zStream.avail_out = (unsigned int)([outputData length] - (zStream.total_out-bytesProcessedAlready));
		status = deflate(&zStream, shouldFinish ? Z_FINISH : Z_NO_FLUSH);
		
		if (status == Z_STREAM_END) {
			break;
		} else if (status != Z_OK) {
			if (err) {
				return nil;
			}
			return nil;
		}
	}
    
	[outputData setLength: zStream.total_out-bytesProcessedAlready];
    deflateEnd(&zStream);
//    status = inflateEnd(&zStream);
//	if (status != Z_OK) {
//		return nil;
//	}
    
	return outputData;
}
@end
