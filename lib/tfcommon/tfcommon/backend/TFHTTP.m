#line 1 "TFHTTP.m"
//
//  TFHttp.m
//  tfcommon
//
//  Created by yin shen on 12/15/12.
//
//

#import "TFHTTP.h"
#include <sys/time.h>
#include <time.h>
#include <mach/mach_time.h>
#import "TFHTTPData.h"
#import "tfthreadpool.h"
#import <UIKit/UIKit.h>
#import "TFCommonDefine.h"
#import "TFURLConnection.h"
#import "TFURLCache.h"
#import "TFTraffic.h"

#import "UIImage+WebP.h"
#import "TFWebPConvertData.h"

static CFReadStreamRef _lastStream = NULL;
static NSMutableArray *kPersistentConnectionsPool = nil;
static double kPersistentConnectionTimeoutSeconds = 90.0;
static NSRecursiveLock *kConnectionsLock = nil;

static const NSString *kConnectionStream = @"stream";
static const NSString *kConnectionScheme = @"scheme";
static const NSString *kConnectionHost = @"host";
static const NSString *kConnectionExpires = @"expires";

static TFURLCache *urlCache = nil;

@implementation TFHTTP

void showNetworkActivityIndicator();

void hideNetworkActivityIndicator();


+ (void)initialize{
    if (self == [TFHTTP class]) {
        kPersistentConnectionsPool = [[NSMutableArray alloc] init];
        kConnectionsLock = [[NSRecursiveLock alloc] init];
        
        urlCache = [[TFURLCache alloc] initWithMemoryCapacity:2*1024*1024
                                                 diskCapacity:10*1024*1024
                                                     diskPath:nil];
    }
}

+ (void)cleanExpirePersistentConnections{
    [kConnectionsLock lock];
	NSUInteger i;
	for (i=0; i<[kPersistentConnectionsPool count]; i++) {
		NSDictionary *existingConnection = [kPersistentConnectionsPool objectAtIndex:i];
		if ([[existingConnection objectForKey:kConnectionExpires] timeIntervalSinceNow] <= 0) {
            
			NSInputStream *stream = [existingConnection objectForKey:kConnectionStream];
			if (stream) {
				[stream close];
			}
			[kPersistentConnectionsPool removeObject:existingConnection];
			i--;
		}
	}
	[kConnectionsLock unlock];
    
}


