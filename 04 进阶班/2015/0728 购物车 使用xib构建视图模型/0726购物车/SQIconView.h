//
//  SQIconView.h
//  0726购物车
//
//  Created by 张思琦 on 15/7/27.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SQIconDateModel.h"

@interface SQIconView : UIView

@property (nonatomic, strong) SQIconDateModel *iconDateModel;

//自定义构造方法
- (instancetype)initWithIconDateModel:(SQIconDateModel *)iconDateModel;

//类工厂方法
+ (instancetype)iconViewWithIconDateMoedl:(SQIconDateModel *)iconDateModel;



@end
