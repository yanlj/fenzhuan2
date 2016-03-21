//
//  TFSmartView.h
//  tfsmart
//
//  Created by yin shen on 8/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TFSmartItem.h"

@protocol TFSmartViewDataSource;
@protocol TFSmartViewDelegate;

@interface TFSmartView : UIScrollView<
 TFSmartItemDelegate,
    UIScrollViewDelegate
>{

    struct {
        short col;
        float rowSpace;
        float colSpace;
        float marginTop;
        float marginLeft;
        NSInteger count;
        NSInteger currentPage;
        NSInteger totalPage;
        
    }_constants;

    
    id _target;
    id _dataSource;
    
    CGSize _size;
    
    CGRect _visibleRect;
    
    NSMutableArray *_dequeuedItems;
    
    struct{
        int min;
        int max;
    }_effectRange;
    
    BOOL isReload;
    BOOL isReloadVisible;
    
    float _lastScrollViewMoveY;
    int kCount;
}

@property (nonatomic, assign) id target;
@property (nonatomic, assign) id dataSource;
@property (nonatomic, assign) BOOL isReload;
@property (nonatomic, assign) BOOL isReloadVisible;

- (void)setMarginTop:(float)marginTop;
- (void)setMarginLeft:(float)marginLeft;
- (void)setRowSpace:(float)rowSpace;
- (void)setColSpace:(float)colSpace;
- (void)loadMoreItems;

- (TFSmartItem *)getReuseItem:(int)index;
- (void)render;
- (void)clean;
- (void)layout;
- (void)reloadItems;
- (void)reloadVisibleItems;

- (void)scrollToItemAtIndex:(NSInteger)index;

@end

@protocol TFSmartViewDelegate <NSObject>

@optional
- (void)smartView:(TFSmartView *)smartView didSelectItem:(TFSmartItem *)item;
- (void)smartViewShouldLoadMoreItems:(TFSmartView *)smartView;
- (void)smartView:(TFSmartView *)smartView didChangeContentSize:(CGSize)size;

- (CGSize)smartViewItemSize:(TFSmartView *)smartView withIndex:(int)index;
@required
- (TFSmartItem *)smartView:(TFSmartView *)smartView eachItemAtIndex:(int)index;
- (CGSize)smartViewItemSize;

@end

@protocol TFSmartViewDataSource <NSObject>

@required
- (NSInteger)numberOfColsInSmartView:(TFSmartView *)smartView;
- (NSInteger)numberOfItemsInSmartView:(TFSmartView *)fallView;

@optional
- (NSInteger)currentPageInSmartView:(TFSmartView *)smartView;
- (NSInteger)totalPageInSmartView:(TFSmartView *)smartView;

@end