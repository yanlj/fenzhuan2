//
//  HomePageViewController.m
//  fenzhuan2
//
//  Created by 颜梁坚 on 16/3/18.
//  Copyright © 2016年 yanlj. All rights reserved.
//

#import "HomePageViewController.h"
#import "HomePageViewModel.h"

@interface HomePageViewController ()

@property(nonatomic, strong)HomePageViewModel *ViewModelHomePage;

@end

@implementation HomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.ViewModelHomePage getHomeValue:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (HomePageViewModel *)ViewModelHomePage {
    if (!_ViewModelHomePage) {
        _ViewModelHomePage = [[HomePageViewModel alloc] init];
    }
    return _ViewModelHomePage;
}

@end
