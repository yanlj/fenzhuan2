//
//  UIView+frame.m
//  TfClientPad
//
//  Created by crazycao on 14-5-14.
//
//

#import "UIView+frame.h"

@implementation UIView (frame)

- (void)setLeft:(CGFloat)left
{
    CGRect rect = self.frame;
    rect.origin.x = left;
    self.frame = rect;
}

- (CGFloat)getLeft
{
    CGRect rect = self.frame;
    return rect.origin.x;
}

- (void)setRight:(CGFloat)right
{
    CGRect rect = self.frame;
    rect.origin.x = right - rect.size.width;
    self.frame = rect;
}

- (CGFloat)getRight
{
    CGRect rect = self.frame;
    return rect.origin.x + rect.size.width;
}

- (void)setTop:(CGFloat)top
{
    CGRect rect = self.frame;
    rect.origin.y = top;
    self.frame = rect;
}

- (CGFloat)getTop
{
    CGRect rect = self.frame;
    return rect.origin.y;
}

- (void)setBottom:(CGFloat)bottom
{
    CGRect rect = self.frame;
    rect.origin.y = bottom - rect.size.height;
    self.frame = rect;
}

- (CGFloat)getBottom
{
    CGRect rect = self.frame;
    return rect.origin.y + rect.size.height;
}

- (void)setWidth:(CGFloat)width
{
    CGRect rect = self.frame;
    rect.size.width = width;
    self.frame = rect;
}

- (CGFloat)getWidth
{
    CGRect rect = self.frame;
    return rect.size.width;
}

- (void)setHeight:(CGFloat)height
{
    CGRect rect = self.frame;
    rect.size.height = height;
    self.frame = rect;
}

- (CGFloat)getHeight
{
    CGRect rect = self.frame;
    return rect.size.height;
}

@end
