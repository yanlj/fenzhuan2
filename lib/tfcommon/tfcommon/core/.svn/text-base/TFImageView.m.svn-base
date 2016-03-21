//
//  TFImageView.m
//  tfcommon
//
//  Created by yin shen on 8/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TFImageView.h"
#import "TFCache.h"
#import "TFCommonDefine.h"
#import "TFMemoryAllocTable.h"

#import "GCDCenter.h"
#import "TFHTTP.h"
#import "TFHTTPData.h"
#import "TFWebPConvertData.h"


#import <QuartzCore/CALayer.h>
#import <ImageIO/ImageIO.h>
#import <QuartzCore/CoreAnimation.h>

#define NSLog(...)


/*!
 *   @declare C99 重新声明*/
Class object_getClass(id obj);

@interface TFImageView ()
{
    CGFloat _totalTime;
    NSMutableArray *_gifFrames;
    NSMutableArray *_gifFrameDelayTimes;
    
    UIImageView *_defaultImageView;
}

- (void)_initFlags;
- (void)_finishLoadImage;
@end

static tfthreadpool_t * assignthreadpool = NULL;
static UIImage *k_htDefaultImage = nil;

@implementation TFImageView

+ (void)initialize{
    if (self == [TFImageView self]) {
        
        NSString  *bundlePath = [[NSBundle   mainBundle].resourcePath stringByAppendingPathComponent : @"htimages.bundle"];
        NSBundle *tmpBundle = [NSBundle bundleWithPath:bundlePath];
        NSString *resourcePath = tmpBundle.resourcePath;
        
        
        
        k_htDefaultImage = [[UIImage alloc] initWithContentsOfFile:[resourcePath stringByAppendingString:@"/ht-placeholder-image-tf.png"]];
    }
}

+ (tfthreadpool_t *)assignPool
{
    if (NULL == assignthreadpool) {
        assignthreadpool = (tfthreadpool_t *)malloc(sizeof(tfthreadpool_t));
        assignthreadpool->name = "pink_img_assign";
        assignthreadpool->threads = NULL;
        tfthreadpool_init(assignthreadpool, 5);
    }

    return assignthreadpool;
}

+ (void)destoryAssignPool
{
    tfthreadpool_free(assignthreadpool);
}

- (tfthreadpool_t *)reuseDownloadPool
{
    if (NULL == dlthreadpool) {
        dlthreadpool = (tfthreadpool_t *)malloc(sizeof(tfthreadpool_t));
        dlthreadpool->name = "pink_img_dl";
        dlthreadpool->threads = NULL;
        tfthreadpool_init(dlthreadpool, 1);
    }

    return dlthreadpool;
}

- (void)destoryReuseDownloadPool
{
    tfthreadpool_free(dlthreadpool);
}

- (id)initTapImageViewWithFrame:(CGRect)frame
{
    self = [self initWithFrame:frame];
    if (self) {
        
            self.userInteractionEnabled = YES;

        _defaultImageView.image  = k_htDefaultImage;
        
        
    }
    return self;
}

+ (UIImage *)htDefaultImage {
    NSString  *bundlePath = [[NSBundle   mainBundle].resourcePath stringByAppendingPathComponent : @"htimages.bundle"];
    NSBundle *tmpBundle = [NSBundle bundleWithPath:bundlePath];
    NSString *resourcePath = tmpBundle.resourcePath;
    return [UIImage imageWithContentsOfFile:[resourcePath stringByAppendingString:@"/ht-placeholder-image-tf.png"]];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];

    if (self) {
        // Initialization code
        [self _initFlags];
//        self.userInteractionEnabled = YES;

        UITapGestureRecognizer *singlePress = [[UITapGestureRecognizer alloc]   initWithTarget  :self
                                                                                action          :@selector(singlePressOccur:)];

        singlePress.numberOfTouchesRequired = 1;
        singlePress.numberOfTapsRequired = 1;
        [singlePress setDelegate:self];
        [self addGestureRecognizer:singlePress];
        [singlePress release];
        _preCancelPoint = NULL;
        [self initDefaultImageView:frame];
    }

    return self;
}

