//
//  SQCellModel.h
//  0915 不等高cell - frame搭建
//
//  Created by 张思琦 on 15/9/15.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SQCellModel : NSObject


/**
 *  姓名
 */
@property (nonatomic, strong)NSString *name_Label_text;
/**
 *  正文
 */
@property (nonatomic, strong) NSString *text_Label_text;
/**
 *  头像
 */
@property (nonatomic, strong) NSString *user_ImageView_ImageName;
/**
 *  配图
 */
@property (nonatomic, strong) NSString *text_ImageView_ImageName;
/**
 *  会员
 */
@property (nonatomic, assign) BOOL isVIP;

//控件的frame值
@property (nonatomic, assign) CGRect name_Label_frame;
@property (nonatomic, assign) CGRect user_ImageView_frame;
@property (nonatomic, assign) CGRect text_Label_frame;
@property (nonatomic, assign) CGRect text_ImageView_frame;
@property (nonatomic, assign) CGRect vip_ImageView_frame;

//控件的cellHeight值
@property (nonatomic, assign) CGFloat cellHeight;

@end
