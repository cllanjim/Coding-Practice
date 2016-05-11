//
//  AddressBook.h
//  Programming in Objective-C
//
//  Created by 张思琦 on 15/7/4.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AddressCard.h"

@interface AddressBook : NSObject<
    NSCoding,
    NSCopying
>

@property (nonatomic, copy)NSString *bookName;
@property (nonatomic, strong)NSMutableArray *book;


- (id)initWithName:(NSString *)name;
- (void)sort;
- (void)sort2;
- (void)addCard:(AddressCard *)theCard;
- (void)removeCard:(AddressCard *)theCard;
- (NSUInteger)entries;
- (void)list;
- (AddressCard *)lookup:(NSString *)theName;

- (void)encodeWithCoder:(NSCoder *)enCoder;
- (id)initWithCoder:(NSCoder *)decoder;


@end
