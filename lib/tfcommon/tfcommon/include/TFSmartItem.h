//
//  TFSmartItem.h
//  tfsmart
//
//  Created by yin shen on 8/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TFSmartItemBean.h"
@class TFSmartView;

@protocol TFSmartItemDelegate;

@interface TFSmartItem : UIView<
 UIGestureRecognizerDelegate
>{
    id<TFSmartItemDelegate> delegate;
}
@property (nonatomic, assign) id<TFSmartItemDelegate> delegate;
@property (nonatomic, assign) int index;
@property (nonatomic, strong) UIButton *btn;
- (TFSmartItem *)initItem;
+ (TFSmartItem *)dequeueReusableItem:(TFSmartView *)smartView index:(int)index;
- (void)loadAtom:(id)atom;
- (void)cancelOperation;
- (void)setImageNil;
- (void)loadAtomWithFanli:(id)atom;

@property (nonatomic,retain) id atom;

@end

@protocol TFSmartItemDelegate <NSObject>

- (void)smartItemDidSelect:(TFSmartItem *)item;

@end
