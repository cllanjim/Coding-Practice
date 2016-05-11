//
//  AddressCard.m
//  Programming in Objective-C
//
//  Created by 张思琦 on 15/7/4.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import "AddressCard.h"

@implementation AddressCard

@synthesize name, email;

//设置方法
- (void)setName:(NSString *)theName andEmail:(NSString *)theEmail
{
    self.name = theName;
    self.email = theEmail;
}

//比较方法
- (NSComparisonResult)compareNames:(id)element
{
    return [name compare:[element name]];
}

//打印方法
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

//NSCopying中规定要求实现的方法
- (id)copyWithZone:(NSZone *)zone
{
    id newCard = [[[self class] allocWithZone:zone] init];
    [newCard assignName:name andEmail:email];
    return newCard;
}


//因为name和email为不可变对象(NSString),不需要生成该对象内容的副本,仅通过保持对该对象的引用就足够
- (void)assignName:(NSString *)theName andEmail:(NSString *)theEmail
{
    name = theName;
    email = theEmail;
}

//为name和email建立编码方法
- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:name forKey:@"AddressCardName"];
    [encoder encodeObject:email forKey:@"AddressCardEmail"];
}

//为name和email建立解码方法
- (id)initWithCoder:(NSCoder *)decoder
{
    name = [decoder decodeObjectForKey:@"AddressCardName"];
    email = [decoder decodeObjectForKey:@"AddressCardEmail"];
    return self;
}
@end
