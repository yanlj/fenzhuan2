//
//  TFSwitchButton.h
//  tfcommon
//
//  Created by crazycao on 14-12-30.
//
//

#ifndef tfcommon_TFSwitchButton_h
#define tfcommon_TFSwitchButton_h

#import <UIKit/UIKit.h>

@class TFSwitchButton;
@protocol TFSwitchButtonDelegate
@optional
- (void)switchButtonStatusChanged:(TFSwitchButton *)switchButton;
@end

@interface TFSwitchButton : UIView {
}

@property (nonatomic, assign) BOOL isOn;
@property (nonatomic, assign) id<TFSwitchButtonDelegate> delegate;

- (void)setOnImage:(UIImage *)image forState:(UIControlState)state;
- (void)setOffImage:(UIImage *)image forState:(UIControlState)state;

@end

#endif
