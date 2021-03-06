//
//  LongLivedVariables.m
//  TfClient
//
//  Created by yin shen on 11/30/12.
//
//

#import "LongLivedVariables.h"


@implementation LongLivedVariables

+ (LongLivedVariables *)shared{
    static LongLivedVariables *k_variables = nil;
    @synchronized(self){
        if (nil == k_variables) {
            k_variables = [[LongLivedVariables alloc] init];
            
            NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
            
            k_variables.coinUrl = [userDefault objectForKey:kLongLivedVariablesCoinUrl];
            
            k_variables.renrenId = [userDefault objectForKey:kLongLivedVariablesRenrenId];
            k_variables.weiboId = [userDefault objectForKey:kLongLivedVariablesWeiboId];
            k_variables.tengxunWeiboId = [userDefault objectForKey:kLongLivedVariablesTengxunWeiboId];
            k_variables.qqSpaceId = [userDefault objectForKey:kLongLivedVariablesQQSpaceId];
            
            k_variables.shakeToken =[userDefault objectForKey:kLongLivedVariablesShakeToken];
            k_variables.shakeChannel =[userDefault objectForKey:kLongLivedVariablesShakeChannel];
            k_variables.shakeTime =[userDefault objectForKey:kLongLivedVariablesShareTime];
            k_variables.shakeMode =[userDefault objectForKey:kLongLivedVariablesShakeMode];
            
            id thriftObj = [userDefault objectForKey:kLongLivedVariablesThrift];
            if (thriftObj) {
                k_variables.thrift = [thriftObj intValue];
            }
            else{
                k_variables.thrift = 0;
            }
            
            id smartThriftObj = [userDefault objectForKey:kLongLivedVariablesSmartThrift];
            if (smartThriftObj) {
                k_variables.smartThrift = [smartThriftObj intValue];
            }else{
                k_variables.smartThrift = 0;//智能省流量默认关闭。
            }
            
            id showCourseTimesObj = [userDefault objectForKey:kLongLivedVariablesShowCourseTimes];
            if (showCourseTimesObj) {
                k_variables.showCourseTimes = [showCourseTimesObj intValue];
            }else{
                k_variables.showCourseTimes = 1;
            }
            
            id isNewerToNewGiftObj = [userDefault objectForKey:kLongLivedVariablesIsNewerToNewGift];
            if (isNewerToNewGiftObj) {
                k_variables.isNewerToNewGift = [isNewerToNewGiftObj boolValue];
            }
            else{
                k_variables.isNewerToNewGift = YES;
            }
            
            id isNewerToScrollItemViewObj = [userDefault objectForKey:kLongLivedVariablesIsNewerToScrollItemView];
            if (isNewerToScrollItemViewObj) {
                k_variables.isNewerToScrollItemView = [isNewerToScrollItemViewObj boolValue];
            }
            else{
                k_variables.isNewerToScrollItemView = YES;
            }
            
            k_variables.searchHistoryArray = [userDefault objectForKey:kLongLivedVariablesSearchHistoryArray];
            if (k_variables.searchHistoryArray == nil) {
                k_variables.searchHistoryArray = [[NSArray alloc] init];
            }
            
            k_variables.splashDictionary = [userDefault objectForKey:kLongLivedVariablesSplashDictionary];
            if (k_variables.splashDictionary == nil) {
                k_variables.splashDictionary = [[NSMutableDictionary alloc] init];
            }
            
            NSData *data = [userDefault objectForKey:kLongLivedVariablesLocalNotificationDictionary];
            if (data == nil) {
                k_variables.localNotificationDictionary = [[NSMutableDictionary alloc] init];
            }
            else {
                @try {
                    k_variables.localNotificationDictionary = [NSKeyedUnarchiver unarchiveObjectWithData:data];
                }
                @catch (NSException *exception) {
                    NSLog(@"%@", exception);
                    [userDefault removeObjectForKey:kLongLivedVariablesLocalNotificationDictionary];
                    k_variables.localNotificationDictionary = [[NSMutableDictionary alloc] init];
                }
                @finally {
                    
                }
            }
            
            id firstQueryNewerPushObj = [userDefault objectForKey:kLongLivedVariablesFirstQueryNewerPush];
            if (firstQueryNewerPushObj) {
                k_variables.firstQueryNewerPush = [firstQueryNewerPushObj boolValue];
            }
            else {
                k_variables.firstQueryNewerPush = YES;
            }
            
            data = [userDefault objectForKey:kLongLivedVariablesCategoryList];
            if (data == nil) {
                k_variables.categoryList = [[NSMutableArray alloc] init];
            }
            else {
                @try {
                    k_variables.categoryList = [NSKeyedUnarchiver unarchiveObjectWithData:data];
                }
                @catch (NSException *exception) {
                    [userDefault removeObjectForKey:kLongLivedVariablesCategoryList];
                    k_variables.categoryList = [[NSMutableArray alloc] init];
                }
                @finally {
                    
                }
            }
            
            data = [userDefault objectForKey:kLongLivedVariablesCategoryDigestDictionary];
            if (data == nil) {
                k_variables.categoryDigestDictionary = [[NSMutableDictionary alloc] init];
            }
            else {
                @try {
                    k_variables.categoryDigestDictionary = [NSKeyedUnarchiver unarchiveObjectWithData:data];
                }
                @catch (NSException *exception) {
                    [userDefault removeObjectForKey:kLongLivedVariablesCategoryDigestDictionary];
                    k_variables.categoryDigestDictionary = [[NSMutableDictionary alloc] init];
                }
                @finally {
                    
                }
            }
            
            data = [userDefault objectForKey:kLongLivedVariablesCategoryContentDictionary];
            if (data == nil) {
                k_variables.categoryContentDictionary = [[NSMutableDictionary alloc] init];
            }
            else {
                @try {
                    k_variables.categoryContentDictionary = [NSKeyedUnarchiver unarchiveObjectWithData:data];
                }
                @catch (NSException *exception) {
                    [userDefault removeObjectForKey:kLongLivedVariablesCategoryContentDictionary];
                    k_variables.categoryContentDictionary = [[NSMutableDictionary alloc] init];
                }
                @finally {
                    
                }
            }
            
            data = [userDefault objectForKey:kLongLivedVariablesCategoryBannerDictionary];
            if (data == nil) {
                k_variables.categoryBannerDictionary = [[NSMutableDictionary alloc] init];
            }
            else {
                @try {
                    k_variables.categoryBannerDictionary = [NSKeyedUnarchiver unarchiveObjectWithData:data];
                }
                @catch (NSException *exception) {
                    [userDefault removeObjectForKey:kLongLivedVariablesCategoryBannerDictionary];
                    k_variables.categoryBannerDictionary = [[NSMutableDictionary alloc] init];
                }
                @finally {
                    
                }
            }
            
            k_variables.mallCategoryDigest = [userDefault objectForKey:kLongLivedVariablesMallCategoryDigestString];
            
            k_variables.mallResponseString = [userDefault objectForKey:kLongLivedVariablesMallResponseDataString];
            
            data = [userDefault objectForKey:kLongLivedVariablesMallNeedShowTipsDictionary];
            if (data == nil) {
                k_variables.mallNeedShowTipsDictionary = [[NSMutableDictionary alloc] init];
            }
            else {
                @try {
                    k_variables.mallNeedShowTipsDictionary = [NSKeyedUnarchiver unarchiveObjectWithData:data];
                }
                @catch (NSException *exception) {
                    [userDefault removeObjectForKey:kLongLivedVariablesMallNeedShowTipsDictionary];
                    k_variables.mallNeedShowTipsDictionary = [[NSMutableDictionary alloc] init];
                }
                @finally {
                    
                }
            }
            
            data = [userDefault objectForKey:kLongLivedVariablesBrandReminderItemsDictionary];
            if (data == nil) {
                k_variables.brandReminderItemsDictionary = [[NSMutableDictionary alloc] init];
            }
            else {
                @try {
                    k_variables.brandReminderItemsDictionary = [NSKeyedUnarchiver unarchiveObjectWithData:data];
                }
                @catch (NSException *exception) {
                    [userDefault removeObjectForKey:kLongLivedVariablesBrandReminderItemsDictionary];
                    k_variables.brandReminderItemsDictionary = [[NSMutableDictionary alloc] init];
                }
                @finally {
                    
                }
            }
            
            //            id activityNoteShowedObj = [userDefault objectForKey:kLongLivedVariablesActivityNoteShowed];
            //            if (activityNoteShowedObj) {
            //                k_variables.activityNoteShowed = [activityNoteShowedObj boolValue];
            //            }
            //            else {
            //                k_variables.activityNoteShowed = NO;
            //            }
            
            id isNotFirstLikeObj = [userDefault objectForKey:kLongLivedVariablesIsNotFirstLike];
            if (isNotFirstLikeObj) {
                k_variables.isNotFirstLike = [isNotFirstLikeObj boolValue];
            }
            else {
                k_variables.isNotFirstLike = NO;
            }
            
            id isNotFirstBrandListItemSetAlarm = [userDefault objectForKey:kLongLivedVariablesIsNotFirstBrandListItemSetAlarm];
            if (isNotFirstBrandListItemSetAlarm) {
                k_variables.isNotFirstBrandListItemSetAlarm = [isNotFirstBrandListItemSetAlarm boolValue];
            }
            else {
                k_variables.isNotFirstBrandListItemSetAlarm = NO;
            }
            
            id isListStyleGridInsideObj = [userDefault objectForKey:kLongLivedVariablesIsListStyleGridInside];
            if (isListStyleGridInsideObj) {
                k_variables.isListStyleGridInside = [isListStyleGridInsideObj boolValue];
            }
            else {
                k_variables.isListStyleGridInside = YES;
            }
            
            id isListStyleGridOutsideObj = [userDefault objectForKey:kLongLivedVariablesIsListStyleGridOutside];
            if (isListStyleGridOutsideObj) {
                k_variables.isListStyleGridOutside = [isListStyleGridOutsideObj boolValue];
            }
            else {
                k_variables.isListStyleGridOutside = NO;
            }
            
            id hasClickFanliUseObj = [userDefault objectForKey:kLongLivedVariablesHasClickFanliUse];
            if (hasClickFanliUseObj) {
                k_variables.hasClickFanliUse = [hasClickFanliUseObj boolValue];
            }
            else {
                k_variables.hasClickFanliUse = NO;
            }
            
            id hasClickFilterTipsObj = [userDefault objectForKey:kLongLivedVariablesHasClickFilterTips];
            if (hasClickFilterTipsObj) {
                k_variables.hasClickFilterTips = [hasClickFilterTipsObj boolValue];
            }
            else {
                k_variables.hasClickFilterTips = NO;
            }
            
            //            id activityNoteRejectedTimesObj = [userDefault objectForKey:kLongLivedVariablesActivityNoteRejectedTimes];
            //            if (activityNoteRejectedTimesObj) {
            //                k_variables.activityNoteRejectedTimes = [activityNoteRejectedTimesObj integerValue];
            //            }
            //            else {
            //                k_variables.activityNoteRejectedTimes = 0;
            //            }
            //
            //            k_variables.activityNoteDate = [userDefault objectForKey:kLongLivedVariablesActivityNoteDate];
            
            id isTaobaoFanliExpandObj = [userDefault objectForKey:kLongLivedVariablesIsTaobaoFanliExpand];
            if (isTaobaoFanliExpandObj) {
                k_variables.isTaobaoFanliExpand = [isTaobaoFanliExpandObj intValue];
            }
            else {
                k_variables.isTaobaoFanliExpand = 2;//初始化为2，之后为1是打开，为0是关闭
            }
            
            id showTaobaoFanliCourseTimesObj = [userDefault objectForKey:kLongLivedVariablesShowTaobaoFanliCourseTimes];
            if (showTaobaoFanliCourseTimesObj) {
                k_variables.showTaobaoFanliCourseTimes = [showTaobaoFanliCourseTimesObj intValue];
            }else{
                k_variables.showTaobaoFanliCourseTimes = 1;
            }
            
            id homeTipsShowedObj = [userDefault objectForKey:kLongLivedVariablesHomeTipsShowed];
            if (homeTipsShowedObj) {
                k_variables.homeTipsShowed = [homeTipsShowedObj boolValue];
            }
            else {
                k_variables.homeTipsShowed = NO;
            }
            
            id homeTaskTipsShowedObj = [userDefault objectForKey:kLongLivedVariablesHomeTaskTipsShowed];
            if (homeTaskTipsShowedObj) {
                k_variables.homeTaskTipsShowed = [homeTaskTipsShowedObj boolValue];
            }
            else {
                k_variables.homeTaskTipsShowed = NO;
            }
            
            id integratedChannelSuperRebateTipsShowedObj = [userDefault objectForKey:kLongLivedVariablesIntegratedChannelSuperRebateTipsShowed];
            if (integratedChannelSuperRebateTipsShowedObj) {
                k_variables.integratedChannelSuperRebateTipsShowed = [integratedChannelSuperRebateTipsShowedObj boolValue];
            }
            else {
                k_variables.integratedChannelSuperRebateTipsShowed = NO;
            }
            
            id integratedChannelCheapTipsShowedObj = [userDefault objectForKey:kLongLivedVariablesIntegratedChannelCheapTipsShowed];
            if (integratedChannelCheapTipsShowedObj) {
                k_variables.integratedChannelCheapTipsShowed = [integratedChannelCheapTipsShowedObj boolValue];
            }
            else {
                k_variables.integratedChannelCheapTipsShowed = NO;
            }
            
            k_variables.activityNoteHasShowedImageUrl = [userDefault objectForKey:kLongLivedVariablesActivityNoteHasShowedImageUrl];
            
            id activityNoteCloseCountObj = [userDefault objectForKey:kLongLivedVariablesActivityNoteCloseCount];
            if (activityNoteCloseCountObj) {
                k_variables.activityNoteCloseCount = [activityNoteCloseCountObj intValue];
            }
            else {
                k_variables.activityNoteCloseCount = 0;
            }
            
            id activityNoteSkipCountObj = [userDefault objectForKey:kLongLivedVariablesActivityNoteSkipCount];
            if (activityNoteSkipCountObj) {
                k_variables.activityNoteSkipCount = [activityNoteSkipCountObj intValue];
            }
            else {
                k_variables.activityNoteSkipCount = 0;
            }
            
            data = [userDefault objectForKey:kLongLivedVaribalesShowedHotItemIdArray];
            if (data == nil) {
                k_variables.showedHotItemIdArray = [[NSMutableArray alloc] init];
            }
            else {
                @try {
                    k_variables.showedHotItemIdArray = [NSKeyedUnarchiver unarchiveObjectWithData:data];
                }
                @catch (NSException *exception) {
                    [userDefault removeObjectForKey:kLongLivedVaribalesShowedHotItemIdArray];
                    k_variables.showedHotItemIdArray = [[NSMutableArray alloc] init];
                }
                @finally {
                    
                }
            }
            
            k_variables.showedHotItemLastShowDate = [userDefault objectForKey:kLongLivedVaribalesShowedHotItemLastShowDate];
            
            id isManualCrawlObj = [userDefault objectForKey:kLongLivedVariablesIsManualCrawl];
            if (isManualCrawlObj) {
                k_variables.isManualCrawl = [isManualCrawlObj boolValue];
            }
            else {
                k_variables.isManualCrawl = NO;
            }
            
            id isShowTrackOrderObj = [userDefault objectForKey:kLongLivedVariablesIsShowTrackOrder];
            if (isShowTrackOrderObj) {
                k_variables.isShowTrackOrder = [isShowTrackOrderObj boolValue];
            }
            else {
                k_variables.isShowTrackOrder = NO;
            }
            
            k_variables.trackOrderIds = [userDefault objectForKey:kLongLivedVariablesTrackOrderIds];
            k_variables.trackResult = [userDefault objectForKey:kLongLivedVariablesTrackResult];
            
            id trackStatusObj = [userDefault objectForKey:kLongLivedVariablesTrackStatus];
            if (trackStatusObj) {
                k_variables.trackStatus = [trackStatusObj intValue];
            }
            else {
                k_variables.trackStatus = 0;
            }
            
            id trackOrderTimeObj = [userDefault objectForKey:kLongLivedVariablesTrackOrderTime];
            if (trackOrderTimeObj) {
                k_variables.trackOrderTime = [trackOrderTimeObj longValue];
            }
            else {
                k_variables.trackOrderTime = 0;
            }
            
            id isJhsManualCrawlObj = [userDefault objectForKey:kLongLivedVariablesIsJhsManualCrawl];
            if (isJhsManualCrawlObj) {
                k_variables.isJhsManualCrawl = [isJhsManualCrawlObj boolValue];
            }
            else {
                k_variables.isJhsManualCrawl = NO;
            }
            
            id isJhsShowTrackOrderObj = [userDefault objectForKey:kLongLivedVariablesIsJhsShowTrackOrder];
            if (isJhsShowTrackOrderObj) {
                k_variables.isJhsShowTrackOrder = [isJhsShowTrackOrderObj boolValue];
            }
            else {
                k_variables.isJhsShowTrackOrder = NO;
            }
            
            k_variables.trackJhsOrderIds = [userDefault objectForKey:kLongLivedVariablesTrackJhsOrderIds];
            k_variables.trackJhsResult = [userDefault objectForKey:kLongLivedVariablesTrackJhsResult];
            
            id trackJhsStatusObj = [userDefault objectForKey:kLongLivedVariablesTrackJhsStatus];
            if (trackJhsStatusObj) {
                k_variables.trackJhsStatus = [trackJhsStatusObj intValue];
            }
            else {
                k_variables.trackJhsStatus = 0;
            }
            
            id trackJhsOrderTimeObj = [userDefault objectForKey:kLongLivedVariablesTrackJhsOrderTime];
            if (trackJhsOrderTimeObj) {
                k_variables.trackJhsOrderTime = [trackJhsOrderTimeObj longValue];
            }
            else {
                k_variables.trackJhsOrderTime = 0;
            }
            
            
            k_variables.successNotLogin = [userDefault objectForKey:kLongLivedVariablesSuccessNotLogin];
            k_variables.successLoginIdDiff = [userDefault objectForKey:kLongLivedVariablesSuccessLoginIdDiff];
            k_variables.successLoginIdSame = [userDefault objectForKey:kLongLivedVariablesSuccessLoginIdSame];
            k_variables.failNotLogin = [userDefault objectForKey:kLongLivedVariablesFailNotLogin];
            k_variables.failLoginIdDiff = [userDefault objectForKey:kLongLivedVariablesFailLoginIdDiff];
            k_variables.failLoginIdSame = [userDefault objectForKey:kLongLivedVariablesFailLoginIdSame];
            
            id wapFanliDoNotAlertAgainObj = [userDefault objectForKey:kLongLivedVariablesWapFanliDoNotAlertAgain];
            if (wapFanliDoNotAlertAgainObj) {
                k_variables.wapFanliDoNotAlertAgain = [wapFanliDoNotAlertAgainObj boolValue];
            }
            else {
                k_variables.wapFanliDoNotAlertAgain = NO;
            }
            
            
            id searchTipFirstShowObj = [userDefault objectForKey:kLongLivedVariablesSearchTipFirstShow];
            if (searchTipFirstShowObj) {
                k_variables.searchTipFirstShow = [searchTipFirstShowObj boolValue];
            }
            else {
                k_variables.searchTipFirstShow = YES;
            }
            
            id fanliTipFirstShowObj = [userDefault objectForKey:kLongLivedVariablesFanliTipFirstShow];
            if (fanliTipFirstShowObj) {
                k_variables.fanliTipFirstShow = [fanliTipFirstShowObj boolValue];
            }
            else {
                k_variables.fanliTipFirstShow = YES;
            }
            k_variables.searchTipString = [userDefault objectForKey:kLongLivedVariablesSearchTipString];
            k_variables.fanliTipString = [userDefault objectForKey:kLongLivedVariablesFanliTipString];
            
            
            id trackOrderEntranceTipFirstShowObj = [userDefault objectForKey:kLongLivedVariablesTrackOrderEntranceTipFirstShow];
            if (trackOrderEntranceTipFirstShowObj) {
                k_variables.trackOrderEntranceTipFirstShow = [trackOrderEntranceTipFirstShowObj boolValue];
            }
            else {
                k_variables.trackOrderEntranceTipFirstShow = YES;
            }
            k_variables.trackOrderEntranceTipString = [userDefault objectForKey:kLongLivedVariablesTrackOrderEntranceTipString];
            
            
            data = [userDefault objectForKey:kLongLivedVariablesHaihuCookiesDictionary];
            if (data == nil) {
                k_variables.haihuCookiesDictionary = [[NSMutableDictionary alloc] init];
            }
            else {
                @try {
                    k_variables.haihuCookiesDictionary = [NSKeyedUnarchiver unarchiveObjectWithData:data];
                }
                @catch (NSException *exception) {
                    [userDefault removeObjectForKey:kLongLivedVariablesHaihuCookiesDictionary];
                    k_variables.haihuCookiesDictionary = [[NSMutableDictionary alloc] init];
                }
                @finally {
                    
                }
            }
            
#ifdef DEBUG
            id urlRequiredObj = [userDefault objectForKey:kLongLivedVariablesUrlRequired];
            if (urlRequiredObj) {
                k_variables.urlRequired = [urlRequiredObj boolValue];
            }
            else{
                k_variables.urlRequired = NO;
            }
            
            k_variables.endPoint = [userDefault objectForKey:kLongLivedVariablesEndPoint];
            if (k_variables.endPoint == nil) {
                k_variables.endPoint = kDefault_Server_Online;
            }
            
            k_variables.uploadEndPoint = [userDefault objectForKey:kLongLivedVariablesUploadEndPoint];
            if (k_variables.uploadEndPoint == nil) {
                k_variables.uploadEndPoint = kDefault_Server_Upload;
            }
            
            k_variables.apiEndPoint = [userDefault objectForKey:kLongLivedVariablesApiEndPoint];
            if (k_variables.apiEndPoint == nil) {
                k_variables.apiEndPoint = kDefault_Server_Api;
            }
            
            k_variables.reportEndPoint = [userDefault objectForKey:kLongLivedVariablesReportEndPoint];
            if (k_variables.reportEndPoint == nil) {
                k_variables.reportEndPoint = kDefault_Server_Report;
            }
#endif
        }
    }
    return k_variables;
}

