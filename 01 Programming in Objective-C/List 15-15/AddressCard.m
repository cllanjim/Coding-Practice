//
//  AddressCard.m
//  Programming in Objective-C
//
//  Created by 张思琦 on 15/6/25.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import "AddressCard.h"

@implementation AddressCard

@synthesize name ,email;
- (instancetype)initWithName:(NSString *)theName andEmail:(NSString *)theMail
{
    self = [super init];
    if (self)
    {
        self.name = theName;
        self.email = theMail;
    }
    return self;
}

- (void)setName:(NSString *)theName andEmail:(NSString *)theMail
{
    self.name = theName;
    self.email = theMail;
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

- (NSComparisonResult)compareNames:(id)element
{
    return [name compare:[element name]];
}

@end
