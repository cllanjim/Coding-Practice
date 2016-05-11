//
//  UITextField+SQTextFieldExtension.m
//  1105 BaiSiBuDeJie
//
//  Created by 张思琦 on 15/11/28.
//  Copyright © 2015年 SQ Software Group. All rights reserved.
//

#import "UITextField+SQTextFieldExtension.h"

static NSString * const SQPlaceholderColorKey = @"placeholderLabel.textColor";


@implementation UITextField (SQTextFieldExtension)

- (void)setPlaceholderColor:(UIColor *)placeholderColor{

    //判断文字长度并提前设置占位符文字
    //如果当前textFiled中placeholder没有实例化
    if (self.placeholder.length == 0) {
        //因为placeholder为懒加载，如果不提前生成的话，直接对其placeholderColor赋值会失效
        //所以在赋值前应当提前加载placeHolder,使其实例化
        self.placeholder = @" ";
        //对于length为0的placeholder恢复初始状态,即nil
        self.placeholder = nil;
    }
    
    //如果将placeholderColor设置为空,应当将其恢复系统设置的灰色
    //由于placeholder为nil时,字体为黑色
    //所以需要改变传入的参数placeholderColor
    if (placeholderColor == nil) {
        placeholderColor = [UIColor colorWithRed:0 green:0 blue:0.0980392 alpha:0.22];
    }
    
    //设置placeholderColor的颜色
    [self setValue:placeholderColor forKeyPath:SQPlaceholderColorKey];
}


- (UIColor *)placeholderColor{
    return [self valueForKeyPath:SQPlaceholderColorKey];
}

@end
