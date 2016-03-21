//
//  TFURLConnection.m
//  tfcommon
//
//  Created by yin shen on 2/21/14.
//
//

#import "TFURLConnection.h"

@implementation TFURLConnection

- (void)dealloc{
    self.httpData = nil;
    [super dealloc];
}

@synthesize httpData;

@end
