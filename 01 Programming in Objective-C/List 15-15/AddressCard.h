//
//  AddressCard.h
//  Programming in Objective-C
//
//  Created by 张思琦 on 15/6/25.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AddressCard : NSObject

@property NSString *name, *email;

- (instancetype)initWithName:(NSString *)theName andEmail:(NSString *)theMail;
- (void)setName:(NSString *)theName andEmail:(NSString *)theMail;
- (void)print;
- (NSComparisonResult)compareNames:(id)element;


@end
