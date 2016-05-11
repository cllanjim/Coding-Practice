//
//  Foo.m
//  Programming in Objective-C
//
//  Created by 张思琦 on 15/7/4.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import "Foo.h"

@implementation Foo

@synthesize strVal, intVal, floatVal;

- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:strVal forKey:@"FoostrVar"];
    [encoder encodeInt:intVal forKey:@"FoointVar"];
    [encoder encodeFloat:floatVal forKey:@"FoofloatVal"];
}

- (id)initWithCoder:(NSCoder *)decoder
{
    strVal = [decoder decodeObjectForKey:@"FoostrVar"];
    intVal = [decoder decodeIntForKey:@"FoointVar"];
    floatVal = [decoder decodeFloatForKey:@"FoofloatVar"];
    return self;
}

@end
