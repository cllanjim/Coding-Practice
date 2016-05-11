//
//  AddressCard.h
//  Programming in Objective-C
//
//  Created by 张思琦 on 15/7/4.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AddressCard : NSObject <NSCopying,NSCoding>

@property (copy, nonatomic)NSString *name, *email;

- (void)setName:(NSString *)theName andEmail:(NSString *)theEmail;
- (NSComparisonResult)compareNames:(id)element;
- (void)print;

//添加NSCopying协议方法
- (void)assignName:(NSString *)theName andEmail:(NSString *)theEmail;

@end
