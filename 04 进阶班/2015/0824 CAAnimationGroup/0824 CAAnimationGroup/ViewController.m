//
//  ViewController.m
//  0824 CAAnimationGroup
//
//  Created by 张思琦 on 15/8/24.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *myView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //1.创建CAAnimationGroup动画
    CAAnimationGroup *group = [CAAnimationGroup animation];
    
    //2.创建动画
    //跟随路径移动
    CAKeyframeAnimation *anim1 = [CAKeyframeAnimation animation];
    anim1.keyPath = @"position";
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:self.view.center radius:150 startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    //要将UIBeziePath路径转换为CGPath
    anim1.path = path.CGPath;
    
    //图片抖动
    CAKeyframeAnimation *anim2 = [CAKeyframeAnimation animation];
    anim2.keyPath = @"transform";
    CATransform3D a = CATransform3DMakeRotation(-M_PI_4, 0, 0, 1);
    NSValue *ratationA = [NSValue valueWithCATransform3D:a];
    CATransform3D b = CATransform3DMakeRotation(+M_PI_4, 0, 0, 1);
    NSValue *ratationB = [NSValue valueWithCATransform3D:b];
    CATransform3D c = CATransform3DMakeRotation(-M_PI_4, 0, 0, 1);
    NSValue *ratationC = [NSValue valueWithCATransform3D:c];
    
    anim2.values = @[ratationA, ratationB, ratationC];
    
    //图片缩放
    CABasicAnimation *anim3;
    anim3.keyPath = @"transform";
    anim3.fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(1, 1, 0)];
    anim3.toValue   = [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.5, 0.5, 0)];

    
    
    //3.添加动画至动画组
    
    group.duration = 4;
    group.repeatCount = MAXFLOAT;
    group.animations = @[anim1, anim2];
    
    //4.添加动画至相应的layer中
    [self.myView.layer addAnimation:group forKey:nil];
    
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
