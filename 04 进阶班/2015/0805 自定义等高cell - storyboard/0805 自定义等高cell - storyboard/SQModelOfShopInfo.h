//
//  SQModelOfShopInfo.h
//  0805 自定义等高cell - storyboard
//
//  Created by 张思琦 on 15/8/8.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class SQModelOfShopInfo;


@interface SQModelOfShopInfo : NSObject

@property (nonatomic, copy) NSString *icon;

@property (nonatomic, copy) NSString *price;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *buyCount;

@property (nonatomic, strong) UIImage *image;


@end
