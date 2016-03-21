//
//  TFBaseViewModel.m
//  tfcommon
//
//  Created by yin shen on 8/3/12.
//


#import "TFBaseViewModel.h"
#import "TFDictionary.h"
#import "TFCommand.h"
#import <objc/runtime.h>



extern NSString *LIB_NOTE_KEY;

@interface TFBaseViewModel ()



@end

@implementation TFBaseViewModel


- (id)init{
    self = [super init];
    if (self) {
//        self.net = [[TFNetModel alloc] init];
#pragma mark - memory optimization by limq
        _net = [[TFNetExecutor alloc] init];
    }
    return self;
}

- (void)postDictionary:(NSMutableDictionary *)postDictionary toUrl:(NSString *)url
{
    if (url == nil || [url isEqualToString:@""]) {
        [self httpFail:nil];
        return;
    }
    if (postDictionary == nil || postDictionary.allKeys.count == 0 || postDictionary.allValues.count == 0) {
        [self httpFail:nil];
        return;
    }
    NSString *data = [TFCommand queryWithParam:postDictionary];
    
    [self.net setDelegate:self];
    [self.net postRequestNoCancel:url body:data];
}

- (void)postDictionaryAndCancelPreRequest:(NSMutableDictionary *)postDictionary toUrl:(NSString *)url
{
    if (url == nil || [url isEqualToString:@""]) {
        [self httpFail:nil];
        return;
    }
    if (postDictionary == nil || postDictionary.allKeys.count == 0 || postDictionary.allValues.count == 0) {
        [self httpFail:nil];
        return;
    }
    NSString *data = [TFCommand queryWithParam:postDictionary];
    
    [self.net setDelegate:self];
    [self.net postRequest:url body:data];
}


- (void)setDelegate:(id<TFBaseViewModelDelegate>)delegate{
    _tfDelegate = delegate;
    _originalClass = object_getClass(_tfDelegate);
}

- (void)process{
    [self httpFail:nil];
}

- (void)processWithDict:(NSDictionary *)dict{
    [self httpFail:nil];
}

- (BOOL)_productModelItem:(NSDictionary *)dict{
//    dialogTitle(对话框标题)
//    dialogText(对话框内容)
//    dialogArgument(对话框对应操作需要的参数)
//    dialogType(对话框对应操作类型)
    
    
    
    return YES;
}

- (void)httpSuccess:(TFHTTPData *)data{
    NSDictionary *jsonDict = [TFDataModel parserJsonString:[data responseString]];
    if (nil == jsonDict||[jsonDict isEqual:[NSNull null]]) {
        self.dataStatus = MODEL_DATA_JSON_FAL;
        if (self.tfDelegate) {
            Class currentClass = object_getClass(_tfDelegate);
            if  (_originalClass == currentClass)
            {
                [(NSObject *)self.tfDelegate performSelectorOnMainThread:@selector(modelSomethingWrong:)
                                                              withObject:self
                                                           waitUntilDone:NO];
            }
            else
            {
                NSLog(@"maybe crash");
            }
        }
        return;
    }
    
    self.resultStatus = [[jsonDict objectForKey:@"resultStatus"] intValue];
    
    if (self.resultStatus<100||self.resultStatus >= 300) {
        self.dataStatus = MODEL_DATA_STRUCT_FAL;
        if (self.tfDelegate) {
            Class currentClass = object_getClass(_tfDelegate);
            if  (_originalClass == currentClass)
            {
                [(NSObject *)self.tfDelegate performSelectorOnMainThread:@selector(modelSomethingWrong:)
                                                              withObject:self
                                                           waitUntilDone:NO];
            }
            else
            {
                NSLog(@"maybe crash");
            }
        }
        return;
    }
    
    self.memo = [jsonDict objectForKey:@"memo"];
    
    
    if ([self _productModelItem:jsonDict]) {
        if (self.tfDelegate) {
            
            Class currentClass = object_getClass(_tfDelegate);
            if  (_originalClass == currentClass)
            {
                [(NSObject *)self.tfDelegate performSelectorOnMainThread:@selector(modelEverythingFine:)
                                                              withObject:self
                                                           waitUntilDone:NO];
            }
            else
            {
                NSLog(@"maybe crash");
            }

            
           
        }
    }
    else {
        self.dataStatus = MODEL_DATA_STRUCT_FAL;
        
        if (self.tfDelegate) {
            Class currentClass = object_getClass(_tfDelegate);
            if  (_originalClass == currentClass)
            {
                [(NSObject *)self.tfDelegate performSelectorOnMainThread:@selector(modelSomethingWrong:)
                                                              withObject:self
                                                           waitUntilDone:NO];
            }
            else
            {
                NSLog(@"maybe crash");
            }
        }
        
        
    }
    
    
}

- (void)httpFail:(NSString *)data{
    if (self.tfDelegate) {
        Class currentClass = object_getClass(_tfDelegate);
        if  (_originalClass == currentClass)
        {
            [(NSObject *)self.tfDelegate performSelectorOnMainThread:@selector(modelSomethingWrong:)
                                                          withObject:self
                                                       waitUntilDone:NO];
        }
        else
        {
            NSLog(@"maybe crash");
        }
    }
}

- (void)dealloc{
    if (self.net != nil) {
        [self.net release];
//        self.net = nil;
#pragma mark - memory optimization by limq        
        _net = nil;
    }
    self.controllerTag = nil;
    self.memo = nil;
    
    
    
    [super dealloc];
}

//-(void)setNet:(TFNetModel *)newnet{
//    if (_net != newnet)
//    {
//        [_net release];
//        _net = [newnet retain];
//    }
//}

@synthesize controllerTag;
@synthesize net = _net;
@synthesize netStatus;
@synthesize dataStatus;
@synthesize tfDelegate = _tfDelegate;
@synthesize resultStatus;
@synthesize memo;
@end
