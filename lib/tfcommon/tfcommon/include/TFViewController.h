//
//  TFViewController.h
//  tfcommon
//
//  Created by yin shen on 8/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TFViewController : UIViewController{
    NSString *controllerTag;
}
- (void)setupUI;
- (void)setupData;



@property (nonatomic, retain) NSString *parentTitle;
@property (nonatomic, retain) NSString *controllerTag;

@end
