//
//  ViewController.m
//  0822 CoreAnimation - CABasicAnimation
//
//  Created by 张思琦 on 15/8/23.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *grayView;
@property (weak, nonatomic) IBOutlet UIImageView *herat;

@end





@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    

}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //1.创建动画对象
    CABasicAnimation *heartAnim= [CABasicAnimation animation];
    
    //2.设置keyPath
    heartAnim.keyPath = @"transform";
    
    //3.设置动画参数
    heartAnim.fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(1, 1, 0)];
    heartAnim.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.5, 0.5, 0)];

    heartAnim.repeatCount = 10;
    heartAnim.duration = 1;
    
    
    
    //4.添加动画至对应的layer层
    [self.herat.layer addAnimation:heartAnim forKey:nil];
    
    

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)animationOfPosition
{
    //1.创建动画
    CABasicAnimation *basciAnimation = [CABasicAnimation animation];
    
    //2.描述要修改的动画属性
    //本质是修改要进行动画的layer层中的属性
    basciAnimation.keyPath = @"position";
    
    
    //3.修改对应的属性
    //动画的起点
    basciAnimation.fromValue = [NSValue valueWithCGPoint:CGPointMake(300, 20)];
    //动画的终点
    basciAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(20, 400)];
    
    basciAnimation.duration = 5;
    //CoreAnimation的一些关键属性
    //1.在动画完成时不要取消动画效果
    //removedOnCompletion属性默认为YES，代表动画执行完毕后就从图层上移除，图形会恢复到动画执行前的状态。
    //如果想让图层保持显示动画执行后的状态，那就设置为NO，不过还要设置fillMode为kCAFillModeForwards
    basciAnimation.removedOnCompletion = NO;
    //2.速度函数
    //首先要创建速度函数对象
    //kCAMediaTimingFunctionLinear（线性）：匀速，给你一个相对静态的感觉
    //kCAMediaTimingFunctionEaseIn（渐进）：动画缓慢进入，然后加速离开
    //kCAMediaTimingFunctionEaseOut（渐出）：动画全速进入，然后减速的到达目的地
    //kCAMediaTimingFunctionEaseInEaseOut（渐进渐出）：动画缓慢的进入，中间加速，然后减速的到达目的地。这个是默认的动画行为。
    CAMediaTimingFunction *function = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    basciAnimation.timingFunction = function;
    
    
    //3.动画永远保持最新的状态
    //fillMode决定当前对象在非active时间段的行为。比如动画开始之前或者动画结束之后
    //kCAFillModeRemoved 这个是默认值，也就是说当动画开始前和动画结束后，动画对layer都没有影响，动画结束后，layer会恢复到之前的状态
    //kCAFillModeForwards 当动画结束后，layer会一直保持着动画最后的状态
    //kCAFillModeBackwards 在动画开始前，只需要将动画加入了一个layer，layer便立即进入动画的初始状态并等待动画开始。
    //kCAFillModeBoth 这个其实就是上面两个的合成.动画加入后开始之前，layer便处于动画初始状态，动画结束后layer保持动画最后的状态
    
    //    basciAnimation.fillMode = kCAFillModeRemoved;
    basciAnimation.fillMode = kCAFillModeForwards;
    //    basciAnimation.fillMode = kCAFillModeBackwards;
    //    basciAnimation.fillMode = kCAFillModeBoth;
    
    //4.添加动画
    [self.grayView.layer addAnimation:basciAnimation forKey:nil];

}


- (void)automacros{
    
#define showlist(...) puts(#__VA_ARGS__)
    showlist();
    showlist(1, "X", int);

#define ZSQ(number1, number2) number1##number2
    NSLog(@"%d", ZSQ(5,6));
    
#define property(objc,property) @(((void)objc.property, #property))
    property(self.view, frame);
    NSLog(@"%@", property(self.view, frame));
    
}

@end
