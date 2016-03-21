//
//  HomePageViewModel.m
//  fenzhuan2
//
//  Created by 颜梁坚 on 16/3/18.
//  Copyright © 2016年 yanlj. All rights reserved.
//

#import "HomePageViewModel.h"

@implementation HomePageViewModel

- (HomePageModel *)modelHomePage {
    if (!_modelHomePage) {
        _modelHomePage = [[HomePageModel alloc] init];
        _modelHomePage.delegate = self;
        _modelHomePage.localRequestEndPoint = [LongLivedVariables shared].apiEndPoint;
    }
    return _modelHomePage;
}

- (void)getHomeValue:(NSDictionary *)homeValDic {
    [self.modelHomePage queryNewHomePage:@"1" cid:@"" activityCode:nil];
}

- (void)modelEverythingFine:(TFModel *)model {
    if (model == self.modelHomePage) {
        
    }
}

- (void)modelSomethingWrong:(TFModel *)model {
    
}

@end
