//
//  SQDragController.m
//  1001 抽屉效果
//
//  Created by 张思琦 on 15/10/1.
//  Copyright © 2015年 SQ Software Group. All rights reserved.
//

#import "SQDragController.h"

#define shrinkHeight  100

@interface SQDragController ()

//主界面
@property (nonatomic, weak) UIView *mainView;
//左界面
@property (nonatomic, weak) UIView *leftView;
//右界面
@property (nonatomic, weak) UIView *rightView;

@end

@implementation SQDragController

- (void)viewDidLoad {
    [super viewDidLoad];
    //添加视图
    [self setUpAllView];
    
    //创建手势 添加手势
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [self.mainView addGestureRecognizer:pan];
    
//    //给mainView添加KVO监听其frame的变化情况
//    [self.mainView addObserver:self forKeyPath:@"transform" options:NSKeyValueObservingOptionNew context:nil];
    
}

- (void)setUpAllView{
    //左视图
    UIView *leftView = [[UIView alloc] init];
    leftView.frame = self.view.frame;
    leftView.backgroundColor = [UIColor greenColor];
    self.leftView = leftView;
    [self.view addSubview:self.leftView];
    
    //右视图
    UIView *rightView = [[UIView alloc] init];
    rightView.frame = self.view.frame;
    rightView.backgroundColor = [UIColor orangeColor];
    self.rightView = rightView;
    [self.view addSubview:self.rightView];
    
    //中间视图
    UIView *mainView = [[UIView alloc] init];
    mainView.frame = self.view.frame;
    mainView.backgroundColor = [UIColor lightGrayColor];
    self.mainView = mainView;
    [self.view addSubview:self.mainView];

}

- (void)pan:(UIPanGestureRecognizer *)pan {
    
    //手势滑动的向量
    CGPoint distance = [pan translationInView:self.mainView];
    
    //滑动mainView
    self.mainView.transform = CGAffineTransformTranslate(self.mainView.transform, distance.x, 0);
    
    CGFloat width = self.view.bounds.size.width;
    CGFloat height = shrinkHeight;
    
    //x轴移动距离
    CGFloat realHeight;
    
    //根据中间view的x值判断mainView高度的计算方法
    if (self.mainView.frame.origin.x >= 0) {//在左边的view左右滑动时
        realHeight = self.view.bounds.size.height - 2 * (distance.x * height) / width;
    }else if(self.mainView.frame.origin.x < 0){//在右边的view左右滑动时
        realHeight = self.view.bounds.size.height + 2 * (distance.x * height) / width;
    }
    
    //固定高度值
    CGFloat constantHeight = self.view.bounds.size.height;
    //缩放比
    CGFloat scale = realHeight/constantHeight;
    NSLog(@"%f",scale);
    self.mainView.transform = CGAffineTransformScale(self.mainView.transform, scale, scale);

    //复位手势
    [pan setTranslation:CGPointZero inView:self.view];
    
    
    /****************** 使用frame值判断界面更换 **************/
    //根据界面的frame值来进行界面切换
    if (self.mainView.frame.origin.x < 0) {
        //向左滑动时候显示左视图
        self.rightView.hidden = YES;
    }else if (self.mainView.frame.origin.x >= 0){
        //向右滑动时候显示右视图
        self.rightView.hidden = NO;
    }
    /*****************************************************/
    
}


//- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
//    
//    if (self.mainView.frame.origin.x < 0) {
//        //向左滑动时候显示左视图
//        self.rightView.hidden = YES;
////        self.leftView.hidden = NO;
//    }else if (self.mainView.frame.origin.x >= 0){
//        //向右滑动时候显示右视图
//        self.rightView.hidden = NO;
////        self.leftView.hidden = YES;
//    }
//
//}

@end
