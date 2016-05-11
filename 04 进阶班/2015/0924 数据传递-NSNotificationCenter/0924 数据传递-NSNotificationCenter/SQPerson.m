//
//  SQPerson.m
//  0924 数据传递-NSNotificationCenter
//
//  Created by 张思琦 on 15/9/24.
//  Copyright © 2015年 SQ Software Group. All rights reserved.
//

#import "SQPerson.h"

@implementation SQPerson
- (void)receiveNews:(NSNotification *)note
{
    NSLog(@"%@",note.userInfo);
}

@end
