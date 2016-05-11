//
//  DrawView.m
//  1229 绘制文字
//
//  Created by 张思琦 on 15/12/29.
//  Copyright © 2015年 SQ Software Group. All rights reserved.
//

#import "DrawView.h"

@implementation DrawView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    //创建文本内容
    NSString *str = @"Hello World Hello World Hello World Hello World";
    //创建富文本对象
    NSMutableDictionary *strAttr = [NSMutableDictionary dictionary];
    //设置字典属性
//    strAttr[NSFontAttributeName] = [UIFont systemFontOfSize:40];
    
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowBlurRadius = 1;
    shadow.shadowOffset = CGSizeMake(0, 10);
    shadow.shadowColor = [UIColor redColor];
    strAttr[NSShadowAttributeName]= shadow;
    //内容在一个点开始绘制，没有宽度界限
//    [str drawAtPoint:CGPointZero withAttributes:strAttr];
    //内容在一个区域开始绘制，有宽度界限
    [str drawInRect:rect withAttributes:strAttr];
}


@end
