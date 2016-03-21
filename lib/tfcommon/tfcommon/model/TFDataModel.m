//
//  TFDataModel.m
//  tfcommon
//
//  Created by yin shen on 8/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TFDataModel.h"
#import "JSON.h"
#import "SPSJsonWrapper.h"


int MODEL_DATA_SUC = 0;
int MODEL_DATA_JSON_FAL = 1;
int MODEL_DATA_STRUCT_FAL = 2;

@implementation TFDataModel

+ (NSDictionary *)parserJsonString:(NSString *)json{
//    NSDictionary *dic = [SPSJsonWrapper jsonValue:json];
    // 应对多线程情况，创建单独实例来解析JSON串
    SPSJsonWrapper *jsonWrapper = [[SPSJsonWrapper alloc] init];
    NSDictionary *dic = [jsonWrapper jsonValue:json];
    [jsonWrapper release];
    return dic;
}

@end
