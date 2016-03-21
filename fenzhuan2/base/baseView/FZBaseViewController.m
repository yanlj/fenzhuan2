//
//  FZBaseViewController.m
//  fenzhuan2
//
//  Created by 颜梁坚 on 16/3/18.
//  Copyright © 2016年 yanlj. All rights reserved.
//

#import "FZBaseViewController.h"

@interface FZBaseViewController ()

@end

@implementation FZBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUp];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if ([[self.navigationController viewControllers] count] > 1) {
        _fzPopButton.hidden = NO;
    } else {
        _fzPopButton.hidden = YES;
    }
}

- (void)dealloc {
    
}

- (void)setUp {
    self.navigationController.navigationBarHidden = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    [self setUpNavigationBar];
    [self setUpNavigationTitle];
    [self setUpPopButton];
}

#pragma mark 绘制区
//绘制导航条
- (void)setUpNavigationBar {
    self.fzNavigationBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_MAINSCREEN_WIDTH, NAV_BAR_HEIGHT)];
    self.fzNavigationBar.backgroundColor = [UIColor colorWithRed:0.97 green:0.97 blue:0.97 alpha:1];
    [self.view addSubview:self.fzNavigationBar];
    
    self.fzNavigationBar.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSString *constraintHeightStr = (IS_IOS7_OR_GREATER) ? @"V:|-0-[_fzNavigationBar(==64)]" : @"V:|-0-[_fzNavigationBar(==44)]";
    NSArray *constrainHeight = [NSLayoutConstraint constraintsWithVisualFormat:constraintHeightStr options:0 metrics:nil views:NSDictionaryOfVariableBindings(_fzNavigationBar)];
    [self.view addConstraints:constrainHeight];
    
    NSString *constraintWidthStr = @"H:|-0-[_fzNavigationBar]-0-|";
    NSArray *constrainWidth = [NSLayoutConstraint constraintsWithVisualFormat:constraintWidthStr options:0 metrics:nil views:NSDictionaryOfVariableBindings(_fzNavigationBar)];
    [self.view addConstraints:constrainWidth];
}

//绘制标题label
- (void)setUpNavigationTitle {
    _fzTitleLabel = [[MarqueeLabel alloc] initWithFrame:CGRectMake(50, 20, DEVICE_MAINSCREEN_WIDTH - 100, 44)];
    [self.fzNavigationBar addSubview:_fzTitleLabel];
    _fzTitleLabel.textColor = [UIColor blackColor];
    _fzTitleLabel.backgroundColor = [UIColor clearColor];
    _fzTitleLabel.textAlignment = NSTextAlignmentCenter;
    
    
    _fzTitleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSString *constraintHeightStr = (IS_IOS7_OR_GREATER) ? @"V:|-20-[_fzTitleLabel(==44)]" : @"V:|-0-[_fzTitleLabel(==44)]";
    NSArray *constraintHeight = [NSLayoutConstraint constraintsWithVisualFormat:constraintHeightStr options:0 metrics:nil views:NSDictionaryOfVariableBindings(_fzTitleLabel)];
    [self.fzNavigationBar addConstraints:constraintHeight];
    
    NSString *constraintWidthStr = @"H:|-50-[_fzTitleLabel]-50-|";
    NSArray *constraintWidth = [NSLayoutConstraint constraintsWithVisualFormat:constraintWidthStr options:0 metrics:nil views:NSDictionaryOfVariableBindings(_fzTitleLabel)];
    [self.fzNavigationBar addConstraints:constraintWidth];
}

//绘制返回按钮
- (void)setUpPopButton {
    self.fzPopButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.fzNavigationBar addSubview:self.fzPopButton];
    [self.fzPopButton setImage:[UIImage imageNamed:@"pink-nav-back"] forState:UIControlStateNormal];
    [self.fzPopButton addTarget:self action:@selector(popViewController:) forControlEvents:UIControlEventTouchUpInside];
    self.fzPopButton.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSString *constraintLeftStr = @"H:|-10-[_fzPopButton]";
    NSArray *constraintLeft = [NSLayoutConstraint constraintsWithVisualFormat:constraintLeftStr options:0 metrics:nil views:NSDictionaryOfVariableBindings(_fzPopButton)];
    [self.fzNavigationBar addConstraints:constraintLeft];
    
    NSLayoutConstraint *constraintCenterY = [NSLayoutConstraint constraintWithItem:_fzPopButton attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:_fzTitleLabel attribute:NSLayoutAttributeCenterY multiplier:1 constant:0];
    [self.fzNavigationBar addConstraint:constraintCenterY];
}

#pragma mark 设置区
- (void)setFzTitleColor:(UIColor *)fzTitleColor {
    _fzTitleColor = fzTitleColor;
    [_fzTitleLabel setTextColor:_fzTitleColor];
}

- (void)setFzTitleFont:(UIFont *)fzTitleFont {
    _fzTitleFont = fzTitleFont;
    [_fzTitleLabel setFont:_fzTitleFont];
}

- (void)setFzTitle:(NSString *)fzTitle {
    _fzTitle = fzTitle;
    [_fzTitleLabel setText:_fzTitle];
}

- (void)setFzNavigionBarHidden:(BOOL)fzNavigionBarHidden {
    _fzNavigionBarHidden = fzNavigionBarHidden;
    self.fzNavigationBar.hidden = _fzNavigionBarHidden;
}

#pragma mark 方法区
- (void)popViewController:(id)sender
{
    if (self.navigationController) {
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

@end
