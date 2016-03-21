//
//  GCDCenter.m
//  tfcommon
//
//  Created by yin shen on 2/3/13.
//
//

#import "GCDCenter.h"

static dispatch_queue_t ioQueue = NULL;
static dispatch_queue_t imageDownloadQueue = NULL;
static dispatch_queue_t convertQueue = NULL;
static dispatch_queue_t netQueue = NULL;

@implementation GCDCenter

+ (dispatch_queue_t)getNetQueue{
    
    @synchronized(self){
        if (NULL == netQueue) {
            netQueue = dispatch_queue_create("netQueue", NULL);
        }
    }
    
    return netQueue;
}

+ (dispatch_queue_t)getIOQueue{
    
    @synchronized(self){
        if (NULL == ioQueue) {
            ioQueue = dispatch_queue_create("ioQueue", NULL);
        }
    }
    
    return ioQueue;
}

+ (dispatch_queue_t)getImageDownloadQueue{
    @synchronized(self){
        if (NULL == imageDownloadQueue) {
            imageDownloadQueue = dispatch_queue_create("imageDownloadQueue", DISPATCH_QUEUE_CONCURRENT);
        }
    }
    
    return imageDownloadQueue;
}

+ (dispatch_queue_t)getConvertQueue{
    @synchronized(self){
        if (NULL == convertQueue) {
            convertQueue = dispatch_queue_create("convertQueue", NULL);
        }
    }
    
    return convertQueue;
}

@end

