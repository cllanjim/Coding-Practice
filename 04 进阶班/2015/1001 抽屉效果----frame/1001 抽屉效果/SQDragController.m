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
    
    //添加手势
    [self setUpGestureRecognizer];

    //给mainView添加KVO监听其frame的变化情况
    [self.mainView addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionNew context:nil];
    
}


- (void)setUpAllView{
    //右视图
    UIView *rightView = [[UIView alloc] init];
    rightView.frame = self.view.frame;
    rightView.backgroundColor = [UIColor blueColor];
    self.rightView = rightView;
    [self.view addSubview:self.rightView];
    
    //左视图
    UIView *leftView = [[UIView alloc] init];
    leftView.frame = self.view.frame;
    leftView.backgroundColor = [UIColor greenColor];
    self.leftView = leftView;
    [self.view addSubview:self.leftView];
    
    
    //中间视图
    UIView *mainView = [[UIView alloc] init];
    mainView.frame = self.view.frame;
    mainView.backgroundColor = [UIColor redColor];
    self.mainView = mainView;
    [self.view addSubview:self.mainView];
    
}



- (void)setUpGestureRecognizer{
    //创建手势 添加手势
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [self.mainView addGestureRecognizer:pan];
    
    // 给控制器的view添加点按手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
    [self.view addGestureRecognizer:tap];

}



- (void)pan:(UIPanGestureRecognizer *)pan {
    
    //手势滑动的向量
    CGPoint distance = [pan translationInView:self.mainView];
    
    //移动view
    [self frameWithOffset:distance];

    //复位手势
    [pan setTranslation:CGPointZero inView:self.mainView];
    /*************************************************************/
    
    /******************  添加手势定位功能 ********************/
    if(pan.state == UIGestureRecognizerStateEnded){
    
        [UIView animateWithDuration:0.15 animations:^{
            // 计算最新frame
            CGFloat target = 0;
            if (self.mainView.frame.origin.x > self.view.bounds.size.width * 0.5) {
                target = 300;
            }else if(CGRectGetMaxX(self.mainView.frame) <self.view.bounds.size.width * 0.5 ){
                target = -250;
            }
            
            CGFloat offsetX = target - self.mainView.frame.origin.x;
            CGPoint offSet = CGPointMake(offsetX, 0);
            [self frameWithOffset:offSet];
        }];
    }
    /*************************************************************/
    
    /****************** 使用frame值判断界面更换 **************/
    //根据界面的frame值来进行界面切换
//    if (self.mainView.frame.origin.x < 0) {
//        //向左滑动时候显示左视图
//        self.rightView.hidden = YES;
//    }else if (self.mainView.frame.origin.x >= 0){
//        //向右滑动时候显示右视图
//        self.rightView.hidden = NO;
//    }
    /*****************************************************/
    
}





- (void)frameWithOffset:(CGPoint)offSet{

    CGFloat offsetX = offSet.x;
    
    CGFloat screenH = [UIScreen mainScreen].bounds.size.height;
    // 获取上一次mainView的frame
    CGRect frame = _mainView.frame;
    
    // 获取最新的x
    CGFloat x = frame.origin.x += offsetX;
    
    // 获取最新的y
    CGFloat y = fabs(x / self.view.bounds.size.width * shrinkHeight);
    
    // 获取最新的高度
    CGFloat h = screenH - 2 * y;
    
    // 获取缩放比例
    CGFloat scale =  h / screenH;
    // 获取最新的宽度
    CGFloat w = self.view.bounds.size.width * scale;
    
    self.mainView.frame = CGRectMake(x, y, w, h);

}

- (void)tap
{
    if (_mainView.frame.origin.x != 0) {
        // 还原
        [UIView animateWithDuration:0.25 animations:^{
            
            _mainView.frame = self.view.bounds;
        }];
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    
    if (self.mainView.frame.origin.x > 0) {
        //向左滑动时候显示左视图
        self.rightView.hidden = YES;
        self.leftView.hidden = NO;
    }else if (self.mainView.frame.origin.x < 0){
        //向右滑动时候显示右视图
        self.rightView.hidden = NO;
        self.leftView.hidden = YES;
    }

}


//- (void)transformWithOffset:(CGPoint)offSet{
//    
//    //滑动mainView
//    self.mainView.transform = CGAffineTransformTranslate(self.mainView.transform, offSet.x, 0);
//    
//    CGFloat width = self.view.bounds.size.width;
//    CGFloat height = shrinkHeight;
//    
//    //x轴移动距离
//    CGFloat realHeight;
//    
//    //根据中间view的x值判断mainView高度的计算方法
//    if (self.mainView.frame.origin.x >= 0) {//在左边的view左右滑动时
//        realHeight = self.view.bounds.size.height - 2 * (offSet.x * height) / width;
//    }else if(self.mainView.frame.origin.x < 0){//在右边的view左右滑动时
//        realHeight = self.view.bounds.size.height + 2 * (offSet.x * height) / width;
//    }
//    
//    //固定高度值
//    CGFloat constantHeight = self.view.bounds.size.height;
//    //缩放比
//    CGFloat scale = realHeight/constantHeight;
//    NSLog(@"%f",scale);
//    self.mainView.transform = CGAffineTransformScale(self.mainView.transform, scale, scale);
//    
//}

@end
