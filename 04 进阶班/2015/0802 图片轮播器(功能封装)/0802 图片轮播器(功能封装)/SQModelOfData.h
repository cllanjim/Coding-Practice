//
//  SQModelOfData.h
//  0802 图片轮播器(功能封装)
//
//  Created by 张思琦 on 15/8/6.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SQModelOfData : NSObject

//提取字典中的图片名
@property (nonatomic, strong) NSString *imageName;
//根据字典中的图片名生成图片
@property (nonatomic, strong) UIImage *image;
//根据图片生成ImageView
@property (nonatomic, strong) UIImageView *imageView;




//提供自定义构造方法
- (instancetype)initWithDict:(NSDictionary *)dict;

//提供类工厂方法
+ (instancetype)modelOfDataWithDict:(NSDictionary *)dict;

//返回保存着一组imageView的数组
+ (NSArray *)groupOfImageView;
@end
