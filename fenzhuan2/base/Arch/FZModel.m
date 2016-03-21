//
//  FZModel.m
//  fenzhuan2
//
//  Created by 颜梁坚 on 16/3/18.
//  Copyright © 2016年 yanlj. All rights reserved.
//

#import "FZModel.h"
#import "TFHTTPData.h"
#import <objc/runtime.h>
#import <objc/objc.h>

@implementation FZModel

- (instancetype)init{
    self  = [super init];
    if (self){
        self.localRequestEndPoint = [LongLivedVariables shared].apiEndPoint;
    }
    return self;
}

- (void)request{
    self.requesting = YES;
    NSDictionary *dict = [self fillCommonParams];
    //    [self.netExcutor post:self.localRequestEndPoint body:dict];
    
    //    TFNetLog(@"\n{\nREQUEST\n%@?%@\n}\n", self.localRequestEndPoint, [TF8Model queryWithParam:dict]);
    [self.netExcutor postRequest:self.localRequestEndPoint body:[FZModel queryWithParam:dict]];
    
}

- (NSDictionary *)fillCommonParams{
    return self.requestDict;
}

- (void)httpSuccess:(TFHTTPData *)httpData{
    //    NSString *data = [httpData responseString];
    NSDictionary *jsonDict = [SPSJsonWrapper jsonValue:httpData.responseString];
    self.requesting = NO;
    /*! 数据返回有误 */
    if (nil == jsonDict||[jsonDict isEqual:[NSNull null]]) {
        if (self.delegate) {
            Class currentClass = object_getClass(self.delegate);
            if  (_originalClass == currentClass){
                [(NSObject *)self.delegate performSelectorOnMainThread:@selector(modelSomethingWrong:)
                                                            withObject:self
                                                         waitUntilDone:NO];
            }
            else{
                NSLog(@"maybe crash");
            }
        }
        return;
    }
    
    //    self.operation = jsonDict[@"operation"];
    //    self.common = jsonDict[@"common"];
    //    self.status = [self.common[@"status"] integerValue];
    //    self.memo = self.common[@"memo"];
    //
    //    [self saveCommon:jsonDict[@"common"]];
    self.resultStatus = [jsonDict[@"resultStatus"] integerValue];
    /*! 业务出错 */
    if (self.resultStatus<100||self.resultStatus >= 300) {
        if (self.delegate) {
            Class currentClass = object_getClass(self.delegate);
            if  (_originalClass == currentClass){
                [(NSObject *)self.delegate performSelectorOnMainThread:@selector(modelSomethingWrong:)
                                                            withObject:self
                                                         waitUntilDone:NO];
            }
            else{
                NSLog(@"maybe crash");
            }
        }
        return;
    }
    
    if ([self _productModelItem:jsonDict]) {
        if (self.delegate) {
            Class currentClass = object_getClass(self.delegate);
            if  (_originalClass == currentClass){
                [(NSObject *)self.delegate performSelectorOnMainThread:@selector(modelEverythingFine:)
                                                            withObject:self
                                                         waitUntilDone:NO];
                
            }
            else{
                NSLog(@"model delegate was dealloced");
            }
        }
    }
    else { /*! 业务参数处理出错 */
        if (self.delegate) {
            Class currentClass = object_getClass(self.delegate);
            if  (_originalClass == currentClass){
                [(NSObject *)self.delegate performSelectorOnMainThread:@selector(modelSomethingWrong:)
                                                            withObject:self
                                                         waitUntilDone:NO];
            }
            else{
                NSLog(@"model delegate was dealloced");
            }
        }
    }
    
}

- (void)httpFail:(NSString *)data{
    self.requesting = NO;
    
    if (self.delegate) {
        Class currentClass = object_getClass(self.delegate);
        if  (_originalClass == currentClass){
            [(NSObject *)self.delegate performSelectorOnMainThread:@selector(modelSomethingWrong:)
                                                        withObject:self
                                                     waitUntilDone:NO];
            //            [self.delegate modelSomethingWrong:self];
        }
        else{
            NSLog(@"model delegate was dealloced");
        }
    }
}



