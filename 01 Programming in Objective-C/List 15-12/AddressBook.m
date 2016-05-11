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


//- (void)list
//{
//    NSLog(@"=========Contents of: %@ =========",bookName);
//    
//    for (AddressCard *theCard in book )
//        NSLog(@"%-20s   %-32s", [theCard.name UTF8String],[theCard.email UTF8String]);
//    
//    NSLog(@"==================================");
//        
//}


- (void)list
{
    NSLog(@"=========Contents of: %@ =========",bookName);
    
    [self.book enumerateObjectsUsingBlock:
     ^(AddressCard *theCard, NSUInteger idx, BOOL *stop)
    {
        NSLog(@"%-20s   %-32s",[theCard.name UTF8String],[theCard.email UTF8String]);
    }
    ];
    NSLog(@"==================================");
}


@end
