//
//  SQHTTPSessionManager.h
//  1221 AFN使用注意事项
//
//  Created by 张思琦 on 15/12/21.
//  Copyright © 2015年 SQ Software Group. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface SQHTTPSessionManager : AFHTTPSessionManager

+ (instancetype)sharedSQManager;

@end