- (void)resetNonAppendProperties{
    unsigned int outCount = 0;
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    
    for (int i = 0; i < outCount ; i++){
        objc_property_t property = properties[i];
        
        NSString *propertyName = [NSString stringWithUTF8String:property_getName(property)];
        
        if ([self respondsToSelector:@selector(append)]){
            NSDictionary *appendDict = [self append];
            if (appendDict[propertyName]){
                continue;
            }
        }
        
        const char *typeName = property_getTypeName(property);
        
        if (nil == typeName) continue;
        
        NSString *className = [NSString stringWithUTF8String:typeName];
        
        if ([propertyName isEqualToString:@"description"] || [propertyName isEqualToString:@"debugDescription"] || [propertyName isEqualToString:@"hash"] || [propertyName isEqualToString:@"superclass"]||[propertyName hasPrefix:@"local"]){
            continue;
        }
        
        if ([@"Bqi" rangeOfString:className].location == NSNotFound){
            if ([self valueForKey:propertyName]){
                [self setValue:nil forKey:propertyName];
            }
        }else if ([className isEqualToString:@"B"]){
            [self setValue:@(NO) forKey:propertyName];
        }else if ([className isEqualToString:@"q"] || [className isEqualToString:@"i"]){
            [self setValue:@(0) forKey:propertyName];
        }
        
    }
    free(properties);
    
}

- (void)resetAllProperties{
    
    unsigned int outCount = 0;
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    
    for (int i = 0; i < outCount ; i++){
        objc_property_t property = properties[i];
        
        NSString *propertyName = [NSString stringWithUTF8String:property_getName(property)];
        
        const char *typeName = property_getTypeName(property);
        
        if (nil == typeName) continue;
        
        NSString *className = [NSString stringWithUTF8String:typeName];
        
        if ([propertyName isEqualToString:@"description"] || [propertyName isEqualToString:@"debugDescription"] || [propertyName isEqualToString:@"hash"] || [propertyName isEqualToString:@"superclass"]||[propertyName hasPrefix:@"local"]){
            //序列化对象会生成这几个固定的属性;
            continue;
        }
        
        if ([@"Bqi" rangeOfString:className].location == NSNotFound){
            [self setValue:nil forKey:propertyName];
        }else if ([className isEqualToString:@"B"]){
            [self setValue:@(NO) forKey:propertyName];
        }else if ([className isEqualToString:@"q"] || [className isEqualToString:@"i"]){
            [self setValue:@(0) forKey:propertyName];
        }
    }
    self.localIsEnd = NO;
    free(properties);
}


- (BOOL)_productModelItem:(NSDictionary *)dict{
    [self automate:dict];
    return YES;
}

