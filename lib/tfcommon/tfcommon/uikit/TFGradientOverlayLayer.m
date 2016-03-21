//
//  TFGradientOverlayLayer.m
//  TFAnimation
//
//  Created by yin shen on 8/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TFGradientOverlayLayer.h"

@implementation TFGradientOverlayLayer

- (id)init{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)layoutSublayers{
    [super layoutSublayers];
    [_mask setFrame:self.bounds];
}

- (id)initWithType:(TFGradientLayerType)type{
    [self init];
  
    [self setMasksToBounds:YES];
    [self setContentsScale:[[UIScreen mainScreen] scale]];
    
    
//    _mask = [CAGradientLayer layer];
//    [self setMask:_mask];
//    _mask.backgroundColor = [UIColor blackColor].CGColor;
//    
//    
//    
//    if (TFGradientLayerTypeTop == type) {
//        [_mask setColors:[NSArray arrayWithObjects:
////                                   (id)[UIColor colorWithWhite:0. alpha:0.9].CGColor,
////                                   (id)[UIColor colorWithWhite:0. alpha:0.5].CGColor,
//                          (id)[UIColor colorWithRed:0 green:0 blue:0 alpha:0.9].CGColor,
//                          (id)[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5].CGColor,
//                                   nil]];
//        
//        [_mask setLocations:[NSArray arrayWithObjects:
//                                      [NSNumber numberWithFloat:0.1],
//                                      [NSNumber numberWithFloat:0.9],
//                                      nil]];
//
//    }
//    
//    [self setMask:];
    
    return self;
}

@end
