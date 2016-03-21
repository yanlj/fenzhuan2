//
//  SkipEvent.h
//  TfClient
//
//  Created by crazycao on 15/4/27.
//
//

#import <Foundation/Foundation.h>

@interface SkipEvent : FZEntity

@property (nonatomic, strong) NSString *eventType;
@property (nonatomic, strong) NSString *needLogin;//默认NO
@property (nonatomic, strong) NSString *mobilePage;

// 组装一个便于使用的Array
@property (nonatomic, strong) NSMutableArray *argsArray;


-(instancetype)initWithDictionary:(NSDictionary *)dic;

@end