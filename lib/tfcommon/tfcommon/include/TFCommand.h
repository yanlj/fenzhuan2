//
//  TFCommand.h
//  TfClient
//
//  Created by yin shen on 12-3-19.
//

/*!
 @file          TFCommand
 @discussion    ARC unsupported, last update taofen8_2.30
 @author        shenyin
 */

#import <UIKit/UIKit.h>
#import "TFDeviceInfo.h"
#import "TFCommonDefine.h"

/*!
 @interface     TFCommand
 @abstract      The TFCommand provides taofen8 net protocol assemble, all the properties 
                present public vars
 @discussion    The TFCommand is used by iphone and ipad version, all the "DEPRECATED" 
                methords will return NULL, please do not use that
 */
@interface TFCommand : NSObject
//{
//    NSString *clientId;
//    NSString *userId;
//    NSString *nick;
//    NSString *model;
//    NSString *os;
//    NSString *productId;
//    NSString *channelId;
//    NSString *productVersion;
//    NSString *deviceToken;
//    NSString *userAgent;
//    NSString *topSession;
//    NSString *outerCode;
//    NSString *retina;
//    NSString *lat;
//    NSString *lng;
//}
//
//@property (nonatomic, retain) NSString *clientId;
//@property (nonatomic, retain) NSString *userId;
//@property (nonatomic, retain) NSString *nick;
//@property (nonatomic, retain) NSString *model;
//@property (nonatomic, retain) NSString *os;
//@property (nonatomic, retain) NSString *productId;
//@property (nonatomic, retain) NSString *channelId;
//@property (nonatomic, retain) NSString *productVersion;
//@property (nonatomic, retain) NSString *deviceToken;
//@property (nonatomic, retain) NSString *userAgent;
//@property (nonatomic, retain) NSString *topSession;
//@property (nonatomic, retain) NSString *outerCode;
//@property (nonatomic, retain) NSString *retina;
//@property (nonatomic, retain) NSString *display;
//@property (nonatomic, retain) NSString *deviceId;
//@property (nonatomic, retain) NSString *cookie;
//@property (nonatomic, retain) NSString *lat;
//@property (nonatomic, retain) NSString *lng;
//@property (nonatomic, retain) NSString *mobileId;
//@property (nonatomic, retain) NSString *ifa;
//@property (nonatomic, retain) NSString *network;
//@property (nonatomic, retain) NSString *isRoot;
//
//+ (TFCommand *)shared;
//
//- (NSMutableDictionary *)getPublic;
//
//+ (NSString *)getProductID;

+(NSString *)TFSignMd5:(NSString *)requestType time:(NSString *)time; //  r

+ (NSString *)do_SHA_String:(NSString *)body; // l

+ (NSString *)currentTime; // l
+ (NSString *)currentDate; // l

+(NSString *)setValue:(NSString *)value;

//取APP KEY
//+(NSString *)queryAppKey;  // r

//取商品列表
//+(NSString *)queryMemberList:(NSString *)pageArgument pageNo:(NSString *)pageNo cid:(NSString *)cid; // r

//取标准店铺数据
//+(NSString *)queryShopDetail:(NSString *)shopNick pageArgument:(NSString *)pageArgument; // r
//取标准店铺的子分类
//+(NSString *)queryShopSubCategory:(NSString *)shopNick cid:(NSString *)cid pageNo:(NSString *)pageNo;
//+(NSString *)queryItemByShopCategory:(NSString *)shopNick cid1:(NSString *)cid1 cid2:(NSString *)cid2 pageNo:(NSString *)pageNo; // r

//+(NSString *)getExUserId:(NSString *)userId userNick:(NSString *)nick topSession:(NSString *)topSession; // r

//取商品详情数据 生成淘宝客url
//+(NSString *)queryItemDetail:(NSString *)itemId; // r

//取返利列表的数据，按页取
//+(NSString *)queryMyFanli:(NSString *)userId pageNo:(NSString *)pageNo;
//+(NSString *)queryMyFanli:(NSString *)pageNo alipay:(NSString *)alipay; // l
//+(NSString *)queryMyCollection:(NSString *)pageNo; // r

