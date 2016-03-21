//
//  TFHTTPData.m
//  tfcommon
//
//  Created by yin shen on 2/22/13.
//
//

#import "TFHTTPData.h"
#import <UIKit/UIKit.h>
#import "GZipTool.h"
int HTTP_OK = 200;
int HTTP_STREAM_ERROR = 800;
int HTTP_STREAM_TIMEOUT = 801;
#define kTFHTTPDataStringBoundary @"293iosfksdfkiowjksdf31jsiuwq003s02dsaffafass3qw"
#import "TFCommonDefine.h"
#import "NSData+Base64.h"

@implementation TFHTTPData

- (void)dealloc
{
    self.postData = nil;
    [self.responseData release];
    [self.url release];
    self.delegate = nil;
    self.cacheStamp = nil;
    self.err= nil;
    self.extra = nil;
    [super dealloc];
}

- (id)init
{
    self = [super init];

    if (self) {
        self.timeout = 30.;
        self.cacheStamp = @"";
        self.responseData = [NSMutableData data];
    }

    return self;
}

- (NSString *)responseString
{
    NSData *data = [self responseData];

    if (!data) {
        return nil;
    }
    
    

    if (self.gzipResponse){
        
      
        NSData *uncompress = [GZipTool uncompressBytes:(Bytef *)[data bytes]
                                                length:[data length]];
        
        
        NSString *tempStr =   [[[NSString alloc]   initWithBytes   :[uncompress bytes]
                                    length          :[uncompress length]
                                    encoding        :NSUTF8StringEncoding] autorelease];
        return tempStr;
    }
    else{
        return [[[NSString alloc]   initWithBytes   :[data bytes]
                                    length          :[data length]
                                    encoding        :NSUTF8StringEncoding] autorelease];
    }
    
}

