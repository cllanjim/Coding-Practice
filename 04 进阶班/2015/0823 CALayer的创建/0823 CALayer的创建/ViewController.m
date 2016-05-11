//
//  ViewController.m
//  0823 CALayer的创建
//
//  Created by 张思琦 on 15/8/23.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //创建CALayer的方法
    CALayer *myLayer = [CALayer layer];
    
    //必须设定尺寸才能显示Layer
    myLayer.frame = CGRectMake(100, 100, 100, 100);
    
    //背景颜色属性
    myLayer.backgroundColor = [UIColor redColor].CGColor;
    
    //填充内容可以是任意的,类型为id,但常见为CGImageRef
    //创建的UIImage先使用CGImage属性获得CGImageRef对象,使用(id)强制转换后才能赋值
    myLayer.contents = (id)[UIImage imageNamed:@"阿狸头像"].CGImage;
    
    //需要添加到view的layer中,使用的方法为addSublayer:
    [self.view.layer addSublayer:myLayer];
    
    // Do any additional setup after loading the view, typically from a nib.
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
