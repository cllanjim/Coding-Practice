//
//  ViewController.m
//  0114 图片擦除
//
//  Created by 张思琦 on 16/1/14.
//  Copyright © 2016年 SQ Software Group. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *frontImageView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //创建pan手势
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [self.frontImageView addGestureRecognizer:pan];
    
}

- (void)pan:(UIPanGestureRecognizer *)gestutre{
    //获取当前触摸点
    CGPoint curPoint = [gestutre locationInView:self.view];
    //确定擦除区域
    CGFloat distance = 30;
    CGFloat x = curPoint.x - distance * 0.5;
    CGFloat y = curPoint.y - distance * 0.5;
    
    CGRect clipRect = CGRectMake(x, y, distance, distance);
    
    //创建imageContext
    UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, NO , 0.0);
    
    //将imageView的layer渲染到imageContext中
    //获取imageContext
    CGContextRef imageContext = UIGraphicsGetCurrentContext();
    //获取当前imageView的layer
    CALayer *ivLayer = gestutre.view.layer;
    [ivLayer renderInContext:imageContext];
    
    //清除imageContext
    CGContextClearRect(imageContext, clipRect);
    
    //从imageContext中获取image对象
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    //关闭上下文
    UIGraphicsEndImageContext();
    
    
    self.frontImageView.image = image;
    
    

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
