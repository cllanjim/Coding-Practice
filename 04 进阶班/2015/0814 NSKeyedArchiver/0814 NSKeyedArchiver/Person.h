//
//  Person.h
//  0814 NSKeyedArchiver
//
//  Created by 张思琦 on 15/8/17.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject <NSCoding>

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *age;


@end
