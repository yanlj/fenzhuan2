//
//  FZTabBarController.m
//  fenzhuan2
//
//  Created by 颜梁坚 on 16/3/18.
//  Copyright © 2016年 yanlj. All rights reserved.
//

#import "FZTabBarController.h"
#import "FZTabbar.h"

@interface FZTabBarController ()<FZTabbarDelegate> {
    FZTabbar *myView;
}

@property (nonatomic, weak) UIButton *selectedBtn;

@end

@implementation FZTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGRect rect = self.tabBar.bounds; //这里要用bounds来加, 否则会加到下面去.看不见
    //测试添加自己的视图
    myView = [[FZTabbar alloc] init]; //设置代理必须改掉前面的类型,不能用UIView
    myView.titleArr = @[@"首页",@"任务",@"我的"];
    myView.delegate = self; //设置代理
    if(IS_IOS7_OR_GREATER){
        self.tabBar.barStyle = UIBarStyleDefault;
        self.tabBar.translucent = YES;
        myView.backgroundColor = [UIColor clearColor];
    } else {
        myView.backgroundColor = [UIColor whiteColor];
    }
    myView.frame = rect;
    [self.tabBar addSubview:myView]; //添加到系统自带的tabBar上, 这样可以用的的事件方法. 而不必自己去写
    //为控制器添加按钮
    
    for (int i=0; i<self.viewControllers.count+1; i++) { //根据有多少个子视图控制器来进行添加按钮
        NSString *imageName = [NSString stringWithFormat:@"TabBar%d", i + 1];
        NSString *imageNameSel = [NSString stringWithFormat:@"TabBar%dSel", i + 1];
        UIImage *image = [UIImage imageNamed:imageName];
        UIImage *imageSel = [UIImage imageNamed:imageNameSel];
        
        [myView addButtonWithImage:image selectedImage:imageSel withIndex:i];
    }
}

/**永远别忘记设置代理*/
- (void)tabBar:(FZTabbar *)tabBar selectedFrom:(NSInteger)from to:(NSInteger)to {
    self.selectedIndex = to;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)fzTabBarSelect:(NSInteger)Num {
    if (myView) {
        [myView clickBtnWithNum:Num];
    }
}

@end