- (id)init{
    self = [super init];
    if (self) {

    }
    return self;
}

- (void)dealloc
{
    //    [_searchHistoryArray release];
    //    [super dealloc];
}

- (void)uploadImages:(NSDictionary *)dict session:(NSString *)session{
//    NSLog(@"{ upload multi images }");
//    if (!_uploadImageModel){
//        _uploadImageModel = [[UploadImageModel alloc] init];
//        _uploadImageModel.delegate = self;
//    }
//    
//    [_uploadImageModel uploadImages:dict
//                            session:session];
}

- (void)modelEverythingFine:(TFBaseViewModel *)model{
    NSLog(@"{ multi image upload ok }");
}

- (void)modelSomethingWrong:(TFBaseViewModel *)model{
    NSLog(@"{ multi image upload fail }");
}

- (void)setCoinUrl:(NSString *)coinUrl
{
    //    [_coinUrl release];
    //    _coinUrl = [coinUrl retain];
    _coinUrl = coinUrl;
    [[NSUserDefaults standardUserDefaults] setObject:_coinUrl?_coinUrl:@"" forKey:kLongLivedVariablesCoinUrl];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)setRenrenId:(NSString *)aRenrenId{
    //    [_renrenId release];
    //    _renrenId = [aRenrenId copy];
    _renrenId = aRenrenId;
    [[NSUserDefaults standardUserDefaults] setObject:_renrenId?_renrenId:@""
                                              forKey:kLongLivedVariablesRenrenId];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)setWeiboId:(NSString *)aWeiboId{
    //    [_weiboId release];
    //    _weiboId = [aWeiboId copy];
    _weiboId = aWeiboId;
    [[NSUserDefaults standardUserDefaults] setObject:_weiboId?_weiboId:@""
                                              forKey:kLongLivedVariablesWeiboId];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)setTengxunWeiboId:(NSString *)aId{
    //    [_tengxunWeiboId release];
    //    _tengxunWeiboId = [aId copy];
    _tengxunWeiboId = aId;
    [[NSUserDefaults standardUserDefaults] setObject:_tengxunWeiboId?_tengxunWeiboId:@""
                                              forKey:kLongLivedVariablesTengxunWeiboId];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)setQqSpaceId:(NSString *)aId{
    //    [_qqSpaceId release];
    //    _qqSpaceId = [aId copy];
    _qqSpaceId = aId;
    [[NSUserDefaults standardUserDefaults] setObject:_qqSpaceId?_qqSpaceId:@""
                                              forKey:kLongLivedVariablesQQSpaceId];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


- (void)setNetType:(ENetType)aNetType{
    _netType = aNetType;
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInt:_netType]
                                              forKey:kLongLivedVariablesNetType];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)setThrift:(int)aThrift{
    _thrift = aThrift;
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInt:aThrift]
                                              forKey:kLongLivedVariablesThrift];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

