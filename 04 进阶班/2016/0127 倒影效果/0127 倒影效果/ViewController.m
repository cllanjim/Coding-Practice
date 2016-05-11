//
//  ViewController.m
//  0127 倒影效果
//
//  Created by 张思琦 on 16/1/27.
//  Copyright © 2016年 SQ Software Group. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //取出当前的复制层
    CAReplicatorLayer *replicatorLayer = (CAReplicatorLayer *)self.view.layer;
    replicatorLayer.instanceCount = 2;
    
    
    //围绕父层的锚点旋转
    //旋转60度
    replicatorLayer.instanceTransform = CATransform3DMakeRotation(M_PI / 4, 0, 0, 1);
    
    
    
//    replicatorLayer.instanceTransform = CATransform3DRotate(replicatorLayer.instanceTransform, M_PI/4, 1, 0, 0);

    
    replicatorLayer.instanceRedOffset -= 0.1;
    replicatorLayer.instanceGreenOffset -= 0.1;
    replicatorLayer.instanceBlueOffset -= 0.1;
    replicatorLayer.instanceAlphaOffset -= 0.1;
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