void TFHTTPNet(void *objs, short *cancel_point)
{
    
    NSLog(@"{ start request... }");
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    
    struct timeval  begin_t;
    struct timeval  past_t;
    gettimeofday(&begin_t, NULL);
    
    NSMutableArray *freePool = [[NSMutableArray alloc] init];
    
    NSInputStream *oldStream = nil;
    NSMutableDictionary *connection = nil;
    
    TFHTTPData *selfBridge = (TFHTTPData *)objs;
    
    TFTASK_TEST_CANCEL(*cancel_point, selfBridge.statusCode = HTTP_STREAM_ERROR; goto POOL_FREE;);
    
    showNetworkActivityIndicator();
    
    
    [TFHTTP cleanExpirePersistentConnections];
    
    [kConnectionsLock lock];
    
    CFStringRef urlStr = (CFStringRef)selfBridge.url;
    CFURLRef    url = CFURLCreateWithString(kCFAllocatorDefault, urlStr, NULL);
    CFStringRef requestMethod = selfBridge.postData ? CFSTR("POST") : CFSTR("GET");
    
    CFStringRef scheme = CFURLCopyScheme(url);
    CFStringRef host = CFURLCopyHostName(url);
    
    [freePool addObject:(NSString *)scheme];
    [freePool addObject:(NSString *)host];
    
    CFRelease(scheme);
    CFRelease(host);
    
    
    CFHTTPMessageRef request = CFHTTPMessageCreateRequest(kCFAllocatorDefault, requestMethod, url, kCFHTTPVersion1_1);
    
    CFHTTPMessageSetHeaderFieldValue(request, CFSTR("Content-type"), CFSTR("application/x-www-form-urlencoded;charset=utf-8"));
    
    CFHTTPMessageSetHeaderFieldValue(request, CFSTR("Connection"), CFSTR("Keep-Alive:timeout=90,max=100"));
    
    if (selfBridge.postData) {
        CFHTTPMessageSetBody(request, (CFDataRef)selfBridge.postData);
        selfBridge.postData = nil;
    }
    
    NSLog(@"{ create stream... }");
    
    [freePool addObject:(id)request];
    CFRelease(request);
    [freePool addObject:(id)url];
    CFRelease(url);
    
    TFTASK_TEST_CANCEL(*cancel_point,  selfBridge.statusCode = HTTP_STREAM_ERROR; [kConnectionsLock unlock]; goto POOL_FREE; );
    
    CFReadStreamRef readStream = CFReadStreamCreateForHTTPRequest(kCFAllocatorDefault, request);
    
    for (NSMutableDictionary *existingConnection in kPersistentConnectionsPool) {
        if ([[existingConnection objectForKey:kConnectionHost] isEqualToString:(NSString *)host]
            && [[existingConnection objectForKey:kConnectionScheme] isEqualToString:(NSString *)scheme]) {
            connection = existingConnection;
        }
    }
    
    if (connection) {
        NSLog(@"{ keep pre connection open }");
        oldStream = [[connection objectForKey:kConnectionStream] retain];
    }
    
    if (!connection) {
        NSLog(@"{ no reuse connection create one }");
        connection = [NSMutableDictionary dictionary];
        [connection setObject:(NSString *)host forKey:kConnectionHost];
        [connection setObject:(NSString *)scheme forKey:kConnectionScheme];
        [kPersistentConnectionsPool addObject:connection];
    }
    
    [connection setObject:(NSInputStream *)readStream forKey:kConnectionStream];
    CFRelease(readStream);
    
    CFReadStreamSetProperty(readStream, kCFStreamPropertyHTTPAttemptPersistentConnection, kCFBooleanTrue);
    
    
    BOOL done = NO;
    
    NSLog(@"{ open stream... }");
    
    if (!CFReadStreamOpen(readStream)) {
        done = YES;
    }
    
    selfBridge.responseData = [[[NSMutableData alloc] init] autorelease];
    
    [kConnectionsLock unlock];
    
    while (!done) {
        TFTASK_TEST_CANCEL(*cancel_point,selfBridge.statusCode = HTTP_STREAM_ERROR; goto POOL_FREE;);
        
        if (CFReadStreamHasBytesAvailable(readStream)) {
            UInt8   buf[1024] = {0};
            CFIndex bytesRead = CFReadStreamRead(readStream, buf, sizeof(buf));
            
            if (bytesRead < 0) {
                NSLog(@"{ HTTP_STREAM_ERROR }");
                selfBridge.statusCode = HTTP_STREAM_ERROR;
                done = YES;
            } else if (bytesRead == 0) {
                if (kCFStreamStatusAtEnd == CFReadStreamGetStatus(readStream)) {
                    NSLog(@"{ kCFStreamStatusAtEnd }");
                    done = YES;
                }
            } else {
                [selfBridge.responseData appendBytes:buf length:bytesRead];
            }
        } else {
            int status = CFReadStreamGetStatus(readStream);
            
            if (kCFStreamStatusAtEnd == status) {
                done = YES;
            } else if (kCFStreamStatusOpen == status) {
                gettimeofday(&past_t, NULL);
                
                if (past_t.tv_sec - begin_t.tv_sec > selfBridge.timeout) {
                    NSLog(@"{ TIME_OUT }");
                    selfBridge.statusCode = HTTP_STREAM_TIMEOUT;
                    selfBridge.responseData = nil;
                    done = YES;
                }
            } else if (kCFStreamStatusError == status) {
                NSLog(@"{ kCFStreamStatusError }");
                selfBridge.statusCode = HTTP_STREAM_ERROR;
                selfBridge.responseData = nil;
                done = YES;
            }
        }
    }
    
    if (HTTP_STREAM_ERROR != selfBridge.statusCode) {
        CFHTTPMessageRef responseHeader = (CFHTTPMessageRef)CFReadStreamCopyProperty(readStream, kCFStreamPropertyHTTPResponseHeader);
        
        if (responseHeader!=NULL) {
            selfBridge.statusCode = CFHTTPMessageGetResponseStatusCode(responseHeader);
            CFRelease(responseHeader);
        }
        
    }
    
    
    [kConnectionsLock lock];
    
    [connection setObject:[NSDate dateWithTimeIntervalSinceNow:kPersistentConnectionTimeoutSeconds]
                   forKey:kConnectionExpires];
    
    [kConnectionsLock unlock];
    
POOL_FREE:{
    [freePool release];
    freePool=nil;
    
    
    if (oldStream) {
        CFReadStreamClose((CFReadStreamRef)oldStream);
        CFRelease((CFReadStreamRef)oldStream);
        oldStream = nil;
    }
    
    hideNetworkActivityIndicator();
    
    if (selfBridge) {
        [selfBridge.delegate httpFinished:selfBridge];
    }
    
    [pool release];
}
}

