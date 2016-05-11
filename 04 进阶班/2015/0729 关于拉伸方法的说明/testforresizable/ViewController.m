//
//  ViewController.m
//  testforresizable
//
//  Created by 张思琦 on 15/7/29.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView1;

@property (weak, nonatomic) IBOutlet UIImageView *imageView2;
@property (weak, nonatomic) IBOutlet UIImageView *imageView3;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

//--imageView1的相关内容------------------------------------------------------------------------------------
    
    //相框大小为60 * 128
    //图片尺寸为60 * 128
    UIImage *testImage1 = [UIImage imageNamed:@"123456789"];
    
    testImage1 = [testImage1 resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0) resizingMode:UIImageResizingModeStretch];
    self.imageView1.image = testImage1;
    
//---imageView2的相关内容-----------------------------------------------------------------------------------
    //相框为180 * 384
    //图片尺寸为60 * 128
    //相框大小为原始图片的3倍
    //读取图片
    UIImage *testImage2 = [UIImage imageNamed:@"123456789"];
    /***********************************************/
    //resizableImageWithCapInsets默认是平铺
    //平铺的概念是保证原图像大小不变,将新图像填充满
    //testImage2 = [testImage2 resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    
    //将上部的三分之一"保护",然后进行显示
    //这代表新图像中,上部的三分之一和原图像一样,而其余部分的填充不会使用原图像上部的三分之一
    //testImage2 = [testImage2 resizableImageWithCapInsets:UIEdgeInsetsMake(42, 0, 0, 0)];
    
    //将左部的三分之一"保护",然后进行显示
    //这代表新图像中,上部的三分之一和原图像一样,而其余部分的填充不会使用原图像上部的三分之一
    //testImage2 = [testImage2 resizableImageWithCapInsets:UIEdgeInsetsMake(0, 20, 0, 0)];
    
    //将四周进行保护后
    //在X轴上
    //由于1被左边的设置保护,3被右边的设置保护,所以中间只能用2来平铺
    //同理,7和9之间的8
    //在Y轴上
    //由于1被上边的设置保护,7被下边的设置保护,所以中间只能用4来平铺
    //同理,3和9之间的6
    //由于5没有被保护,所以在整个空间中,用5进行平铺来填充剩余的区域
    testImage2 = [testImage2 resizableImageWithCapInsets:UIEdgeInsetsMake(42, 20, 42, 20)];
    /**********************************************/

    

    /***********************************************/
    //resizableImageWithCapInsets: resizingMode: 方法
    //  UIImageResizingModeTile,     平铺 (已经测试过了,)
    //  UIImageResizingModeStretch,  拉伸
    //  拉伸的概念是直接按比例将图片放大到与相框尺寸相同的图像,
    //testImage2 = [testImage2 resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0) resizingMode:UIImageResizingModeStretch];
    
    //将上部的三分之一"保护",然后进行显示
    //保证原图像上部的三分之一在Y轴上不被拉伸,其余部分按剩余比例拉伸
    //testImage2 = [testImage2 resizableImageWithCapInsets:UIEdgeInsetsMake(42, 0, 0, 0) resizingMode:UIImageResizingModeStretch];
    
    
    //将左部的三分之一"保护",然后进行显示
    //保证原图像左部的三分之一在Y轴上不被拉伸,其余部分按剩余比例拉伸
    //testImage2 = [testImage2 resizableImageWithCapInsets:UIEdgeInsetsMake(0, 20, 0, 0) resizingMode:UIImageResizingModeStretch];


    //将四周进行保护后
    //在X轴上
    //由于1被左边的设置保护,3被右边的设置保护,所以中间只能用2来拉伸
    //同理,7和9之间的8
    //在Y轴上
    //由于1被上边的设置保护,7被下边的设置保护,所以中间只能用4来拉伸
    //同理,3和9之间的6
    //由于5没有被保护,所以在整个空间中,用5进行拉伸来填充剩余的区域
    //testImage2 = [testImage2 resizableImageWithCapInsets:UIEdgeInsetsMake(42, 20, 42, 20) resizingMode:UIImageResizingModeStretch];
    
    
    //将图片添加到相框
    self.imageView2.image = testImage2;
    
//-----imageView3的相关内容----------------------------------------------------------------------------------
    
    //读取图片
    UIImage *testImage3 = [UIImage imageNamed:@"123456789"];
    
    
    /***********************************************/
    //resizableImageWithCapInsets默认是平铺
    //resizableImageWithCapInsets默认情况对比图
    testImage3 = [testImage3 resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    /***********************************************/
    
    
    /***********************************************/
    //resizableImageWithCapInsets: resizingMode: 方法
    //  UIImageResizingModeTile,     平铺 (已经测试过了,)
    //  UIImageResizingModeStretch,  拉伸
     //testImage3 = [testImage3 resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0) resizingMode:UIImageResizingModeStretch];
    /***********************************************/

    
    //将图片添加到相框
    self.imageView3.image = testImage3;
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
