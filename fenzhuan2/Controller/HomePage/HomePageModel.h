//
//  HomePageModel.h
//  fenzhuan2
//
//  Created by 颜梁坚 on 16/3/18.
//  Copyright © 2016年 yanlj. All rights reserved.
//

#import "FZModel.h"
#import "SkipEvent.h"

@interface HomeBannerInfo : NSObject

@property (nonatomic, retain) NSString *bannerId;
@property (nonatomic, retain) NSString *imageUrl;
@property (nonatomic, retain) SkipEvent *skipEvent;

@end

@interface HomeHotwordInfo : NSObject

@property (nonatomic, retain) NSString *text;
@property (nonatomic, retain) NSString *color;
@property (nonatomic, strong) NSString *isHot;

@end

@interface HomeFunctionInfo : NSObject

@property (nonatomic, retain) NSString *functionId;
@property (nonatomic, retain) NSString *iconUrl;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *flagUrl;
@property (nonatomic, retain) SkipEvent *skipEvent;

@end

@interface HomeCellInfo : NSObject

@property (nonatomic, retain) NSString *cellId;
@property (nonatomic, retain) NSString *imageUrl;
@property (nonatomic, retain) SkipEvent *skipEvent;
@property (nonatomic, strong) NSString *restTime;//倒计时，豪秒值

@end

@interface HomeBlockInfo : NSObject

@property (nonatomic, retain) NSString *blockType;
@property (nonatomic, retain) NSMutableArray *cellList;

@end

@interface HomeRecommendCategoryInfo : NSObject

@property (nonatomic, retain) NSString *cid;
@property (nonatomic, retain) NSString *title;

@end

@interface HomeRecommendInfo : NSObject

@property (nonatomic, retain) NSString *itemId;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *imageUrl;
@property (nonatomic, retain) NSString *flagUrl;
//@property (nonatomic, retain) NSString *price;
@property (nonatomic, retain) NSArray *priceTextArray;
@property (nonatomic, retain) NSArray *fanliTextArray;
@property (nonatomic, retain) SkipEvent *skipEvent;

@end

@interface HomePageModel : FZModel

@property (nonatomic, retain) NSMutableArray *bannerList;
@property (nonatomic, retain) NSMutableArray *hotwordList;

//@property (nonatomic, retain) HomeActivityNote *activityNote;

@property (nonatomic, retain) NSString *functionLayoutColumn;
@property (nonatomic, retain) NSMutableArray *functionList;

@property (nonatomic, retain) NSMutableArray *blockList;

@property (nonatomic, retain) NSString *recommendTitle;
@property (nonatomic, retain) NSMutableArray *recommendTextArray;
@property (nonatomic, retain) NSMutableArray *recommendCategoryList;
@property (nonatomic, retain) NSMutableArray *recommendList;

@property (nonatomic, retain) NSString *pageNo;
@property (nonatomic, retain) NSString *totalPage;

@property (nonatomic, retain) NSString *updateUrl;
@property (nonatomic, retain) NSString *updateTitle;

@property (nonatomic, retain) NSString *needUpdateAlipay;

@property (nonatomic, retain) NSArray *updateTexts;

@property (nonatomic, retain) NSString *searchFlag;

@property (nonatomic, strong) NSString *searchTip;

@property (nonatomic, strong) NSString *recommendCount;

@property (nonatomic, strong) NSString *searchHint;

- (void)queryNewHomePage:(NSString *)pageNo cid:(NSString *)cid activityCode:(NSString *)activityCode;

@end