void TFHTTPUpload(void *objs, short *cancel_point)
{
    
    NSLog(@"{ start request... }");
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    
    struct timeval  begin_t;
    struct timeval  past_t;
    gettimeofday(&begin_t, NULL);
    
    TFHTTPData *selfBridge = (TFHTTPData *)objs;
    TFTASK_TEST_CANCEL(*cancel_point, [selfBridge release]; selfBridge = nil; [pool release]; );
    showNetworkActivityIndicator();
    
    CFStringRef urlStr = (CFStringRef)selfBridge.url;
    CFURLRef    url = CFURLCreateWithString(kCFAllocatorDefault, urlStr, NULL);
    CFStringRef requestMethod = selfBridge.postData ? CFSTR("POST") : CFSTR("GET");
    
    CFHTTPMessageRef request = CFHTTPMessageCreateRequest(kCFAllocatorDefault, requestMethod, url, kCFHTTPVersion1_1);
    
    CFHTTPMessageSetHeaderFieldValue(request, CFSTR("Content-type"), CFSTR("multipart/form-data; boundary=293iosfksdfkiowjksdf31jsiuwq003s02dsaffafass3qw"));
    
    // CFHTTPMessageSetHeaderFieldValue(request, CFSTR("Connection"), CFSTR("Keep-Alive:timeout=90,max=100"));
    
    if (selfBridge.postData) {
#if DEBUG
        SENDX(selfBridge.postData.length);
#endif
        CFHTTPMessageSetBody(request, (CFDataRef)selfBridge.postData);
        selfBridge.postData = nil;
    }
    
    NSLog(@"{ create stream... }");
    
    TFTASK_TEST_CANCEL(*cancel_point, hideNetworkActivityIndicator(); CFRelease(url); CFRelease(request); [selfBridge release]; selfBridge = nil; [pool release]; );
    
    CFReadStreamRef readStream = CFReadStreamCreateForHTTPRequest(kCFAllocatorDefault, request);
    
    BOOL done = NO;
    
    NSLog(@"{ open stream... }");
    
    if (!CFReadStreamOpen(readStream)) {
        done = YES;
    }
    
    selfBridge.responseData = [[[NSMutableData alloc] init] autorelease];
    
    while (!done) {
        TFTASK_TEST_CANCEL(*cancel_point, hideNetworkActivityIndicator(); CFRelease(url); CFRelease(request); CFReadStreamClose(readStream); CFRelease(readStream); [selfBridge release]; selfBridge = nil; [pool release]; );
        
        if (CFReadStreamHasBytesAvailable(readStream)) {
            UInt8   buf[1024] = {0};
            CFIndex bytesRead = CFReadStreamRead(readStream, buf, sizeof(buf));
            
            if (bytesRead < 0) {
                NSLog(@"{ HTTP_STREAM_ERROR }");
                selfBridge.statusCode = HTTP_STREAM_ERROR;
                done = YES;
            } else if (bytesRead == 0) {
                // int status = CFReadStreamGetStatus(readStream);
                if (kCFStreamStatusAtEnd == CFReadStreamGetStatus(readStream)) {
                    NSLog(@"{ kCFStreamStatusAtEnd }");
                    done = YES;
                }
            } else {
                [selfBridge.responseData appendBytes:buf length:bytesRead];
#if DEBUG
                RECVX(bytesRead);
#endif
            }
        } else {
            int status = CFReadStreamGetStatus(readStream);
            
            if (kCFStreamStatusAtEnd == CFReadStreamGetStatus(readStream)) {
                done = YES;
            } else if (status == kCFStreamStatusOpen) {
                gettimeofday(&past_t, NULL);
                
                if (past_t.tv_sec - begin_t.tv_sec > selfBridge.timeout) {
                    NSLog(@"{ TIME_OUT }");
                    selfBridge.statusCode = HTTP_STREAM_ERROR;
                    done = YES;
                }
            } else if (status == kCFStreamStatusError) {
                NSLog(@"{ kCFStreamStatusError }");
                selfBridge.statusCode = HTTP_STREAM_ERROR;
                done = YES;
            }
        }
    }
    
    if (HTTP_STREAM_ERROR != selfBridge.statusCode) {
        CFHTTPMessageRef responseHeader = (CFHTTPMessageRef)CFReadStreamCopyProperty(readStream, kCFStreamPropertyHTTPResponseHeader);
        
        selfBridge.statusCode = CFHTTPMessageGetResponseStatusCode(responseHeader);
        CFRelease(responseHeader);
    }
    
    hideNetworkActivityIndicator();
    
    CFRelease(url);
    CFRelease(request);
    CFReadStreamClose(readStream);
    CFRelease(readStream);
    
    if (selfBridge) {
        TFTASK_TEST_CANCEL(*cancel_point, [selfBridge release]; selfBridge = nil; [pool release]; );
        [selfBridge.delegate httpFinished:selfBridge];
    }
    
    [pool release];
}

