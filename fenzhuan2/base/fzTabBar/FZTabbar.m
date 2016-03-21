//
//  FZTabbar.m
//  fenzhuan2
//
//  Created by 颜梁坚 on 16/3/18.
//  Copyright © 2016年 yanlj. All rights reserved.
//

#import "FZTabbar.h"

@interface FZTabbar ()

/**
 *  设置之前选中的按钮
 */
@property (nonatomic, weak) UIButton *selectedBtn;

@end

@implementation FZTabbar

- (void)addButtonWithImage:(UIImage *)image selectedImage:(UIImage *)selectedImage withIndex:(int)index{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.tag = 1000+index;
    int btnWidth = self.bounds.size.width / 3;
    btn.frame = CGRectMake(btnWidth*index, 0, btnWidth, self.bounds.size.height);
    
    btn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, self.bounds.size.height * 1/3, 0);
    if(([self.titleArr count]-1) >= index) {
        UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(btnWidth*index, self.bounds.size.height * 2/3 - 2, btnWidth, self.bounds.size.height * 1/3)];
        titleLab.textColor = RGBCOLOR(81, 81, 81);
        titleLab.backgroundColor = [UIColor clearColor];
        titleLab.textAlignment = NSTextAlignmentCenter;
        titleLab.font = [UIFont systemFontOfSize:12];
        titleLab.text = [self.titleArr objectAtIndex:index];
        titleLab.tag = 2000+index;
        [self addSubview:titleLab];
        if(index == 0){
            titleLab.textColor = RGBCOLOR(228, 39, 55);
        }
    }
    if(index == 0){
        btn.selected = YES;
        self.selectedBtn = btn;
    }
    
    [btn setImage:image forState:UIControlStateNormal];
    [btn setImage:selectedImage forState:UIControlStateSelected];
    [btn setImage:selectedImage forState:UIControlStateHighlighted];
    
    [self addSubview:btn];
    
    //带参数的监听方法记得加"冒号"
    [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    //如果是第一个按钮, 则选中(按顺序一个个添加)
    if (self.subviews.count == 1) {
        [self clickBtn:btn];
    }
}

/**
 *  自定义TabBar的按钮点击事件
 */
- (void)clickBtn:(UIButton *)button {
    UILabel *lblSelect = (UILabel *)[self viewWithTag:self.selectedBtn.tag+1000];
    UILabel *lblNewSelect = (UILabel *)[self viewWithTag:button.tag+1000];
    lblSelect.textColor = RGBCOLOR(81, 81, 81);
    self.selectedBtn.selected = NO;
    lblNewSelect.textColor = RGBCOLOR(228, 39, 55);
    button.selected = YES;
    self.selectedBtn = button;
    
    //却换视图控制器的事情,应该交给controller来做
    //最好这样写, 先判断该代理方法是否实现
    if ([self.delegate respondsToSelector:@selector(tabBar:selectedFrom:to:)]) {
        [self.delegate tabBar:self selectedFrom:self.selectedBtn.tag-1000 to:button.tag-1000];
    }
}

- (void)clickBtnWithNum:(NSInteger)num {
    UIButton *btn = (UIButton *)[self viewWithTag:num+1000];
    if (btn && [btn isKindOfClass:[UIButton class]]) {
        [self clickBtn:btn];
    }
}

@end