- (NSData *)covertMultiPart:(NSDictionary *)dict
{
    if (dict == nil) {
        return nil;
    }
    
    NSMutableData   *ret = [[NSMutableData alloc] init];
    NSString        *bodyPrefixString = [NSString stringWithFormat:@"--%@\r\n", kTFHTTPDataStringBoundary];
    NSString        *bodySuffixString = [NSString stringWithFormat:@"\r\n--%@--\r\n", kTFHTTPDataStringBoundary];


    for (id key in dict) {
        NSObject *obj = [dict valueForKey:key];
        [ret appendData:[bodyPrefixString dataUsingEncoding:NSUTF8StringEncoding]];
        if ([obj isKindOfClass:[UIImage class]]) {
            NSData *imageData = UIImagePNGRepresentation((UIImage *)obj);

            [ret appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@.png\"; filename=\"%@.png\"\r\n", key, key] dataUsingEncoding:NSUTF8StringEncoding]];

            [ret appendData:[@"Content-Type: image/jpg\r\nContent-Transfer-Encoding: binary\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
            [ret appendData:imageData];
            [ret appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        } else if ([obj isKindOfClass:[NSData class]]) {
            [ret appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@.png\"; filename=\"%@.png\r\n", key,key] dataUsingEncoding:NSUTF8StringEncoding]];

            [ret appendData:[@"Content-Type: content/unknown\r\nContent-Transfer-Encoding: binary\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];

            [ret appendData:(NSData *)obj];
        }
        
    }
    
    [ret appendData:[bodySuffixString dataUsingEncoding:NSUTF8StringEncoding]];

    return [ret autorelease];
}

- (void)setPostData:(NSData *)aPostData{
    
    [_postData  release];
    
    if (aPostData==nil) {
        _postData = nil;
        return;
    }
    
    if (self.rc4Crypt) {
        NSData *dst = nil;
        [aPostData retain];
        dst = [GZipTool compressBytes:(Bytef *)[aPostData bytes]
                         length:[aPostData length]
                          error:nil
                   shouldFinish:YES];
        _postData = [[self rc4Encrypt:dst] retain];
        [aPostData release];
    }
    else{
        _postData = [aPostData retain];
    }
}

- (NSData *)rc4Encrypt:(NSData *)plainData{
    int s[256],t[256];
    int length = [plainData length];
    char *plain = [plainData bytes];
    
    char k[] = "79927f330445959dd6a0be6a2d2a27668bee90657453f6f4d5ea7f7a0fc34204c48baa1c6e3031f78d27ab61d1e2b414b6ec6f38963ed5d81fb3dc065661bbf5";
    if (self.isHaihuReq){
        memcpy(k, "c1FwXaA10LCcRTPtSQPoKcwijlKoJOXPXnBWAGuQ62Z1T8CHuZZFhKCkoyLywVVBJs2FDcO20NXmM9HfwPr4m95Hv1OSi8RCZc5F1JWC5iHRRJ1X0CZsQLedKpL465RG", 128);
        
    }
    for(int i=0;i<256;i++)
    {
        s[i]=i;
        t[i]=k[i%strlen(k)];
    }
    
    int j=0;
    for(int i=0;i<256;i++)
    {
        int temp;
        j=(j+s[i]+t[i])%256;
        temp=s[i];
        s[i]=s[j];
        s[j]=temp;
    }
    
    int m,n,key[length],q;
    m=n=0;
    int i;

    char *ciphertext = malloc(length+1);
    memset(ciphertext, 0, length+1);
    
    for(i=0;i<length;i++)
    {
        int temp;
        m=(m+1)% 256;
        n=(n+s[n])% 256;
        temp=s[m];
        s[m]=s[n];
        s[n]=temp;
        q=(s[m]+s[n])%256;
        key[i]=s[q];
        ciphertext[i] = plain[i]^key[i];
    }
   // Byte byte = 0x0001;
    NSMutableData *retData = [NSMutableData dataWithBytes:ciphertext length:length];
    free(ciphertext);
   // [retData appendBytes:ciphertext length:length];
    //[self rc4Decrypt:ciphertext];
  //  Byte *bytes = (Byte *)[retData bytes];
   // printf("%d",*bytes);
    
    
    return retData;
    // printf("%s",ciphertext);
}

- (void)rc4Decrypt:(char *)cipher{
    int s[256],t[256];
    int length = strlen(cipher);
    char k[] = "c1FwXaA10LCcRTPtSQPoKcwijlKoJOXPXnBWAGuQ62Z1T8CHuZZFhKCkoyLywVVBJs2FDcO20NXmM9HfwPr4m95Hv1OSi8RCZc5F1JWC5iHRRJ1X0CZsQLedKpL465RG";
    char plaintext[length+1];
    memset(plaintext, 0, length+1);
    for(int i=0;i<256;i++)//////////////给字节状态矢量和可变长的密钥数组赋值
    {
        s[i]=i;
        t[i]=k[i%strlen(k)];
    }
    int j=0;
    for(int i=0;i<256;i++) //////使用可变长的密钥数组初始化字节状态矢量数组s
    {
        int temp;
        j=(j+s[i]+t[i])%256;
        temp=s[i];
        s[i]=s[j];
        s[j]=temp;
    }
    
    int m,n,key[length],q;
    m=n=0;
    int i;
    for(i=0;i<length;i++)/////////////由字节状态矢量数组变换生成密钥流并对密文字符进行解密
    {
        int temp;
        m=(m+1)% 256;
        n=(n+s[n])% 256;
        temp=s[m];
        s[m]=s[n];
        s[n]=temp;
        
        q=(s[m]+s[n])%256;
        key[i]=s[q];
        plaintext[i]=cipher[i]^key[i];
        
    }
    
    printf("%s",plaintext);
}

@synthesize postData = _postData;
@synthesize responseData;
@synthesize url;
@synthesize statusCode;
@synthesize timeout;
@synthesize delegate;
@synthesize noPersistent;
@synthesize type;
@synthesize rc4Crypt;
@synthesize cacheStamp;
@synthesize cachedTimeout;
@synthesize err;
@synthesize extra;
@end