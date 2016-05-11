//
//  AddressBook.h
//  Programming in Objective-C
//
//  Created by 张思琦 on 15/6/25.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AddressCard.h"

@interface AddressBook : NSObject

@property (nonatomic,copy)NSString *bookName;
@property (nonatomic,strong)NSMutableArray *book;

- (instancetype)initWithName:(NSString *)name;
- (void)addCard:(AddressCard *)theCard;
- (NSUInteger)entries;
- (void)list;
- (AddressCard *)lookup:(NSString *)theName;


@end
