//
//  TFViewModel.m
//  tfcommon
//
//  Created by yin shen on 6/15/15.
//
//

#import "TFViewModel.h"
#import <AVFoundation/AVFoundation.h>


@implementation Singal

- (id)copyWithZone:(NSZone *)zone{
    Singal *copy = [[[self class] allocWithZone:zone] init];
    copy->_singal = self.singal;
    copy->_seq = self.seq;
    copy->_barrierBoundary = self.barrierBoundary;
    copy->_barrier = self.barrier;
    copy->_conditionSent = self.conditionSent;
    
    return copy;
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeBool:self.singal forKey:@"singal"];
    [aCoder encodeInteger:self.seq forKey:@"seq"];
    [aCoder encodeInteger:self.barrierBoundary forKey:@"barrierBoundary"];
    [aCoder encodeBool:self.barrier forKey:@"barrier"];
    [aCoder encodeBool:self.conditionSent forKey:@"conditionSent"];
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        self.singal = [aDecoder decodeBoolForKey:@"singal"];
        self.seq = [aDecoder decodeIntegerForKey:@"seq"];
        self.barrierBoundary = [aDecoder decodeIntegerForKey:@"barrierBoundary"];
        self.barrier = [aDecoder decodeBoolForKey:@"barrier"];
        self.conditionSent = [aDecoder decodeBoolForKey:@"conditionSent"];
    }
    
    return self;
}


@end

@implementation SingalBOOL

- (id)copyWithZone:(NSZone *)zone{
    
    SingalBOOL *copy = [[[self class] allocWithZone:zone] init];
    copy.barrier = self.barrier;
    copy.barrierBoundary =self.barrierBoundary;
    copy.singal = self.singal;
    copy.seq = self.seq;
    copy->_value = self.value;
    
    return copy;
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    [super encodeWithCoder:aCoder];
    [aCoder encodeBool:self.value forKey:@"singalValue"];
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        self.value = [aDecoder decodeBoolForKey:@"singalValue"];
    }
    
    return self;
}

@end

@implementation SingalIngeter

- (id)copyWithZone:(NSZone *)zone{
    
    SingalIngeter *copy = [[[self class] allocWithZone:zone] init];
    copy.barrier = self.barrier;
    copy.barrierBoundary =self.barrierBoundary;
    copy.singal = self.singal;
    copy.seq = self.seq;
    copy->_value = self.value;
    
    return copy;
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    [super encodeWithCoder:aCoder];
    [aCoder encodeInteger:self.value forKey:@"singalValue"];
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        self.value = [aDecoder decodeIntegerForKey:@"singalValue"];
    }
    
    return self;
}

@end

@implementation SingalFloat

- (id)copyWithZone:(NSZone *)zone{
    
    SingalFloat *copy = [[[self class] allocWithZone:zone] init];
    copy.barrier = self.barrier;
    copy.barrierBoundary =self.barrierBoundary;
    copy.singal = self.singal;
    copy.seq = self.seq;
    copy->_value = self.value;
    
    return copy;
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    [super encodeWithCoder:aCoder];
    [aCoder encodeFloat:self.value forKey:@"singalValue"];
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        self.value = [aDecoder decodeFloatForKey:@"singalValue"];
    }
    
    return self;
}

@end

@implementation SingalString

- (id)copyWithZone:(NSZone *)zone{
    
    SingalString *copy = [[[self class] allocWithZone:zone] init];
    copy.barrier = self.barrier;
    copy.barrierBoundary =self.barrierBoundary;
    copy.singal = self.singal;
    copy.seq = self.seq;
    copy-> _value = [self.value copy];
    
    return copy;
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    [super encodeWithCoder:aCoder];
    [aCoder encodeObject:self.value forKey:@"singalValue"];
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        self.value = [aDecoder decodeObjectForKey:@"singalValue"];
    }
    
    return self;
}

@end

@interface TFViewModelSingal : NSObject
@property (nonatomic, assign) id target;
@property (nonatomic, assign) id observer;
@property (nonatomic, readonly, copy) NSString *keyPath;
@property (nonatomic, readonly, copy) SingalActionBlock block;

- (id)initWithTarget:(id)target
              observer:(id)observer
               keyPath:(NSString *)keyPath
               options:(NSKeyValueObservingOptions)options
                 block:(SingalActionBlock)block;

@end

@implementation TFViewModelSingal

- (id)initWithTarget:(id)target
              observer:(id)observer
               keyPath:(NSString *)keyPath
               options:(NSKeyValueObservingOptions)options
                 block:(SingalActionBlock)block{
    if (self = [super init]) {
        self.target = target;
        self.observer = observer;
        _keyPath = [keyPath copy];
        _block = [block copy];
        
        [self.target addObserver:self.observer
                      forKeyPath:[self.keyPath stringByAppendingString:@".singal"]
                         options:options
                         context:self];
        
    }
    
    return self;
}


