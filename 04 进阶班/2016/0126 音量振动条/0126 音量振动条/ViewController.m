//
//  ViewController.m
//  0126 音量振动条
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
    
    //创建复制层
    CAReplicatorLayer *replicatorLayer = [CAReplicatorLayer layer];
    replicatorLayer.frame = self.contentView.bounds;
    //设置replicaton层中对象的份数
    replicatorLayer.instanceCount = 5;
    //设置replication的transform
    replicatorLayer.instanceTransform = CATransform3DMakeTranslation(40, 0, 0);
    //设置replication层中对象动画的延迟
    replicatorLayer.instanceDelay = 0.2;

    
    [self.contentView.layer addSublayer:replicatorLayer];
    
    //添加音量条
    CALayer *redLayer = [CALayer layer];
    redLayer.anchorPoint = CGPointMake(0, 1);
    redLayer.position = CGPointMake(0, 200);
    redLayer.bounds = CGRectMake(0, 0, 30, 150);
    redLayer.backgroundColor = [UIColor redColor].CGColor;
    [replicatorLayer addSublayer:redLayer];

    //添加动画
    CABasicAnimation *anim = [CABasicAnimation animation];
    anim.keyPath = @"transform.scale.y";
    anim.toValue = @0;
    anim.repeatCount = MAXFLOAT;
    anim.duration = .5;
    //autoreverses属性表示是否反向完成动画
    anim.autoreverses = YES;
    //addAnimation:forKey:
    //key参数用来描绘动画的关键词
    //当同时设定keyPath和key值时，优先考虑keyPath属性
    //注意点：当duration值小于0时，会改成默认值0.25或者kCATransactionAnimationDuration
    [redLayer addAnimation:anim forKey:nil];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
