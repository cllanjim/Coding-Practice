//
//  UIImageView+SQImageViewExtension.m
//  1105 BaiSiBuDeJie
//
//  Created by 张思琦 on 16/4/14.
//  Copyright © 2016年 SQ Software Group. All rights reserved.
//

#import "UIImageView+SQImageViewExtension.h"
#import <UIImageView+WebCache.h>


@implementation UIImageView (SQImageViewExtension)

- (void)sq_setHeader:(NSString *)imageURL{
    //设置为圆形的头像
    [self sq_setCircleHeader:imageURL];
}


- (void)sq_setCircleHeader:(NSString *)imageURL{
    //返回一个圆形的占位图片
    UIImage *placeholderImage = [[UIImage imageNamed:@"defaultUserIcon"] sq_circleImage];
    //为ImageView赋值
    [self sd_setImageWithURL:[NSURL URLWithString: imageURL] placeholderImage:placeholderImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (image == nil) {
            return ;
        }
        self.image = [image sq_circleImage];
    } ];
}


- (void)sq_setRectHeader:(NSString *)imageURL{
    //返回一个圆形的占位图片
    UIImage *placeholderImage = [UIImage imageNamed:@"defaultUserIcon"] ;
    //为ImageView赋值
    [self sd_setImageWithURL:[NSURL URLWithString: imageURL] placeholderImage:placeholderImage];
}
@end
