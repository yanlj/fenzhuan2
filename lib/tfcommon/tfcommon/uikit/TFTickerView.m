//
//  TFTickerView.m
//  TFAnimation
//
//  Created by yin shen on 8/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TFTickerView.h"
#import "TFGradientOverlayLayer.h"

#define TF_ANIMATION_D2R(d) (d*M_PI/180)

@implementation TFTickerView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
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
- (void)_initTick{
    
    if (_tmpContainer) {
        [_tmpContainer removeFromSuperlayer];
        _tmpContainer = nil;
    }
    
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, [UIScreen mainScreen].scale);

	[_front.layer renderInContext:UIGraphicsGetCurrentContext()];
    
	UIImage *f = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
    
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, [UIScreen mainScreen].scale);

	[_back.layer renderInContext:UIGraphicsGetCurrentContext()];
	UIImage *b = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
    
    
    _tmpContainer = [CALayer layer];
    [_tmpContainer setFrame:self.layer.bounds];
    CATransform3D perspective = CATransform3DIdentity;
    float zDistanse = 400.;
    perspective.m34 = 1. / -zDistanse;
    [_tmpContainer setSublayerTransform:perspective];
    [self.layer addSublayer:_tmpContainer];
    
    [self bringSubviewToFront:[self viewWithTag:79]];
    
    if (_tickLayer != nil) {
        [_tickLayer release], _tickLayer = nil;
    }
    _tickLayer = [[TFDoubleSidedLayer alloc] init];

    [_tickLayer setAnchorPoint:CGPointMake(0, 1)];
    [_tickLayer setZPosition:1.];
    [_tickLayer setFrame:
     CGRectMake(0., 0., _tmpContainer.frame.size.width, floorf(_tmpContainer.frame.size.height/2))];
    
    TFGradientOverlayLayer *tickerFront = [[TFGradientOverlayLayer alloc] initWithType:TFGradientLayerTypeTop];
    [tickerFront setContentsGravity:kCAGravityBottom];
    [tickerFront setContents:(id)f.CGImage];
    
    TFGradientOverlayLayer *tickerBack = [[TFGradientOverlayLayer alloc] initWithType:TFGradientLayerTypeBottom];
    [tickerBack setContentsGravity:kCAGravityTop];
    [tickerBack setContents:(id)b.CGImage];
    
    [_tickLayer setFront:tickerFront];
    [tickerFront release];
    [_tickLayer setBack:tickerBack];
    [tickerBack release]; 
    
    CALayer *topFaceLayer = [CALayer layer];
    [topFaceLayer setContentsScale:[UIScreen mainScreen].scale];
    [topFaceLayer setContentsGravity:kCAGravityBottom];
    [topFaceLayer setContents:(id)b.CGImage];
    [topFaceLayer setMasksToBounds:YES];
    [topFaceLayer setFrame:
     CGRectMake(0., 0., _tmpContainer.frame.size.width, floorf(_tmpContainer.frame.size.height/2))];
    
    CALayer *bottomFaceLayer = [CALayer layer];
    [bottomFaceLayer setContentsScale:[UIScreen mainScreen].scale];
    [bottomFaceLayer setContentsGravity:kCAGravityTop];
    [bottomFaceLayer setContents:(id)f.CGImage];
    [bottomFaceLayer setMasksToBounds:YES];
    [bottomFaceLayer setFrame:CGRectMake(0., floorf(_tmpContainer.frame.size.height / 2), _tmpContainer.frame.size.width, floorf(_tmpContainer.frame.size.height/2))];
    
    
    [_tmpContainer addSublayer:bottomFaceLayer];
    [_tmpContainer addSublayer:topFaceLayer];
    
    [_tmpContainer addSublayer:_tickLayer];


    
}

- (void)dealloc{

    [_tickLayer release]; _tickLayer = nil;
    [super dealloc];
}


