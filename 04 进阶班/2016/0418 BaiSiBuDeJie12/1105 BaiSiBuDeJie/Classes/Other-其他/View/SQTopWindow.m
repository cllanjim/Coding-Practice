//
//  SQTopWindow.m
//  1105 BaiSiBuDeJie
//
//  Created by 张思琦 on 16/4/19.
//  Copyright © 2016年 SQ Software Group. All rights reserved.
//

#import "SQTopWindow.h"

@implementation SQTopWindow

- (instancetype)init{
    self = [super init];
    if (self) {
        //创建TopWindow
        self.frame = [UIApplication sharedApplication].statusBarFrame;
        self.backgroundColor = [UIColor redColor];
        self.alpha = 0.2;
        self.windowLevel = UIWindowLevelAlert;
        self.hidden = NO;
        
        //添加window的根控制器
        UIViewController *rootVCofTopWindow = [[UIViewController alloc] init];
        self.rootViewController = rootVCofTopWindow;

        //在window中添加手势
        [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(topWindowClick)]];
    }
    return self;
}

//声明全局变量
static UIWindow *window_;
+ (void)show
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        window_ = [[UIWindow alloc] init];
        window_.frame = [UIApplication sharedApplication].statusBarFrame;
        window_.backgroundColor = [UIColor redColor];
        window_.alpha = 0.2;
        window_.windowLevel = UIWindowLevelAlert;
        window_.hidden = NO;
        [window_ addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(topWindowClick)]];
    });
}


+ (void)topWindowClick{
    SQLOGFUNC;
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [SQTopWindow findScrollViewInView:keyWindow];
}

+ (void)findScrollViewInView:(UIView *)view{
    /***** 遍历当前Window下的所有子控件及其控件的子控件 *****/
    for (UIView *subView in view.subviews) {
        //递归每个控件下的子控件
        [self findScrollViewInView:subView];
    }

    /***** 排除不符合条件的控件 *****/
    //如果当前控件不是scrollView就跳出
    if( ![view isKindOfClass:[UIScrollView class]] ){
        return;
    }
    //如果当前控件不与keyWindow重叠就跳出
    if( ![view sq_intersectWithKeyWindow] ){
        return;
    }
    
    /***** 获取目标scrollView *****/
    UIScrollView *targetScrollView = (UIScrollView *)view;
    
    /***** 修改offset *****/
//    //获取当前targetScrollView的偏移量
//    CGPoint offset = targetScrollView.contentOffset;
//    //设置targetScrollView需要偏移的位置
//    offset.y = - targetScrollView.contentInset.top;
//    //滚动targetScrollView到目标位置
//    [targetScrollView setContentOffset:offset animated:YES];
    
    [targetScrollView scrollRectToVisible:CGRectMake(1, 1, 1, 1) animated:YES];
}

@end