//提建议
//+(NSString *)recommendation:(NSString *)content; // l

//更新淘宝客 click url
//+(NSString *)updateClickUrl:(NSString *)userId itemId:(NSString *)itemId;
//+(NSString *)updateClickUrl:(NSString *)itemId TF_DEPRECATED(4.70#mobilePage); // r
//+(NSString *)updateClickUrl:(NSString *)itemId mobilePage:(NSString *)mobilePage; //l

//查询评价
//+(NSString *)queryRateList:(NSString *)itemId  seller_nick:(NSString *)nick  pageNo:(NSString *)pageNo; // r

//宝贝详情
//+(NSString *)queryItemDetailDes:(NSString *)itemId; // r

//搜索列表中的三个选项 历史记录 商品分类 皇冠店铺

//排序查找数据,按页取
//+(NSString *)searchGoods:(NSString *)pageNo
//                           keyWord:(NSString *)keyWord
//                           orderBy:(NSString *)orderBy
//                        startPrice:(NSString *)startPrice
//                          endPrice:(NSString *)endPrice
//                           isTmall:(NSString *)isTmall
//                            itemId:(NSString *)itemId
//                            searchFlag:(NSString *)searchFlag; // r


///商户版本添加店铺内搜索功能
//+(NSString *)querySearchShopGoodsResultPage:(NSString *)pageNo
//                                    keyWord:(NSString *)keyWord
//                                    orderBy:(NSString *)orderBy
//                                 startPrice:(NSString *)startPrice
//                                   endPrice:(NSString *)endPrice
//                                    isTmall:(NSString *)isTmall
//                                 sellerNick:(NSString *)sellerNick; // r

//商品分类
//+(NSString *)queryItemCategory; // r
//皇冠店铺
//+(NSString *)queryKingShop;  // r

//默认关注列表
//+(NSString *)queryDefaultAttention; // r
//查询用户关注列表
//+(NSString *)queryUserAttention; // r
//删除用户关注项
//+(NSString *)deleteUserAttention:(NSString *)focusId; // r
//添加用户关注项
//+(NSString *)addUserAttention:(NSString *)focusId;
//+(NSString *)addUserAttention:(NSString *)focusId shopName:(NSString *)shopName logo:(NSString *)logo;
//+(NSString *)addUserAttention:(NSString *)focusId shopName:(NSString *)shopName logo:(NSString *)logo shopLevel:(NSString *)shopLevel; //r
//取主题街商品
//+(NSString *)queryTopicStreet:(NSString *)pageNo; // r
//取名气关注店铺
//+(NSString *)queryHotShop:(NSString *)pageNo; // r
//去淘宝搜索人气店铺
//+(NSString *)searchHotShop:(NSString *)keyword pageNo:(NSString *)pageNo; // r
//己购订单列表
//+(NSString *)queryHadFanliOrders:(NSString *)pageNo; // l
//摇奖
//+(NSString *)shakePrize:(NSString *)shakeChannel shakeToken:(NSString *)shakeToken shakeTime:(NSString *)shakeTime shakeMode:(NSString *)shakeMode;  // r
//推荐好友
//+(NSString *)shareFriend:(NSString *)body; //l
//上传淘宝
//+(NSString *)updateMyTaobao:(NSString *)body tbNick:(NSString *)tbNick; //r

///摇奖查询功能
//+ (NSString *)queryShakeMoney:(NSString *)pageNo pageSize:(NSString *)pageSize; //l

///商户版 插件
//+ (NSString *)queryShopHomePage:(NSString *)aPage 
//                       pageSize:(NSString *)aSize 
//                         shopId:(NSString *)aId 
//                     updateTime:(NSString *)aUpdateTime; // r

//+ (NSString *)queryHotDetail:(NSString *)hotId shopId:(NSString *)shopId; //r

///上传点击记录
//+ (NSString *)updateUserClickUrl:(NSString *)itemId
//                           price:(NSString *)price
//                          tkRate:(NSString *)tkRate
//                      mobileTime:(NSString *)mobileTime
//                        clickUrl:(NSString *)clickUrl; // l