- (void)tick{
    [self _initTick];
    
  //  dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.1 * NSEC_PER_SEC); // WTF!
    
    _delayedBlockHandle = perform_block_after_delay(0.1, ^(void){
        [CATransaction begin];
        [CATransaction setAnimationDuration:0.4f];
        [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
        
        /*!
         *CompletionBlock 翻转至底部后弹起*/
        [CATransaction setCompletionBlock:^{
            
            [CATransaction begin];
            [CATransaction setAnimationDuration:0.4f];
            [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
            
            /*!
             *CompletionBlock 弹起后再次倒下*/
            [CATransaction setCompletionBlock:^{
                
                [CATransaction begin];
                [CATransaction setAnimationDuration:0.2f];
                [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
                
                /*!
                 *CompletionBlock 移除layer和整个tick动画结束后动作*/
                [CATransaction setCompletionBlock:^{
                    [_tmpContainer removeFromSuperlayer];
                    _tmpContainer = nil;
                    
                    [self _finalizeTick];
                }];
                
                CGFloat angle =TF_ANIMATION_D2R(-180);
                if (nil ==_tickLayer) {
                    return ;
                }
                
                _tickLayer.transform = CATransform3DMakeRotation(angle, 1., 0., 0.);
                [CATransaction commit];
                
            }];
            
            CGFloat angle =TF_ANIMATION_D2R(-165);
            if (nil ==_tickLayer) {
                return ;
            }
            _tickLayer.transform = CATransform3DMakeRotation(angle, 1., 0., 0.);
            
            
            [CATransaction commit];
        }];
        
        CGFloat angle = (M_PI) * (1-0);
        if (nil ==_tickLayer) {
            return ;
        }
        _tickLayer.transform = CATransform3DMakeRotation(angle, 1., 0., 0.);
        
        [CATransaction commit];
    });
    
//    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
//        
//        [CATransaction begin];
//        [CATransaction setAnimationDuration:0.4f];
//        [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
//        
//        /*!
//         *CompletionBlock 翻转至底部后弹起*/
//        [CATransaction setCompletionBlock:^{
//            
//            [CATransaction begin];
//            [CATransaction setAnimationDuration:0.4f];
//            [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
//            
//            /*!
//             *CompletionBlock 弹起后再次倒下*/
//            [CATransaction setCompletionBlock:^{
//                
//                [CATransaction begin];
//                [CATransaction setAnimationDuration:0.2f];
//                [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
//                
//                /*!
//                 *CompletionBlock 移除layer和整个tick动画结束后动作*/
//                [CATransaction setCompletionBlock:^{
//                    [_tmpContainer removeFromSuperlayer];
//                    _tmpContainer = nil;
//                    [self _finalizeTick];
//                }];
//                
//                CGFloat angle =TF_ANIMATION_D2R(-180);
//                
//                NSLog(@"%@",_tickLayer);
//                _tickLayer.transform = CATransform3DMakeRotation(angle, 1., 0., 0.);
//                [CATransaction commit];
//                
//            }];
//            
//            CGFloat angle =TF_ANIMATION_D2R(-165);
//            NSLog(@"%@",_tickLayer);
//            _tickLayer.transform = CATransform3DMakeRotation(angle, 1., 0., 0.);
//            
//            
//            [CATransaction commit];
//        }];
//        
//        CGFloat angle = (M_PI) * (1-0);
//        NSLog(@"%@",_tickLayer);
//        _tickLayer.transform = CATransform3DMakeRotation(angle, 1., 0., 0.);
//        //        _topFaceLayer.gradientOpacity = direction;
//        //        _bottomFaceLayer.gradientOpacity = 1. - direction;
//        //        
//        //        ((SBGradientOverlayLayer*)_tickLayer.frontLayer).gradientOpacity = 1. - direction;
//        //        ((SBGradientOverlayLayer*)_tickLayer.backLayer).gradientOpacity = direction;
//        
//        [CATransaction commit];
//    });
    
    
}

-(void)_finalizeTick{
    
    UIImageView *newFront = [[UIImageView alloc] initWithImage:_back.image];
    UIImageView *newBack = [[UIImageView alloc] initWithImage:_front.image];
    
    [self setFront:newFront];
    [newFront release];
    
    [self setBack:newBack];
    [newBack release];
    
    [self bringSubviewToFront:[self viewWithTag:79]];

}

- (void)setFront:(UIImageView *)v{
    
    if (_front.superview) {
        [_front removeFromSuperview];
        _front = nil;
    }
    _front = v;
    [_front setFrame:self.bounds];
    
    [self addSubview:_front];
    [self bringSubviewToFront:_front];
    
}

- (UIImageView *)getFront{
    return _front;
}


- (void)setBack:(UIImageView *)v{
    if (_back.superview) {
        [_back removeFromSuperview];
        _back = nil;
    }
    _back = v;
    [_back setFrame:self.bounds];
    [self addSubview:_back];
    [self sendSubviewToBack:_back];
    
}

- (UIImageView *)getBack{
    return _back;
}




@synthesize front;
@synthesize back;
@end
