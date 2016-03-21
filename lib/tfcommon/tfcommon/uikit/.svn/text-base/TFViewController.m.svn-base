//
//  TFViewController.m
//  tfcommon
//
//  Created by yin shen on 8/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TFViewController.h"
#include <mach/mach.h>
#import "TFMemoryAllocTable.h"
#import "TFCommonDefine.h"


@interface TFViewController ()

@end

@implementation TFViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}



- (void)dealloc{
#if kMemoryTableManage
    [[TFMemoryAllocTable shared] releaseImageViewInMemoryTableWithTag:self.controllerTag];
#endif
    self.controllerTag = nil;
    self.parentTitle = nil;
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
#if kMemoryTableManage
    TFLog(@"current memory used %.5f",[TFMemoryAllocTable memoryUsedInApp]);
    [TFMemoryAllocTable controllerCreatedCountUp];
#endif
    self.controllerTag = NSStringFromClass([self class]);
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    NSLog(@"%s", __func__);
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (NSUInteger)supportedInterfaceOrientations
{
    NSLog(@"%s", __func__);
    return UIInterfaceOrientationMaskPortrait;
}

- (BOOL)shouldAutorotate
{
    NSLog(@"%s", __func__);
    return YES;
}


- (id)init{
    self = [super init];
    if (self) {
        TFLog(@"get class%@",NSStringFromClass([self class]));
        self.controllerTag = NSStringFromClass([self class]);
        
    }
    return self;
}




- (void)didReceiveMemoryWarning{
    
    [super didReceiveMemoryWarning];
}

@synthesize controllerTag;
@synthesize parentTitle;
@end
