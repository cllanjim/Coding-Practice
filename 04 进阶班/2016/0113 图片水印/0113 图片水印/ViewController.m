//
//  ViewController.m
//  0113 图片水印
//
//  Created by 张思琦 on 16/1/13.
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

//单击后生成带有水印的图片
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //获取图片
    UIImage *imageToShow = [UIImage imageNamed:@"小黄人"];
    
    //获取image的上下文
    //创建一个image的图像上下文
    //CGSize size 表示图形上下文的大小
    //BOOL opaque 表示不透明度 (YES不透明 NO透明)
        //在view中使用透明度
        //在GraphicsContext中使用不透明度
    //CGFloat scale 表示图片的缩放比例因子
        //如果将scale的值设为0,则代表图片与设备主屏幕一样大
    UIGraphicsBeginImageContextWithOptions(imageToShow.size, NO, 0.0);
    
    //将图片绘制到imageContext中
    [imageToShow drawAtPoint:CGPointZero];
    
    //在image的上下文中添加水印
    NSString *stringToAdd = [NSString stringWithFormat:@"Design By SketchK"];
    NSDictionary *attributes = @{
                                 NSForegroundColorAttributeName:[UIColor redColor],
//                                 NSFontAttributeName:@16
                                 };
    [stringToAdd drawAtPoint:CGPointZero withAttributes:attributes];
    
    //从image的上下文中获取最终的image图像
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    //关闭imageContext
    UIGraphicsEndImageContext();
    
    
    /***************** 输出image图像至桌面 ******************/
    //NSData * UIImagePNGRepresentation (UIImage *image); image为需要转换的图像对象
    //NSData * UIImageJPEGRepresentation (UIImage *image,CGFloat compressionQuality); image为需要转换的图像对象  compressionQuality为图片压缩质量,0-1,当为1时压缩质量最好
    
    NSData *data = UIImagePNGRepresentation(image);
    //NSData *data = UIImageJPEGRepresentation(image, 1.0);
    
    [data writeToFile:@"/Users/SketchK/Desktop/1.png" atomically:YES];
    
}



@end