- (void)setSmartThrift:(int)aSmartThrift{
    _smartThrift = aSmartThrift;
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInteger:aSmartThrift] forKey:kLongLivedVariablesSmartThrift];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)setShakeToken:(NSString *)aShakeToken{
    //    [aShakeToken retain];
    //    [_shakeToken release];
    _shakeToken = aShakeToken;
    [[NSUserDefaults standardUserDefaults] setObject:aShakeToken
                                              forKey:kLongLivedVariablesShakeToken];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)setShakeChannel:(NSString *)aShakeChannel{
    //    [aShakeChannel retain];
    //    [_shakeChannel release];
    _shakeChannel = aShakeChannel;
    [[NSUserDefaults standardUserDefaults] setObject:aShakeChannel
                                              forKey:kLongLivedVariablesShakeChannel];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)setShakeTime:(NSString *)aShareTime{
    //    [aShareTime retain];
    //    [_shakeTime release];
    _shakeTime = aShareTime;
    [[NSUserDefaults standardUserDefaults] setObject:aShareTime
                                              forKey:kLongLivedVariablesShareTime];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)setShakeMode:(NSString *)aShakeMode{
    //    [aShakeMode retain];
    //    [_shakeMode release];
    _shakeMode = aShakeMode;
    [[NSUserDefaults standardUserDefaults] setObject:aShakeMode
                                              forKey:kLongLivedVariablesShakeMode];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


- (void)setIsNewerToNewGift:(BOOL)isNewerToNewGift {
    _isNewerToNewGift = isNewerToNewGift;
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:_isNewerToNewGift]
                                              forKey:kLongLivedVariablesIsNewerToNewGift];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

