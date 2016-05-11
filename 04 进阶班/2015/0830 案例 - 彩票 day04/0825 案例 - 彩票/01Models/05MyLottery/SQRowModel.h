//
//  SQRowModel.h
//  0825 案例 - 彩票
//
//  Created by 张思琦 on 15/8/30.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

@interface SQRowModel : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *subTitle;
@property (nonatomic, strong) UIImage *iconImage;

//用来保存cell点击后要执行的操作
@property (nonatomic, strong) void(^optionBlock)(NSIndexPath *indexPath);
//用来保存cell中accessoryView的样式
//@property (nonatomic, strong) UIView *accessoryView;


+ (instancetype)rowModelWithTitle:(NSString *)title subTitle:(NSString *)subTitle;


@end
