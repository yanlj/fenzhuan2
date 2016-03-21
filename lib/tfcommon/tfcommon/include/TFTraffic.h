//
//  TFTraffic.h
//  tfcommon
//
//  Created by ChiangChoyi on 6/20/14.
//
//

#import <Foundation/Foundation.h>

#define SENDX(x)    do {                                                                    \
                        [[TFTraffic instance] sendBytes:x];                                 \
                    } while (0)
#define RECVX(x)    do {                                                                    \
                        [[TFTraffic instance] recvBytes:x];                                 \
                    } while (0)

//#define SENDX(x)    (nil)
//#define RECVX(x)    (nil)

@interface TFTraffic : NSObject

+ (TFTraffic *)instance;

@property (nonatomic, readonly) unsigned long long recv;
@property (nonatomic, readonly) unsigned long long send;

@property (nonatomic, readonly) NSString *recvString;
@property (nonatomic, readonly) NSString *sendString;

- (void)loadTrafficStatisticsInfo;
- (void)saveTrafficStatisticsInfo;

- (void)sendBytes:(unsigned long long)bytes;
- (void)recvBytes:(unsigned long long)bytes;

- (NSString *)totalTrafficInMB;
- (NSString *)getTotalTrafficInMBWithLastInterval:(NSTimeInterval *)interval;
- (NSString *)getLastTrafficInMBWithLastInterval:(NSTimeInterval *)interval;

@end
