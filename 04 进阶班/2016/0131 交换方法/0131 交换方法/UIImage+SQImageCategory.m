//
//  UIImage+SQImageCategory.m
//  0131 交换方法
//
//  Created by 张思琦 on 16/1/31.
//  Copyright © 2016年 SQ Software Group. All rights reserved.
//

#import "UIImage+SQImageCategory.h"

#import <objc/message.h>

@implementation UIImage (SQImageCategory)

+ (void)load{
    //获取对象方法
    //class_getInstanceMethod(__unsafe_unretained Class cls, SEL name)
    //cls指对象的类对象
    //name指对象的方法
    
    //获取类方法
    //class_getClassMethod(__unsafe_unretained Class cls, SEL name)
    //cls指类对象
    //name指对象的方法
    
    Method imageNamed = class_getClassMethod([UIImage class], @selector(imageNamed:));
    
    Method sq_imageNamed = class_getClassMethod([UIImage class], @selector(sq_imageNamed:));
    
    //交换方法
    method_exchangeImplementations(imageNamed, sq_imageNamed);

}

+ (UIImage *)sq_imageNamed:(NSString *)imageName{
    //交换两个方法后,
    //调用新方法就等于调用原方法
    //调用原方法就等于调用新方法
    UIImage *image = [UIImage sq_imageNamed:imageName];
    
    //添加自定义内容
    if (image == nil) {
        NSLog(@"加载image为空");
    }
    
    return image;
}

@end
