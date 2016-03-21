//
//  TFScrollView.m
//  tfcommon
//
//  Created by yin shen on 8/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TFScrollView.h"
#import "TFImageView.h"
#import "TFCommonDefine.h"
#import "TFMemoryAllocTable.h"

@implementation TFScrollView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _pageSize = [TFMemoryAllocTable getPageSize];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/



//- (void)layoutSubviews{
//    [self imageViewRecursion:self directOnScroll:nil];
//    
//}
//
//- (void)imageViewRecursion:(UIView *)base directOnScroll:(UIView *)direct{
//    if ([base isKindOfClass:[TFImageView class]]) {
//        //TFLog(@"scroll %@",base);
//        
//        
//        if (nil == TF_SAFE_BRIDGE(TFImageView, base).image) {
//            
//            float y = self.contentOffset.y;
//            //TFLog(@"scroll y %.2f view %@",y,NSStringFromCGRect([pre frame]));
//            float compareY = 0;
//            if (direct == self) {  //pre==scrollview 说明scroll只是第一层就加载与scrollview上
//                compareY = base.frame.origin.y;
//            }
//            else {
//                compareY = direct.frame.origin.y;
//            }
//            if (compareY+base.frame.size.height > y) {
//               [TF_SAFE_BRIDGE(TFImageView, base) reloadFromDiskIfHad];
//            }
//            
//            
//            return;
//        }
//    }
//    else {
//        for (id view in base.subviews) {
//            if (base == self) {
//                [self imageViewRecursion:view directOnScroll:view];
//            }
//            else {
//                [self imageViewRecursion:view directOnScroll:direct];
//            }
//        }
//    }
//}

@end
