//
//  ViewController.m
//  0114 屏幕截屏
//
//  Created by 张思琦 on 16/1/14.
//  Copyright © 2016年 SQ Software Group. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//实现的功能为点击屏幕就在桌面保存当前屏幕截图
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    //1 创建imageContext
    UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, YES, 0.0);
    //2 获取当前imageContext对象
    CGContextRef imageContext = UIGraphicsGetCurrentContext();
    
    //3 获取当前view的图层信息
    CALayer *vcCalayer = self.view.layer;
    //4 将图层渲染到imageContext上
    [vcCalayer renderInContext:imageContext];
    
    
    //5 从imageContext中获取图片文件
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    //6 关闭上下文
    UIGraphicsEndImageContext();
    
    
    /*************** 转换image对象为二进制码 ****************/
    NSData *data = UIImageJPEGRepresentation(image, 1.0);
    [data writeToFile:@"/Users/SketchK/Desktop/1.jpeg" atomically:YES];
    
}



@end
