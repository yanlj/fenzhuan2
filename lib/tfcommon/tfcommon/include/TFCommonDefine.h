//
//  TFCommonDefine.h
//  tfcommon
//
//  Created by yin shen on 8/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

/*----------------TF_DEPRECATED format--------------------------------
*    tufu_x.x           deprecated class/function in tufu lib version x.x
* #no_used           class/function no longer userd
* #update            function update,a new more stronger function will
*                     replace this one
* #function_replaced function replaced, a new design function replace
*                     the old function
*
*    --------------------------------------------------------------------*/

#define TF_IS_IPHONE5 [UIScreen mainScreen].bounds.size.height == 568

/*!
 *   @define    TF_MAIN_THREAD_PROTECT
 *   @abstract  强制跳转主线程*/
#define TF_MAIN_THREAD_PROTECT(methord, args)        \
    if (![NSThread isMainThread]) {                  \
        [self   performSelectorOnMainThread :methord \
                withObject                  :args    \
                waitUntilDone               :NO];    \
        return;                                      \
    }

#define TF_OS_MIN_REQ(v, ret)   do {  NSString    *reqSysVer = v;                                         \
        NSString    *currSysVer = [[UIDevice currentDevice] systemVersion]; \
        *ret = ([currSysVer compare:reqSysVer options:NSNumericSearch] != NSOrderedAscending); } while (0)

/*!
 *   @define    TF_CAST
 *   @abstract  强制类型转换*/
#define TF_CAST(class, var)     ((class *)var)

/*!
 *   @define    TFC_PREFIX
 *   @abstract  tufu库前缀提示*/
#undef TFC_PREFIX
#define TFC_PREFIX(a) tufu##a

/*!
 *   @define    TF_DEPRECATED
 *   @abstract  摒弃函数提示*/
#if defined(__GNUC__) && (__GNUC__ >= 4) && defined(__APPLE_CC__) && (__APPLE_CC__ >= 5465)
  #define TF_DEPRECATED(_message)   __attribute__((deprecated))
#elif __has_extension(attribute_deprecated_with_message)
  #define TF_DEPRECATED(_message)   __attribute__((deprecated(_message)))
#else
  #define TF_DEPRECATED(_message)
#endif

// /运行时判断运行版本
#define TF_IS_IPAD_RUNTIME                  [[[UIDevice currentDevice] model] isEqualToString:@"iPad"]
#define TF_IS_IPHONE_RUNTIME                [[[UIDevice currentDevice] model] isEqualToString:@"iPhone"]
#define TF_IS_IPOD_TOUCH_RUNTIME            [[[UIDevice currentDevice] model] isEqualToString:@"iPod touch"]

#define TF_CALL_AND_MESSAGE_ABILITY_RUNTIME TF_IS_IPHONE_RUNTIME

// /视图tag的基础tag
#define kTFBasedTag                         79

// /公共库是否启用GCD模式 目前暂未实现
#define TF_ENABLE_GCD                       0

// /GCD模式的最大并发数 目前暂未实现
#if TF_ENABLE_GCD
  #define TF_CONCURRENT_COUNT   10
#endif

#define TF_IS_IPAD              UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad

#define TF_RELEASE(var) {[var release]; var = nil; }

#define kTaoFen8TripleDes   @"www.taofen8.com/906/3a10"
#define kTaoFen8LocalDes    @"www.taofen8.com/3a103a22"

#define TFC_NORMAL_IMAGE(path) [UIImage imageWithContentsOfFile :[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:path]]

// /公共库notification定义
#define nTF_DO_SMART_OPERATION  @"nTF_DO_SMART_OPERATION_"
#define nTF_NETWORK_FINISHED    @"nTF_NETWORK_FINISHED_"
#define nTF_NETWORK_CANCELED    @"nTF_NETWORK_CANCELED_"

#define TF_SAFE_BRIDGE(class, a) ((class *)a)

// /自定义log提示
#ifdef __cplusplus
    extern "C" {
#endif // __cplusplus

void TFNetLog(NSString *format, ...);

void TFLog(NSString *format, ...);

#ifdef __cplusplus
    }
#endif // __cplusplus

 //release版本屏蔽log
#ifdef DEBUG
#else
  #define printf(...)
  #define NSLog(...)
  #define TFLog(...)
  #define TFNetLog(...)
#endif

// 是否开启加压加密
#define EncryptAndGZip


#define TF_SINGLE_INSTANCE_INTERFACE(classname) +(classname*)shared;\
+(void)destory;\

#define TF_SINGLE_INSTANCE_IMPLEMENTION(classname) static classname* k_##classname = nil;\
+(classname*)shared{\
@synchronized(self){\
if (nil == k_##classname) {\
[[self alloc] init];\
}\
}\
return k_##classname;\
}\
+ (id)allocWithZone:(NSZone *)zone{\
@synchronized(self) {\
if (nil == k_##classname) {\
k_##classname = [super allocWithZone:zone];\
return k_##classname;\
}\
}\
return nil;\
}\
+ (void)destory{\
[k_##classname release],k_##classname=nil;\
}\
- (id)retain{ return k_##classname; }\
- (oneway void)release{}\
- (id)autorelease{ return k_##classname; }\
- (NSUInteger)retainCount{ return 100000;}