- (void)setIsNewerToScrollItemView:(BOOL)isNewerToScrollItemView {
    _isNewerToScrollItemView = isNewerToScrollItemView;
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:_isNewerToScrollItemView]
                                              forKey:kLongLivedVariablesIsNewerToScrollItemView];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

- (void)setSearchHistoryArray:(NSArray *)searchHistoryArray
{
    //    [searchHistoryArray retain];
    //    [_searchHistoryArray release];
    _searchHistoryArray = searchHistoryArray;
    
    if (_searchHistoryArray == nil) {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:kLongLivedVariablesSearchHistoryArray];
    }
    else {
        [[NSUserDefaults standardUserDefaults] setObject:_searchHistoryArray
                                                  forKey:kLongLivedVariablesSearchHistoryArray];
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

- (void)setSplashDictionary:(NSMutableDictionary *)splashDictionary
{
    //    [splashDictionary retain];
    //    [_splashDictionary release];
    _splashDictionary = splashDictionary;
    
    if (_splashDictionary == nil) {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:kLongLivedVariablesSplashDictionary];
    }
    else {
        [[NSUserDefaults standardUserDefaults] setObject:_splashDictionary
                                                  forKey:kLongLivedVariablesSplashDictionary];
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)setLocalMobileNoString:(NSString *)localMobileNoString
{
    //    [localMobileNoString retain];
    //    [_localMobileNoString release];
    _localMobileNoString = localMobileNoString;
    
    if (_localMobileNoString == nil) {
        [[NSUserDefaults standardUserDefaults] setObject:@""
                                                  forKey:kLongLivedVariablesLocalMobileNoString];
    }
    else {
        [[NSUserDefaults standardUserDefaults] setObject:_localMobileNoString
                                                  forKey:kLongLivedVariablesLocalMobileNoString];
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)setLocalNotificationDictionary:(NSMutableDictionary *)localNotificationDictionary
{
    _localNotificationDictionary = localNotificationDictionary;
    
    if (_localNotificationDictionary == nil) {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:kLongLivedVariablesLocalNotificationDictionary];
    }
    else {
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:_localNotificationDictionary];
        [[NSUserDefaults standardUserDefaults] setObject:data forKey:kLongLivedVariablesLocalNotificationDictionary];
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)setFirstQueryNewerPush:(BOOL)firstQueryNewerPush
{
    _firstQueryNewerPush = firstQueryNewerPush;
    
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:_firstQueryNewerPush]
                                              forKey:kLongLivedVariablesFirstQueryNewerPush];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)setCategoryList:(NSMutableArray *)categoryList
{
    //    [categoryList retain];
    //    [_categoryList release];
    _categoryList = categoryList;
    
    if (_categoryList == nil) {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:kLongLivedVariablesCategoryList];
    }
    else {
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:_categoryList];
        [[NSUserDefaults standardUserDefaults] setObject:data
                                                  forKey:kLongLivedVariablesCategoryList];
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)setCategoryDigestDictionary:(NSMutableDictionary *)categoryDigestDictionary
{
    _categoryDigestDictionary = categoryDigestDictionary;
    
    if (_categoryDigestDictionary == nil) {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:kLongLivedVariablesCategoryDigestDictionary];
    }
    else {
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:_categoryDigestDictionary];
        [[NSUserDefaults standardUserDefaults] setObject:data forKey:kLongLivedVariablesCategoryDigestDictionary];
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)setCategoryContentDictionary:(NSMutableDictionary *)categoryContentDictionary
{
    _categoryContentDictionary = categoryContentDictionary;
    
    if (_categoryContentDictionary == nil) {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:kLongLivedVariablesCategoryContentDictionary];
    }
    else {
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:_categoryContentDictionary];
        [[NSUserDefaults standardUserDefaults] setObject:data
                                                  forKey:kLongLivedVariablesCategoryContentDictionary];
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)setCategoryBannerDictionary:(NSMutableDictionary *)categoryBannerDictionary
{
    _categoryBannerDictionary = categoryBannerDictionary;
    
    if (_categoryBannerDictionary == nil) {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:kLongLivedVariablesCategoryBannerDictionary];
    }
    else {
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:_categoryBannerDictionary];
        [[NSUserDefaults standardUserDefaults] setObject:data
                                                  forKey:kLongLivedVariablesCategoryBannerDictionary];
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)setMallCategoryDigest:(NSString *)mallCategoryDigest
{
    //    [mallCategoryDigest retain];
    //    [_mallCategoryDigest release];
    _mallCategoryDigest = mallCategoryDigest;
    
    if (_mallCategoryDigest == nil) {
        [[NSUserDefaults standardUserDefaults] setObject:@""
                                                  forKey:kLongLivedVariablesMallCategoryDigestString];
    }
    else {
        [[NSUserDefaults standardUserDefaults] setObject:_mallCategoryDigest
                                                  forKey:kLongLivedVariablesMallCategoryDigestString];
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)setMallResponseString:(NSString *)mallResponseString
{
    //    [mallResponseString retain];
    //    [_mallResponseString release];
    _mallResponseString = mallResponseString;
    
    if (_mallResponseString == nil) {
        [[NSUserDefaults standardUserDefaults] setObject:@""
                                                  forKey:kLongLivedVariablesMallResponseDataString];
    }
    else {
        [[NSUserDefaults standardUserDefaults] setObject:_mallResponseString
                                                  forKey:kLongLivedVariablesMallResponseDataString];
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)setMallNeedShowTipsDictionary:(NSMutableDictionary *)mallNeedShowTipsDictionary
{
    _mallNeedShowTipsDictionary = mallNeedShowTipsDictionary;
    
    if (_mallNeedShowTipsDictionary == nil) {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:kLongLivedVariablesMallNeedShowTipsDictionary];
    }
    else {
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:_mallNeedShowTipsDictionary];
        [[NSUserDefaults standardUserDefaults] setObject:data forKey:kLongLivedVariablesMallNeedShowTipsDictionary];
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)setBrandReminderItemsDictionary:(NSMutableDictionary *)brandReminderItemsDictionary
{
    //    [brandReminderItemsDictionary retain];
    //    [_brandReminderItemsDictionary release];
    _brandReminderItemsDictionary = brandReminderItemsDictionary;
    
    if (_brandReminderItemsDictionary == nil) {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:kLongLivedVariablesBrandReminderItemsDictionary];
    }
    else {
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:_brandReminderItemsDictionary];
        [[NSUserDefaults standardUserDefaults] setObject:data
                                                  forKey:kLongLivedVariablesBrandReminderItemsDictionary];
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
}
//
//- (void)setActivityNoteShowed:(BOOL)activityNoteShowed {
//    _activityNoteShowed = activityNoteShowed;
//    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:activityNoteShowed]
//                                              forKey:kLongLivedVariablesActivityNoteShowed];
//    [[NSUserDefaults standardUserDefaults] synchronize];
//
//}

