//
//  HomePageViewModel.h
//  fenzhuan2
//
//  Created by 颜梁坚 on 16/3/18.
//  Copyright © 2016年 yanlj. All rights reserved.
//

#import "FZViewModel.h"
#import "HomePageModel.h"

@interface HomePageViewModel : FZViewModel

@property(nonatomic, strong)HomePageModel *modelHomePage;

- (void)getHomeValue:(NSDictionary *)homeValDic;

@end
