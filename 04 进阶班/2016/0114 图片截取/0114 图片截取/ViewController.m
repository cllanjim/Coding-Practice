//
//  ViewController.m
//  0114 图片截取
//
//  Created by 张思琦 on 16/1/14.
//  Copyright © 2016年 SQ Software Group. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
//截取图片的起始点
@property (nonatomic, assign) CGPoint strPoint;
//蒙版
//@property (nonatomic, strong) UIView *cover;
@property (nonatomic, weak) UIView *cover;

@end

@implementation ViewController

- (UIView *)cover{
    if (_cover == nil) {
        UIView *cover = [[UIView alloc] init];
        cover.backgroundColor = [UIColor blackColor];
        cover.alpha = 0.6;
        [self.view addSubview:cover];
        _cover = cover;
    }
    return _cover;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //在imageView中添加手势
    //创建pan手势
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    //在view中添加pan手势
    [self.view addGestureRecognizer:panGestureRecognizer];
    
}

- (void)pan:(UIPanGestureRecognizer *)gestureRecognizer{
    NSLog(@"%s",__func__);
    
    //主要思路
    
    //1 计算滑动区域大小
    //获取手指在屏幕上的触点
//    CGPoint curPoint = [gestureRecognizer locationInView:self.imageView];
    
    CGPoint curPoint = [gestureRecognizer translationInView:self.view];
    
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        self.strPoint = curPoint;
    }
    
    CGFloat clipW = curPoint.x - self.strPoint.x;
    CGFloat clipH = curPoint.y - self.strPoint.y;
    CGRect clipRect = CGRectMake(self.strPoint.x, self.strPoint.y, clipW, clipH);
    
    self.cover.frame = clipRect;
    
    //2 在手指离开屏幕时进行相应的截图操作
    if(gestureRecognizer.state == UIGestureRecognizerStateEnded){
        
        //创建imageContext
        //UIGestureRecognizer的view属性是指当前手势所属的view,即target对象
        UIGraphicsBeginImageContextWithOptions(gestureRecognizer.view.bounds.size, NO, 0.0);
    
        //裁剪imageContext
        UIBezierPath *clipPath = [UIBezierPath bezierPathWithRect:clipRect];
        [clipPath addClip];
        
        //将当前imageView中的内容渲染到imageContext中
        CGContextRef imageContext = UIGraphicsGetCurrentContext();
        CALayer *vcLayer = self.imageView.layer;
        //绘制图片至imageContext
        [vcLayer renderInContext:imageContext];
        
        //获取image对象
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        
        //关闭上下文
        UIGraphicsEndImageContext();
        
        //重新赋值
        self.imageView.image = image;
        
        //移除cover
        [self.cover removeFromSuperview];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