- (void)setIsNotFirstLike:(BOOL)isNotFirstLike{
    _isNotFirstLike = isNotFirstLike;
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:isNotFirstLike]
                                              forKey:kLongLivedVariablesIsNotFirstLike];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)setIsNotFirstBrandListItemSetAlarm:(BOOL)isNotFirstBrandListItemSetAlarm{
    _isNotFirstBrandListItemSetAlarm = isNotFirstBrandListItemSetAlarm;
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:isNotFirstBrandListItemSetAlarm]
                                              forKey:kLongLivedVariablesIsNotFirstBrandListItemSetAlarm];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)setIsListStyleGridInside:(BOOL)isListStyleGridInside{
    _isListStyleGridInside = isListStyleGridInside;
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:isListStyleGridInside]
                                              forKey:kLongLivedVariablesIsListStyleGridInside];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)setIsListStyleGridOutside:(BOOL)isListStyleGridOutside{
    _isListStyleGridOutside = isListStyleGridOutside;
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:isListStyleGridOutside]
                                              forKey:kLongLivedVariablesIsListStyleGridOutside];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)setHasClickFanliUse:(BOOL)hasClickFanliUse{
    _hasClickFanliUse = hasClickFanliUse;
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:hasClickFanliUse]
                                              forKey:kLongLivedVariablesHasClickFanliUse];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)setHasClickFilterTips:(BOOL)hasClickFilterTips{
    _hasClickFilterTips = hasClickFilterTips;
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:hasClickFilterTips]
                                              forKey:kLongLivedVariablesHasClickFilterTips];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

