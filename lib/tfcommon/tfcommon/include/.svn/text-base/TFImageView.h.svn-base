//
//  TFImageView.h
//  tfcommon
//
//  Created by yin shen on 8/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "tfthreadpool.h"
/*!
 * *@class    TFImageView
 * *@brief    继承'UIImageView' 主要用于网络下载图片 并发，顺序操作，缓存
 * *@author   shenyin
 */

@class TFImageView;

typedef void (^B_ImageDownloadFinished)();
typedef void (^B_ImageDownloadFinishedEx)(TFImageView *imageView);
typedef void (^b_ImageTouched)(void *);
typedef void (^b_ImageDidLoadBlock)(UIImage *image);

typedef enum {
    TFImageStyleRound = 0x0001,
    TFImageStyleBorder = 0x0010,
} TFImageStyle;

@interface TFImageView : UIImageView <
    UIGestureRecognizerDelegate
    >{
    @public
    NSString    *controllerTag;
    NSString    *cacheIdentifier;
    id          touchDelegate;

    @private
    struct {
        unsigned int    sConcurrent : 1;
        unsigned int    sInLoading  : 1;
    } _flags;
    id      weakExtra;
    BOOL    selected;

    int imageStyle;

    tfthreadpool_t  *dlthreadpool;
    Class           _originalClass;

    BOOL reuse;

    short *_preCancelPoint;

    tftask_t *_pre_task;

    BOOL cacheImg;
        
    
}
@property (assign) BOOL     reuse;
@property (retain) NSString *url;
@property (retain) NSString *controllerTag;
@property (retain) NSString *cacheIdentifier;
@property (assign) id       touchDelegate;
@property (assign) id       weakExtra;
@property (assign) BOOL     selected;
@property (assign) int      imageStyle;
@property (assign) BOOL     isDLImg;
@property (assign) BOOL     cacheImg;
@property (nonatomic, copy) b_ImageTouched imageTouchedBlock;
@property (nonatomic, copy) B_ImageDownloadFinished imageDownloadFinishedBlock;
@property (nonatomic, copy) B_ImageDownloadFinishedEx imageDownloadFinishedBlockEx;
@property (nonatomic, copy) b_ImageDidLoadBlock imageDidLoadBlock;
@property (nonatomic, assign) CGFloat gifDuration;
@property (nonatomic, assign) NSInteger gifRepeatCount;
@property (nonatomic, assign) BOOL notNeedDefaultImage;

- (void)reloadFromDiskIfHad;
- (void)setConcurrent:(BOOL)b; // /default is NO;
- (void)enableUserInteraction:(BOOL)b;
- (void)loadImage:(NSString *)aUrl;
- (void)loadGif:(NSString *)aUrl;
- (void)cancelImageDownload;
- (void)setGif:(NSString *)filename;
- (void)startGif;
- (void)setImageWithURL:(NSURL *)url;
- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder;

@end