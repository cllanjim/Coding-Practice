//
//  ViewController.m
//  按钮操作
//
//  Created by 张思琦 on 15/7/12.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import "ViewController.h"
//对方向键的标签进行设置
typedef enum {
    kMovingTop = 10,
    kMovingBottom,
    kMovingLeft,
    kMovingRight,
} kMovingDir;

//对放大缩小键的标签进行设置
typedef enum {
    kZoomSmall = 3,
    kZoomBig,
} kZoom;

//
#define kMovingDelta 10.0f

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIButton *picture;

@property (assign, nonatomic) CGFloat delta;

@end

@implementation ViewController

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
    //1.创建一个UIButton
    UIButton *btn = [[UIButton alloc] init];
    
    //2.设置Button的位置
    [btn setFrame:CGRectMake(110, 400, 100, 100)];
    
    //3.设置Button的背景色
    [btn setBackgroundColor:[UIColor redColor]];
    
    //4.设置Button的背景图
    [btn setBackgroundImage:[UIImage imageNamed:@"btn_01"] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:@"btn_02"] forState:UIControlStateHighlighted];
    
    //5.设置Button的文字
    [btn setTitle:@"摸我啊?" forState:UIControlStateNormal];
    [btn setTitle:@"别摸了!" forState:UIControlStateHighlighted];
    
    //6.设置Button的文字颜色
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];

    //7.设置Button的文字对齐方式
    [btn setContentVerticalAlignment:UIControlContentVerticalAlignmentBottom];
    
    //将建立好的实例Button赋值给ViewController
    self.picture = btn;
    
    //将btn添加到视图中
    //[self.view addSubview:btn];
    
    //增加不同属性的Button
//    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeContactAdd];
//    [btn1 setFrame:CGRectMake(110, 200, 100, 100)];
//    [self.view addSubview:btn1];
    

}


//Solution 1 每个按钮使用一个方法
//- (IBAction)top
//{
//    //1.获取对象的frame
//    CGRect newframe = self.picture.frame;
//
//    //2.修改参数
//    newframe.origin.y -= 10;
//
//    //3.将
//    self.picture.frame = newframe;
//}
//
//- (IBAction)bottom
//{
//    //1.获取对象的frame
//    CGRect newframe = self.picture.frame;
//    
//    //2.修改参数
//    newframe.origin.y += 10;
//    
//    //3.将
//    self.picture.frame = newframe;
//}
//
//- (IBAction)left
//{
//    //1.获取对象的frame
//    CGRect newframe = self.picture.frame;
//    
//    //2.修改参数
//    newframe.origin.x -= 10;
//    
//    //3.将
//    self.picture.frame = newframe;
//}
//
//- (IBAction)right
//{
//    //1.获取对象的frame
//    CGRect newframe = self.picture.frame;
//    
//    //2.修改参数
//    newframe.origin.x += 10;
//    
//    //3.将
//    self.picture.frame = newframe;
//}

//Solution 2 将四个按钮用一个方法实现 使用frame属性
//- (IBAction)move:(UIButton *)button
//{
//    //1.获得对象的frame属性并赋值给newframe;
//    CGRect newFrame = self.picture.frame;
//    
//    //2.根据button的tag值进行相应的操作
//    switch (button.tag) {
//        case kMovingTop:
//            newFrame.origin.y -= kMovingDelta;
//            break;
//        case kMovingBottom:
//            newFrame.origin.y += kMovingDelta;
//            break;
//        case kMovingLeft:
//            newFrame.origin.x += kMovingDelta;
//            break;
//        case kMovingRight:
//            newFrame.origin.x -= kMovingDelta;
//            break;
//    }
//    
//    //3.将修改后的newframe值返回给button
//    self.picture.frame = newFrame;
//    
//}

//Solution 3 利用CGAffineTransformMakeTranslation方法进行位移
//- (IBAction)move:(UIButton *)button
//{
//    self.delta -= 20;//self.delta只是一个参数,并没有任何的物理意义!
//    
//    CGAffineTransform newTransform = CGAffineTransformMakeTranslation(0, self.delta);
//
//    self.picture.transform = newTransform;
//}