//- (void)setActivityNoteRejectedTimes:(NSInteger)activityNoteRejectedTimes {
//    _activityNoteRejectedTimes = activityNoteRejectedTimes;
//    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInteger:activityNoteRejectedTimes]
//                                              forKey:kLongLivedVariablesActivityNoteRejectedTimes];
//    [[NSUserDefaults standardUserDefaults] synchronize];
//
//}
//
//- (void)setActivityNoteDate:(NSString *)activityNoteDate
//{
//    [activityNoteDate retain];
//    [_activityNoteDate release];
//    _activityNoteDate = activityNoteDate;
//
//    if (_activityNoteDate == nil) {
//        [[NSUserDefaults standardUserDefaults] removeObjectForKey:kLongLivedVariablesActivityNoteDate];
//    }
//    else {
//        [[NSUserDefaults standardUserDefaults] setObject:_activityNoteDate
//                                                  forKey:kLongLivedVariablesActivityNoteDate];
//    }
//    [[NSUserDefaults standardUserDefaults] synchronize];
//}
- (void)setIsTaobaoFanliExpand:(int)isTaobaoFanliExpand{
    _isTaobaoFanliExpand = isTaobaoFanliExpand;
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInteger:isTaobaoFanliExpand]
                                              forKey:kLongLivedVariablesIsTaobaoFanliExpand];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (void)setShowCourseTimes:(int)showCourseTimes{
    _showCourseTimes = showCourseTimes;
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInteger:showCourseTimes] forKey:kLongLivedVariablesShowCourseTimes];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)setShowTaobaoFanliCourseTimes:(int)showTaobaoFanliCourseTimes{
    _showTaobaoFanliCourseTimes = showTaobaoFanliCourseTimes;
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInteger:showTaobaoFanliCourseTimes] forKey:kLongLivedVariablesShowTaobaoFanliCourseTimes];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)setHomeTipsShowed:(BOOL)homeTipsShowed {
    _homeTipsShowed = homeTipsShowed;
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:homeTipsShowed]
                                              forKey:kLongLivedVariablesHomeTipsShowed];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

- (void)setHomeTaskTipsShowed:(BOOL)homeTaskTipsShowed {
    _homeTaskTipsShowed = homeTaskTipsShowed;
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:_homeTaskTipsShowed]
                                              forKey:kLongLivedVariablesHomeTaskTipsShowed];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)setIntegratedChannelSuperRebateTipsShowed:(BOOL)integratedChannelSuperRebateTipsShowed{
    _integratedChannelSuperRebateTipsShowed = integratedChannelSuperRebateTipsShowed;
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:integratedChannelSuperRebateTipsShowed]
                                              forKey:kLongLivedVariablesIntegratedChannelSuperRebateTipsShowed];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)setIntegratedChannelCheapTipsShowed:(BOOL)integratedChannelCheapTipsShowed{
    _integratedChannelCheapTipsShowed = integratedChannelCheapTipsShowed;
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:integratedChannelCheapTipsShowed]
                                              forKey:kLongLivedVariablesIntegratedChannelCheapTipsShowed];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (void)setActivityNoteHasShowedImageUrl:(NSString *)activityNoteHasShowedImageUrl
{
    //    [activityNoteHasShowedImageUrl retain];
    //    [_activityNoteHasShowedImageUrl release];
    _activityNoteHasShowedImageUrl = activityNoteHasShowedImageUrl;
    
    if (_activityNoteHasShowedImageUrl == nil) {
        [[NSUserDefaults standardUserDefaults] setObject:@""
                                                  forKey:kLongLivedVariablesActivityNoteHasShowedImageUrl];
    }
    else {
        [[NSUserDefaults standardUserDefaults] setObject:_activityNoteHasShowedImageUrl
                                                  forKey:kLongLivedVariablesActivityNoteHasShowedImageUrl];
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)setActivityNoteCloseCount:(int)activityNoteCloseCount{
    _activityNoteCloseCount = activityNoteCloseCount;
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInteger:activityNoteCloseCount]
                                              forKey:kLongLivedVariablesActivityNoteCloseCount];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (void)setActivityNoteSkipCount:(int)activityNoteSkipCount{
    _activityNoteSkipCount = activityNoteSkipCount;
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInteger:activityNoteSkipCount]
                                              forKey:kLongLivedVariablesActivityNoteSkipCount];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)setShowedHotItemIdArray:(NSMutableArray *)showedHotItemIdArray
{
    //    [_showedHotItemIdArray retain];
    //    [_showedHotItemIdArray release];
    _showedHotItemIdArray = showedHotItemIdArray;
    
    if (_showedHotItemIdArray == nil) {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:kLongLivedVaribalesShowedHotItemIdArray];
    }
    else {
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:_showedHotItemIdArray];
        [[NSUserDefaults standardUserDefaults] setObject:data
                                                  forKey:kLongLivedVaribalesShowedHotItemIdArray];
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)setShowedHotItemLastShowDate:(NSString *)showedHotItemLastShowDate
{
    //    [showedHotItemLastShowDate retain];
    //    [_showedHotItemLastShowDate release];
    _showedHotItemLastShowDate = showedHotItemLastShowDate;
    [[NSUserDefaults standardUserDefaults] setObject:_showedHotItemLastShowDate forKey:kLongLivedVaribalesShowedHotItemLastShowDate];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)setIsManualCrawl:(BOOL)isManualCrawl{
    _isManualCrawl = isManualCrawl;
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:isManualCrawl]
                                              forKey:kLongLivedVariablesIsManualCrawl];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)setIsShowTrackOrder:(BOOL)isShowTrackOrder{
    _isShowTrackOrder = isShowTrackOrder;
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:isShowTrackOrder]
                                              forKey:kLongLivedVariablesIsShowTrackOrder];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)setTrackOrderIds:(NSString *)trackOrderIds
{
    _trackOrderIds = trackOrderIds;
    
    if (_trackOrderIds == nil) {
        [[NSUserDefaults standardUserDefaults] setObject:@""
                                                  forKey:kLongLivedVariablesTrackOrderIds];
    }
    else {
        [[NSUserDefaults standardUserDefaults] setObject:_trackOrderIds
                                                  forKey:kLongLivedVariablesTrackOrderIds];
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)setTrackResult:(NSString *)trackResult
{
    _trackResult = trackResult;
    
    if (_trackResult == nil) {
        [[NSUserDefaults standardUserDefaults] setObject:@""
                                                  forKey:kLongLivedVariablesTrackResult];
    }
    else {
        [[NSUserDefaults standardUserDefaults] setObject:_trackResult
                                                  forKey:kLongLivedVariablesTrackResult];
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)setTrackStatus:(int *)trackStatus{
    _trackStatus = trackStatus;
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInteger:trackStatus]
                                              forKey:kLongLivedVariablesTrackStatus];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (void)setTrackOrderTime:(long)trackOrderTime{
    _trackOrderTime = trackOrderTime;
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithLong:trackOrderTime]
                                              forKey:kLongLivedVariablesTrackOrderTime];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)setIsJhsManualCrawl:(BOOL)isJhsManualCrawl{
    _isJhsManualCrawl = isJhsManualCrawl;
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:isJhsManualCrawl]
                                              forKey:kLongLivedVariablesIsJhsManualCrawl];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)setIsJhsShowTrackOrder:(BOOL)isJhsShowTrackOrder{
    _isJhsShowTrackOrder = isJhsShowTrackOrder;
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:isJhsShowTrackOrder]
                                              forKey:kLongLivedVariablesIsJhsShowTrackOrder];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)setTrackJhsOrderIds:(NSString *)trackJhsOrderIds
{
    _trackJhsOrderIds = trackJhsOrderIds;
    
    if (_trackJhsOrderIds == nil) {
        [[NSUserDefaults standardUserDefaults] setObject:@""
                                                  forKey:kLongLivedVariablesTrackJhsOrderIds];
    }
    else {
        [[NSUserDefaults standardUserDefaults] setObject:_trackJhsOrderIds
                                                  forKey:kLongLivedVariablesTrackJhsOrderIds];
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)setTrackJhsResult:(NSString *)trackJhsResult
{
    _trackJhsResult = trackJhsResult;
    
    if (_trackJhsResult == nil) {
        [[NSUserDefaults standardUserDefaults] setObject:@""
                                                  forKey:kLongLivedVariablesTrackJhsResult];
    }
    else {
        [[NSUserDefaults standardUserDefaults] setObject:_trackJhsResult
                                                  forKey:kLongLivedVariablesTrackJhsResult];
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)setTrackJhsStatus:(int *)trackJhsStatus{
    _trackJhsStatus = trackJhsStatus;
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInteger:trackJhsStatus]
                                              forKey:kLongLivedVariablesTrackJhsStatus];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)setTrackJhsOrderTime:(long)trackJhsOrderTime{
    _trackJhsOrderTime = trackJhsOrderTime;
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithLong:trackJhsOrderTime]
                                              forKey:kLongLivedVariablesTrackJhsOrderTime];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

