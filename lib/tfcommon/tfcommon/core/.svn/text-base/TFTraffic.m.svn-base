//
//  TFTraffic.m
//  tfcommon
//
//  Created by ChiangChoyi on 6/20/14.
//
//

#import "TFTraffic.h"

@interface TFTraffic ()
{
    time_t      _timestamp;
    long long   _lastRecv;
    long long   _lastSend;
}
@end

@implementation TFTraffic

@synthesize recv = _recv;
@synthesize send = _send;

+ (void)initialize
{
    [[TFTraffic instance] loadTrafficStatisticsInfo];
}

+ (TFTraffic *)instance
{
    static TFTraffic *_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[TFTraffic alloc] init];
    });
    return _instance;
}

- (id)init
{
    if (self = [super init]) {
        [NSTimer scheduledTimerWithTimeInterval:60 target:self
                                       selector:@selector(autoSave:)
                                       userInfo:nil repeats:YES];
    }
    return self;
}

#pragma mark - Accessor

- (NSString *)recvString
{
    NSString *ret = nil;
    if (self.recv < 1024) {
        ret = [NSString stringWithFormat:@"%lluB", self.recv];
    } else {
        double recv = self.recv / 1024.f;
        if (recv < 1024) {
            ret = [NSString stringWithFormat:@"%.2fKB", recv];
        } else {
            recv /= 1024.f;
            if (recv < 1024) {
                ret = [NSString stringWithFormat:@"%.2fMB", recv];
            } else {
                recv /= 1024.f;
                ret = [NSString stringWithFormat:@"%.2fGB", recv];
            }
        }
    }
    return ret;
}

- (NSString *)sendString
{
    NSString *ret = nil;
    if (self.send < 1024) {
        ret = [NSString stringWithFormat:@"%lluB", self.send];
    } else {
        double send = self.send / 1024.f;
        if (send < 1024) {
            ret = [NSString stringWithFormat:@"%.2fKB", send];
        } else {
            send /= 1024.f;
            if (send < 1024) {
                ret = [NSString stringWithFormat:@"%.2fMB", send];
            } else {
                send /= 1024.f;
                ret = [NSString stringWithFormat:@"%.2fGB", send];
            }
        }
    }
    return ret;
}

- (NSString *)totalTrafficInKB
{
    long long bytes = self.send + self.recv;
    return [NSString stringWithFormat:@"%.3f", bytes / 1024.f];
}

- (NSString *)totalTrafficInMB
{
    long long bytes = self.send + self.recv;
    return [NSString stringWithFormat:@"%.2f", bytes / 1024.f / 1024.f];
}

- (NSString *)lastTrafficInMB
{
    long long bytes = self.recv - _lastRecv + self.send - _lastSend;
    return [NSString stringWithFormat:@"%.2f", bytes / 1024.f / 1024.f];
}

- (NSString *)getTotalTrafficInKBWithLastInterval:(NSTimeInterval *)interval
{
    time_t now = time(NULL);
    if (_timestamp == 0) {
        *interval = 0;
    } else {
        *interval = now - _timestamp;
    }
    _timestamp = now;
    
    NSString *totalTrafficInKB = [self totalTrafficInKB];
    
    [self saveTrafficStatisticsInfo];
    
    return totalTrafficInKB;
}

- (NSString *)getTotalTrafficInMBWithLastInterval:(NSTimeInterval *)interval
{
    time_t now = time(NULL);
    if (_timestamp == 0) {
        *interval = 0;
    } else {
        *interval = now - _timestamp;
    }
    _timestamp = now;
    
    NSString *totalTrafficInMB = [self totalTrafficInMB];
    
    [self saveTrafficStatisticsInfo];
    
    return totalTrafficInMB;
}

- (NSString *)getLastTrafficInMBWithLastInterval:(NSTimeInterval *)interval
{
    time_t now = time(NULL);
    if (_timestamp == 0) {
        *interval = 0;
    } else {
        *interval = now - _timestamp;
    }
    _timestamp = now;
    
    NSString *lastTrafficInMB = [self lastTrafficInMB];
    
    _lastRecv = self.recv;
    _lastSend = self.send;
    
    [self saveTrafficStatisticsInfo];
    
    return lastTrafficInMB;
}

#pragma mark - Private Methods

- (NSString *)trafficFilepath
{
    static NSString *_trafficFilepath = nil;
    if (!_trafficFilepath) {
        _trafficFilepath = [[NSString alloc] initWithFormat:@"%@/Documents/CommonData/traffic.dat", NSHomeDirectory()];
    }
    return _trafficFilepath;
}

- (void)autoSave:(id)sender
{
    [self saveTrafficStatisticsInfo];
}

#pragma mark - Public Methods

- (void)loadTrafficStatisticsInfo
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:[self trafficFilepath]]) {
        NSDictionary *traffic = [[[NSDictionary alloc] initWithContentsOfFile:[self trafficFilepath]]autorelease];
        if (traffic) {
            _send = [traffic[@"send"] unsignedLongLongValue];
            _recv = [traffic[@"recv"] unsignedLongLongValue];
            _lastRecv = [traffic[@"lastRecv"] unsignedLongLongValue];
            _lastSend = [traffic[@"lastSend"] unsignedLongLongValue];
            _timestamp = [traffic[@"timestamp"] longValue];
        }
    }
}

- (void)saveTrafficStatisticsInfo
{
    NSDictionary *traffic = @{@"send": @(self.send),
                              @"recv": @(self.recv),
                              @"lastSend": @(_lastSend),
                              @"lastRecv": @(_lastRecv),
                              @"timestamp": @(_timestamp)};
    [traffic writeToFile:[self trafficFilepath] atomically:YES];
}

- (void)sendBytes:(unsigned long long)bytes
{
    _send += bytes;
}

- (void)recvBytes:(unsigned long long)bytes
{
    _recv += bytes;
}

@end
