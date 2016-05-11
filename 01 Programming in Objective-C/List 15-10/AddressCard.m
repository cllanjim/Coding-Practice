//
//  AddressCard.m
//  Programming in Objective-C
//
//  Created by 张思琦 on 15/6/22.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import "AddressCard.h"

@implementation AddressCard
{
    NSString *name;
    NSString *email;
}


- (void)setName:(NSString *)theName
{
    if (name != theName)
    name = [NSString stringWithString:theName];
}

- (void)setEmail:(NSString *)theEmail
{
    if (email != theEmail)
    email = [NSString stringWithString:theEmail];
}

- (NSString *)name
{
    return name;
}

- (NSString *)email
{
    return email;
}

- (void)print
{
    NSLog(@"===================================");
    NSLog(@"|                                 |");
    NSLog(@"| %-31s |", [name UTF8String]);
    NSLog(@"| %-31s |", [email UTF8String]);
    NSLog(@"|                                 |");
    NSLog(@"|                                 |");
    NSLog(@"|                                 |");
    NSLog(@"|        o                     o  |");
    NSLog(@"===================================");
}

@end
