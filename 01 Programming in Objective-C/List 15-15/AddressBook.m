//
//  AddressBook.m
//  Programming in Objective-C
//
//  Created by 张思琦 on 15/6/25.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import "AddressBook.h"

@implementation AddressBook

@synthesize bookName,book;

- (instancetype)initWithName:(NSString *)name
{
    self = [super init];
    if (self) {
        bookName = [NSString stringWithString:name];
        book = [NSMutableArray array];
    }
    return self;
}


- (instancetype)init
{
    return [self initWithName:@"NoName"];
}

- (void)addCard:(AddressCard *)theCard
{
    [book addObject:theCard];
}

- (NSUInteger)entries
{
    return [book count];
}


- (void)list
{
    NSLog(@"=========Contents of: %@ =========",bookName);
    
    for (AddressCard *theCard in book )
        NSLog(@"%-20s   %-32s", [theCard.name UTF8String],[theCard.email UTF8String]);
    
    NSLog(@"==================================");
    
}

- (AddressCard *)lookup:(NSString *)theName
{
    for (AddressCard *nextCard in book)
        if ([nextCard.name caseInsensitiveCompare:theName] == NSOrderedSame)
            return nextCard;
    return nil;
}

- (void)removeCard:(AddressCard *)theCard
{
    [book removeObjectIdenticalTo:theCard];
}

//- (void)sort
//{
//    [book sortUsingSelector:@selector(compareNames:)];
//}

//- (void) sort
//{
//    [book sortUsingComparator:
//    ^(id obj1, id obj2)
//    {
//        return [obj1 compareNames:obj2];
//    
//    }];
//}

- (void) sort
{
    [book sortUsingComparator:
    ^(id obj1, id obj2) {
        return [[obj1 name] compare:[obj2 name]];
    }];
}

@end