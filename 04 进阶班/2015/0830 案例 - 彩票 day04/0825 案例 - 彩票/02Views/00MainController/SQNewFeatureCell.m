//
//  SQNewFeatureCell.m
//  0825 案例 - 彩票
//
//  Created by 张思琦 on 15/8/27.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import "SQNewFeatureCell.h"
#import "SQMainTabBarController.h"

@interface SQNewFeatureCell ()

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) UIButton *startButton;


@end

@implementation SQNewFeatureCell



/****************************** 设置cell的ImageView ***************/
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
//设置相框
- (UIImageView *)imageView{
    if (_imageView == nil) {
        //根据image创建imageView
        _imageView = [[UIImageView alloc] initWithImage:self.image];
        self.imageView.frame = self.bounds;

        //添加imageView到contentView中
        [self.contentView addSubview:_imageView];
        //跳转imageView与contentView大小相同
        //[_imageView sizeToFit];
    }
    return _imageView;
}
//设置图片
- (void)setImage:(UIImage *)image
{
    _image = image;
    self.imageView.image = image;
}



/****************************  设置startButton  ************************************/
//获得当前cell的序号
- (void)setIndexPath:(NSIndexPath *)indexPath count:(int)count
{
    //设置cell的Button的hidden属性
    //当到达第4张时,显示button
    if (indexPath.row == count - 1) {
        self.startButton.hidden = NO;
    }else
    {
        self.startButton.hidden = YES;
    }

}

//startButton的懒加载
- (UIButton *)startButton{

    if(_startButton == nil){
        
        _startButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [_startButton setBackgroundImage:[UIImage imageNamed:@"guideStart"] forState:UIControlStateNormal];
       
        //设置size
        [_startButton sizeToFit];
        //设置origin
        //设置参数时尽量使用绝对数值,不要使用相对数值
        //_startButton.center = CGPointMake(self.center.x, self.bounds.size.height * 0.85);
        _startButton.center = CGPointMake(self.bounds.size.width * 0.5, self.bounds.size.height * 0.85);
        //设置button的行为
        [_startButton addTarget:self action:@selector(action) forControlEvents:UIControlEventTouchUpInside];
        
        
        [self addSubview:_startButton];
    }
    return _startButton;

}

- (void)action
{
    //当点击开始按钮跳转到TabBarController界面
    SQMainTabBarController *mainController = [[SQMainTabBarController alloc] init];
    [UIApplication sharedApplication].keyWindow.rootViewController = mainController;
}



@end