//Solution4 利用CGAffineTransformTranslate方法进行位移

//- (IBAction)move:(UIButton *)button
//{
//    CGFloat dx;
//    CGFloat dy;
//    //1.判断点击的是哪个标签
//        //solution 1.1 switch case
////    switch (button.tag) {
////        case kMovingTop:
////            dy -= kMovingDelta;
////            break;
////        case kMovingBottom:
////            dy += kMovingDelta;
////            break;
////        case kMovingLeft:
////            dx -= kMovingDelta;
////            break;
////        case kMovingRight:
////            dx += kMovingDelta;
////            break;
////    }
//    
//        //solution 1.2 三目语法
//    if (button.tag == kMovingTop || button.tag == kMovingBottom)
//    {
//        dy = ((button.tag == 10) ? -kMovingDelta : kMovingDelta);
//    }else {
//        dx = ((button.tag == 12) ? -kMovingDelta : kMovingDelta);
//    };
//    
//    
//    //2.做出相应的动作
//    CGAffineTransform newTransform = CGAffineTransformTranslate(self.picture.transform, dx, dy);
//    
//    
//    //3.将新的结果返回给对象
//    self.picture.transform = newTransform;
//}


- (IBAction)move:(UIButton *)button
{
    CGPoint center = self.picture.center;
    
    switch (button.tag) {
        case kMovingTop:
            center.y -= kMovingDelta;
            break;
        case kMovingBottom:
            center.y += kMovingDelta;
            break;
        case kMovingLeft:
            center.x -= kMovingDelta;
            break;
        case kMovingRight:
            center.x += kMovingDelta;
            break;
    }
    
    self.picture.center = center;
    
}




//放大或者缩小
- (IBAction)zoom:(UIButton *)button
{
/*
//    //solution1 通过frame解决
//    //1.提取对象的frame
//    CGRect newFrame = self.picture.frame;
//    
//    //2.判断是放大还是缩小,并进行相应的调整
//    if (button.tag) {
//        newFrame.size.height -= 30;
//        newFrame.size.width  -= 30;
//    }else{
//        newFrame.size.height += 30;
//        newFrame.size.width  += 30;
//    }
//    
//    //3.将新的参数返回给对象
//    self.picture.frame = newFrame;
*/
//    //solution2 通过bounds解决
//    //1.提取对象的bounds
//    CGRect newbounds = self.picture.bounds;
//    
//    //2.判断是放大还是缩小,并进行相应的调整
//    if (button.tag == kZoomSmall) {
//        newbounds.size.width  -= 20;
//        newbounds.size.height -= 20;
//    }else{
//        newbounds.size.width  += 20;
//        newbounds.size.height += 20;        
//    }
//    
//    [UIView beginAnimations:nil context:nil];
//    [UIView setAnimationDuration:2.0];
//    
//    
//    //3.将新的参数返回给对象
//    self.picture.bounds = newbounds;
//
//    [UIView commitAnimations];
    
    //solution3 通过CGAffineTransformScale进行放大缩小
    //1.判断是进行放大还是缩小
    CGFloat scale = (button.tag == kZoomSmall) ? 0.8 : 1.2 ;
    
    //2.对picture对象的参数进行调整,并将值返回给对象本身
    self.picture.transform = CGAffineTransformScale(self.picture.transform, scale, scale);
    
}

//旋转
- (IBAction)rotate:(UIButton *)button
{
    //判断向左还是向右旋转
    CGFloat rotate = (button.tag == 1) ? -M_PI_4 : M_PI_4;

    //提取picture对象的属性并进行修改
    CGAffineTransform newrotate = CGAffineTransformRotate(self.picture.transform, rotate);
    
    //将修改后的数值赋给picture
    self.picture.transform = newrotate;
    
}
@end
