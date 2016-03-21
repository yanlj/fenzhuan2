//
//  CheckJailBroken.m
//  tfcommon
//
//  Created by crazycao on 14-11-25.
//
//

#import "CheckJailBroken.h"

#import <dlfcn.h>

@implementation CheckJailBroken

#define NSLog(...)

// 通过常见的越狱文件判定

#define ARRAY_SIZE(a) sizeof(a)/sizeof(a[0])

const char* jailbreak_tool_pathes[] = {
    "/Applications/Cydia.app",
    "/Library/MobileSubstrate/MobileSubstrate.dylib",
    "/bin/bash",
    "/usr/sbin/sshd",
    "/etc/apt"
};

+ (BOOL)isJailBreakByFile
{
    for (int i=0; i<ARRAY_SIZE(jailbreak_tool_pathes); i++) {
        if ([[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithUTF8String:jailbreak_tool_pathes[i]]]) {
            NSLog(@"The device is jail broken!");
            return YES;
        }
    }
    NSLog(@"The device is NOT jail broken!");
    return NO;
}

// 通过cydia的 URL scheme 判定

+ (BOOL)isJailBreakByURLScheme
{
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"cydia://"]]) {
        NSLog(@"The device is jail broken!");
        return YES;
    }
    NSLog(@"The device is NOT jail broken!");
    return NO;
}

// 通过访问系统应用列表判定（非越狱设备无此权限）

#define USER_APP_PATH                 @"/User/Applications/"

+ (BOOL)isJailBreakByApplicationList
{
    if ([[NSFileManager defaultManager] fileExistsAtPath:USER_APP_PATH]) {
        NSLog(@"The device is jail broken!");
        NSArray *applist = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:USER_APP_PATH error:nil];
        NSLog(@"applist = %@", applist);
        return YES;
    }
    NSLog(@"The device is NOT jail broken!");
    return NO;
}


// 通过读取环境变量（DYLD_INSERT_LIBRARIES）判断

char* printEnv(void)
{
    char *env = getenv("DYLD_INSERT_LIBRARIES");
    NSLog(@"%s", env);
    return env;
}

+ (BOOL)isJailBreakByEnvironmentVariable
{
    if (printEnv()) {
        NSLog(@"The device is jail broken!");
        return YES;
    }
    NSLog(@"The device is NOT jail broken!");
    return NO;
}

// 使用stat方法来判定cydia是否存在
//
//#define CYDIA_APP_PATH                "/Applications/Cydia.app"
//
//int checkInject()
//{
//    int ret;
//    Dl_info dylib_info;
//    int (*func_stat)(const char*, struct stat*) = stat;
//    
//    if ((ret = dladdr(func_stat, &dylib_info)) && strncmp(dylib_info.dli_fname, dylib_name, strlen(dylib_name))) {
//        return 0;
//    }
//    return 1;
//}
//
//int checkCydia()
//{
//    // first ,check whether library is inject
//    struct stat stat_info;
//    
//    if (!checkInject()) {
//        if (0 == stat(CYDIA_APP_PATH, &stat_info)) {
//            return 1;
//        }
//    } else {
//        return 1;
//    }
//    return 0;
//}
//
//- (BOOL)isJailBreakByCydiaStat
//{
//    if (checkCydia()) {
//        NSLog(@"The device is jail broken!");
//        return YES;
//    }
//    NSLog(@"The device is NOT jail broken!");
//    return NO;
//}



+ (BOOL)isJailBroken
{
    if ([self isJailBreakByFile]) {
        return YES;
    }
    
    if ([self isJailBreakByURLScheme]) {
        return YES;
    }
    
    if ([self isJailBreakByApplicationList]) {
        return YES;
    }
    
    if ([self isJailBreakByEnvironmentVariable]) {
        return YES;
    }
    
    return NO;
}


@end