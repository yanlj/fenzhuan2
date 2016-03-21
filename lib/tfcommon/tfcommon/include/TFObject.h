//
//  TFObject.h
//  w
//
//  Created by yin shen on 7/19/13.
//  Copyright (c) 2013 yin shen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject(TFObject)

id tfobjc_msgSend(void *sender,SEL cmd,...);

void tfobjc_msgHandler();
@end
