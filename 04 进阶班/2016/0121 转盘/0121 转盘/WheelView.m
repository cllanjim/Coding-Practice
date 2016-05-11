//
//  WheelView.m
//  0121 转盘
//
//  Created by 张思琦 on 16/1/21.
//  Copyright © 2016年 SQ Software Group. All rights reserved.
//

#import "WheelView.h"
#import "WheelButton.h"


@interface WheelView ()

//转盘
@property (weak, nonatomic) IBOutlet UIImageView *wheelView;
//用于记录被选中的button
@property (nonatomic, strong) WheelButton *selectedButton;
//用作定时器
@property (nonatomic, strong) CADisplayLink *displayLink;


@end


@implementation WheelView

/******* button的选择 *******/
#pragma mark - 选号功能的实现
- (IBAction)startPickNumber:(UIButton *)sender {
    //停止转盘的转动
    self.displayLink.paused = YES;
    
    CABasicAnimation *anim = [CABasicAnimation animation];
    
    anim.keyPath = @"transform.rotation";
    anim.toValue = @(M_PI * 4);
    anim.duration = 0.5;
    anim.delegate = self;
    
    [self.wheelView.layer addAnimation:anim forKey:nil];
    
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{

    //根据atan2函数计算button的形变角度
    //atan2( y, x ) y代表点的y坐标 x代表点的x坐标
    
    CGFloat angle = atan2(self.selectedButton.transform.b, self.selectedButton.transform.a);

    self.wheelView.transform = CGAffineTransformMakeRotation(-angle);
    
    //在2秒后继续转动转盘
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.displayLink.paused = NO;
    });
    
}

/******* 大转盘的转动 ********/
#pragma mark - lazy
- (CADisplayLink *)displayLink{
    if (_displayLink == nil) {
        //创建定时器
        CADisplayLink *displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(timeChange)];
        //将定时器添加到runloop中
        [displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        
        _displayLink = displayLink;
    }
    return _displayLink;
}

- (void)timeChange{
    //
    self.wheelView.transform = CGAffineTransformRotate(self.wheelView.transform, (40 / 60.0) / 180.0 * M_PI);
}

#pragma mark - 转盘开始转动
- (void)startRotate{
    self.displayLink.paused = NO;
}

#pragma mark - 转盘停止转动
- (void)pauseRotate{
    self.displayLink.paused = YES;
}


#pragma mark - 初始化方法
+ (instancetype)wheel{
    
    //- (NSArray *)loadNibNamed:(NSString *)name owner:(id)owner options:(NSDictionary *)options;
    //name参数是nib文件的名称
    //owner参数是指name参数指代的nib文件的file's owner(即加载的nib文件归属于哪个对象)
    //options参数是指相关的打开方式
    //注意点:
    //loadNibNamed:owner:options: 这个函数会返回一个nib的数组。
    //不过，在iPhone2.1包括以后的版本，这个数组的第一个元素，即nib[0]表示的就是除了File‘s Owner 和 File Responder后的第一个东西。
    //在iPhon2.1之前的版本，nib[0]是File's Owner，nib[1]才是除了File‘s Owner 和 File Responder后的第一个东西。
    
    WheelView *wheel = [[[NSBundle mainBundle] loadNibNamed:@"WheelView" owner:nil options:nil] lastObject];
    return wheel;
    
}

#pragma mark - 加载方法
- (void)awakeFromNib{
    //加载normal情况下的集体图片
    UIImage *norGroupImage = [UIImage imageNamed:@"LuckyAstrology"];
    //加载selected情况下的集体图片
    UIImage *selGroupImage = [UIImage imageNamed:@"LuckyAstrologyPressed"];
    
    //获取当前设备下,点与像素的比例
    CGFloat scale = [UIScreen mainScreen].scale;
    //初始化坐标体系
     //因为norGroupImage.size.width是UIKit框架中的方法,所以获得的单位是点,
     //而裁剪图片时用的单位是像素,所以要乘以比例值
    CGFloat clipX = 0;
    CGFloat clipY = 0;
    CGFloat clipW = norGroupImage.size.width / 12 * scale;
    CGFloat clipH = norGroupImage.size.height * scale;
    
    CGRect clipRect = CGRectZero;
    
    //进行裁剪
    for (int i = 0; i < 12 ; i++) {
        WheelButton *button = [WheelButton buttonWithType:UIButtonTypeCustom];
        //为button设置标签
        button.tag = i;
        
        //设置button的frame值
        button.layer.anchorPoint = CGPointMake(0.5, 1);
        button.layer.position = CGPointMake(self.bounds.size.width * 0.5, self.bounds.size.height * 0.5);
        button.layer.bounds = CGRectMake(0, 0, 68, 143);
        //设置button的rotation值
        CGFloat angle = (i * 30) / 180.0 * M_PI;
        button.transform = CGAffineTransformMakeRotation(angle);
        
        //设置button的image
        clipX = i * clipW;
        clipRect = CGRectMake(clipX, clipY, clipW, clipH);
        
        //设置button选中状态下的背景图片
        [button setBackgroundImage:[UIImage imageNamed:@"LuckyRototeSelected"] forState:UIControlStateSelected];
        
        //设置button的image属性
        
        //根据指定image的rect进行裁剪
        //image参数是指被裁剪的图片,类型为CGImageRef
        //rect参数是指image中被裁剪的区域
        //CGImageRef __nullable CGImageCreateWithImageInRect(CGImageRef __nullable image, CGRect rect)
        //normla状态
        CGImageRef normalImageRef = CGImageCreateWithImageInRect(norGroupImage.CGImage, clipRect);
        UIImage *norImage = [UIImage imageWithCGImage:normalImageRef];
        [button setImage:norImage forState:UIControlStateNormal];
        //selected状态
        CGImageRef selectedImageRef = CGImageCreateWithImageInRect(selGroupImage.CGImage, clipRect);
        UIImage *selImage = [UIImage imageWithCGImage:selectedImageRef];
        [button setImage:selImage forState:UIControlStateSelected];
        
        //监听按钮的点击
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchDown];
                
        if (i == 0) {
            [self buttonClick:button];
        }
        
        [self.wheelView addSubview:button];
    }
}

#pragma mark - buttonClick的功能
- (void)buttonClick:(WheelButton *)button{
    //令原有button的selected状态改为NO;
    //令触发该方法的button状态改为YES,同时赋值给selectedButton属性
    self.selectedButton.selected = NO;
    button.selected = YES;
    self.selectedButton = button;
}

#pragma mark - random color
- (UIColor *)randomColor{
    CGFloat red = arc4random_uniform(256) /255.0;
    CGFloat green = arc4random_uniform(256) /255.0;
    CGFloat blue = arc4random_uniform(256) /255.0;
    return [UIColor colorWithRed:red green:green blue:blue alpha:1];
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
