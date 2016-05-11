//
//  SQNewFeatureCell.m
//  0825 案例 - 彩票
//
//  Created by 张思琦 on 15/8/27.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import "SQNewFeatureCell.h"

@interface SQNewFeatureCell ()

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation SQNewFeatureCell

//方法一
//- (UIImageView *)imageView
//{
//    if (_imageView == nil) {
//        //实例化imageView
//        _imageView = [[UIImageView alloc] init];
//        //保存图片至imageView
//        [self.contentView addSubview:self.imageView];
//    }
//    return _imageView;
//}
//
//- (void)setImage:(UIImage *)image
//{
//    //保存图片属性
//    _image = image;
//    self.imageView.image = image;
//
//}

//方法二
- (UIImageView *)imageView{
    if (_imageView == nil) {
        //根据image创建imageView
        _imageView = [[UIImageView alloc] initWithImage:self.image];
        //添加imageView到contentView中
        [self.contentView addSubview:_imageView];
        //跳转imageView与contentView大小相同
        //[_imageView sizeToFit];
    }
    return _imageView;
}

- (void)setImage:(UIImage *)image
{
    _image = image;
    self.imageView.image = image;
}



- (void)layoutSubviews
{
    [super layoutSubviews];
    self.imageView.frame = self.bounds;
}
@end
