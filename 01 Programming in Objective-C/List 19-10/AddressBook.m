//
//  AddressBook.m
//  Programming in Objective-C
//
//  Created by 张思琦 on 15/7/4.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import "AddressBook.h"

@implementation AddressBook

@synthesize book,bookName;

#pragma mark - init方法

- (instancetype)initWithName:(NSString *)name
{
    self = [super init];
    if (self) {
        bookName = [NSString stringWithString:name];
        book = [NSMutableArray array];
    }
    return self;
}

//init重写当前类的init方法,并让之后被继承的类能够返回正确的对象类型
- (instancetype)init
{
    return [self initWithName:@"Unnamed Book"];
}

#pragma mark - setter方法

//重写setBook的方法,以便创建一个可变的副本,电话簿内容需要更改,且声明中没有copy
- (void)setBook:(NSArray *)thebook
{
    book = [thebook mutableCopy];
}

#pragma mark - sort方法


- (void)sort
{
    [book sortUsingSelector:@selector(compareNames:)];
}

- (void)sort2
{
    [book sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [[obj1 name] compare:[obj2 name]];
    }];
}

#pragma mark - add和remove方法

- (void)addCard:(AddressCard *)theCard
{
    [book addObject:theCard];
}

- (void)removeCard:(AddressCard *)theCard
{
    [book removeObjectIdenticalTo:theCard];
}

#pragma mark - 计算book中card数量的方法

-(NSUInteger)entries
{
    return [book count];
}

#pragma mark - List方法

- (void)list
{
    NSLog(@"=========Contents of: %@ =========",bookName);
    
    for (AddressCard *theCard in book )
        NSLog(@"%-20s   %-32s", [theCard.name UTF8String],[theCard.email UTF8String]);
    
    NSLog(@"==================================");
    
}

#pragma mark - Lookup方法

- (AddressCard *)lookup:(NSString *)theName
{
    for (AddressCard *nextCard in book) {
        if ([[nextCard name] caseInsensitiveCompare:theName] == NSOrderedSame) {
            return nextCard;
        }
    }
    return nil;
}

#pragma mark - 编码与解码方法
//NSCoding中的编码方法
- (void)encodeWithCoder:(NSCoder *)enCoder
{
    [enCoder encodeObject:bookName forKey:@"AddressBookBookName"];
    [enCoder encodeObject:book forKey:@"AddressBookBook"];
}

//NSCoding中的解码方法
- (id)initWithCoder:(NSCoder *)decoder
{
    bookName = [decoder decodeObjectForKey:@"AddressBookBookName"];
    book = [decoder decodeObjectForKey:@"AddressBookBook"];
    return self;
}

#pragma mark - copyWithZone方法

- (id)copyWithZone:(NSZone *)zone
{
    id newBook = [[[self class] allocWithZone:zone] init];
    //bookName属性因为不可变,可使用浅复制也可以使用直接赋值
    [newBook setBookName:bookName];
    //book属性因为可变的,要使用浅复制
    [newBook setBook:book];
    return newBook;
}


@end
