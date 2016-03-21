//
//  TFGenieView.m
//  tfcommon
//
//  Created by yin shen on 10/14/12.
//
//

#import "TFGenieView.h"

@implementation TFGenieView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self _initFlags];
    }
    return self;
}

- (void)_initFlags{
    _flags.s_drawRenderPath = NO;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    if (self.renderPath==nil)
    {
        [super drawRect:rect];
        return;
    }
    
    if (_flags.s_drawRenderPath) {
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        
        CGContextAddPath(ctx, self.renderPath);
        CGContextSetRGBFillColor(ctx, 1, 1, 1, 1);
        CGContextFillPath(ctx);
    }
}




- (void)setDrawRenderPath:(BOOL)drawPath{
    _flags.s_drawRenderPath = drawPath;
}

- (BOOL)drawRenderPath{
    return _flags.s_drawRenderPath;
}

@dynamic drawRenderPath;
@synthesize renderPath;
@end
