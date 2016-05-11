//
//  ViewController.m
//  CAKeyframeAnimation
//
//  Created by 张思琦 on 15/8/24.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *photo;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //1.创建动画
    CAKeyframeAnimation *roundPhoto = [CAKeyframeAnimation animation];
    
    //2.设置keyPath
    roundPhoto.keyPath = @"position";
    
    //3.修改动画参数
    //1创建路径
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:self.view.center radius:100 startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    
    roundPhoto.path = path.CGPath;
    
    //4.添加至对应的layer
    [self.photo.layer addAnimation:roundPhoto forKey:nil];

    

}


- (void)shakePhoto{

    //1.创建动画对象
    CAKeyframeAnimation *shakePhoto = [CAKeyframeAnimation animation];
    
    //2.设定keyPath
    shakePhoto.keyPath = @"transform";
    
    //3.设定动画参数
    CATransform3D a = CATransform3DMakeRotation(-M_PI_4, 0, 0, 1);
    NSValue *rotationA = [NSValue valueWithCATransform3D:a];
    CATransform3D b = CATransform3DMakeRotation( M_PI_4, 0, 0, 1);
    NSValue *rotationB = [NSValue valueWithCATransform3D:b];
    CATransform3D c = CATransform3DMakeRotation(-M_PI_4, 0, 0, 1);
    NSValue *rotationC = [NSValue valueWithCATransform3D:c];
    
    shakePhoto.values =@[rotationA,rotationB,rotationC];
    
    shakePhoto.repeatCount = MAXFLOAT;
    shakePhoto.duration =1;
    
    //4.添加动画至对应的图层
    [self.photo.layer addAnimation:shakePhoto forKey:nil];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
