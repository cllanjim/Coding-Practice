//
//  AddressCard.h
//  Programming in Objective-C
//
//  Created by 张思琦 on 15/6/25.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AddressCard : NSObject

@property (copy,nonatomic) NSString *name, *email;

- (instancetype)initWithName:(NSString *)theName andEmail:(NSString *)theEmail;
- (void)setName:(NSString *)theName andEmail:(NSString *)theEmail;
- (void)print;


@end