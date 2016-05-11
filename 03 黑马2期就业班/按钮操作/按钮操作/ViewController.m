//
//  ViewController.m
//  按钮操作
//
//  Created by 张思琦 on 15/7/12.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import "ViewController.h"

//对button的标签进行设置
typedef enum {
    kMovingTop = 10,
    kMovingBottom,
    kMovingLeft,
    KmovingRight,
} kMovingDir;

//
#define kMovingDelta 10.0f

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIButton *picture;


@end

@implementation ViewController

//Solution 1
//- (IBAction)top;
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
//- (IBAction)bottom;
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
//- (IBAction)left;
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
//- (IBAction)right;
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

//Solution 2

- (IBAction)move:(UIButton *)button;
{
    //1.获得对象的frame属性并赋值给newframe;
    CGRect newFrame = self.picture.frame;
    
    //2.根据button的tag值进行相应的操作
    switch (button.tag) {
        case kMovingTop:
            newFrame.origin.y -= kMovingDelta;
            break;
        case kMovingBottom:
            newFrame.origin.y += kMovingDelta;
            break;
        case kMovingLeft:
            newFrame.origin.x += kMovingDelta;
            break;
        case KmovingRight:
            newFrame.origin.x -= kMovingDelta;
            break;
    }
    
    //3.将修改后的newframe值返回给button
    self.picture.frame = newFrame;
    
}

@end
