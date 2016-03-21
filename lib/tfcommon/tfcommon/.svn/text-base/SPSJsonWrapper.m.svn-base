//
//  SPSJsonWrapper.m
//  spsecurity
//
//  Created by Jing Wen on 6/9/12.
//  Copyright (c) 2012 Alipay. All rights reserved.
//

#import "SPSJsonWrapper.h"
#import "JSON.h"

static const SBJsonParser *jsonParser;
static const SBJsonWriter *jsonWriter;

@interface SPSJsonWrapper ()
{
    SBJsonParser *_tmpJsonParser;
    SBJsonWriter *_tmpJsonWriter;
}

@end

@implementation SPSJsonWrapper

- (SPSJsonWrapper *)init
{
    if (self = [super init]) {
        _tmpJsonParser = nil;
        _tmpJsonWriter = nil;
    }
    return self;
}

- (void)dealloc
{
    if (_tmpJsonParser) {
        [_tmpJsonParser release];
        _tmpJsonParser = nil;
    }
    if (_tmpJsonWriter) {
        [_tmpJsonWriter release];
        _tmpJsonWriter = nil;
    }
    [super dealloc];
}

- (id)jsonValue:(NSString *)str
{
	if (!_tmpJsonParser)
		_tmpJsonParser = [SBJsonParser new];
    
    id repr = [_tmpJsonParser objectWithString:str];
    if (repr) {
        [_tmpJsonParser release];
        _tmpJsonParser = nil;
        
        return repr;
    }
    else {
        NSLog(@"-JSONValue failed. Error trace is: %@", [_tmpJsonParser errorTrace]);
        [_tmpJsonParser release];
        _tmpJsonParser = nil;
        
        return nil;
    }
}

+ (NSString *)jsonRepresentation:(id)obj {
	if (!jsonWriter){
		jsonWriter = [SBJsonWriter new];
    }
    
    jsonWriter.sortKeys =NO;
    
    NSString *json = [jsonWriter stringWithObject:obj];
    if (json)
        return json;
    
    NSLog(@"-JSONRepresentation failed. Error trace is: %@", [jsonWriter errorTrace]);
    return nil;
}

+ (NSString *)jsonSortRepresentation:(id)obj {
	if (!jsonWriter){
		jsonWriter = [SBJsonWriter new];
    }
    
    jsonWriter.sortKeys = YES;
    
    
    NSString *json = [jsonWriter stringWithObject:obj];
    if (json)
        return json;
    
    NSLog(@"-JSONRepresentation failed. Error trace is: %@", [jsonWriter errorTrace]);
    return nil;
}


+ (id)jsonValue:(NSString *)str
{
	if (!jsonParser)
		jsonParser = [SBJsonParser new];
    
    id repr = [jsonParser objectWithString:str];
    if (repr)
        return repr;
    
    NSLog(@"-JSONValue failed. Error trace is: %@", [jsonParser errorTrace]);
    return nil;
}


@end
