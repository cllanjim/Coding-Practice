//
//  BubbleView.m
//  0127 粘性效果
//
//  Created by 张思琦 on 16/1/28.
//  Copyright © 2016年 SQ Software Group. All rights reserved.
//

#import "BubbleView.h"
#import "NSObject+MathMethod.h"

//定义两个圆心之间的最大距离
#define MaxCenterDistance 100

@interface BubbleView ()
//原始View
@property (nonatomic, strong) UIView *originalView;
//填充view
@property (nonatomic, strong) CAShapeLayer *shapeLayer;
//用于判断是否超出最大距离
@property (nonatomic, assign) BOOL isOverBorder;

@end


@implementation BubbleView

#pragma mark - lazy
- (UIView *)originalView{
    if (_originalView == nil) {
        UIView *originalView = [[UIView alloc] init];
        //设置orginalView的图层半径
        originalView.layer.cornerRadius = self.bounds.size.width * 0.5;
        //设置背景色
        originalView.backgroundColor = [UIColor redColor];
        //设置originalView的初始隐藏属性
        originalView.hidden = YES;
        //将originalView添加到View视图中
        [self.superview insertSubview:originalView atIndex:0];
        //将创建的originalView赋值给orginalView属性
        _originalView = originalView;
    }
    
    return _originalView;
}


- (CAShapeLayer *)shapeLayer{
    if (_shapeLayer == nil) {
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        shapeLayer.fillColor = [UIColor redColor].CGColor;
        _shapeLayer = shapeLayer;
    }
    return _shapeLayer;
}

#pragma mark - 初始化操作
//从xib或者storyboard中加载
- (void)awakeFromNib{
    [self setup];
}
//从代码中加载
- (instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

//加载的具体指令
- (void)setup{
    
    //填充基本内容
    [self setTitle:@"07" forState:UIControlStateNormal];
    self.titleLabel.font = [UIFont systemFontOfSize:12];
    self.layer.cornerRadius = self.bounds.size.height * 0.5;
    //添加手势
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [self addGestureRecognizer:pan];
    //设置originalView的center
    self.originalView.center = self.center;

}

- (void)pan:(UIPanGestureRecognizer *)pan{
    
    if (pan.state == UIGestureRecognizerStateEnded) {
        CGFloat distance = [self centerDistanceBetweenCurrentViewCenter:self.center andOriginalViewCenter:self.originalView.center];
        
        if(distance > MaxCenterDistance){
            //就播放爆炸画面
            [self setupBoom];
        }else {
            //就返回到初始位置
            [self setupRestore];
        }
        
    }else if (pan.state == UIGestureRecognizerStateChanged){
        /*****实现bubbleView的移动*****/
        //获取手指的移动距离
        CGPoint trans = [pan translationInView:self.superview];
        //bubbleView根据手指的移动距离进行位移
        self.center = CGPointMake(self.center.x + trans.x, self.center.y + trans.y);
        //重置translation值
        [pan setTranslation:CGPointZero inView:self.superview];
        
        /*******实现originalView的大小变化********/
        //计算两个圆心间的距离
        CGFloat distance = [self centerDistanceBetweenCurrentViewCenter:self.center andOriginalViewCenter:self.originalView.center];

        
        if(distance > MaxCenterDistance){
            //如果圆心距离大于最大距离
            self.originalView.hidden = YES;
//            self.isOverBorder = YES;
            [self.shapeLayer removeFromSuperlayer];
            
            
        }else if (distance > 0 && distance < MaxCenterDistance){
//            self.isOverBorder == NO
            //如果圆心距离大于0 且 currentView的位置超出了最大范围
            
            //计算小圆的半径
            //当两圆的圆心距离大于100时需要注意
            CGFloat newOriginalViewRadius = self.bounds.size.width * 0.5 - distance / 10;
            
            //设置originalView的size
            self.originalView.bounds = CGRectMake(0, 0, newOriginalViewRadius * 2, newOriginalViewRadius * 2);
            //设置originalView的圆角半径
            self.originalView.layer.cornerRadius = newOriginalViewRadius;
            //显示图层
            self.originalView.hidden = NO;
            
            
            //显示shapeLayer
            self.shapeLayer.path = [self pathWithOriginalViewCenter:self.originalView.center originalViewRadius:newOriginalViewRadius andCurrentViewCenter:self.center currentViewRadius:self.bounds.size.width * 0.5].CGPath;
            
            [self.superview.layer insertSublayer:self.shapeLayer above:self.originalView.layer];

        }
    }
}

#pragma mark - restore
- (void)setupRestore{
    [self.shapeLayer removeFromSuperlayer];
    [UIView animateWithDuration:.25 delay:0 usingSpringWithDamping:0.3 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        //将bubbleView移回屏幕原点
        self.center = CGPointMake(self.window.bounds.size.width * 0.5, self.window.bounds.size.height * 0.5);
    } completion:^(BOOL finished) {
        //重新设置
//        self.isOverBorder = NO;
        self.originalView.hidden = YES;
    }];
    
}


#pragma mark - boom
- (void)setupBoom{
    //创建imageView
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
    [self addSubview:imageView];
    //创建imageView的image数组
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 1; i < 9; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%d",i]];
        [array addObject:image];
    }
    //设置动画属性
    imageView.animationImages = array;
    imageView.animationDuration = 1.2;
    imageView.animationRepeatCount = 1;
    
    [imageView startAnimating];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [imageView removeFromSuperview];
        [self removeFromSuperview];
    });
    
    
    
}


#pragma mark - highlighted方法重写
- (void)setHighlighted:(BOOL)highlighted{
    //do nothing
//    NSLog(@"%s",__func__);
}

@end
