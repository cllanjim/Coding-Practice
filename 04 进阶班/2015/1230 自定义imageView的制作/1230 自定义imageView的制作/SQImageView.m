//
//  SQImageView.m
//  1230 自定义imageView的制作
//
//  Created by 张思琦 on 15/12/30.
//  Copyright © 2015年 SQ Software Group. All rights reserved.
//

#import "SQImageView.h"

@implementation SQImageView

- (void)setImage:(UIImage *)image{
    _image = image;
    //因为drawRect：只调用一次
    //所以在赋值后，需要调用setNeedsDisplay进行刷新
    [self setNeedsDisplay];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    //可以理解为通过现有的方法获得相应的属性
    //因为imageView在获得相应的_image属性时要显示在控件上
    //所以可以通过绘制的方式将_image画在imageView上
    [_image drawInRect:rect];
}

- (instancetype)initWithImage:(UIImage *)image{
    if (self = [super init]) {
        //保存图片
        _image = image;
        //设置图片的frame
        self.frame = CGRectMake(0, 0, image.size.width, image.size.height);
    }
    
    return self;
}

@end