void TFHTTPNet2(void *objs, short *cancel_point){
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    
    
    showNetworkActivityIndicator();
    
    TFHTTPData *selfBridge = (TFHTTPData *)objs;
    
    
    
    NSData *cachedReponse = nil;
//#if kTFEnableURLCache
//    cachedReponse = [[TFURLCache shareDefaultCache] cachedResponseForRequestStamp:selfBridge.cacheStamp];
//    
//    if (cachedReponse) {
//        NSLog(@"{ go to net_response }");
//        selfBridge.responseData = (NSMutableData *)cachedReponse;
//        goto NET_RESPONSE;
//    }
//#endif
    
    TFTASK_TEST_CANCEL(*cancel_point, hideNetworkActivityIndicator(); [selfBridge release]; selfBridge = nil; [pool release]; );
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:selfBridge.url]
                                                                cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData
                                                            timeoutInterval:20];
    
    [request setHTTPMethod:selfBridge.postData ? @"POST" : @"GET"];
    [request setValue:@"application/x-www-form-urlencoded;charset=utf-8" forHTTPHeaderField:@"Content-type"];
    [request setValue:@"Keep-Alive:timeout=90,max=100" forHTTPHeaderField:@"Connection"];
    
    [request setValue:selfBridge.rc4Crypt?@"yes":@"no" forHTTPHeaderField:@"Encrypt"];
    
   
    [request setHTTPBody:selfBridge.postData];
    
#if DEBUG
    if (selfBridge.postData) {
        SENDX(selfBridge.postData.length);
    }
#endif
    
    NSError *error = nil;
    
    
    selfBridge.responseData = (NSMutableData *)[NSURLConnection sendSynchronousRequest:request
                                                                     returningResponse:nil
                                                                                 error:&error];

    [request release];
     
    if (error) {
        selfBridge.statusCode = HTTP_STREAM_ERROR;
        selfBridge.err = error;
    }
    
NET_RESPONSE:{
    selfBridge.statusCode = selfBridge.responseData?HTTP_OK:HTTP_STREAM_ERROR;
    
    if (selfBridge) {
        TFTASK_TEST_CANCEL(*cancel_point, hideNetworkActivityIndicator();[selfBridge release]; selfBridge = nil; [pool release]; );
        
        hideNetworkActivityIndicator();
        
        [selfBridge.delegate httpFinished:selfBridge];
    }
}
    
    [pool release];
}