- (void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    [self initDefaultImageView:frame];
}

- (void)setImage:(UIImage *)image{
    [super setImage:image];
    if (image != nil) {
        _defaultImageView.hidden = YES;
    }
}

- (void)setNotNeedDefaultImage:(BOOL)notNeedDefaultImage{
//    self.notNeedDefaultImage = notNeedDefaultImage;//这样会报错    当self.notNeedDefaultImage = 会循环调用该方法
    _notNeedDefaultImage = notNeedDefaultImage;
    if (notNeedDefaultImage) {
        if (_defaultImageView) {
            [_defaultImageView removeFromSuperview];
            _defaultImageView = nil;
        }
    }
}

- (void)initDefaultImageView:(CGRect)frame{
    if (self.notNeedDefaultImage) {
        return;
    }
    CGSize defaultImageSize = CGSizeMake(58, 27);
    
    CGFloat fitWidth = defaultImageSize.width;
    CGFloat fitHeight = defaultImageSize.height;
    if (fitWidth > frame.size.width) {
        fitWidth = frame.size.width;
        fitHeight = fitWidth * defaultImageSize.height / defaultImageSize.width;
        
        if (fitHeight > frame.size.height) {
            fitHeight = frame.size.height;
            fitWidth = fitHeight * defaultImageSize.width / defaultImageSize.height;
        }
    }
    
    if (fitHeight > frame.size.height) {
        fitHeight = frame.size.height;
        fitWidth = fitHeight * defaultImageSize.width / defaultImageSize.height;
        
        if (fitWidth > frame.size.width) {
            fitWidth = frame.size.width;
            fitHeight = fitWidth * defaultImageSize.height / defaultImageSize.width;
        }
    }
    if (_defaultImageView == nil) {
        _defaultImageView = [[UIImageView alloc] initWithFrame:CGRectMake((frame.size.width - fitWidth) / 2.f, (frame.size.height - fitHeight) / 2.f, fitWidth, fitHeight)];
        [_defaultImageView setImage:[UIImage imageNamed:@"common_default_image116px*54px"]];
        [self addSubview:_defaultImageView];
        [_defaultImageView release];
    }else{
        [_defaultImageView setFrame:CGRectMake((frame.size.width - fitWidth) / 2.f, (frame.size.height - fitHeight) / 2.f, fitWidth, fitHeight)];
    }
}

- (void)_initFlags
{
    _flags.sConcurrent = NO;
    self.userInteractionEnabled = NO;
    _flags.sInLoading = NO;
    _gifDuration = -1.f;
    _gifRepeatCount = 0;
}

- (void)dealloc
{
    NSLog(@"{ TFImageView deallocate... }");
//    tfthreadpool_clean(dlthreadpool);
    [self destoryReuseDownloadPool];
    [self setImage:nil];
    self.controllerTag = nil;
    self.cacheIdentifier = nil;
    self.imageDownloadFinishedBlock = nil;
    self.imageDownloadFinishedBlockEx = nil;
    self.url = nil;
    [_gifFrames release],_gifFrames = nil;
    [_gifFrameDelayTimes release],_gifFrameDelayTimes = nil;
    self.imageTouchedBlock = nil;
    self.imageDidLoadBlock = nil;
    [super dealloc];
}

- (void)setControllerTag:(NSString *)tag {}

- (NSString *)getControllerTag
{
    return controllerTag;
}

- (void)singlePressOccur:(UIGestureRecognizer *)gesture
{
    NSLog(@"%s", __func__);
    if (self.touchDelegate && [self.touchDelegate respondsToSelector:@selector(touchOnPhotoView:)]) {
        self.selected = !self.selected;
        [self.touchDelegate performSelector:@selector(touchOnPhotoView:) withObject:self];
    }
    if (self.imageTouchedBlock) {
        self.imageTouchedBlock(self);
    }
}

- (void)_finishLoadImage
{
    NSLog(@"%s", __func__);
    _flags.sInLoading = NO;
}

