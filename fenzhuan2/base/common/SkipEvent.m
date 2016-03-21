//
//  SkipEvent.m
//  TfClient
//
//  Created by crazycao on 15/4/27.
//
//

#import "SkipEvent.h"

@interface SkipEvent ()

@property (nonatomic, strong) NSString *arg;
@property (nonatomic, strong) NSArray *args;

@end

@implementation SkipEvent

-(instancetype)initWithDictionary:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        self.eventType = [dic objectForKeySafety:@"eventType"];
        self.needLogin = [dic objectForKeySafety:@"needLogin"];

        self.mobilePage = [dic objectForKeySafety:@"mobilePage"];
        self.arg = [dic objectForKeySafety:@"arg"];
        self.args = [dic objectForKeySafety:@"args"];

        // 组装一个便于使用的Array
        _argsArray = [[NSMutableArray alloc] init];
        if (![NSString checkEmpty:self.arg])
        {
            [_argsArray addObject:self.arg];
            [_argsArray addObjectsFromArray:self.args];
        }
        
    }
    return  self;
}

- (NSMutableArray *)argsArray{
    
    if (_argsArray && ([_argsArray isKindOfClass:[NSMutableArray class]] || [_argsArray isKindOfClass:[NSArray class]])) {
        return [_argsArray mutableCopy];
    }
    
    if (!_argsArray){
        _argsArray = [[NSMutableArray alloc]init];
    }
    [_argsArray removeAllObjects];
    if (![NSString checkEmpty:self.arg])
    {
        [_argsArray addObject:self.arg];
        [_argsArray addObjectsFromArray:self.args];
    }
    return _argsArray;
}

-(void)encodeWithCoder:(NSCoder *)encoder
{
    NSLog(@"%s", __func__);
    [encoder encodeObject:self.eventType forKey:@"eventType"];
    [encoder encodeObject:self.needLogin forKey:@"needLogin"];
    [encoder encodeObject:self.mobilePage forKey:@"mobilePage"];
    [encoder encodeObject:self.argsArray forKey:@"argsArray"];
    [encoder encodeObject:self.arg forKey:@"arg"];
    [encoder encodeObject:self.args forKey:@"args"];
}

-(id)initWithCoder:(NSCoder *)decoder
{
    NSLog(@"%s", __func__);
    self.eventType = [decoder decodeObjectForKey:@"eventType"];
    self.needLogin = [decoder decodeObjectForKey:@"needLogin"];
    self.mobilePage = [decoder decodeObjectForKey:@"mobilePage"];
    self.argsArray = [decoder decodeObjectForKey:@"argsArray"];
    self.arg = [decoder decodeObjectForKey:@"arg"];
    self.args = [decoder decodeObjectForKey:@"args"];
    return self;
}

- (NSDictionary *)arrayClassName{
    return @{
             @"args":@"NSString"
             };
}

@synthesize eventType;
@synthesize needLogin;
@synthesize mobilePage;
@synthesize arg;
@synthesize args;
@end

