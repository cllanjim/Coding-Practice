//
//  ViewController.m
//  0822 隐式动画
//
//  Created by 张思琦 on 15/8/23.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIView *yellowView;
@property (nonatomic, weak) CALayer *myLayer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //创建CALayer
    CALayer *myLayer = [CALayer layer];
    
    myLayer.frame = CGRectMake(20, 20, 100, 100);
    
    myLayer.backgroundColor = [UIColor lightGrayColor].CGColor;
    
    myLayer.borderWidth = 5;
    
    myLayer.borderColor = [UIColor yellowColor].CGColor;
    
    self.myLayer = myLayer;
    
    [self.view.layer addSublayer:self.myLayer];
    
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    //开启事务
    [CATransaction begin];
    
    //设置动画时长
    [CATransaction setAnimationDuration:1];
    
    //设定动画效果
    [CATransaction setDisableActions:NO];
    
    //改变position属性
    self.myLayer.position = CGPointMake(arc4random_uniform(350), arc4random_uniform(500));
    //改变backgroundColor
    self.myLayer.backgroundColor = [self randomColor].CGColor;
    //改变圆角半径
    self.myLayer.cornerRadius = arc4random_uniform(50);
    //改变边框颜色
    self.myLayer.borderColor = [self randomColor].CGColor;
    //改变边框宽度
    self.myLayer.borderWidth = arc4random_uniform(10);

    self.yellowView.layer.position =  CGPointMake(arc4random_uniform(350), arc4random_uniform(500));
    
    [CATransaction commit];

}

- (UIColor *)randomColor{
    CGFloat r = arc4random_uniform(256) / 255.0;
    CGFloat g = arc4random_uniform(256) / 255.0;
    CGFloat b = arc4random_uniform(256) / 255.0;
    return [UIColor colorWithRed:r green:g blue:b alpha:1];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