- (void)loadImage:(NSString *)aUrl
{
    NSLog(@"%s", __func__);
    
    _defaultImageView.hidden = NO;
    
    NSLog(@"%s", __func__);
    
    if ((nil == aUrl) || [aUrl isEqualToString:@""]) {
        return;
    }
    
    self.url = aUrl;
    
    id imageData = [[TFCache shared] objectForKey:aUrl];
    
    if (imageData) {
        if ([[aUrl lowercaseString] hasSuffix:@".webp"]) {
            [self   performSelectorOnMainThread :@selector(presentWebP:)
                    withObject                  :imageData
                    waitUntilDone               :YES];
        }
        else {
            [self   performSelectorOnMainThread :@selector(presentImage:)
                    withObject                  :imageData
                    waitUntilDone               :YES];
        }
    } else {
        if (self.reuse) {
            tfthreadpool_t  *threadpool = [TFImageView assignPool];
            TFHTTPData      *httpData = [[TFHTTPData alloc] init];
            httpData.delegate = self;
            httpData.postData = nil;
            httpData.url = aUrl;
            httpData.type = [[aUrl lowercaseString] hasSuffix:@".webp"]?TFHTTPDataTypeWebP:TFHTTPDataTypeJpgOrPng;
            tfthreadpool_eat2(threadpool, TFImageDownload, httpData);
        } else {
            tfthreadpool_t  *threadpool = [TFImageView assignPool];
            TFHTTPData      *httpData = [[TFHTTPData alloc] init];
            httpData.delegate = self;
            httpData.postData = nil;
            httpData.url = aUrl;
            httpData.type = [[aUrl lowercaseString] hasSuffix:@".webp"]?TFHTTPDataTypeWebP:TFHTTPDataTypeJpgOrPng;
            
            tfthreadpool_eat2(threadpool, TFImageDownload, httpData);
        }
    }

}

- (void)loadGif:(NSString *)aUrl
{
    NSLog(@"%s", __func__);
    
    _defaultImageView.hidden = NO;
    
    if ([aUrl isKindOfClass:[NSNull class]]) {
        return;
    }
    
    if ((nil == aUrl) || [aUrl isEqualToString:@""]) {
        return;
    }
    
    self.url = aUrl;
    
    id imageData = [[TFCache shared] objectForKey:aUrl];
    
    
    if (imageData) {
        [self   performSelectorOnMainThread :@selector(presentGif:)
                withObject                  :imageData
                waitUntilDone               :YES];
    } else {
        tfthreadpool_t  *threadpool = [TFImageView assignPool];
        TFHTTPData      *httpData = [[TFHTTPData alloc] init];
        httpData.delegate = self;
        httpData.postData = nil;
        httpData.type = TFHTTPDataTypeGif;
        httpData.url = aUrl;
        
        tfthreadpool_eat2(threadpool, TFImageDownload, httpData);
    }
}


- (void)httpFinished:(TFHTTPData *)httpData
{
    NSLog(@"%s", __func__);
    
    self.isDLImg = NO;

    if (HTTP_OK == httpData.statusCode) {
        if (self) {
            Class currentClass = object_getClass(self);

            if ([TFImageView class] == currentClass) {
                
                if ([httpData.url isEqualToString:self.url]) {
                    if (httpData.type == TFHTTPDataTypeGif) {
                        [self   performSelectorOnMainThread :@selector(presentGif:)
                                withObject                  :httpData.responseData
                                waitUntilDone               :YES];
                    }
                    else if (httpData.type == TFHTTPDataTypeWebP) {
                        [self   performSelectorOnMainThread :@selector(presentWebP:)
                                withObject                  :httpData.responseData
                                waitUntilDone               :YES];
                    }
                    else{
                        [self   performSelectorOnMainThread :@selector(presentImage:)
                                withObject                  :httpData.responseData
                                waitUntilDone               :YES];
                    }
                }
                
                if (self.cacheImg) {
                    [[TFCache shared] cacheObject:httpData.responseData key:httpData.url where:E_TFCacheWhereBoth];
                } else {
                    [[TFCache shared] cacheObject:httpData.responseData key:httpData.url where:E_TFCacheWhereDisk];
                }
            }
        }
    } else {
        NSLog(@"TFImageView Error! HTTP statusCode:%d", httpData.statusCode);
    }

    [httpData release], httpData = nil;
}

