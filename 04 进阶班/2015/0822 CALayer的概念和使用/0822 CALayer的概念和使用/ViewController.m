//
//  ViewController.m
//  0822 CALayer的概念和使用
//
//  Created by 张思琦 on 15/8/22.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIView *redView;
@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
/**************************** ImageView ***************************/
    
    //如果想对UIImageView进行圆角裁减,必须设定masksToBounds属性
    //超出Root层范围的内容会被裁减掉
    self.photoImageView.layer.masksToBounds = YES;
    //设定root层的圆角半径为50
    self.photoImageView.layer.cornerRadius = 50;
    //设定边框和颜色
    //需要注意的是,边框宽度是从外向内增加
    self.photoImageView.layer.borderColor = [UIColor blackColor].CGColor;
    self.photoImageView.layer.borderWidth = 5;

    
    
    
    
    
/******************************  view **************************/
    //阴影的不透明度 取值范围在0-1
    self.redView.layer.shadowOpacity = 1;
    //阴影的偏移位置
    self.redView.layer.shadowOffset = CGSizeMake(10, 10);
    //阴影的颜色
    //UIColor类都有CGColor属性,返回CGCOlorRef型数据
    self.redView.layer.shadowColor = [UIColor yellowColor].CGColor;
    //阴影的半径
    self.redView.layer.shadowRadius = 3;
    
    //layer的圆角半径
    self.redView.layer.cornerRadius = 50;
    
    //layer的边框宽度
    self.redView.layer.borderWidth = 5;
    //layer的边框颜色
    self.redView.layer.borderColor = [UIColor blackColor].CGColor;
    
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [UIView animateWithDuration:2 animations:^{
        //实现3维旋转
        self.photoImageView.layer.transform = CATransform3DMakeRotation(M_PI, 0, 1, 0);
        //实现3维缩放
//        self.photoImageView.layer.transform = CATransform3DMakeScale(0.5, 0.5, 1);
    }];

}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
