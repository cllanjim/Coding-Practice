//
//  SQHTTPSessionManager.m
//  1221 AFN使用注意事项
//
//  Created by 张思琦 on 15/12/21.
//  Copyright © 2015年 SQ Software Group. All rights reserved.
//

#import "SQHTTPSessionManager.h"

@implementation SQHTTPSessionManager

+ (instancetype)sharedSQManager{
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURL *url = [NSURL URLWithString:@"http://120.25.226.186:32812/"];
        instance = [[self alloc] initWithBaseURL:url sessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    });
    return instance;
    
}

@end
