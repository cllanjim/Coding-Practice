//
//  UIImage+SQImageExtension.m
//  1105 BaiSiBuDeJie
//
//  Created by 张思琦 on 16/4/14.
//  Copyright © 2016年 SQ Software Group. All rights reserved.
//

#import "UIImage+SQImageExtension.h"

@implementation UIImage (SQImageExtension)

- (instancetype)sq_circleImage{
    
    //开启图形上下文
    UIGraphicsBeginImageContext(self.size);
    
    //获取上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    //设定矩形框
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    //在指定的图形上下文中,根据矩形框添加圆形
    CGContextAddEllipseInRect(ctx, rect);
    
    //裁剪上下文
    CGContextClip(ctx);
    
    //绘制图片到上下文
    [self drawInRect:rect];
    
    //获取图片对象,并赋值
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    //关闭上下文
    UIGraphicsEndImageContext();
    
    return image;

}

+ (instancetype)sq_circleImageWithImageNamed:(NSString *)imageName{
    return [[self imageNamed:imageName] sq_circleImage];
}

@end
