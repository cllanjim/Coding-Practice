//
//  AddressCard.m
//  Programming in Objective-C
//
//  Created by 张思琦 on 15/6/24.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//


#import "AddressCard.h"

@implementation AddressCard

@synthesize name, email;

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

- (void)setName:(NSString *)theName andEmail:(NSString *)theEmail
{
    self.name = theName;
    self.email = theEmail;
}

@end
