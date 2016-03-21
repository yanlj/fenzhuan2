//
//  TFWebPConvertData.h
//  tfcommon
//
//  Created by crazycao on 16/2/19.
//
//

#import <Foundation/Foundation.h>
#import "UIImage+WebP.h"

@class TFWebPConvertData;
@protocol TFWebPConvertDelegate <NSObject>

- (void)convertFinished:(TFWebPConvertData *)webP;

@end

@interface TFWebPConvertData : NSObject

@property (atomic, retain) NSData *webPData;
@property (atomic, retain) UIImage *webPImage;

@property (atomic, retain) id <TFWebPConvertDelegate> delegate;


@end
