//
//  TFTFDeviceInfo.m
//  tfcommon
//
//  Created by yin shen on 9/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TFDeviceInfo.h"

#include <sys/types.h>
#include <sys/sysctl.h>
#include <stdio.h>  
#include <stdlib.h>  
#include <string.h>  
#include <unistd.h>  
#include <sys/ioctl.h>  
#include <sys/types.h>  
#include <sys/socket.h>  
#include <netinet/in.h>  
#include <netdb.h>  
#include <arpa/inet.h>  
#include <sys/sockio.h>  
#include <net/if.h>  
#include <errno.h>  
#include <net/if_dl.h>

#if !TF_IS_IPAD
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>
#endif

#include <ifaddrs.h>
#import "TFCommand.h"
#import "TFKeychain.h"
#import <AdSupport/AdSupport.h>
#import <mach/mach_time.h>

#import "CheckJailBroken.h"

@implementation TFDeviceInfo

+(TFDeviceInfo *)sharedTFDeviceInfo 
{
    static TFDeviceInfo *instance = nil;
    
    if (instance == nil) {
        instance = [[TFDeviceInfo alloc] init];
        
    }
    
    return instance;
}

+ (void)printfDeviceInfo
{
    UIDevice *device = [UIDevice currentDevice];
    NSLog(@"device name:%@", [device name]);
    NSLog(@"device model:%@", [device model]);
    NSLog(@"device localizedModel:%@", [device localizedModel]);
    NSLog(@"device systemName:%@", [device systemName]);
    NSLog(@"device systemVersion:%@", [device systemVersion]);
    NSLog(@"device batteryLevel:%f", [device batteryLevel]);
    if ([[device systemVersion] floatValue] >= 6.0) {
        NSLog(@"IDFV:%@", [[device identifierForVendor] UUIDString]);
    }
    
    
    NSString *ifa = [self getIFA];
    NSLog(@"IDFA:%@", ifa);
    NSString *macAddress = [self getUDID];
    NSLog(@"macAddress:%@", macAddress);
    NSString *hardwareModel = [self platform];
    NSLog(@"Hardware Model:%@", hardwareModel);
    NSString *mobileId = [self getMobileId];
    NSLog(@"mobileId:%@", mobileId);
    BOOL isRoot = [self isRoot];
    NSLog(@"Root:%@", isRoot?@"YES":@"NO");
    BOOL isRetina = [self isRetinaDisplay];
    NSLog(@"Retina:%@", isRetina?@"YES":@"NO");
    BOOL isWifi = [self checkWifi];
    NSLog(@"Wifi:%@", isWifi?@"YES":@"NO");
    BOOL isChinaMobile = [self checkChinaMobile];
    NSLog(@"ChinaMobile:%@", isChinaMobile?@"YES":@"NO");

    UIScreen *screen = [UIScreen mainScreen];
    NSLog(@"screen scale:%f", [screen scale]);
    NSLog(@"screen bounds:%@", NSStringFromCGRect([screen bounds]));
    NSLog(@"screen applicationFrame:%@", NSStringFromCGRect([screen applicationFrame]));
    NSLog(@"screen brightness:%f", [screen brightness]);
    NSLog(@"screen currentMode.size:%@", NSStringFromCGSize([screen currentMode].size));
    
#ifdef __IPHONE_8_0
    if ([[device systemVersion] floatValue] >= 8.0) {
        NSLog(@"screen nativeBounds:%@", NSStringFromCGRect([screen nativeBounds]));
        NSLog(@"screen nativeScale:%f", [screen nativeScale]);
    }
#endif
}

+ (NSString *)getImei{
    
	NSString* udid = [TFDeviceInfo getUDID];
	NSString *imei = [NSString stringWithFormat:@"%@",[udid substringToIndex:15]];
	return imei;
	
}


+ (NSString *)getImsi{
    
	NSString* udid = [TFDeviceInfo getUDID];
	int len = [udid length];
	NSString *imsi = [NSString stringWithFormat:@"%@",[udid substringFromIndex:len - 15]];
	return imsi;
	
}

+ (NSString *)getClientID{
    
	NSString* udid = [TFDeviceInfo getUDID];
    return udid;	
}

+ (NSString *) platform{
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = malloc(size);
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString *platform = [NSString stringWithCString:machine encoding:NSUTF8StringEncoding];
    free(machine);
    return platform;
}


