//
//  SQImageView.m
//  1230 绘制文字
//
//  Created by 张思琦 on 15/12/30.
//  Copyright © 2015年 SQ Software Group. All rights reserved.
//

#import "SQImageView.h"

@implementation SQImageView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    UIImage *image = [UIImage imageNamed:@"2"];
    
    //UIRectClip函数是将GraphicsContext进行裁减
    //需要注意的是,只有在绘制图像前进行裁减才有效
//    UIRectClip(CGRectMake(0, 0, 100, 100));
    

    //方法一
    //drawAtPoint:方法会在view上绘制以原始图片尺寸为基准大小的图片,超出的部分会被裁减
//    [image drawAtPoint:CGPointZero];
    //方法二
    //drawInRect:方法会在view上绘制以rect尺寸为基准大小的图片.
    [image drawInRect:rect];
    //方法三
    //drawAtPoint:方法会在view上绘制以原始图片尺寸为基准大小的图片,
    //图片显示在rect区域里,且为平铺形式,超出的部分会被裁减.
//    [image drawAsPatternInRect:rect];
    
    //对指定区域进行填充,默认使用kCGBlendModeCopy模式
    UIRectFill(CGRectMake(0, 0, 100, 100));

}

@end
