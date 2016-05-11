//
//  SQTitleViewButton.m
//  1105 BaiSiBuDeJie
//
//  Created by 张思琦 on 16/3/8.
//  Copyright © 2016年 SQ Software Group. All rights reserved.
//

#import "SQTitleViewButton.h"

@implementation SQTitleViewButton

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        //方法二
        //正常状态下为深灰色
        [self setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        //选中状态下为红色
        [self setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        
        //方法三
//        //正常状态下为深灰色
//        [self setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
//        //disabled状态下为红色
//        [self setTitleColor:[UIColor redColor] forState:UIControlStateDisabled];
        
        //设置字体大小
        self.titleLabel.font = [UIFont systemFontOfSize:14];
    }
    return self;
}

- (void)setHighlighted:(BOOL)highlighted{
    //不写任何代码,用于改变系统默认做法
}

@end
