//
//  ViewController.m
//  0827 事件的产生 传递 响应
//
//  Created by 张思琦 on 15/8/27.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *myView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//当手指触碰屏幕时调用该方法
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    
//    UITouch *myTouch = [touches anyObject];
    
    NSLog(@"%@",self);
//    NSLog(@"touches ---- %@", touches);
//    NSLog(@"event ----%@", event);

}




////当手指离开屏幕时调用该方法
//- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    [super touchesEnded:touches withEvent:event];
//    NSLog(@"移动完毕,手指离开屏幕");
//}


////当手指在屏幕上滑动时调用该方法
//- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    [super touchesMoved:touches withEvent:event];
//    
//    UITouch *myTouch = [touches anyObject];
//    
//    CGPoint myPoint = [myTouch locationInView:self.view];
//    
//    
//    self.myView.transform = CGAffineTransformTranslate(self.view, myPoint.x, myPoint.y);
//    
//    
//    
//}

@end
