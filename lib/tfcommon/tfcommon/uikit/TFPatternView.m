//
//  TFPatternView.m
//  TfClientPad
//
//  Created by yin shen on 8/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TFPatternView.h"

@implementation TFPatternView

- (id)initWithImageName:(NSString *)filename rect:(CGRect)rect{
    self = [super initWithFrame:rect];
    if (self) {
        self.fileName = filename;
        self.backgroundColor = [UIColor clearColor];
        self.type = -1;
    }
    return self;
}

- (id)initWithImageName:(NSString *)filename rect:(CGRect)rect type:(int)t{
    self = [super initWithFrame:rect];
    if (self) {
        self.fileName = filename;
        self.backgroundColor = [UIColor clearColor];
        self.type = t;
    }
    return self;
}



- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    
    UIImage *pattern = [UIImage imageWithContentsOfFile:self.fileName];
    
    if (nil == pattern) {
        pattern = [UIImage imageNamed:self.fileName];
    }
    
    
    float width = pattern.size.width;
    float height = pattern.size.height;
    
    float edge = 0.0f;
    float x = 0.0f;
    float y = 0.0f;
    float step = 0.0f;
    
    if (self.type==-1) {
        if (width >= height) {
            edge = rect.size.height;
            y = pattern.size.height;
            step = y;
            x = 0;
            for (float len = 0; len <= edge; len+=step) {
                [pattern drawAtPoint:CGPointMake(0, len)];
            }   
        }
        else {
            edge = rect.size.width;
            x = pattern.size.width;
            step = x;
            y = 0;
            for (float len = 0; len <= edge; len+=step) {
                
                [pattern drawAtPoint:CGPointMake(len, 0)];
            }   
        }
    }
    else {
        if (self.type == 0) { //横向平铺
            edge = rect.size.width;
            x = pattern.size.width;
            step = x;
            y = 0;
            for (float len = 0; len <= edge; len+=step) {
                
                [pattern drawAtPoint:CGPointMake(len, 0)];
            }   
        }
        else if (self.type == 1){ //竖向平铺
            
        }
    }
}

@synthesize fileName;
@synthesize type;
@end