void TFHTTPNet3(void *objs, short *cancel_point){
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    
    TFHTTPData *selfBridge = (TFHTTPData *)objs;
    TFTASK_TEST_CANCEL(*cancel_point, [selfBridge release]; selfBridge = nil; [pool release]; );
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:selfBridge.url]];
    
    [request setHTTPMethod:selfBridge.postData ? @"POST" : @"GET"];
    [request setValue:@"application/x-www-form-urlencoded;charset=utf-8" forHTTPHeaderField:@"Content-type"];
    [request setValue:@"Keep-Alive:timeout=90,max=100" forHTTPHeaderField:@"Connection"];
    
    [request setHTTPBody:selfBridge.postData];
    
#if DEBUG
    if (selfBridge.postData) {
        SENDX(selfBridge.postData.length);
    }
#endif
    
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request
                                                                  delegate:selfBridge.delegate];
    [request release];

    [connection scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    
    [[NSRunLoop currentRunLoop] run];
    
    [connection start];
    
    [pool release];
}

void TFHTTPNet4(void *objs, short *cancel_point){
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    
    TFHTTPData *selfBridge = (TFHTTPData *)objs;
    TFTASK_TEST_CANCEL(*cancel_point, [selfBridge release]; selfBridge = nil; [pool release]; );
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:selfBridge.url]];
    
    [request setHTTPMethod:selfBridge.postData ? @"POST" : @"GET"];
    [request setValue:@"multipart/form-data; boundary=293iosfksdfkiowjksdf31jsiuwq003s02dsaffafass3qw" forHTTPHeaderField:@"Content-type"];
   // [request setValue:@"Keep-Alive:timeout=90,max=100" forHTTPHeaderField:@"Connection"];
    
    [request setHTTPBody:selfBridge.postData];
    
#if DEBUG
    if (selfBridge.postData) {
        SENDX(selfBridge.postData.length);
    }
#endif
    
    TFURLConnection *connection = [[TFURLConnection alloc] initWithRequest:request
                                                                  delegate:selfBridge.delegate];
    
    [request release];
    
    connection.httpData = selfBridge; ///retain httpdata consider to release
    
    [connection scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    
    [[NSRunLoop currentRunLoop] run];
    
    [connection start];
    
    [pool release];
}


//void TFHTTPUpload2(void *objs, short *cancel_point){
//    
//}

void TFImageDownload(void *objs, short *cancel_point)
{
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    
    TFHTTPData *selfBridge = (TFHTTPData *)objs;
    TFTASK_TEST_CANCEL(*cancel_point, [selfBridge release]; selfBridge = nil; [pool release]; );
    
    selfBridge.responseData = [NSData dataWithContentsOfURL:[NSURL URLWithString:selfBridge.url]];
    
    selfBridge.statusCode = selfBridge.responseData?HTTP_OK:HTTP_STREAM_ERROR;
    
    if (selfBridge) {
        TFTASK_TEST_CANCEL(*cancel_point, [selfBridge release]; selfBridge = nil; [pool release]; );
#if DEBUG
        if (selfBridge.responseData) {
            RECVX(selfBridge.responseData.length);
        }
#endif
        [selfBridge.delegate httpFinished:selfBridge];

    }
    
    [pool release];
}

void showNetworkActivityIndicator()
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"note.tfcommon.beginApiRequest"
                                                        object:nil];
}

void hideNetworkActivityIndicator()
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"note.tfcommon.endApiRequest"
                                                        object:nil];
}

void TFWebPImageDecode(void *objs, short *cancel_point)
{
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    
    TFWebPConvertData *selfBridge = (TFWebPConvertData *)objs;
    TFTASK_TEST_CANCEL(*cancel_point, [selfBridge release]; selfBridge = nil; [pool release]; );
    
    UIImage *image = [UIImage imageWithWebPData:selfBridge.webPData];
    selfBridge.webPImage = image;
    
    if (selfBridge) {
        TFTASK_TEST_CANCEL(*cancel_point, [selfBridge release]; selfBridge = nil; [pool release]; );
        
        if (selfBridge.delegate && [selfBridge.delegate respondsToSelector:@selector(convertFinished:)]) {
            [selfBridge.delegate convertFinished:selfBridge];
        }
        
    }
    
    [pool release];
}

@end