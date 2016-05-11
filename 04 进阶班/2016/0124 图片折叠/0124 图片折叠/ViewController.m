//
//  ViewController.m
//  0124 图片折叠
//
//  Created by 张思琦 on 16/1/24.
//  Copyright © 2016年 SQ Software Group. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *upperView;
@property (weak, nonatomic) IBOutlet UIImageView *underView;

@property (weak, nonatomic) IBOutlet UIView *contentView;


@property (nonatomic, strong) CAGradientLayer *gradientLayer;

@end

@implementation ViewController

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    /******** topView的属性设置 ********/
    //contentsRect属性的作用是控制图片的显示范围
    self.upperView.layer.contentsRect = CGRectMake(0, 0, 1, 0.5);
    //设置图片的anchorPoint
    self.upperView.layer.anchorPoint = CGPointMake(0.5, 1);
    //设置图片的position
    self.upperView.layer.position = CGPointMake(100, 100);
    
    /********** bottomView的属性设置 **********/
    self.underView.layer.contentsRect = CGRectMake(0, 0.5, 1, 0.5);
    self.underView.layer.anchorPoint = CGPointMake(0.5, 0);
    self.underView.layer.position = CGPointMake(100, 100);

}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [self.contentView addGestureRecognizer:pan];

//    /******** topView的属性设置 ********/
//    //contentsRect属性的作用是控制图片的显示范围
//    self.upperView.layer.contentsRect = CGRectMake(0, 0, 1, 0.5);
//    //设置图片的anchorPoint
//    self.upperView.layer.anchorPoint = CGPointMake(0.5, 1);
//    //设置图片的position
//    self.upperView.layer.position = CGPointMake(100, 100);
//    
//    /********** bottomView的属性设置 **********/
//    self.underView.layer.contentsRect = CGRectMake(0, 0.5, 1, 0.5);
//    self.underView.layer.anchorPoint = CGPointMake(0.5, 0);
//    self.underView.layer.position = CGPointMake(100, 100);

    //创建渐变层
    CAGradientLayer *layer = [CAGradientLayer layer];
    //设置渐变层的frame
    layer.frame = self.underView.bounds;
    
    //渐变层的透明度
    layer.opacity = 0;
    
    //设置渐变层颜色组
    layer.colors = @[(id)[UIColor clearColor].CGColor,(id)[UIColor blackColor].CGColor];
    
//    //渐变层的开始位置组
//    layer.locations = @[@0.2];
//    
//    //渐变层的方向
//    layer.startPoint = CGPointMake(0, 0);
//    layer.endPoint = CGPointMake(0, 1);
//    
    self.gradientLayer = layer;
    [self.underView.layer addSublayer:layer];
    

}

- (void)pan:(UIPanGestureRecognizer *)pan{
    //获取手指移动距离
    CGPoint tranP = [pan translationInView:pan.view];
    
    //计算透明度
    self.gradientLayer.opacity = tranP.y / 200;
    
    
    //计算旋转角度
    CGFloat angle = -tranP.y / 200 * M_PI;
    
    //设置形变
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = -1 / 400.0;
    transform = CATransform3DRotate(transform, angle, 1, 0, 0);
    self.upperView.layer.transform = transform;
    
    
    //判断状态
    if(pan.state == UIGestureRecognizerStateEnded){
        
        self.gradientLayer.opacity = 0;
        
        [UIView animateWithDuration:1 delay:0 usingSpringWithDamping:0.2 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.upperView.layer.transform = CATransform3DIdentity;
        } completion:^(BOOL finished) {
        
        }];
    }
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
