//
//  ViewController.m
//  0126 活动指示器
//
//  Created by 张思琦 on 16/1/26.
//  Copyright © 2016年 SQ Software Group. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIView *contentView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    CGFloat count = 10;
    CGFloat angle = 2 * M_PI / count;

    //创建复制层
    CAReplicatorLayer *replicatorLayer = [CAReplicatorLayer layer];
    replicatorLayer.frame = self.contentView.bounds;
    replicatorLayer.instanceCount = count;
    replicatorLayer.instanceDelay = 1.0 / count;
    replicatorLayer.instanceTransform = CATransform3DMakeRotation(angle, 0, 0, 1);
    [self.contentView.layer addSublayer:replicatorLayer];
    
    //添加绿色layer层
    CALayer *greenLayer = [CALayer layer];
    greenLayer.frame = CGRectMake(95, 10, 10, 10);
    greenLayer.transform = CATransform3DMakeScale(0, 0, 0);
    greenLayer.backgroundColor = [UIColor greenColor].CGColor;
    [replicatorLayer addSublayer:greenLayer];
    
    //添加动画
    CABasicAnimation *anim = [CABasicAnimation animation];
    anim.keyPath = @"transform.scale";
    anim.fromValue = @1;
    anim.toValue = @0;
    anim.repeatCount = MAXFLOAT;
    anim.duration = 1;
    [greenLayer addAnimation:anim forKey:nil];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
