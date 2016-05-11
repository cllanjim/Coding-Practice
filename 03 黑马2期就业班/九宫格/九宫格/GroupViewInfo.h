//
//  GroupViewInfo.h
//  九宫格
//
//  Created by 张思琦 on 15/7/16.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface GroupViewInfo : NSObject

@property (nonatomic, copy)NSString *name;
@property (nonatomic, copy)NSString *icon;
@property (nonatomic, strong)UIImage *iconImage;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)groupViewInfo:(NSDictionary *)dict;

+ (NSArray *)classOfGroupViewInfo;


@end