- (void)httpCanceled:(TFHTTPData *)httpData
{
}

static void addRoundedRectToPath(CGContextRef context, CGRect rect,
    float ovalWidth, float ovalHeight)
{
    float fw, fh;

    if ((ovalWidth == 0) || (ovalHeight == 0)) {
        CGContextAddRect(context, rect);
        return;
    }

    CGContextSaveGState(context);
    CGContextTranslateCTM(context, CGRectGetMinX(rect),
        CGRectGetMinY(rect));
    CGContextScaleCTM(context, ovalWidth, ovalHeight);
    fw = CGRectGetWidth(rect) / ovalWidth;
    fh = CGRectGetHeight(rect) / ovalHeight;
    CGContextMoveToPoint(context, fw, fh / 2);
    CGContextAddArcToPoint(context, fw, fh, fw / 2, fh, 1);
    CGContextAddArcToPoint(context, 0, fh, 0, fh / 2, 1);
    CGContextAddArcToPoint(context, 0, 0, fw / 2, 0, 1);
    CGContextAddArcToPoint(context, fw, 0, fw, fh / 2, 1);
    CGContextClosePath(context);
    CGContextRestoreGState(context);
}

static void addBorderRectToPath(CGContextRef context, CGRect rect)
{
    //  CGContextSaveGState(context);
    CGContextSetLineWidth(context, 2.0);
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:212 / 255.0 green:212 / 255.0 blue:212 / 255.0 alpha:1.0].CGColor);
    // CGContextAddRect(context, rect);
    //    CGContextStrokePath(context);
    //    CGContextMoveToPoint(context, 0, 0);
    //    CGContextAddLineToPoint(context, 0, 50);

    //    CGContextAddLineToPoint(context, rect.origin.x+rect.size.width, rect.origin.y+rect.size.height);
    //    CGContextAddLineToPoint(context, rect.origin.x+rect.size.width, rect.origin.y);
    //    CGContextAddLineToPoint(context, rect.origin.x, rect.origin.y);
    // CGContextStrokePath(context);
    CGContextStrokeRect(context, rect);
    //  CGContextClosePath(context);
    //   CGContextRestoreGState(context);
}

- (NSData *)addImageStyple:(NSData *)data
{
    NSLog(@"%s", __func__);
    UIImage *processImg = [UIImage imageWithData:data];
    // [data release],data = nil;
    int w = processImg.size.width;
    int h = processImg.size.height;

    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef    context = CGBitmapContextCreate(NULL, w, h, 8, 4 * w, colorSpace, kCGImageAlphaPremultipliedFirst);

    CGContextBeginPath(context);
    CGRect rect = CGRectMake(0, 0, processImg.size.width, processImg.size.height);

    switch (self.imageStyle) {
        case TFImageStyleRound:
            addRoundedRectToPath(context, rect, 10, 10);
            CGContextClosePath(context);
            CGContextClip(context);

            CGContextDrawImage(context, CGRectMake(0, 0, w, h), processImg.CGImage);
            break;

        case TFImageStyleBorder:
            addBorderRectToPath(context, rect);
            CGContextClosePath(context);
            CGContextClip(context);

            CGContextDrawImage(context, CGRectMake(1, 1, w - 2, h - 2), processImg.CGImage);
            break;

        //        case TFImageStyleRound|TFImageStyleBorder:
        //
        //            break;
        default:
            break;
    }

    CGImageRef imageMasked = CGBitmapContextCreateImage(context);
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);

    UIImage *maskedImg = [UIImage imageWithCGImage:imageMasked];
    // CFRelease(imageMasked);
    return UIImagePNGRepresentation(maskedImg);
}

- (void)presentImage:(NSData *)data
{
    NSLog(@"%s", __func__);
    _flags.sInLoading = NO;
    
    UIImage *image = [UIImage imageWithData:data];
    [self setImage:image];
    
    _defaultImageView.hidden = YES;
    
    if (nil != self.imageDownloadFinishedBlockEx) {
        self.imageDownloadFinishedBlockEx(self);
    }
    else if (nil != self.imageDownloadFinishedBlock) {
        self.imageDownloadFinishedBlock();
    }
    
    if (self.imageDidLoadBlock != nil){
        self.imageDidLoadBlock(image);
    }
}