#pragma -
#pragma Automating
- (void)automate:(NSDictionary *)json{
    @synchronized(self){
        unsigned int outCount = 0;
        
        objc_property_t *properties = class_copyPropertyList([self class], &outCount);
        
        [self resetNonAppendProperties];
        
        for (int i = 0; i < outCount;++i) {
            objc_property_t property = properties[i];
            
            NSString *propertyName = [NSString stringWithUTF8String:property_getName(property)];
            
            const char *typeName = property_getTypeName(property);
            
            if (nil == typeName) continue;
            
            NSString *className = [NSString stringWithUTF8String:typeName];
            
            NSString *jsonKey = propertyName;
            
            if ([self respondsToSelector:@selector(replacedPropertyName)]) {
                NSDictionary *replacedPropertyName = [self replacedPropertyName];
                if (replacedPropertyName) {
                    if ([propertyName isEqualToString:@"description"]) {
                    }
                    NSString *replaced = replacedPropertyName[propertyName];
                    if (replaced) jsonKey = replaced;
                }
            }
            
            id jsonObj = json[jsonKey];
            
            if (nil == jsonObj){
                if ([className hasPrefix:@"Singal"]) {
                    
                    if (nil == [self valueForKey:propertyName]) {
                        id singal = [[NSClassFromString(className) alloc] init];
                        [self setValue:singal forKey:propertyName];
                    }
                    
                    //                    id singal = [[NSClassFromString(className) alloc] init];
                    //                    [self setValue:singal forKey:propertyName];
                    
                }
                
                continue;
            }
            
            if ([jsonObj isKindOfClass:[NSArray class]]) {
                
                if ([self respondsToSelector:@selector(arrayClassName)]){
                    NSDictionary *arrayClassName  = [self arrayClassName];
                    NSString *className = arrayClassName[propertyName];
                    if (className) {
                        NSArray *array = (NSArray *)jsonObj;
                        
                        NSMutableArray *mutble = [NSMutableArray array];
                        
                        if ([self respondsToSelector:@selector(append)]){
                            NSDictionary *appendDict = [self append];
                            if (appendDict[propertyName]){
                                id  obj =  [self valueForKey:propertyName];
                                if (![obj isKindOfClass:[NSArray class]]){
                                }else{
                                    NSArray *originArr = [self valueForKey:propertyName];
                                    [mutble addObjectsFromArray:originArr];
                                }
                                
                            }
                        }
                        if (array.count == 0){
                            self.localIsEnd = YES;
                        }else{
                            
                            ///装载最新一次的数据
                            ///如果有EACH数组 进行装载
                            //                            NSMutableArray *EACH = [self valueForKey:[NSString stringWithFormat:@"%@_EACH",propertyName]];
                            //                            if (!EACH) EACH = [[NSMutableArray alloc] init];
                            //                            [EACH removeAllObjects];
                            
                            for (int  i = 0; i < array.count; ++i) {
                                
                                if ([className isEqualToString:@"NSString"]) {
                                    [mutble addObject:array[i]];
                                    //[EACH addObject:array[i]];
                                }
                                else{
                                    id<Automating> autoModel = [[NSClassFromString(className) alloc] init];
                                    [autoModel automate:array[i]];
                                    [mutble addObject:autoModel];
                                    //[EACH addObject:array[i]];
                                }
                            }
                            
                            //[self setValue:EACH forKey:[NSString stringWithFormat:@"%@_EACH",propertyName]];
                            
                        }
                        [self setValue:mutble forKey:propertyName];
                        
                    }
                    else{
                        NSLog(@"missing array class name");
                    }
                }
                else{
                    NSAssert(YES, @"json return contains array but do not implements arrayClass");
                }
            }
            else if ([jsonObj isKindOfClass:[NSDictionary class]]){
                id<Automating> autoModel = [[NSClassFromString(className) alloc] init];
                [autoModel automate:jsonObj];
                
                [self setValue:autoModel forKey:propertyName];
            }
            else if ([jsonObj isKindOfClass:[NSString class]]){
                NSString *str = (NSString *)jsonObj;
                if ([className isEqualToString:@"NSString"]) {
                    [self setValue:str
                            forKey:propertyName];
                }
                else if ([className isEqualToString:@"B"]){
                    [self setValue:[NSNumber numberWithBool:[str boolValue]]
                            forKey:propertyName];
                }
                else if ([className isEqualToString:@"q"]){
                    [self setValue:[NSNumber numberWithInteger:[str integerValue]]
                            forKey:propertyName];
                }
            }
        }
        
        if ([self respondsToSelector:@selector(finished)]){
            [self finished];
        }
        free(properties);
    }
}


const char *property_getTypeName(objc_property_t property) {
    
    const char *attributes = property_getAttributes(property);
    char buffer[1 + strlen(attributes)];
    strcpy(buffer, attributes);
    char *state = buffer, *attribute;
    while ((attribute = strsep(&state, ",")) != NULL) {
        if (attribute[0] == 'T') {
            if(attribute[1] == '@'){
                size_t len = strlen(attribute);
                attribute[len - 1] = '\0';
                return (const char *)[[NSData dataWithBytes:(attribute + 3) length:len - 2] bytes];
            }
            else{
                return (const char *)[[NSData dataWithBytes:(attribute + 1) length:1] bytes];
            }
            
        }
    }
    return "@";
}



+ (NSString *)queryWithParam:(NSDictionary *)param{
    NSString *operateType = [param objectForKey:@"operationType"];
    NSString *time = [Top currentTime];
    NSString *sign = [TFCommand TFSignMd5:operateType time:time];
    
    NSMutableDictionary *publicDict = [[TF8PublicData shared]getPublic];
    
    NSMutableDictionary *mutableRequest = [NSMutableDictionary dictionaryWithDictionary:publicDict];
    
    [mutableRequest addEntriesFromDictionary:param];
    
    [mutableRequest setObject:time forKey:@"time"];
    [mutableRequest setObject:sign forKey:@"sign"];
    
    NSString *temp = [SPSJsonWrapper jsonRepresentation:mutableRequest];
    return [Top gateway:temp];
    
}

@end
