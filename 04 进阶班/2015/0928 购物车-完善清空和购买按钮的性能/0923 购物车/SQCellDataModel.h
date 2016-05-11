//
//  SQCellDataModel.h
//  0923 购物车
//
//  Created by 张思琦 on 15/9/23.
//  Copyright © 2015年 SQ Software Group. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SQCellDataModel : NSObject

@property (nonatomic, strong) NSString *image;
@property (nonatomic, strong) NSString *money;
@property (nonatomic, strong) NSString *name;

//酒的数量
@property (nonatomic, assign) int count;

@end
