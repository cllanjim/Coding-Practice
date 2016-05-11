//
//  UIImage+clipImageWithCircleShape.h
//  0113 图片剪裁
//
//  Created by 张思琦 on 16/1/13.
//  Copyright © 2016年 SQ Software Group. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (clipImageWithCircleShape)

+ (UIImage *)clipImage:(NSString *)imageName withCircleWidth:(CGFloat)width withCircleColor:(UIColor *)color;

@end
