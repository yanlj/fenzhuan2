//
//  TFModel.m
//  tfcommon
//
//  Created by yin shen on 6/15/15.
//
//

#import "TFModel.h"
#import "TFNetExecutor.h"
#import <objc/runtime.h>

//Class object_getClass(id obj);

@interface TFModel(){
    TFNetExecutor *_netExcutor;
    id<TFModelDelegate> _delegate;
    
}

@end

@implementation TFModel

@synthesize delegate = _delegate;
@synthesize netExcutor = _netExcutor;

- (id)init{
    self = [super init];
    
    if (self) {
        _netExcutor = [[TFNetExecutor alloc] init];
        [_netExcutor setDelegate:self];
    }
    
    return self;
}

- (void)regainNetExcutor{
    if (_netExcutor) {
        [_netExcutor release],_netExcutor = nil;
    }
    
    _netExcutor = [[TFNetExecutor alloc] init];
    [_netExcutor setDelegate:self];
}

- (void)dealloc{
    
    ///netExcutor自身被HttpData retain 所以不会进入netExcutor的dealloc将delegate=nil
    [_netExcutor setDelegate:nil];
    [_netExcutor release],_netExcutor = nil;
    [super dealloc];
}

- (void)setDelegate:(id<TFModelDelegate>)delegate{
    _delegate = delegate;
    _originalClass = object_getClass(_delegate);
}


- (BOOL)_productModelItem:(NSDictionary *)dict{ return NO; }
- (void)httpFail:(NSString *)data{}
- (void)httpSuccess:(TFHTTPData *)httpData{}


- (NSString *)makeRequestString:(id)oriData{ return nil;}


@end
