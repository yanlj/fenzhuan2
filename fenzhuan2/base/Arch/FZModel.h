//
//  FZModel.h
//  fenzhuan2
//
//  Created by 颜梁坚 on 16/3/18.
//  Copyright © 2016年 yanlj. All rights reserved.
//

#import "TFModel.h"
#import "FZEntity.h"

@interface FZModel : TFModel<Automating>
{
    int resultStatus;
}
@property (nonatomic,strong)NSDictionary *requestDict;
@property (nonatomic,assign)BOOL localIsEnd;
@property (nonatomic,assign)BOOL requesting;
@property (nonatomic,assign)NSInteger resultStatus;
@property (nonatomic,strong)NSString *memo;
@property (nonatomic,strong)NSString *localRequestEndPoint;

- (BOOL)_productModelItem:(NSDictionary *)dict;

- (void)request;

- (void)resetNonAppendProperties;

- (void)resetAllProperties;

+ (NSString *)queryWithParam:(NSDictionary *)param;


@end
