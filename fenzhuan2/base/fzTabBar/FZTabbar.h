//
//  FZTabbar.h
//  fenzhuan2
//
//  Created by 颜梁坚 on 16/3/18.
//  Copyright © 2016年 yanlj. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FZTabbar;

@protocol FZTabbarDelegate <NSObject>
/**
 *  工具栏按钮被选中, 记录从哪里跳转到哪里. (方便以后做相应特效)
 */
- (void) tabBar:(FZTabbar *)tabBar selectedFrom:(NSInteger) from to:(NSInteger)to;

@end

@interface FZTabbar : UIView

@property(nonatomic,strong)NSArray *titleArr;
@property(nonatomic,weak) id<FZTabbarDelegate> delegate;

/**
 *  使用特定图片来创建按钮, 这样做的好处就是可扩展性. 拿到别的项目里面去也能换图片直接用
 *
 *  @param image         普通状态下的图片
 *  @param selectedImage 选中状态下的图片
 */
- (void)addButtonWithImage:(UIImage *)image selectedImage:(UIImage *)selectedImage withIndex:(int)index;

- (void)clickBtnWithNum:(NSInteger)num;

@end