- (void)presentWebP:(NSData *)data
{
    NSLog(@"%s", __func__);
    
//    tfthreadpool_t  *threadpool = [TFImageView assignPool];
//    TFHTTPData      *httpData = [[TFHTTPData alloc] init];
//    httpData.delegate = self;
//    httpData.postData = nil;
//    httpData.type = TFHTTPDataTypeGif;
//    httpData.url = aUrl;
//    
//    tfthreadpool_eat2(threadpool, TFImageDownload, httpData);
    
    tfthreadpool_t  *threadpool = [TFImageView assignPool];
    TFWebPConvertData *convertData = [[TFWebPConvertData alloc] init];
    convertData.delegate = self;
    convertData.webPData = data;
    tfthreadpool_eat2(threadpool, TFWebPImageDecode, convertData);
    
    return;
}

- (void)convertFinished:(TFWebPConvertData *)convertData
{
    UIImage *image = convertData.webPImage;
    [self performSelectorOnMainThread:@selector(showWebPImage:) withObject:image waitUntilDone:NO];
}

- (void)showWebPImage:(UIImage *)image
{
    [self setImage:image];
    
    _flags.sInLoading = NO;
    
    _defaultImageView.hidden = YES;
    
    if (nil != self.imageDownloadFinishedBlockEx) {
        self.imageDownloadFinishedBlockEx(self);
    }
    else {
        if (nil != self.imageDownloadFinishedBlock) {
            self.imageDownloadFinishedBlock();
        }
    }
}

- (void)presentGif:(NSData *)data
{
    NSLog(@"%s", __func__);
    [self stopGif];
    
    _defaultImageView.hidden = YES;
    
    if (nil == _gifFrames) {
        _gifFrames = [[NSMutableArray alloc] init];
    }
    else{
        [_gifFrames removeAllObjects];
    }
    
    if (nil == _gifFrameDelayTimes) {
        _gifFrameDelayTimes = [[NSMutableArray alloc] init];
    }
    else{
        [_gifFrameDelayTimes removeAllObjects];
    }
    
    
    CGFloat width = 0;
    CGFloat height = 0;
    _totalTime = 0;
    
    [self getFrameInfo:(CFDataRef)data
                frames:_gifFrames
            delayTimes:_gifFrameDelayTimes
             totaltime:&_totalTime
                 width:&width
                height:&height];
    
    if (_gifFrames.count == 0 || _gifFrameDelayTimes.count == 0) {
        [self   performSelectorOnMainThread :@selector(presentImage:)
                withObject                  :data
                waitUntilDone               :YES];
        return;
    }
    
    if (nil != self.imageDownloadFinishedBlock) {
        self.imageDownloadFinishedBlock();
    }
    
    [self startGif];
    
    
}

- (void)getFrameInfo:(CFDataRef)data
              frames:(NSMutableArray *)frames
          delayTimes:(NSMutableArray *)delayTimes
           totaltime:(CGFloat *)totalTime
               width:(CGFloat *)width
              height:(CGFloat *)height{
    NSLog(@"%s", __func__);
    CGImageSourceRef gifSource = CGImageSourceCreateWithData(data, NULL);
    
    // get frame count
    size_t frameCount = CGImageSourceGetCount(gifSource);
    for (size_t i = 0; i < frameCount; ++i) {
        // get each frame
        CGImageRef frame = CGImageSourceCreateImageAtIndex(gifSource, i, NULL);
        [frames addObject:(id)frame];
        CGImageRelease(frame);
        
        // get gif info with each frame
        NSDictionary *dict = (NSDictionary*)CGImageSourceCopyPropertiesAtIndex(gifSource, i, NULL);
        NSLog(@"kCGImagePropertyGIFDictionary %@", [dict valueForKey:(NSString*)kCGImagePropertyGIFDictionary]);
        
        // get gif size
        if (width != NULL && height != NULL) {
            *width = [[dict valueForKey:(NSString*)kCGImagePropertyPixelWidth] floatValue];
            *height = [[dict valueForKey:(NSString*)kCGImagePropertyPixelHeight] floatValue];
        }
        
        NSDictionary *gifDict = [dict valueForKey:(NSString*)kCGImagePropertyGIFDictionary];
        if (gifDict == nil) {
            NSLog(@"IT IS NOT GIF!");
            [frames removeAllObjects];
            [delayTimes removeAllObjects];
            CFRelease(gifSource);
            return;
        }
        [delayTimes addObject:[gifDict valueForKey:(NSString*)kCGImagePropertyGIFDelayTime]];
        
        if (totalTime) {
            NSLog(@"%f",*totalTime);
            *totalTime = *totalTime + [[gifDict valueForKey:(NSString*)kCGImagePropertyGIFDelayTime] floatValue];
        }
    }
    
    CFRelease(gifSource);
    
}

