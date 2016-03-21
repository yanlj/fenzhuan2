//
//  _TFOPNetDispatch.h
//  tfcommon
//
//  Created by yin shen on 12/15/12.
//
//

#import <Foundation/Foundation.h>
#import "TFDispatch.h"

extern int HTTP_OK;
extern int HTTP_HEADER_ERROR;
extern int HTTP_STREAM_ERROR;

typedef enum {
    TFNetDispatchCancelPre=0x0,
    TFNetDispatchNoCancel,
}TFNetDispatchType;


typedef void(^dispatchCompletionBlock)(BOOL,void *);
@interface TFNetDispatch : TFDispatch{
    
    dispatchCompletionBlock _completionBlock;
    TFNetDispatchType netType;
    
}

@property (nonatomic,retain) NSData *postData;
@property (atomic,retain) NSMutableData *responseData;
@property (nonatomic,retain) NSString *url;
@property (nonatomic,assign) int statusCode;
@property (nonatomic,assign) double timeout;
@property (nonatomic,assign) TFNetDispatchType netType;
+ (TFNetDispatch *)quick;
- (void)dispatchNetTaskAndCompletion:(dispatchCompletionBlock) completionBlock;
- (void)netTaskDone;
- (NSString *)responseString;
@end
