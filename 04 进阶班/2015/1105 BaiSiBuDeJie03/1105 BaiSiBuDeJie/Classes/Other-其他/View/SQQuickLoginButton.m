//
//  SQQuickLoginButton.m
//  1105 BaiSiBuDeJie
//
//  Created by 张思琦 on 15/11/8.
//  Copyright © 2015年 SQ Software Group. All rights reserved.
//

#import "SQQuickLoginButton.h"

@implementation SQQuickLoginButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

//初始化控件的操作
- (void)awakeFromNib{
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
//    self.titleLabel.backgroundColor = [UIColor redColor];
//    self.imageView.backgroundColor = [UIColor greenColor];
//    self.backgroundColor = [UIColor grayColor];
}


//布局子控件的操作
- (void)layoutSubviews{
    [super layoutSubviews];
    //布局imageView
    self.imageView.sq_centerX = self.sq_width / 2;
    self.imageView.sq_y = 0;
    //布局titleLabel
    self.titleLabel.sq_y = self.imageView.sq_bottom;
    self.titleLabel.sq_x = 0;
    self.titleLabel.sq_width = self.sq_width;
    self.titleLabel.sq_height = self.sq_height - self.imageView.sq_height;
}

@end
