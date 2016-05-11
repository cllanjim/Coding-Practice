//
//  SQModelOfShopInfo.m
//  0805 自定义等高cell - atuolayout方法
//
//  Created by 张思琦 on 15/8/8.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import "SQModelOfShopInfo.h"
#import "MJExtension.h"

@implementation SQModelOfShopInfo

+ (NSArray *)groupOfShopInfo{
    return [SQModelOfShopInfo objectArrayWithFilename:@"tgs.plist"];
}

- (UIImage *)image{
    return [UIImage imageNamed:self.icon];
}

@end
