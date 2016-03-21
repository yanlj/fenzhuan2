//
//  TFTickerView.h
//  TFAnimation
//
//  Created by yin shen on 8/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TFDoubleSidedLayer.h"
#import "SpacemanBlocks.h"

@interface TFTickerView : UIView{
    UIImageView *_front;
    UIImageView *_back;
    SMDelayedBlockHandle _delayedBlockHandle;
    
    CALayer *_tmpContainer;
    TFDoubleSidedLayer *_tickLayer;
  
}

@property (nonatomic, retain, getter = getFront, setter = setFront:) UIImageView *front;
@property (nonatomic, retain, getter = getBack, setter = setBack:) UIImageView *back;

- (void)tick;

@end
