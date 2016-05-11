//
//  ViewController.m
//  0828 手势处理事件
//
//  Created by 张思琦 on 15/8/28.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *myImageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //[self setUpTapping];
    //[self setUpPanning];
    //[self setUpLongPress];
    //[self setUpSwiping];
    
    
    
    [self setUpPinching];
    [self setUpRotating];
    
    
    
    
    // Do any additional setup after loading the view, typically from a nib.
}

#pragma mark - UIGestureRecognizerDelegate代理方法

//- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
//{
//    return NO;
//}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}





/*********************** Tap手势 ***********************/
//Tapping
- (void)setUpTapping{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    tap.delegate = self;
    [self.myImageView addGestureRecognizer:tap];
    
}

- (void)tap:(UITapGestureRecognizer *)tap
{
    //需要点击几次触发当前手势
    NSLog(@"%li", tap.numberOfTapsRequired);
    //需要几根手指点击触发当前手势
    NSLog(@"%li", tap.numberOfTouchesRequired);

}

/*********************** LongPress手势 ***********************/
- (void)setUpLongPress
{
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
    [self.myImageView addGestureRecognizer:longPress];

}

- (void)longPress:(UILongPressGestureRecognizer *)longPress
{
    //触发手势的最短时间
    NSLog(@"%f",longPress.minimumPressDuration);
    //触发手势前,手指能移动的一个范围值
    NSLog(@"%f",longPress.allowableMovement);
    

}


/*********************** swip手势 ***********************/
- (void)setUpSwiping{
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipe:)];
    
    [self.myImageView addGestureRecognizer:swipe];
    
}

- (void)swipe:(UISwipeGestureRecognizer *)swipe
{
    //触发手势的方向
    NSLog(@"%lu",(unsigned long)swipe.direction);
}


/*********************** Pan手势 ***********************/
//Panning
- (void)setUpPanning{
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [self.myImageView addGestureRecognizer:pan];
}

- (void)pan:(UIPanGestureRecognizer *)pan
{
    // translation in the coordinate system of the specified view
    //手指的滑动向量值
    CGPoint p = [pan translationInView:self.view];
    NSLog(@"%@", NSStringFromCGPoint(p));
    
    //备注:CGAffineTransformMakeTranslation方法是根据view原始位置做形变
    //重新开始pan手势时其移动向量会重新从0计算,
    //CGAffineTransformMakeTranslation方法会根据myImageView的原始位置移动,
    //由于移动向量一开始为0,myImageView会突然返回到初始位置,并不能从上次移动位置的重点继续移动
    //self.myImageView.transform = CGAffineTransformMakeTranslation(p.x, p.y);
    
    //备注:CGAffineTransformTranslate是根据传入的transform参数位置继续做形变
    //在一次连续不间断的滑动过程中,pan手势会持续计算手势的偏移向量,其偏移距离为初始点到终点的距离
    //CGAffineTransformTranslate方法会根据上一次的形变做移动
    //举例:当在一次滑动过程中,从A点起始, 到达B点,终点为C点,pan手势不失效
    //当从B点到C点滑动时,myImageView的移动向量并没有根据B点重新计算,仍然会根据A点的偏移量移动
    //这回造成图像的移动距离不准确
    self.myImageView.transform = CGAffineTransformTranslate(self.myImageView.transform, p.x, p.y);
    
    //setTranslation的作用是在某个view下,为手势设置其坐标
    //下面的方法意思是在self.view中,将pan所在的位置设为CGPointZero(即原点)
    [pan setTranslation:CGPointZero inView:self.view];
    
    //注意点:
    //设置坐标和获取偏移量时,要在同一个view中
    //官方文档建议在superview中获取坐标偏移量
    //The view in whose coordinate system the translation of the pan gesture should be computed. If you want to adjust a view's location to keep it under the user's finger, request the translation in that view's superview's coordinate system.
    
}


/*********************** Pinch手势 ***********************/
//Pinching
- (void)setUpPinching{
    UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinch:)];
    pinch.delegate = self;
    [self.myImageView addGestureRecognizer:pinch];
}

- (void)pinch:(UIPinchGestureRecognizer *)pinch
{
    
    //触摸点相对于屏幕坐标系的缩放系数
    NSLog(@"%f", pinch.scale);
    //缩放的速度
    NSLog(@"%f", pinch.velocity);
    
    //获取缩放系数
    CGFloat scale = pinch.scale;
    //利用Transform矩阵完成缩放
    self.myImageView.transform = CGAffineTransformScale(self.myImageView.transform, scale, scale);
    //缩放系数复位
    pinch.scale = 1;
    
}


/*********************** Rotating手势 ***********************/
//Rotating
- (void)setUpRotating{
    UIRotationGestureRecognizer *rotate = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotate:)];
    rotate.delegate = self;
    [self.myImageView addGestureRecognizer:rotate];
}

- (void)rotate:(UIRotationGestureRecognizer *)rotate
{
    //触摸点相对于屏幕坐标系的旋转角度
    NSLog(@"%f", rotate.rotation);
    //缩放的速度
    NSLog(@"%f", rotate.velocity);
    
    //获取旋转角度
    CGFloat rotation = rotate.rotation;
    //利用Transform矩阵完成旋转
    self.myImageView.transform = CGAffineTransformRotate(self.myImageView.transform, rotation);
    //旋转角度复位
    rotate.rotation = 0;
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
