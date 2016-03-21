//
//  TFSmartItem.m
//  tfsmart
//
//  Created by yin shen on 8/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TFSmartItem.h"
#import "TFSmartView.h"

@implementation TFSmartItem

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
//        UITapGestureRecognizer *singlePress = [[UITapGestureRecognizer alloc] initWithTarget:self 
//                                                                                      action:@selector(singlePressOccur:)];
//        
//        singlePress.numberOfTouchesRequired = 1;
//        singlePress.numberOfTapsRequired = 1;
//        [singlePress setDelegate:self];
//        [self addGestureRecognizer:singlePress];
//        [singlePress release];

        self.btn = [[UIButton alloc] initWithFrame:frame];
        [self.btn setExclusiveTouch:YES];
        self.btn.backgroundColor = [UIColor clearColor];
        [self.btn addTarget:self action:@selector(singlePressOccur) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.btn];
        [self.btn setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:23 / 255.0 green:23 / 255.0 blue:23 / 255.0 alpha:0.1]] forState:UIControlStateHighlighted];
    }
    return self;
}
- (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (void)singlePressAfterDelay
{
    self.btn.highlighted = YES;
    [self performSelector:@selector(singlePressAfterDelay1) withObject:nil afterDelay:0.1];
}

- (void)singlePressAfterDelay1
{
    self.btn.highlighted = NO;
    if ([self.delegate respondsToSelector:@selector(smartItemDidSelect:)]) {
        [self.delegate smartItemDidSelect:self];
    }
}

- (void)singlePressOccur{
    [self performSelector:@selector(singlePressAfterDelay) withObject:nil afterDelay:0.01];
}

- (void)singlePressOccur:(UIGestureRecognizer *)gesture{
    if ([self.delegate respondsToSelector:@selector(smartItemDidSelect:)]) {
        [self.delegate smartItemDidSelect:self];
    }
}

- (TFSmartItem *)initItem{
    [self initWithFrame:CGRectMake(0, 0, 10, 10)];
    return self;
}

- (void)dealloc{
    self.atom = nil;
    [super dealloc];
}


+ (TFSmartItem *)dequeueReusableItem:(TFSmartView *)smartView index:(int)index{
    return [smartView getReuseItem:index];
}

- (TFSmartItem *)initWithBean:(TFSmartItemBean *)bean index:(int)index{
    
    [self initWithFrame:CGRectMake(0, 0, 10, 10)];
    
    return self;
}

- (void)loadAtom:(id)atom{
    
}

- (void)loadAtomWithFanli:(id)atom{
    
}

- (void)cancelOperation{
    
}

- (void)setImageNil{
    
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
@synthesize delegate;
@synthesize atom;
@synthesize index;

@end
