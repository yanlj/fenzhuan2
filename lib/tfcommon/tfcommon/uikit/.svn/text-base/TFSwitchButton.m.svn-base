//
//  TFSwitchButton.m
//  tfcommon
//
//  Created by crazycao on 14-12-30.
//
//

#import <Foundation/Foundation.h>
#import "TFSwitchButton.h"

@interface TFSwitchButton ()
{
    UIButton *_onButton;
    UIButton *_offButton;
}

@end

@implementation TFSwitchButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _onButton = [[UIButton alloc] initWithFrame:self.bounds];
        _onButton.backgroundColor = [UIColor clearColor];
        [_onButton addTarget:self action:@selector(onButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_onButton];
        [_onButton release];
        
        _offButton = [[UIButton alloc] initWithFrame:self.bounds];
        _offButton.backgroundColor = [UIColor clearColor];
        [_offButton addTarget:self action:@selector(offButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_offButton];
        [_offButton release];
        
        _isOn = NO;
        _offButton.hidden = YES;
    }
    return self;
}

- (void)dealloc
{
    NSLog(@"%s", __func__);
    [super dealloc];
}

- (void)setOnImage:(UIImage *)image forState:(UIControlState)state
{
    NSLog(@"%s", __func__);
    [_onButton setImage:image forState:state];
}

- (void)setOffImage:(UIImage *)image forState:(UIControlState)state
{
    NSLog(@"%s", __func__);
    [_offButton setImage:image forState:state];
}

- (void)setIsOn:(BOOL)isOn
{
    NSLog(@"%s", __func__);
    if (_isOn == isOn) {
        return;
    }
    
    _isOn = isOn;
    
    if (_isOn) {
        _onButton.hidden = YES;
        _offButton.hidden = NO;
    }
    else {
        _onButton.hidden = NO;
        _offButton.hidden = YES;
    }
    
    if (_delegate && [(NSObject *)_delegate respondsToSelector:@selector(switchButtonStatusChanged:)]) {
        [_delegate switchButtonStatusChanged:self];
    }
}

- (void)onButtonAction
{
    NSLog(@"%s", __func__);
    [self setIsOn:YES];
}

- (void)offButtonAction
{
    NSLog(@"%s", __func__);
    [self setIsOn:NO];
}

@end