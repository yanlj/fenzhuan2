//
//  TFDictionary.m
//  tfcommon
//
//  Created by yin shen on 12/6/12.
//
//

#import "TFDictionary.h"

@implementation TFDictionary

- (id)objectForKey:(id)aKey{
    id obj = [super objectForKey:aKey];
    if ([obj isEqual:[NSNull null]]) {
        return nil;
    }
    else
        return obj;
}

@end
