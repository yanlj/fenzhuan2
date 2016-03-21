//
//  FZEntity.m
//  fenzhuan2
//
//  Created by 颜梁坚 on 16/3/18.
//  Copyright © 2016年 yanlj. All rights reserved.
//

#import "FZEntity.h"
#import <objc/runtime.h>

extern const char *property_getTypeName(objc_property_t property);

@implementation FZEntity

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
            [self setValue:nil forKey:propertyName];
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
    free(properties);
}



- (void)automate:(NSDictionary *)json{
    
    
    @synchronized(self){
        Class cls;
        for (cls = [self class]; cls; cls = [cls superclass]) {
            if ([NSStringFromClass(cls) isEqualToString:@"HTEntity"]){
                break;
            }
            
            unsigned int outCount = 0;
            objc_property_t *properties = class_copyPropertyList(cls, &outCount);
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
                        NSString *replaced = replacedPropertyName[propertyName];
                        
                        if (replaced) {
                            jsonKey = replaced;
                        }
                    }
                }
                
                id jsonObj = json[jsonKey];
                
                if (nil == jsonObj){
                    if ([className hasPrefix:@"Singal"]) {
                        if (nil == [self valueForKey:propertyName]) {
                            id singal = [[NSClassFromString(className) alloc] init];
                            [self setValue:singal forKey:propertyName];
                        }
                        
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
                            
                            for (int  i = 0; i < array.count; ++i) {
                                
                                if ([className isEqualToString:@"NSString"]) {
                                    [mutble addObject:array[i]];
                                }
                                else{
                                    id<Automating> autoModel = [[NSClassFromString(className) alloc] init];
                                    [autoModel automate:array[i]];
                                    [mutble addObject:autoModel];
                                }
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
                        
                        
                        //                        if ([self respondsToSelector:@selector(replacedPropertyName)]) {
                        //                            NSDictionary *replacedPropertyName = [self replacedPropertyName];
                        //                            if (replacedPropertyName) {
                        //                                NSString *replaced = replacedPropertyName[propertyName];
                        //
                        //                                if ([propertyName isEqualToString:@"description"]) {
                        //
                        //                                }
                        //
                        //                                if (replaced) propertyName = replaced;
                        //                            }
                        //                        }
                        
                        
                        if ([propertyName isEqualToString:@"description"]) {
                            [self setValue:str forKey:@"desc"];
                        }
                        else {
                            [self setValue:str
                                    forKey:propertyName];
                        }
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
                else if ([jsonObj isKindOfClass:[NSNumber class]]) {
                    NSNumber *number = (NSNumber *)jsonObj;
                    if ([className isEqualToString:@"NSNumber"]) {
                        [self setValue:number forKey:propertyName];
                    }
                }
            }
            free(properties);
        }
        if ([self respondsToSelector:@selector(finished)]){
            [self finished];
        }
        
    }
    
}


- (NSDictionary *)replacedPropertyName {
    return  @{@"description" : @"desc",@"id" : @"htid"};
}

@end
