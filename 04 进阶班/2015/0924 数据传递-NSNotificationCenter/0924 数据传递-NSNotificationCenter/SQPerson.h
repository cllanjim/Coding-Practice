//
//  SQPerson.h
//  0924 数据传递-NSNotificationCenter
//
//  Created by 张思琦 on 15/9/24.
//  Copyright © 2015年 SQ Software Group. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SQPerson : NSObject

@property (nonatomic, strong) NSString *name;

- (void)receiveNews:(NSString *)name;

@end
