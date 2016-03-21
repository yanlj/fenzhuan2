//
//  TFImageAllocTable.m
//  tfcommon
//
//  Created by yin shen on 8/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TFMemoryAllocTable.h"
#import "TFImageView.h"
#include <mach/mach.h>
#import "TFCommonDefine.h"
#import <malloc/malloc.h>

#undef kMaxUsedMemorySize
#define kMaxUsedMemorySize 20 /*!激发smart操作执行的最大内存用量*/

#undef kMaxOriginalViewControllerCount  
#define kMaxOriginalViewControllerCount 7 /*!激发smart操作执行的最大原始控制器创建数*/

static int kOriginalViewControllerCount = 0;

static int kPageSize = 0;

static double kMemoryCardinal = 0;

static double kImageMemory = 0;

@interface TFMemoryAllocTable()

+ (double)_usedMemory;

@end

@implementation TFMemoryAllocTable

+ (TFMemoryAllocTable *)shared{
    static TFMemoryAllocTable *kMemory = nil;
    @synchronized(self){
        if (nil == kMemory) {
            kMemory = [[TFMemoryAllocTable alloc] init];
        }
    }
    return kMemory;
}

+ (double)_usedMemory{
//    mach_port_t           host_port = mach_host_self();
//    mach_msg_type_number_t   host_size = sizeof(vm_statistics_data_t) / sizeof(integer_t);
//    vm_size_t               pagesize;
//    vm_statistics_data_t     vm_stat;
//    
//    host_page_size(host_port, &pagesize);
//    
//    if (host_statistics(host_port, HOST_VM_INFO, (host_info_t)&vm_stat, &host_size) != KERN_SUCCESS) NSLog(@"Failed to fetch vm statistics");
//    
//    natural_t   mem_used = (vm_stat.active_count + vm_stat.inactive_count + vm_stat.wire_count) * pagesize;
//    //    natural_t   mem_free = vm_stat.free_count * pagesize;
//    //    natural_t   mem_total = mem_used + mem_free;
//    
//   // natural_t   mem_used = (vm_stat.active_count + vm_stat.wire_count) * pagesize;
//    
//    double m = mem_used/1024.0/1024.0;
//    
//    return m;
    
//    struct task_basic_info info;
//    
//    mach_msg_type_number_t size = sizeof(info);
//    
//    kern_return_t kerr = task_info(mach_task_self(),
//                                   
//                                   TASK_BASIC_INFO,
//                                   
//                                   (task_info_t)&info,
//                                   
//                                   &size);
//    
//    if( kerr == KERN_SUCCESS ) {
//        
//        NSLog(@"Memory used: %u", info.resident_size); //in bytes
//        
//    } else {
//        
//        NSLog(@"Error: %s", mach_error_string(kerr));
//        
//    }
//    return info.resident_size/1024.0/1024.0;
    
    malloc_statistics_t stats;
    malloc_zone_statistics(NULL, &stats);
    NSLog(@"size_allocated = %lu", (unsigned long)stats.size_allocated);
    return stats.size_allocated/1024.0/1024.0;

}
 
+ (void)imageMemoryIncrease:(double)m{
    kImageMemory+=m/1024.0/1024.0;
}

+ (void)imageMemoryDecrease:(double)m{
    kImageMemory-=m/1024.0/1024.0;
}

+ (void)appMemoryCardinal{
    kMemoryCardinal = [TFMemoryAllocTable _usedMemory];
}

+ (double)memoryUsedInApp{
//    double curMemory = [TFMemoryAllocTable _usedMemory];
//    double used = curMemory - kMemoryCardinal;
//    return used;
    TFLog(@"used memory belong to image %.5f",kImageMemory);
    return kImageMemory;
}

+ (void)controllerCreatedCountUp{
    kOriginalViewControllerCount++;
}

- (id)init{
    self = [super init];
    if (self) {
        _maintainTable = [[NSMutableDictionary alloc] init];
        kPageSize = [UIScreen mainScreen].bounds.size.height*2;
    }
    return self;
}

