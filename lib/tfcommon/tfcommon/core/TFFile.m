//
//  TFFile.m
//  tfcommon
//
//  Created by yin shen on 8/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TFFile.h"
#include <time.h>

@implementation TFFile

+ (void)appendLogs:(NSString *)logs name:(NSString *)name{
    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSString *file = [path stringByAppendingPathComponent:name];
    
    FILE *fp = fopen([file UTF8String], "a");
    if (fp) {
        time_t t = time(NULL);
        struct tm *local_t = localtime(&t);
        int year = local_t->tm_year+1900;
        int month = local_t->tm_mon+1;
        int day = local_t->tm_mday;
        int hour = local_t->tm_hour;
        int min = local_t->tm_min;
        char *zone = local_t->tm_zone;
        char t_buf[64]={0};
        sprintf(t_buf, "%d-%d-%d %d:%d %s",year,month,day,hour,min,zone);
        
        fprintf(fp, "%s\n%s\n\n",t_buf,[logs UTF8String]);
        fclose(fp);
    }
}

@end
