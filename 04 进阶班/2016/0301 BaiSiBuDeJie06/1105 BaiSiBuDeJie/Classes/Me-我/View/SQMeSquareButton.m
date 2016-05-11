//
//  SQMeSquareButton.m
//  1105 BaiSiBuDeJie
//
//  Created by 张思琦 on 16/2/18.
//  Copyright © 2016年 SQ Software Group. All rights reserved.
//

#import "SQMeSquareButton.h"
#import <SDWebImage/UIButton+WebCache.h>


@implementation SQMeSquareButton

#pragma mark - 初始化button
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setupButton];
    }
    return self;
}

- (void)awakeFromNib{
    [self setupButton];
}

- (void)setupButton{
    //文字居中
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    //文字大小
    self.titleLabel.font = [UIFont systemFontOfSize:15];
    //设置字体颜色
    [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    //设置背景图片
//    [self setBackgroundColor:[UIColor whiteColor]];
    [self setBackgroundImage:[UIImage imageNamed:@"mainCellBackground"] forState:UIControlStateNormal];
}

#pragma mark - 布局子控件

- (void)layoutSubviews{
    [super layoutSubviews];
    //布局imageView
    self.imageView.sq_y = self.sq_height * 0.15;
    self.imageView.sq_height = self.sq_height * 0.5;
    self.imageView.sq_width = self.sq_width * 0.5;
    self.imageView.sq_centerX = self.sq_width * 0.5;
    //布局titleLabel
    self.titleLabel.sq_x = 0;
    self.titleLabel.sq_y = self.imageView.sq_bottom;
    self.titleLabel.sq_width = self.sq_width;
    self.titleLabel.sq_height = self.sq_height - self.titleLabel.sq_y;
    
}


- (void)setModelData:(SQMeSquareModel *)modelData{
    
    _modelData = modelData;
    //设置button的title
    [self setTitle:modelData.name forState:UIControlStateNormal];
    
    //设置button的image
    //方法一
    //        //使用AFNetworking的UIButton+AFNetworking.h文件设置图片
    //        [button setImageForState:UIControlStateNormal withURL:[NSURL URLWithString:modelData.icon] placeholderImage:[UIImage imageNamed:@"chose_tag_close_icon"]];
    //方法二
    //使用SDWebImage的UIButton+WebCache.h文件设置图片
    [self sd_setImageWithURL:[NSURL URLWithString:modelData.icon] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"chose_tag_close_icon"]];
}

@end
