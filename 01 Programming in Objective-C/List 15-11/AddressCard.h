//
//  AddressCard.h
//  Programming in Objective-C
//
//  Created by 张思琦 on 15/6/24.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AddressCard : NSObject

@property (copy, nonatomic)NSString *name, *email;

- (void)print;
- (void)setName:(NSString *)theName andEmail:(NSString *)theEmail;

@end