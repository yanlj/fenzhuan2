//
//  FZBaseViewController.h
//  fenzhuan2
//
//  Created by 颜梁坚 on 16/3/18.
//  Copyright © 2016年 yanlj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MarqueeLabel.h"

@interface FZBaseViewController : UIViewController

@property (nonatomic, strong) UIView *fzNavigationBar;
@property (nonatomic, strong) UIButton *fzPopButton;
@property (nonatomic, assign) BOOL fzNavigionBarHidden;//default is NO

@property (nonatomic, strong) NSString *fzTitle;
@property (nonatomic, strong) UIColor *fzTitleColor;
@property (nonatomic, strong) UIFont *fzTitleFont;

@property (nonatomic, strong) MarqueeLabel *fzTitleLabel;

@end