+ (NSString *)getUDID{
    
    int                 mib[6];
    size_t              len;
    char                *buf;
    unsigned char       *ptr;
    struct if_msghdr    *ifm;
    struct sockaddr_dl  *sdl;
    
    mib[0] = CTL_NET;
    mib[1] = AF_ROUTE;
    mib[2] = 0;
    mib[3] = AF_LINK;
    mib[4] = NET_RT_IFLIST;
    
    if ((mib[5] = if_nametoindex("en0")) == 0) {
        printf("Error: if_nametoindex error\n");
        return NULL;
    }
    
    if (sysctl(mib, 6, NULL, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 1\n");
        return NULL;
    }
    
    if ((buf = malloc(len)) == NULL) {
        printf("Could not allocate memory. error!\n");
        return NULL;
    }
    
    if (sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 2");
        return NULL;
    }
    
    ifm = (struct if_msghdr *)buf;
    sdl = (struct sockaddr_dl *)(ifm + 1);
    ptr = (unsigned char *)LLADDR(sdl);
    NSString *outstring = [NSString stringWithFormat:@"%02X:%02X:%02X:%02X:%02X:%02X", 
                           *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
    free(buf);
    
    return outstring;
}

+ (NSString *)getSID{
    
    int                 mib[6];
    size_t              len;
    char                *buf;
    unsigned char       *ptr;
    struct if_msghdr    *ifm;
    struct sockaddr_dl  *sdl;
    
    mib[0] = CTL_NET;
    mib[1] = AF_ROUTE;
    mib[2] = 0;
    mib[3] = AF_LINK;
    mib[4] = NET_RT_IFLIST;
    
    if ((mib[5] = if_nametoindex("en0")) == 0) {
        printf("Error: if_nametoindex error\n");
        return NULL;
    }
    
    if (sysctl(mib, 6, NULL, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 1\n");
        return NULL;
    }
    
    if ((buf = malloc(len)) == NULL) {
        printf("Could not allocate memory. error!\n");
        return NULL;
    }
    
    if (sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 2");
        return NULL;
    }
    
    ifm = (struct if_msghdr *)buf;
    sdl = (struct sockaddr_dl *)(ifm + 1);
    ptr = (unsigned char *)LLADDR(sdl);
    NSString *outstring = [NSString stringWithFormat:@"t%03d%03d%03d%03d%03d", 
                           *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4)];
    free(buf);
    
    return outstring;
}

+ (NSString *) platformString{
    
    NSString *platform = [self platform];
    
    if ([platform isEqualToString:@"iPhone1,1"])    return @"iPhone 1G";
    if ([platform isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
    if ([platform isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
    if ([platform isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone3,2"])    return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone3,3"])    return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([platform isEqualToString:@"iPhone5,1"])    return @"iPhone 5";
    if ([platform isEqualToString:@"iPhone5,2"])    return @"iPhone 5";
    if ([platform isEqualToString:@"iPhone5,3"])    return @"iPhone 5C";
    if ([platform isEqualToString:@"iPhone5,4"])    return @"iPhone 5C";
    if ([platform isEqualToString:@"iPhone6,1"])    return @"iPhone 5S";
    if ([platform isEqualToString:@"iPhone6,2"])    return @"iPhone 5S";
    if ([platform isEqualToString:@"iPhone7,1"])    return @"iPhone 6 Plus";
    if ([platform isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
    if ([platform isEqualToString:@"iPod1,1"])      return @"iPod Touch 1G";
    if ([platform isEqualToString:@"iPod2,1"])      return @"iPod Touch 2G";
    if ([platform isEqualToString:@"iPod3,1"])      return @"iPod Touch 3G";
    if ([platform isEqualToString:@"iPod4,1"])      return @"iPod Touch 4G";
    if ([platform isEqualToString:@"iPod5,1"])      return @"iPod Touch 5G";
    if ([platform isEqualToString:@"iPad1,1"])      return @"iPad";
    if ([platform isEqualToString:@"iPad2,1"])      return @"iPad2";
    if ([platform isEqualToString:@"iPad2,2"])      return @"iPad2";
    if ([platform isEqualToString:@"iPad2,3"])      return @"iPad2";
    if ([platform isEqualToString:@"iPad2,4"])      return @"iPad2";
    if ([platform isEqualToString:@"iPad2,5"])      return @"iPad mini";
    if ([platform isEqualToString:@"iPad2,6"])      return @"iPad mini";
    if ([platform isEqualToString:@"iPad2,7"])      return @"iPad mini";
    if ([platform isEqualToString:@"iPad3,1"])      return @"New iPad";
    if ([platform isEqualToString:@"iPad3,2"])      return @"New iPad";
    if ([platform isEqualToString:@"iPad3,3"])      return @"New iPad";
    if ([platform isEqualToString:@"iPad3,4"])      return @"iPad4";
    if ([platform isEqualToString:@"iPad3,5"])      return @"iPad4";
    if ([platform isEqualToString:@"iPad3,6"])      return @"iPad4";
    if ([platform isEqualToString:@"iPad4,1"])      return @"iPad Air";
    if ([platform isEqualToString:@"iPad4,2"])      return @"iPad Air";
    if ([platform isEqualToString:@"iPad4,3"])      return @"iPad Air";
    if ([platform isEqualToString:@"iPad4,4"])      return @"iPad mini2";
    if ([platform isEqualToString:@"iPad4,5"])      return @"iPad mini2";
    if ([platform isEqualToString:@"iPad4,6"])      return @"iPad mini2";
    if ([platform isEqualToString:@"iPad4,7"])      return @"iPad mini 3";
    if ([platform isEqualToString:@"iPad4,8"])      return @"iPad mini 3";
    if ([platform isEqualToString:@"iPad4,9"])      return @"iPad mini 3";
    if ([platform isEqualToString:@"iPad5,3"])      return @"iPad Air 2";
    if ([platform isEqualToString:@"iPad5,4"])      return @"iPad Air 2";
    
    if ([platform isEqualToString:@"i386"])         return @"Simulator";
    if ([platform isEqualToString:@"x86_64"])       return @"Simulator";
    return platform;
}

+ (BOOL)isRoot
{
    return [CheckJailBroken isJailBroken];
}

+ (BOOL)isRetinaDisplay {
    static BOOL isRetina = NO;
    static BOOL isGotResult = NO;
    
    if (!isGotResult) {
        int scale = 1.0;
        UIScreen *screen = [UIScreen mainScreen];
        if([screen respondsToSelector:@selector(scale)]) {
            scale = screen.scale;
        }
        
        if(scale == 1.0f) {
            isRetina = NO;
        }
        else {
            isRetina = YES;
        }
    }
    
    return isRetina;
}

+ (BOOL)checkWifi
{
    BOOL ret = YES;
    struct ifaddrs * first_ifaddr, * current_ifaddr;
    NSMutableArray* activeInterfaceNames = [[NSMutableArray alloc] init];
    getifaddrs( &first_ifaddr );
    current_ifaddr = first_ifaddr;
    while( current_ifaddr!=NULL )
    {
        if( current_ifaddr->ifa_addr->sa_family==0x02 )
        {
            [activeInterfaceNames addObject:[NSString stringWithFormat:@"%s", current_ifaddr->ifa_name]];
        }
        current_ifaddr = current_ifaddr->ifa_next;
    }
    ret = [activeInterfaceNames containsObject:@"en0"] || [activeInterfaceNames containsObject:@"en1"];
    freeifaddrs(first_ifaddr);
    [activeInterfaceNames release];
    return ret;
}


+ (BOOL)checkChinaMobile
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        return NO; 
    }
    else{
        BOOL ret = NO;
        CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];
        CTCarrier *carrier = [info subscriberCellularProvider];
        if (carrier == nil) {
            [info release];
            return NO;
        }
        
        NSString *code = [carrier mobileNetworkCode];
        if (code == nil) {
            [info release];
            return NO;
        }
        
        if ([code isEqualToString:@"00"] || [code isEqualToString:@"02"] || [code isEqualToString:@"07"]) {
            ret = YES;
        }
        [info release];   
        return ret;
    }

}

+ (NSString *)getMobileId{
    NSString *deviceId = nil;
    
    deviceId = [[TFKeychain shared] getDeviceIdFromKeychain];
    
    if (deviceId
        &&![deviceId isEqualToString:@""]) {
        return deviceId;
    }
    else{
        srandom((unsigned)(mach_absolute_time() & 0xFFFFFFFF));
        [[UIDevice currentDevice] setBatteryMonitoringEnabled:YES];
        NSString *batteryLevel = [NSString stringWithFormat:@"%.2f", [[UIDevice currentDevice] batteryLevel]];
        
        [[UIDevice currentDevice] setBatteryMonitoringEnabled:NO];
        
        NSString *randomNumber = [TFDeviceInfo generateRandomStringWithCount:10];
        
        NSString *time = [TFCommand currentTime];
        
        
        
        deviceId = [TFCommand do_SHA_String:[NSString stringWithFormat:@"%@%@%@%@%@%@",
                                             [UIDevice currentDevice].name,
                                             [TFDeviceInfo platformString],
                                             [UIDevice currentDevice].systemVersion,
                                             batteryLevel,
                                             time,
                                             randomNumber]];
        
        [[TFKeychain shared] writeDeviceIdToKeychain:deviceId];
        
        NSLog(@"%@",[NSString stringWithFormat:@"%@%@%@%@%@%@",
                     [UIDevice currentDevice].name,
                     [TFDeviceInfo platformString],
                     [UIDevice currentDevice].systemVersion,
                     batteryLevel,
                     time,
                     randomNumber]);
        
        return deviceId;
        
    }

}

+ (NSString *) generateRandomStringWithCount:(NSUInteger) count{
	NSString *sourceString = @"0123456789";
	NSMutableString *result = [[[NSMutableString alloc] init] autorelease];
	for (int i = 0; i < count; i++)
	{
		unsigned index = random() % [sourceString length];
		NSString *s = [sourceString substringWithRange:NSMakeRange(index, 1)];
		[result appendString:s];
	}
	return result;
}

+ (NSString *)getIFA{
    
    
    NSString *version = [[UIDevice currentDevice] systemVersion];
    
    if ([version compare:@"6.0" options:NSNumericSearch]==NSOrderedAscending) {
        return @"";
    }
    else{
//        if ([ASIdentifierManager sharedManager].advertisingTrackingEnabled) {
            return [[ASIdentifierManager sharedManager].advertisingIdentifier UUIDString];
//        }
//        else{
//            return @"";
//        }
    }
   

}

+ (NSString *)getDeviceId{
    
    NSString *deviceId = [TFDeviceInfo _getDeviceIdFromSandbox];
    
    if (deviceId.length > 0) {
        return deviceId;
    }
    
    deviceId = [[TFKeychain shared] getDeviceIdFromKeychain];
    
    if (deviceId.length > 0) {
        [TFDeviceInfo _setDeviceIdToSandbox:deviceId];
        return deviceId;
    }
    
    deviceId = [TFDeviceInfo getIFA];
    if (deviceId.length > 0){
        [TFDeviceInfo _setDeviceIdToSandbox:deviceId];
        [[TFKeychain shared] writeDeviceIdToKeychain:deviceId];
        return deviceId;
    }
    
    srandom((unsigned)(mach_absolute_time() & 0xFFFFFFFF));
    [[UIDevice currentDevice] setBatteryMonitoringEnabled:YES];
    NSString *batteryLevel = [NSString stringWithFormat:@"%.2f", [[UIDevice currentDevice] batteryLevel]];
    [[UIDevice currentDevice] setBatteryMonitoringEnabled:NO];
    
    NSString *randomNumber = [TFDeviceInfo generateRandomStringWithCount:10];
    
    NSString *time = [TFCommand currentTime];
    
    deviceId = [TFCommand do_SHA_String:[NSString stringWithFormat:@"%@%@%@%@%@%@",
                                         [UIDevice currentDevice].name,
                                         [[TFDeviceInfo sharedTFDeviceInfo] platformString],
                                         [UIDevice currentDevice].systemVersion,
                                         batteryLevel,
                                         time,
                                         randomNumber]];
    
    [TFDeviceInfo _setDeviceIdToSandbox:deviceId];
    
    [[TFKeychain shared] writeDeviceIdToKeychain:deviceId];
    
    NSLog(@"%@",[NSString stringWithFormat:@"%@%@%@%@%@%@",
                 [UIDevice currentDevice].name,
                 [TFDeviceInfo platformString],
                 [UIDevice currentDevice].systemVersion,
                 batteryLevel,
                 time,
                 randomNumber]);
    
    return deviceId;
    
}

+ (NSString *)_getDeviceIdFromSandbox{
    return  [[NSUserDefaults standardUserDefaults] objectForKey:@"TFOuterPublicDeviceId_"];
}

+ (void)_setDeviceIdToSandbox:(NSString *)deviceId{
    [[NSUserDefaults standardUserDefaults] setObject:deviceId?deviceId:@""
                                              forKey:@"TFOuterPublicDeviceId_"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


@end

