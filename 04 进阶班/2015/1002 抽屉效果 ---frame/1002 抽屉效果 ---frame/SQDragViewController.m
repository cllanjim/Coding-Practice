//
//  SQDragViewController.m
//  1002 抽屉效果 ---frame
//
//  Created by 张思琦 on 15/10/2.
//  Copyright © 2015年 SQ Software Group. All rights reserved.
//

#import "SQDragViewController.h"

@interface SQDragViewController ()

@property (nonatomic, weak) UIView *mainView;
@property (nonatomic, weak) UIView *leftView;
@property (nonatomic, weak) UIView *rightView;

@end

@implementation SQDragViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpAllChildrenView];
    
    [self setUpGestureRecognizer];
    
    [self setUpKVO];
}

- (void)setUpAllChildrenView{
    //左视图
    UIView *leftView = [[UIView alloc] initWithFrame:self.view.bounds];
    leftView.backgroundColor = [UIColor blueColor];
    self.leftView = leftView;
    [self.view addSubview:leftView];
    
    //右视图
    UIView *rightView = [[UIView alloc] initWithFrame:self.view.bounds];
    rightView.backgroundColor = [UIColor greenColor];
    self.rightView = rightView;
    [self.view addSubview:rightView];
    
    //主视图
    UIView *mainView = [[UIView alloc] initWithFrame:self.view.bounds];
    mainView.backgroundColor = [UIColor redColor];
    self.mainView = mainView;
    [self.view addSubview:self.mainView];

}

- (void)setUpGestureRecognizer
{
    UIPanGestureRecognizer *pan =[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [self.mainView addGestureRecognizer:pan];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [self.mainView addGestureRecognizer:tap];
    
}

- (void)pan:(UIPanGestureRecognizer *)pan
{
    //获取在X轴的滑动偏移量
    CGPoint offSet = [pan translationInView:self.mainView];
    //计算滑动后的frame值
    self.mainView.frame = [self frameWithOffSetX:offSet.x];
    //复原手指
    [pan setTranslation:CGPointZero inView:self.mainView];
    
    //设置停顿功能
    if(pan.state == UIGestureRecognizerStateEnded){
        CGFloat targetX = 0;
        if(self.mainView.frame.origin.x > self.view.bounds.size.width * 0.5){
            //静止在右边
            targetX = 300;
        }else if(CGRectGetMaxX(self.mainView.frame) < self.view.bounds.size.width * 0.5){
            //静止在左边
            targetX = -230;
        }
        
        CGFloat x = targetX - self.mainView.frame.origin.x;
        
        [UIView animateWithDuration:0.1 animations:^{
            self.mainView.frame = [self frameWithOffSetX:x];
        }];
    }
}

- (CGRect)frameWithOffSetX:(CGFloat)offSetX{

    CGRect currentRect = self.mainView.frame;
    
    CGFloat x = currentRect.origin.x + offSetX;
    CGFloat y = (fabs(x) / self.view.bounds.size.width) * 100;
    CGFloat h = self.view.bounds.size.height - 2 * y;
    CGFloat w = self.view.bounds.size.width * (h / self.view.bounds.size.height);

    CGRect rect = CGRectMake(x, y, w, h);
    return rect;
}

- (void)tap:(UIGestureRecognizer *)tap
{
    if (self.mainView.frame.origin.x != 0) {
        [UIView animateWithDuration:0.1 animations:^{
            self.mainView.frame = self.view.bounds;
        }];
    }
}


- (void)setUpKVO{
    [self.mainView addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    if (self.mainView.frame.origin.x > 0) {
        self.leftView.hidden = NO;
        self.rightView.hidden = YES;
    }else if(self.mainView.frame.origin.x < 0){
        self.leftView.hidden = YES;
        self.rightView.hidden = NO;
    }

}

- (void)dealloc{
    [self.mainView removeObserver:self forKeyPath:@"frame"];
}
@end
