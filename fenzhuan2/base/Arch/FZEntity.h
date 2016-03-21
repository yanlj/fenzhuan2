//
//  FZEntity.h
//  fenzhuan2
//
//  Created by 颜梁坚 on 16/3/18.
//  Copyright © 2016年 yanlj. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol Automating <NSObject>

@required
- (void)automate:(NSDictionary *)json;

@optional
/* 自动化装载结束后回调 */
- (void)finished;
/* 当网络返回数据关键字与property不一致时 用于进行替换 {property:json_key} */
- (NSDictionary *)replacedPropertyName;
/* 返回数组类型中的类名称 {property:class_name} */
- (NSDictionary *)arrayClassName;
/* 列表数据需要append */
- (NSDictionary *)append;


@end

@interface FZEntity : NSObject<Automating>

- (void)resetNonAppendProperties;

- (void)resetAllProperties;

@end