+ (int)getPageSize{
    return kPageSize;
}

- (void)dealloc{
    [_maintainTable release],_maintainTable = nil;
    [super dealloc];
}

- (void)attach:(id)obj tag:(NSString *)tag{
    if (nil == tag) {
        return;
    }
    NSMutableArray *arr = [_maintainTable objectForKey:tag];
    
    if (nil == arr) {
        NSMutableArray *a = [[NSMutableArray alloc] init];
        [a addObject:obj];
        
        [_maintainTable setObject:a forKey:tag];
        [a release];
    }
    else {
        [arr addObject:obj];
    }
}

- (void)_innerActionReleaseImageViewInMemoryTableWithTag:(NSString *)tag{
    TFLog(@"release image in memory %@",tag);
    NSMutableArray *arr = [_maintainTable objectForKey:tag];
    
    if ([_maintainTable objectForKey:tag]) {
        for (int i = [arr count];i--;) {
            TFImageView *imageView = [arr objectAtIndex:i];
            [TFMemoryAllocTable imageMemoryDecrease:imageView.image.size.width*imageView.image.size.height*4];
        }
    }
    
    [_maintainTable removeObjectForKey:tag];
}

- (void)releaseImageViewInMemoryTableWithTag:(NSString *)tag{
//    TFQueue *q = [TFQueue shared];
//    TFOperation *op = [[TFOperation alloc] init];
//    op.concurrent = YES;
//    [op setMainTarget:self action:@selector(_innerActionReleaseImageViewInMemoryTableWithTag:) withObject:tag];
//    [q add:op];
//    [op release];
    [self _innerActionReleaseImageViewInMemoryTableWithTag:tag];
}

- (void)_innerActionReleaseImageInMemoryTableWithTag:(NSString *)tag{
    NSMutableArray *arr = [_maintainTable objectForKey:tag];
    for (int i = [arr count];i--;) {
        TFImageView *imageView = [arr objectAtIndex:i];
        [TFMemoryAllocTable imageMemoryDecrease:imageView.image.size.width*imageView.image.size.height*4];
        [imageView setImage:nil];
    }
}

- (void)releaseImageInMemoryTableWithTag:(NSString *)tag{
//    TFQueue *q = [TFQueue shared];
//    TFOperation *op = [[TFOperation alloc] init];
//    op.concurrent = YES;
//    [op setMainTarget:self action:@selector(_innerActionReleaseImageInMemoryTableWithTag:) withObject:tag];
//    [q add:op];
//    [op release];
    [self _innerActionReleaseImageInMemoryTableWithTag:tag];
}

- (void)_innerActionReloadImageInMemoryTableWithTag:(NSString *)tag{
    NSMutableArray *arr = [_maintainTable objectForKey:tag];
    
    if (nil == arr) {
        return;
    }
    
    for (int i = [arr count];i--;) {
        TFImageView *imageView = [arr objectAtIndex:i];
       // NSLog(@"%@",NSStringFromCGRect(imageView.frame));
        
        BOOL runOnScrollView = NO;
        UIView *superView = imageView.superview;
        UIView *preView = nil;
        while (superView) {
            if([superView isKindOfClass:[UIScrollView class]]){
                runOnScrollView = YES;
                break;
            }
            preView = superView;
            superView = superView.superview;
        }
        
        if (runOnScrollView) {
            float y = TF_SAFE_BRIDGE(UIScrollView,superView).contentOffset.y;
            
            float judgmentY = 0.0f;
            
            if (nil==preView) { ///如果preview 为空 则说明imageView直接被加载到了scrollview上
                judgmentY = imageView.frame.origin.y;
            }
            else {
                judgmentY = preView.frame.origin.y;
            }
            
            
            
            if (judgmentY > y-kPageSize&&judgmentY < y+kPageSize) {
                //TFLog(@"judg %.3f, y-kPageSize %.3f,y+kPageSize %.3f y %.3f",judgmentY,y-kPageSize,y+kPageSize,y);
                [imageView reloadFromDiskIfHad];
            }
        }
        else {
            [imageView reloadFromDiskIfHad];
        }
    }

}