//flash fanli
- (void)setSuccessNotLogin:(NSString *)successNotLogin
{
    _successNotLogin = successNotLogin;
    
    if (_successNotLogin == nil) {
        [[NSUserDefaults standardUserDefaults] setObject:@""
                                                  forKey:kLongLivedVariablesSuccessNotLogin];
    }
    else {
        [[NSUserDefaults standardUserDefaults] setObject:_successNotLogin
                                                  forKey:kLongLivedVariablesSuccessNotLogin];
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (void)setSuccessLoginIdDiff:(NSString *)successLoginIdDiff
{
    _successLoginIdDiff = successLoginIdDiff;
    
    if (_successLoginIdDiff == nil) {
        [[NSUserDefaults standardUserDefaults] setObject:@""
                                                  forKey:kLongLivedVariablesSuccessLoginIdDiff];
    }
    else {
        [[NSUserDefaults standardUserDefaults] setObject:_successLoginIdDiff
                                                  forKey:kLongLivedVariablesSuccessLoginIdDiff];
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (void)setSuccessLoginIdSame:(NSString *)successLoginIdSame
{
    _successLoginIdSame = successLoginIdSame;
    
    if (_successLoginIdSame == nil) {
        [[NSUserDefaults standardUserDefaults] setObject:@""
                                                  forKey:kLongLivedVariablesSuccessLoginIdSame];
    }
    else {
        [[NSUserDefaults standardUserDefaults] setObject:_successLoginIdSame
                                                  forKey:kLongLivedVariablesSuccessLoginIdSame];
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (void)setFailNotLogin:(NSString *)failNotLogin
{
    _failNotLogin = failNotLogin;
    
    if (_failNotLogin == nil) {
        [[NSUserDefaults standardUserDefaults] setObject:@""
                                                  forKey:kLongLivedVariablesFailNotLogin];
    }
    else {
        [[NSUserDefaults standardUserDefaults] setObject:_failNotLogin
                                                  forKey:kLongLivedVariablesFailNotLogin];
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (void)setFailLoginIdDiff:(NSString *)failLoginIdDiff
{
    _failLoginIdDiff = failLoginIdDiff;
    
    if (_failLoginIdDiff == nil) {
        [[NSUserDefaults standardUserDefaults] setObject:@""
                                                  forKey:kLongLivedVariablesFailLoginIdDiff];
    }
    else {
        [[NSUserDefaults standardUserDefaults] setObject:_failLoginIdDiff
                                                  forKey:kLongLivedVariablesFailLoginIdDiff];
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (void)setFailLoginIdSame:(NSString *)failLoginIdSame
{
    _failLoginIdSame = failLoginIdSame;
    
    if (_failLoginIdSame == nil) {
        [[NSUserDefaults standardUserDefaults] setObject:@""
                                                  forKey:kLongLivedVariablesFailLoginIdSame];
    }
    else {
        [[NSUserDefaults standardUserDefaults] setObject:_failLoginIdSame
                                                  forKey:kLongLivedVariablesFailLoginIdSame];
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)setSearchTipString:(NSString *)searchTipString
{
    _searchTipString = searchTipString;
    
    if (_searchTipString == nil) {
        [[NSUserDefaults standardUserDefaults] setObject:@""
                                                  forKey:kLongLivedVariablesSearchTipString];
    }
    else {
        [[NSUserDefaults standardUserDefaults] setObject:_searchTipString
                                                  forKey:kLongLivedVariablesSearchTipString];
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)setFanliTipString:(NSString *)fanliTipString
{
    _fanliTipString = fanliTipString;
    
    if (_fanliTipString == nil) {
        [[NSUserDefaults standardUserDefaults] setObject:@""
                                                  forKey:kLongLivedVariablesFanliTipString];
    }
    else {
        [[NSUserDefaults standardUserDefaults] setObject:_fanliTipString
                                                  forKey:kLongLivedVariablesFanliTipString];
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)setHaihuCookiesDictionary:(NSMutableDictionary *)haihuCookiesDictionary
{
    _haihuCookiesDictionary = haihuCookiesDictionary;
    
    if (_haihuCookiesDictionary == nil) {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:kLongLivedVariablesHaihuCookiesDictionary];
    }
    else {
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:_haihuCookiesDictionary];
        [[NSUserDefaults standardUserDefaults] setObject:data forKey:kLongLivedVariablesHaihuCookiesDictionary];
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
}



#ifdef DEBUG
- (void)setUrlRequired:(BOOL)urlRequired
{
    _urlRequired = urlRequired;
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:_urlRequired]
                                              forKey:kLongLivedVariablesUrlRequired];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

- (void)setEndPoint:(NSString *)endPoint
{
    //    [endPoint retain];
    //    [_endPoint release];
    _endPoint = endPoint;
    [[NSUserDefaults standardUserDefaults] setObject:_endPoint
                                              forKey:kLongLivedVariablesEndPoint];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)setUploadEndPoint:(NSString *)uploadEndPoint
{
    //    [uploadEndPoint retain];
    //    [_uploadEndPoint release];
    _uploadEndPoint = uploadEndPoint;
    [[NSUserDefaults standardUserDefaults] setObject:_uploadEndPoint
                                              forKey:kLongLivedVariablesUploadEndPoint];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)setApiEndPoint:(NSString *)apiEndPoint
{
    //    [apiEndPoint retain];
    //    [_apiEndPoint release];
    _apiEndPoint = apiEndPoint;
    [[NSUserDefaults standardUserDefaults] setObject:_apiEndPoint
                                              forKey:kLongLivedVariablesApiEndPoint];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

- (void)setReportEndPoint:(NSString *)reportEndPoint
{
    //    [reportEndPoint retain];
    //    [_reportEndPoint release];
    _reportEndPoint = reportEndPoint;
    [[NSUserDefaults standardUserDefaults] setObject:_reportEndPoint
                                              forKey:kLongLivedVariablesReportEndPoint];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

- (void)setWapFanliDoNotAlertAgain:(BOOL)wapFanliDoNotAlertAgain
{   _wapFanliDoNotAlertAgain = wapFanliDoNotAlertAgain;
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:wapFanliDoNotAlertAgain]
                                              forKey:kLongLivedVariablesWapFanliDoNotAlertAgain];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)setSearchTipFirstShow:(BOOL)searchTipFirstShow
{
    _searchTipFirstShow = searchTipFirstShow;
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:searchTipFirstShow]
                                              forKey:kLongLivedVariablesSearchTipFirstShow];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)setFanliTipFirstShow:(BOOL)fanliTipFirstShow
{
    _fanliTipFirstShow = fanliTipFirstShow;
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:fanliTipFirstShow]
                                              forKey:kLongLivedVariablesFanliTipFirstShow];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)setTrackOrderEntranceTipFirstShow:(BOOL)trackOrderEntranceTipFirstShow
{
    _trackOrderEntranceTipFirstShow = trackOrderEntranceTipFirstShow;
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:trackOrderEntranceTipFirstShow]
                                              forKey:kLongLivedVariablesTrackOrderEntranceTipFirstShow];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)setTrackOrderEntranceTipString:(NSString *)trackOrderEntranceTipString
{
    _trackOrderEntranceTipString = trackOrderEntranceTipString;
    
    if (_trackOrderEntranceTipString == nil) {
        [[NSUserDefaults standardUserDefaults] setObject:@""
                                                  forKey:kLongLivedVariablesTrackOrderEntranceTipString];
    }
    else {
        [[NSUserDefaults standardUserDefaults] setObject:_trackOrderEntranceTipString
                                                  forKey:kLongLivedVariablesTrackOrderEntranceTipString];
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#endif

@synthesize coinUrl = _coinUrl;

@synthesize weiboId=_weiboId;
@synthesize renrenId=_renrenId;
@synthesize tengxunWeiboId = _tengxunWeiboId;
@synthesize qqSpaceId = _qqSpaceId;

@synthesize netType = _netType;
@synthesize thrift = _thrift;
@synthesize smartThrift = _smartThrift;
@synthesize endPoint = _endPoint;
@synthesize uploadEndPoint = _uploadEndPoint;
@synthesize apiEndPoint = _apiEndPoint;
@synthesize reportEndPoint = _reportEndPoint;
@synthesize urlRequired = _urlRequired;
@synthesize shakeToken = _shakeToken;
@synthesize shakeChannel = _shakeChannel;
@synthesize shakeTime = _shakeTime;
@synthesize shakeMode = _shakeMode;
@synthesize mobilePage;
@synthesize scheme;
@synthesize searchHistoryArray = _searchHistoryArray;
@synthesize splashDictionary = _splashDictionary;
@synthesize localMobileNoString = _localMobileNoString;
@synthesize localNotificationDictionary = _localNotificationDictionary;
@synthesize categoryList = _categoryList;
@synthesize categoryDigestDictionary = _categoryDigestDictionary;
@synthesize categoryContentDictionary = _categoryContentDictionary;
@synthesize categoryBannerDictionary = _categoryBannerDictionary;
@synthesize mallCategoryDigest = _mallCategoryDigest;
@synthesize mallResponseString = _mallResponseString;
@synthesize mallNeedShowTipsDictionary = _mallNeedShowTipsDictionary;
@synthesize brandReminderItemsDictionary = _brandReminderItemsDictionary;
//@synthesize activityNoteShowed = _activityNoteShowed;
//@synthesize activityNoteRejectedTimes = _activityNoteRejectedTimes;
//@synthesize activityNoteDate = _activityNoteDate;
@synthesize isNotFirstLike = _isNotFirstLike;
@synthesize isListStyleGridInside = _isListStyleGridInside;
@synthesize isListStyleGridOutside = _isListStyleGridOutside;
@synthesize hasClickFanliUse = _hasClickFanliUse;
@synthesize hasClickFilterTips = _hasClickFilterTips;
@synthesize isNotFirstBrandListItemSetAlarm = _isNotFirstBrandListItemSetAlarm;
@synthesize showCourseTimes = _showCourseTimes;

@synthesize isTaobaoFanliExpand = _isTaobaoFanliExpand;
@synthesize showTaobaoFanliCourseTimes = _showTaobaoFanliCourseTimes;

@synthesize integratedChannelSuperRebateTipsShowed = _integratedChannelSuperRebateTipsShowed;
@synthesize integratedChannelCheapTipsShowed = _integratedChannelCheapTipsShowed;

@synthesize activityNoteHasShowedImageUrl = _activityNoteHasShowedImageUrl;
@synthesize activityNoteCloseCount = _activityNoteCloseCount;
@synthesize activityNoteSkipCount = _activityNoteSkipCount;

@synthesize isManualCrawl = _isManualCrawl;
@synthesize isShowTrackOrder = _isShowTrackOrder;
@synthesize trackOrderIds = _trackOrderIds;
@synthesize trackResult = _trackResult;
@synthesize trackStatus = _trackStatus;
@synthesize trackOrderTime = _trackOrderTime;

@synthesize isJhsManualCrawl = _isJhsManualCrawl;
@synthesize isJhsShowTrackOrder = _isJhsShowTrackOrder;
@synthesize trackJhsOrderIds = _trackJhsOrderIds;
@synthesize trackJhsResult = _trackJhsResult;
@synthesize trackJhsStatus = _trackJhsStatus;
@synthesize trackJhsOrderTime = _trackJhsOrderTime;

@synthesize successNotLogin = _successNotLogin;
@synthesize successLoginIdDiff = _successLoginIdDiff;
@synthesize successLoginIdSame = _successLoginIdSame;
@synthesize failNotLogin = _failNotLogin;
@synthesize failLoginIdDiff = _failLoginIdDiff;
@synthesize failLoginIdSame = _failLoginIdSame;
@synthesize wapFanliDoNotAlertAgain = _wapFanliDoNotAlertAgain;
@synthesize searchTipFirstShow = _searchTipFirstShow;
@synthesize fanliTipFirstShow = _fanliTipFirstShow;
@synthesize searchTipString = _searchTipString;
@synthesize fanliTipString = _fanliTipString;

@synthesize trackOrderEntranceTipFirstShow = _trackOrderEntranceTipFirstShow;
@synthesize trackOrderEntranceTipString = _trackOrderEntranceTipString;

@synthesize haihuCookiesDictionary = _haihuCookiesDictionary;
@end