- (void)dealloc{
    
    [self.target removeObserver:self.observer
                     forKeyPath:[self.keyPath stringByAppendingString:@".singal"]];
    
    [_block release],_block = nil;
    [_keyPath release],_keyPath = nil;
    
    [super dealloc];
}

@end

@interface TFViewModel(){
    
}

@property (nonatomic, retain) NSMutableDictionary *singals;
@end

@implementation TFViewModel

@synthesize controller;


///from:
///https://github.com/elado/jastor/blob/master/Jastor/Jastor/JastorRuntimeHelper.m
//const char *property_getTypeName(objc_property_t property) {
//    
//    const char *attributes = property_getAttributes(property);
//    char buffer[1 + strlen(attributes)];
//    strcpy(buffer, attributes);
//    char *state = buffer, *attribute;
//    while ((attribute = strsep(&state, ",")) != NULL) {
//        if (attribute[0] == 'T') {
//            if(attribute[1] == '@'){
//                size_t len = strlen(attribute);
//                attribute[len - 1] = '\0';
//                return (const char *)[[NSData dataWithBytes:(attribute + 3) length:len - 2] bytes];
//            }
//            else{
//                return (const char *)[[NSData dataWithBytes:(attribute + 1) length:1] bytes];
//            }
//            
//        }
//    }
//    return "@";
//}

- (id)init{
    if (self = [super init]) {
        
        self.singals = [NSMutableDictionary dictionary];
     
        unsigned int outCount = 0;
        objc_property_t *properties = class_copyPropertyList([self class], &outCount);
        for (int i = 0; i < outCount;++i) {
            objc_property_t property = properties[i];
            
            NSString *propertyName = [NSString stringWithUTF8String:property_getName(property)];
            
            const char *typeName = property_getTypeName(property);
            
            if (nil == typeName) {
                continue;
            }
            
            if (self.doNotInitProperty[propertyName]) {
                continue;
            }
            
            
            NSString *className = [NSString stringWithUTF8String:typeName];
            
            Class class = NSClassFromString(className);
/*
            if (nil == class) {
                continue;
            }
            
            register Class cls;
            cls = class->isa;
//            for (cls = class->isa; cls; cls = class_getSuperclass(cls)){
//                if ([NSStringFromClass(cls) isEqualToString:@"UIView"]){
//                    id obj = [[class alloc] initWithFrame:CGRectZero];
//                    [self setValue:obj forKey:propertyName];
//                    break;
//                }
//                
//            }
 */
            if (nil == class){
                continue;
            }
            if ([class isSubclassOfClass:[UIView class]]){
                id obj = [[class alloc]initWithFrame:CGRectZero];
                [self setValue:obj forKey:propertyName];
            }
            
        }

        free(properties);
    }
    
    return self;
}

- (void)addSingal:(NSString *)key
           target:(id)target
          keyPath:(NSString *)keyPath
          options:(NSKeyValueObservingOptions)options
     singalAction:(SingalActionBlock)block{
    
   [self addSingalBarrier:key
                      seq:0
                 boundary:0
                   target:target
                  keyPath:keyPath
                  options:options
             singalAction:block];
}

- (void)addSingalBarrier:(NSString *)key
                     seq:(NSInteger)seq
                boundary:(NSInteger)boundary
                  target:(id)target
                 keyPath:(NSString *)keyPath
                 options:(NSKeyValueObservingOptions)options
            singalAction:(SingalActionBlock)block{
    
    if ([self.singals objectForKey:key]) {
        [self.singals removeObjectForKey:key];
    }
    
    Singal *singal = [target valueForKey:keyPath];
    singal.seq = seq;
    singal.barrierBoundary = boundary;
    
    TFViewModelSingal *viewSingal = [[TFViewModelSingal alloc] initWithTarget:target
                                                                 observer:self
                                                                  keyPath:keyPath
                                                                  options:options
                                                                    block:block];
    [self.singals setObject:viewSingal
                     forKey:key];
    [viewSingal release];
    
}

- (void)removeSingalGroup:(NSString *)groupKey{
    [self.singals enumerateKeysAndObjectsUsingBlock:^(id key,id obj,BOOL *stop){
        NSString *strKey = (NSString *)key;
        if ([strKey hasPrefix:groupKey]) {
            [self.singals removeObjectForKey:key];
        }
    }];
}

- (void)removeSingal:(NSString *)key{
    [self.singals removeObjectForKey:key];
}

- (void)removeAllSingal{
    [self.singals removeAllObjects];
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context
{
    TFViewModelSingal *singal  = context;
    
    //id value =[change objectForKey:NSKeyValueChangeNewKey];
    
    singal.block(singal.target,[singal.target valueForKey:singal.keyPath]);
}

- (void)request{

};

- (void)render{}

- (void)eventListen{}

- (NSDictionary *)doNotInitProperty{ return @{}; }

- (void)reload{}

- (void)modelEverythingFine:(TFModel *)model{}

- (void)modelSomethingWrong:(TFModel *)model{}

- (TFModel *)mainModel{ return nil; }

- (void)dealloc{
    
    
    self.singals = nil;
    [super dealloc];
}

@end