- (void)reloadImageInMemoryTableWithTag:(NSString *)tag{
//    TFQueue *q = [TFQueue shared];
//    TFOperation *op = [[TFOperation alloc] init];
//    op.concurrent = YES;
//    [op setMainTarget:self action:@selector(_innerActionReloadImageInMemoryTableWithTag:) withObject:tag];
//    [q add:op];
//    [op release];
    
    [self _innerActionReloadImageInMemoryTableWithTag:tag];
}

- (void)_innerActionReleaseAllImageInMemoryTableWithoutTag:(NSString *)tag{
    NSArray *keys = [_maintainTable allKeys];
    for (int i = [keys count]; i--;) {
        
        NSString *everyTag = [keys objectAtIndex:i];
        
        BOOL releaseImageAlways = [everyTag isEqualToString:tag]?NO:YES;
        
        
        NSMutableArray *arr = [_maintainTable objectForKey:[keys objectAtIndex:i]];
        for (int j = [arr count]; j--;) {
            
            
            TFImageView *imageView = [arr objectAtIndex:j];
            
            if (releaseImageAlways) {
                [TFMemoryAllocTable imageMemoryDecrease:imageView.image.size.width*imageView.image.size.height*4];
                [imageView setImage:nil];
            }
            else {
                /*!
                 *如果当前需要释放的controller存在scroll view的话需要释放可视区域以外的image
                 *@算法
                 *循环查找当前的image的上层view 直到找到为scroll view，根据找到的scroll view的前一层
                 *取出frame做相应的操作
                 */
                
                BOOL runOnScrollView = NO;
                UIView *superView = imageView.superview;
                UIView *preView = nil;
                while (superView) {
                    if([superView isKindOfClass:[UIScrollView class]]){
                        runOnScrollView = YES;
                        break;
                    }
                    preView = superView;
                    superView = superView.superview;
                }
                
                if (runOnScrollView) {
                    float y = TF_SAFE_BRIDGE(UIScrollView,superView).contentOffset.y;
                    
                    float judgmentY = 0.0f;
                    
                    if (nil==preView) { ///如果preview 为空 则说明imageView直接被加载到了scrollview上
                        judgmentY = imageView.frame.origin.y;
                    }
                    else {
                        judgmentY = preView.frame.origin.y;
                    }
                    
                    if (judgmentY < y-kPageSize) {
                        [TFMemoryAllocTable imageMemoryDecrease:imageView.image.size.width*imageView.image.size.height*4];
                        [imageView setImage:nil];
                    }
                }
            }
        }
    }

}


- (void)releaseAllImageInMemoryTableWithoutTag:(NSString *)tag{
//    TFQueue *q = [TFQueue shared];
//    TFOperation *op = [[TFOperation alloc] init];
//    op.concurrent = YES;
//    [op setMainTarget:self action:@selector(_innerActionReleaseAllImageInMemoryTableWithoutTag:) withObject:tag];
//    [q add:op];
//    [op release];
    [self _innerActionReleaseAllImageInMemoryTableWithoutTag:tag];
}

- (void)smartOperationIfMemoryWarning:(BOOL)memoryWarning tag:(NSString *)tag{
    
    double usedMemory = [TFMemoryAllocTable memoryUsedInApp];
    BOOL shouldDo = NO;
    
    if (memoryWarning)
        shouldDo = YES;
    else 
        if (kOriginalViewControllerCount > kMaxOriginalViewControllerCount
            ||usedMemory > kMaxUsedMemorySize) 
            shouldDo = YES;
    
    if (shouldDo) {
        ///Image Alloc Table Operation
        [[TFMemoryAllocTable shared] releaseAllImageInMemoryTableWithoutTag:tag];
        kOriginalViewControllerCount=0;
      //  [self performSelector:@selector(memoryusedtime) withObject:nil afterDelay:10];
    }
}

- (void)memoryusedtime{
    [TFMemoryAllocTable memoryUsedInApp];
}

@end