- (void)setGif:(NSString *)filename{
    
    NSLog(@"%s", __func__);
    
    if (!(filename == nil || [filename isEqualToString:@""])) {
        _defaultImageView.hidden = YES;
    }
    
    [self stopGif];
    
    NSURL *fileUrl = [[NSBundle mainBundle] URLForResource:filename withExtension:@"gif"];
    NSData *data = [NSData dataWithContentsOfURL:fileUrl];
    
    if (nil == _gifFrames) {
        _gifFrames = [[NSMutableArray alloc] init];
    }
    else{
        [_gifFrames removeAllObjects];
    }
    
    if (nil == _gifFrameDelayTimes) {
        _gifFrameDelayTimes = [[NSMutableArray alloc] init];
    }
    else{
        [_gifFrameDelayTimes removeAllObjects];
    }
    
    CGFloat width = 0;
    CGFloat height = 0;
    _totalTime = 0;
    
    [self getFrameInfo:(CFDataRef)data
                frames:_gifFrames
            delayTimes:_gifFrameDelayTimes
             totaltime:&_totalTime
                 width:&width
                height:&height];
    
    if (_gifFrames.count == 0 || _gifFrameDelayTimes.count == 0) {
        [self   performSelectorOnMainThread :@selector(presentImage:)
                withObject                  :data
                waitUntilDone               :YES];
        return;
    }
    [self startGif];
    
}

- (void)startGif
{
    NSLog(@"%s", __func__);
    int count = _gifFrameDelayTimes.count;
    
    NSMutableArray *images = [NSMutableArray arrayWithCapacity:3];
    for (int i = 0; i < count; ++i) {
        [images addObject:[UIImage imageWithCGImage:(CGImageRef)[_gifFrames objectAtIndex:i] scale:2.f orientation:UIImageOrientationUp]];
    }
    
    self.animationImages = images;
    self.animationDuration = (self.gifDuration < 0 ? _totalTime : self.gifDuration);
    self.animationRepeatCount = self.gifRepeatCount;
    
    self.image = [UIImage imageWithCGImage:(CGImageRef)[_gifFrames objectAtIndex:0] scale:2.f orientation:UIImageOrientationUp];
    
    [self startAnimating];
    
}

- (void)stopGif
{
    NSLog(@"%s", __func__);
    if ([self isAnimating]) {
        [self stopAnimating];
    }
}

- (void)setConcurrent:(BOOL)b
{
    _flags.sConcurrent = b;
}

- (void)enableUserInteraction:(BOOL)b
{
    self.userInteractionEnabled = b;
}

- (void)reloadFromDiskIfHad
{
    NSLog(@"%s", __func__);
    if (_flags.sInLoading) {
        return;
    }

    if (nil == self.image) {
        NSData *data = [[TFCache shared] objectForKey:self.cacheIdentifier];
        [self setImage:[UIImage imageWithData:data]];
    }
}

- (void)cancelImageDownload
{
}


@dynamic controllerTag;
@synthesize cacheIdentifier;
@synthesize touchDelegate;
@synthesize weakExtra;
@synthesize selected;
@synthesize imageStyle;
@synthesize reuse;
@synthesize isDLImg;
@synthesize url = _url;
@synthesize cacheImg;
@end