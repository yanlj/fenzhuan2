//
//  TFHttp.h
//  tfcommon
//
//  Created by yin shen on 12/15/12.
//
//

/*!
 *   @file          TFHTTP
 *   @discussion    ARC unsupported, last update tufu1.1.1
 *   @author        shenyin
 */
#import <Foundation/Foundation.h>

/*!
 *   @interface     TFHTTP
 *   @abstract      tufu框架http网络协议实现后台，基于CFHTTP
 */
@interface TFHTTP : NSObject

extern void TFHTTPNet2(void *objs, short *cancel_point);
extern void TFHTTPNet4(void *objs, short *cancel_point);


extern void TFHTTPNet3(void *objs, short *cancel_point);

extern void TFHTTPNet(void *objs, short *cancel_point);

extern void TFHTTPUpload(void *objs, short *cancel_point);

extern void TFImageDownload(void *objs, short *cancel_point);

extern void TFWebPImageDecode(void *objs, short *cancel_point);

@end