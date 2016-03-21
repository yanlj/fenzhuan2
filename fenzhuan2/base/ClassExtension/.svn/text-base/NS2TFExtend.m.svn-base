//
//  NS2TFExtend.m
//  tfcommon
//
//  Created by yin shen on 12/10/12.
//
//

#import "NS2TFExtend.h"

@implementation NSDictionary(TFExtend)
- (id)objectForKeySafety:(id)aKey{
    id obj = [self objectForKey:aKey];
    if ([obj isEqual:[NSNull null]]) {
        return nil;
    }
    else
        return obj;
}
@end
