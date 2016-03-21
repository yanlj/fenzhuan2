//
//  TFImageAllocTable.h
//  tfcommon
//
//  Created by yin shen on 8/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/*!
 *@class    TFMemoryAllocTable
 *@brief    对程序中的资源进行管理，在适当的前置条件下释放，
            保证程序高速运行
 *@author   shenyin
 */
@interface TFMemoryAllocTable : NSObject{
@private
    NSMutableDictionary *_maintainTable;
}

+ (TFMemoryAllocTable *)shared;

+ (int)getPageSize;
+ (void)appMemoryCardinal;
+ (double)memoryUsedInApp;

+ (void)controllerCreatedCountUp;
+ (void)imageMemoryIncrease:(double)m;
+ (void)imageMemoryDecrease:(double)m;

- (void)smartOperationIfMemoryWarning:(BOOL)memoryWarning tag:(NSString *)tag;

/*!about image*/
- (void)releaseAllImageInMemoryTableWithoutTag:(NSString *)tag;
- (void)releaseImageViewInMemoryTableWithTag:(NSString *)tag;
- (void)releaseImageInMemoryTableWithTag:(NSString *)tag;
- (void)reloadImageInMemoryTableWithTag:(NSString *)tag;

- (void)attach:(id)obj tag:(NSString *)tag;

@end
