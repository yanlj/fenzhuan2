//
//  UIView+frame.h
//  TfClientPad
//
//  Created by crazycao on 14-5-14.
//
//

#import <UIKit/UIKit.h>

@interface UIView (frame)

@property (nonatomic, assign, setter = setLeft:, getter = getLeft) CGFloat left;
@property (nonatomic, assign, setter = setRight:, getter = getRight) CGFloat right;
@property (nonatomic, assign, setter = setTop:, getter = getTop) CGFloat top;
@property (nonatomic, assign, setter = setBottom:, getter = getBottom) CGFloat bottom;
@property (nonatomic, assign, setter = setWidth:, getter = getWidth) CGFloat width;
@property (nonatomic, assign, setter = setHeight:, getter = getHeight) CGFloat height;

@end