///上传下单记录
//+ (NSString *)updateUserOrder:(NSString *)itemId
//                        price:(NSString *)price
//                       tkRate:(NSString *)tkRate
//                   mobileTime:(NSString *)mobileTime
//                     clickUrl:(NSString *)clickUrl
//                      orderNo:(NSString *)orderNo; // l

///淘粉吧浏览的记录查询
//+ (NSString *)queryUserItemHistory:(NSString *)pageNo
//                          pageSize:(NSString *)pageSize; //l

///ipad商品详情
//+ (NSString *)queryIPadItemDetail:(NSString *)itemId; //r

//+ (NSString *)queryIPadItemDetailImageList:(NSString *)itemId; // r

///添加查询热词
//+ (NSString *)queryHotWord; // r

/*!
 @function  checkUpdate
 @abstract  检查更新
 @return    json post string*/
//+ (NSString *)checkUpdate; // l

/*!
 @function  queryInvite(pageNo):pageSize
 @abstract  邀请列表
 @param     pageNo      当前请求的页码
 @param     pageSize    当前请求的页大小
 @return    json post string*/
//+ (NSString *)queryInvite:(int)pageNo
//                 pageSize:(int)pageSize; //l

///查询广告列表
//+ (NSString *)queryAdFeed:(int)pageNo
//                 pageSize:(int)pageSize; //l
///更新广告点击记录
//+ (NSString *)updateAdClick:(NSString *)clickUrl
//                         ad:(NSString *)ad
//                      price:(NSString *)price
//                      point:(NSString *)point
//                       adid:(NSString *)adid
//                  outerCode:(NSString *)outerCode; //l
///查询广告任务结果
//+ (NSString *)queryAdResult:(NSString *)adid; //l
///查询广告记录列表
//+ (NSString *)queryAdRecord:(int)pageNo
//                   pageSize:(int)pageSize; // l

//获取新首页数据
//+ (NSString *)queryNewHome; //r

//新人任务
//+ (NSString *)queryNewGift:(NSString *)giftToken type:(NSString *)type; //l

//查询新人任务打款状态
//+ (NSString *)queryNewGiftState; //l

//获取秒杀商品列表
//+ (NSString *)queryMSList:(int)pageNo
//                 pageSize:(int)pageSize
//                   itemId:(NSString *)itemId;//r

//获取邀请达人列表
//+ (NSString *)queryInviteTop; //l

//获取闪屏
//+ (NSString *)getSplash; //l

//+(NSString *)queryFanliConfirm:(NSString *)pageNo code:(NSString *)code; //l

//+ (NSString *)gateway2:(NSString *)jsonRepresentation code:(NSString *)code; //r

//+(NSString *)queryItemDetail:(NSString *)itemId from:(NSString *)from; //r

//+ (NSString *)queryIPadItemDetail:(NSString *)itemId from:(NSString *)from; //r

#pragma mark -
#pragma mark DEPRECATED Methods List
//取返利达人列表的数据，按页取
//+(NSString *)queryFanliSuper:(NSString *)pageNo TF_DEPRECATED(2.30#no_used); //r
////提交点击记录
//+(NSString *)updateClickMark:(NSString *)visitTime itemId:(NSString *)itemId clickUrl:(NSString *)clickUrl tkRate:(NSString *)tkRate TF_DEPRECATED(2.11#updateUserOrder_replaced); //r
//
////取主界面的五个动态数据
//+(NSString *)queryHomePage TF_DEPRECATED(2.11#no_used); //r
////查询userId
//+(NSString *)getUserId:(NSString *)nick topSession:(NSString *)topSession TF_DEPRECATED(2.01#getExUserId_replaced); //r

#pragma mark - 新策略 通过dic统一生成data string

+(NSString *)queryWithParam:(NSDictionary *)param;


//海淘生成请求数据的方法
+ (NSDictionary *)htQueryWithParam:(NSMutableDictionary *)param;

@end


