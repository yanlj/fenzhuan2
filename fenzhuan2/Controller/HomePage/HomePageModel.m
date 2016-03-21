//
//  HomePageModel.m
//  fenzhuan2
//
//  Created by 颜梁坚 on 16/3/18.
//  Copyright © 2016年 yanlj. All rights reserved.
//

#import "HomePageModel.h"

@implementation HomeBannerInfo

- (instancetype)initWithDictionary:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        self.bannerId = [dic objectForKeySafety:@"bannerId"];
        self.imageUrl = [dic objectForKeySafety:@"imageUrl"];
        self.skipEvent = [[SkipEvent alloc] initWithDictionary:[dic objectForKeySafety:@"skipEvent"]];
    }
    
    return  self;
}

@end

@implementation HomeHotwordInfo

- (instancetype)initWithDictionary:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        self.text = [dic objectForKeySafety:@"text"];
        self.color = [dic objectForKeySafety:@"color"];
        self.isHot = [dic objectForKeySafety:@"isHot"];
    }
    
    return  self;
}

@end

@implementation HomeFunctionInfo

- (instancetype)initWithDictionary:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        self.functionId = [dic objectForKeySafety:@"functionId"];
        self.iconUrl = [dic objectForKeySafety:@"iconUrl"];
        self.title = [dic objectForKeySafety:@"title"];
        self.flagUrl = [dic objectForKeySafety:@"flagUrl"];
        self.skipEvent = [[SkipEvent alloc] initWithDictionary:[dic objectForKeySafety:@"skipEvent"]];
    }
    
    return  self;
}

@end

@implementation HomeCellInfo

- (instancetype)initWithDictionary:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        self.cellId = [dic objectForKeySafety:@"cellId"];
        self.imageUrl = [dic objectForKeySafety:@"imageUrl"];
        self.skipEvent = [[SkipEvent alloc] initWithDictionary:[dic objectForKeySafety:@"skipEvent"]];
        
        self.restTime = [dic objectForKeySafety:@"restTime"];
        //#warning limqtodotest
        //        self.restTime = @"237848";
        
        if (![NSString checkEmpty:self.restTime]) {
            NSTimeInterval systemTime = [[NSDate date] timeIntervalSince1970];
            long sumTimeSecond = systemTime + [_restTime longLongValue] / 1000;
            self.restTime = [NSString stringWithFormat:@"%ld",sumTimeSecond];
        }
    }
    
    return  self;
}

@end

@implementation HomeBlockInfo

- (instancetype)initWithDictionary:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        self.blockType = [dic objectForKeySafety:@"blockType"];
        NSArray *array = [dic objectForKeySafety:@"cellList"];
        if (array != nil && ![array isEqual:[NSNull null]]) {
            if (self.cellList == nil) {
                self.cellList = [[NSMutableArray alloc] init];
            }
            
            for (NSDictionary *item in array) {
                HomeCellInfo *info = [[HomeCellInfo alloc] initWithDictionary:item];
                if (info) {
                    [self.cellList addObject:info];
                }
            }
            //#warning limqtodo begin
            //            if ([self.blockType isEqualToString:@"1"]) {
            //                for (NSDictionary *item in array) {
            //                    HomeCellInfo *info = [[HomeCellInfo alloc] initWithDictionary:item];
            //                    if (info) {
            //                        [self.cellList addObject:info];
            //                    }
            //                }
            //                for (NSDictionary *item in array) {
            //                    HomeCellInfo *info = [[HomeCellInfo alloc] initWithDictionary:item];
            //                    if (info) {
            //                        [self.cellList addObject:info];
            //                    }
            //                }
            //            }
            //#warning limqtodo end
        }
    }
    
    return  self;
}

@end

@implementation HomeRecommendCategoryInfo

- (instancetype)initWithDictionary:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        self.cid = [dic objectForKeySafety:@"cid"];
        self.title = [dic objectForKeySafety:@"title"];
    }
    
    return  self;
}

@end

@implementation HomeRecommendInfo

- (instancetype)initWithDictionary:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        self.itemId = [dic objectForKeySafety:@"itemId"];
        self.title = [dic objectForKeySafety:@"title"];
        self.imageUrl = [dic objectForKeySafety:@"imageUrl"];
        self.flagUrl = [dic objectForKeySafety:@"flagUrl"];
        //        self.price = [dic objectForKeySafety:@"price"];
        self.priceTextArray = [dic objectForKeySafety:@"priceTextArray"];
        self.fanliTextArray = [dic objectForKeySafety:@"fanliTextArray"];
        self.skipEvent = [[SkipEvent alloc] initWithDictionary:[dic objectForKeySafety:@"skipEvent"]];
    }
    
    return  self;
}

