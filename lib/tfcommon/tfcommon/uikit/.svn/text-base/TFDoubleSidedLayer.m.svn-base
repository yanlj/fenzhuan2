//
//  TFDoubleSidedLayer.m
//  TFAnimation
//
//  Created by yin shen on 8/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TFDoubleSidedLayer.h"

@implementation TFDoubleSidedLayer

- (id)init {
	if (self = [super init]) {
        [self setDoubleSided:YES];
	}
	return self;
}

- (void)layoutSublayers {
	[super layoutSublayers];
	
	[_front setFrame:self.bounds];
	[_back setFrame:self.bounds];
}


- (void)setFront:(CALayer *)front{
	if (_front != front) {
		[_front removeFromSuperlayer];
		_front = front;
		[_front setDoubleSided:NO];
		[self addSublayer:front];
		[self setNeedsLayout];
	}
}

- (void)setBack:(CALayer *)back {
	if (_back != back) {
		[_back removeFromSuperlayer];
		_back = back;
		[_back setDoubleSided:NO];
		CATransform3D transform = CATransform3DMakeRotation(M_PI, 1., 0., 0.);
		[_back setTransform:transform];
		[self addSublayer:back];
		[self setNeedsLayout];
	}
}



@dynamic front;
@dynamic back;
@end
