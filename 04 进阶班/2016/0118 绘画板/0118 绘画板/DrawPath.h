//
//  DrawPath.h
//  0118 绘画板
//
//  Created by 张思琦 on 16/1/18.
//  Copyright © 2016年 SQ Software Group. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DrawPath : UIBezierPath

/**
 *  设置lineColor属性是为了保存当前线条的颜色，便于在绘制时确认当前线条的颜色
 */
@property (nonatomic, strong) UIColor *lineColor;

+ (instancetype)drawPathWithLineColor:(UIColor *)color;

@end
