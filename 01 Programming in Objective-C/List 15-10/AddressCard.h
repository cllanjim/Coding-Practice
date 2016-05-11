//
//  AddressCard.h
//  Programming in Objective-C
//
//  Created by 张思琦 on 15/6/22.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AddressCard : NSObject

- (void)setName:(NSString *)theName;
- (void)setEmail:(NSString *)theEmail;
- (NSString *)name;
- (NSString *)email;

- (void)print;
@end