@end

@interface HomePageModel ()
{
    NSString *_cid;
}

@end

@implementation HomePageModel

- (void)queryNewHomePage:(NSString *)pageNo cid:(NSString *)cid activityCode:(NSString *)activityCode
{
    NSLog(@"%s", __func__);
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:@"queryNewHomePage" forKey:@"operationType"];
    [dict setObject:(pageNo?pageNo:@"") forKey:@"pageNo"];
    [dict setObject:(cid?cid:@"") forKey:@"cid"];
    [dict setObject:(activityCode?activityCode:@"") forKey:@"activityCode"];
    
    self.requestDict = dict;
    [self request];
    _cid = cid;
    
//    [MobClick event:@"queryNewHomePage"];
}


- (BOOL)_productModelItem:(NSDictionary *)dict
{
    NSLog(@"%s", __func__);
    self.pageNo = [dict objectForKeySafety:@"pageNo"];
    if (self.pageNo == nil) {
        return NO;
    }
    
    self.totalPage = [dict objectForKeySafety:@"totalPage"];
    
    // 首页pageNo等于1时
    if ([self.pageNo integerValue] == 1 && ([NSString checkEmpty:_cid] || [_cid isEqualToString:@"0"])) {
        
        if (self.bannerList != nil) {
            [self.bannerList removeAllObjects];
        }
        if (self.hotwordList != nil) {
            [self.hotwordList removeAllObjects];
        }
        if (self.functionList != nil) {
            [self.functionList removeAllObjects];
        }
        if (self.blockList != nil) {
            [self.blockList removeAllObjects];
        }
        if (self.recommendCategoryList != nil) {
            [self.recommendCategoryList removeAllObjects];
        }
        
        NSArray *array = [dict objectForKeySafety:@"bannerList"];
        if (array != nil && ![array isEqual:[NSNull null]]) {
            if (self.bannerList == nil) {
                self.bannerList = [[NSMutableArray alloc] init];
            }
            
            for (NSDictionary *item in array) {
                HomeBannerInfo *bannerInfo = [[HomeBannerInfo alloc] initWithDictionary:item];
                //                bannerInfo.skipEvent.eventType = @"hn";//for 测试
                if (bannerInfo) {
                    [self.bannerList addObject:bannerInfo];
                }
            }
            //#warning test
            //            HomeBannerInfo *newgiftBanner = [[HomeBannerInfo alloc] init];
            //            newgiftBanner.imageUrl = @"http://img01.taobaocdn.com/imgextra/i1/2296013456/TB2dC38bFXXXXXaXpXXXXXXXXXX_!!2296013456.png";
            //            SkipEvent *skipEvent = [[SkipEvent alloc] init];
            //            skipEvent.eventType = ServiceCenterRedirectTypeNewBonus;
            //            skipEvent.argsArray = @[@"51DMS0003i", @"恭喜您获得新人红包，最高50元！\n试试手气，赶快领取吧！"];
            //            skipEvent.mobilePage = @"test_newgift_banner";
            //            newgiftBanner.skipEvent = skipEvent;
            //            [self.bannerList addObject:newgiftBanner];
        }
        
        array = [dict objectForKeySafety:@"hotwordList"];
        if (array != nil && ![array isEqual:[NSNull null]]) {
            if (self.hotwordList == nil) {
                self.hotwordList = [[NSMutableArray alloc] init];
            }
            
            for (NSDictionary *item in array) {
                HomeHotwordInfo *info = [[HomeHotwordInfo alloc] initWithDictionary:item];
                if (info) {
                    [self.hotwordList addObject:info];
                }
            }
        }
//        [GlobalVariables shared].hotwordList = self.hotwordList;
//        
//        self.activityNote = [[HomeActivityNote alloc] initWithDictionary:[dict objectForKeySafety:@"activityNote"]];
        
        self.functionLayoutColumn = [dict objectForKeySafety:@"functionLayoutColumn"];
        
        array = [dict objectForKeySafety:@"functionList"];
        if (array != nil && ![array isEqual:[NSNull null]]) {
            if (self.functionList == nil) {
                self.functionList = [[NSMutableArray alloc] init];
            }
            
            for (NSDictionary *item in array) {
                HomeFunctionInfo *info = [[HomeFunctionInfo alloc] initWithDictionary:item];
                if (info) {
                    [self.functionList addObject:info];
                }
            }
        }
        
        //#warning limqtodo begin
        //        self.functionLayoutColumn = @"5";
        //        self.functionList = nil;
        //        array = [dict objectForKeySafety:@"functionList"];
        //        if (array != nil && ![array isEqual:[NSNull null]]) {
        //            if (self.functionList == nil) {
        //                self.functionList = [[NSMutableArray alloc] init];
        //            }
        //            int i = 0;
        //            for (NSDictionary *item in array) {
        //                if (i == 5) {
        //                    break;
        //                }
        //                i ++;
        //                HomeFunctionInfo *info = [[HomeFunctionInfo alloc] initWithDictionary:item];
        //                if (info) {
        //                    [self.functionList addObject:info];
        //                }
        //            }
        //        }
        //#warning limqtodo end
        
        
        array = [dict objectForKeySafety:@"blockList"];
        if (array != nil && ![array isEqual:[NSNull null]]) {
            if (self.blockList == nil) {
                self.blockList = [[NSMutableArray alloc] init];
            }
            
            for (NSDictionary *item in array) {
                HomeBlockInfo *info = [[HomeBlockInfo alloc] initWithDictionary:item];
                if (info) {
                    [self.blockList addObject:info];
                }
            }
        }
        
        self.recommendTitle = [dict objectForKeySafety:@"recommendTitle"];
        self.recommendTextArray = [dict objectForKeySafety:@"recommendTextArray"];
        array = [dict objectForKeySafety:@"recommendCategoryList"];
        if (array != nil && ![array isEqual:[NSNull null]]) {
            if (self.recommendCategoryList == nil) {
                self.recommendCategoryList = [[NSMutableArray alloc] init];
            }
            
            for (NSDictionary *item in array) {
                HomeRecommendCategoryInfo *info = [[HomeRecommendCategoryInfo alloc] initWithDictionary:item];
                if (info) {
                    [self.recommendCategoryList addObject:info];
                }
            }
        }
        
    }
    
    //#warning limqtodotest
    //    while ([self.bannerList count] > 1) {
    //        [self.bannerList removeLastObject];
    //    }
    
    if ([self.pageNo integerValue] == 1) {
        if (self.recommendList != nil) {
            [self.recommendList removeAllObjects];
        }
    }
    
    NSArray *array = [dict objectForKeySafety:@"recommendList"];
    if (array != nil && ![array isEqual:[NSNull null]]) {
        if (self.recommendList == nil) {
            self.recommendList = [[NSMutableArray alloc] init];
        }
        
        for (NSDictionary *item in array) {
            HomeRecommendInfo *info = [[HomeRecommendInfo alloc] initWithDictionary:item];
            if (info) {
                
                for (int i=0; i<self.recommendList.count; i++) {
                    HomeRecommendInfo *existItem = [self.recommendList objectAtIndex:i];
                    if ([existItem.itemId isEqualToString:info.itemId]) {
                        
                        NSLog(@"【重复商品被过滤】：%@", existItem.title);
                        info = nil;
                        break;
                    }
                    
                }
                if (info == nil) {
                    continue;
                }
                else {
                    [self.recommendList addObject:info];
                }
                
            }
        }
    }
    
    // need update alipay
    NSString *needUpdateAlipay = [dict objectForKeySafety:@"needUpdateAlipay"];
    //#warning test
    //    needUpdateAlipay = @"YES";
    if (![NSString checkEmpty:needUpdateAlipay] && [needUpdateAlipay boolValue] == YES) {
//        [[NSNotificationCenter defaultCenter] postNotificationName:nNeedUpdateAlipay object:self];
    }
    
    
    self.updateUrl = [dict objectForKeySafety:@"updateUrl"];
    self.updateTitle = [dict objectForKeySafety:@"updateTitle"];
    
    self.updateTexts = [dict objectForKeySafety:@"updateTexts"];
    self.searchFlag = [dict objectForKeySafety:@"searchFlag"];
    self.searchTip = [dict objectForKeySafety:@"searchTip"];
//    [GlobalVariables shared].searchTip = self.searchTip;
    self.recommendCount = [dict objectForKeySafety:@"recommendCount"];
    
    if ([self.pageNo integerValue] == 1) {//因为只有第一页会下发。
        self.searchHint = [dict objectForKeySafety:@"searchHint"];
    }
    //#warning limqtodotest
    //    self.recommendCount = @"123";
    return YES;
}

@end

