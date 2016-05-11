//
//  ViewController.m
//  0120 时钟
//
//  Created by 张思琦 on 16/1/20.
//  Copyright © 2016年 SQ Software Group. All rights reserved.
//

#import "ViewController.h"

#define kPerSecondArc 6
#define kPerMinuteArc 6
#define kPerHourArc 30
#define kPerSecondHourArc 0.5

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic)  CALayer *secLayer;
@property (weak, nonatomic)  CALayer *minLayer;
@property (weak, nonatomic)  CALayer *hourLayer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupHourLayer];
    [self setupMinLayer];
    [self setupSecLayer];
    
    //设定定时器
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timeChange) userInfo:nil repeats:YES];
    
    //初始化time
    [self timeChange];
}

- (void)timeChange{

    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *dateCmp = [calendar components:NSCalendarUnitSecond | NSCalendarUnitMinute | NSCalendarUnitHour fromDate:[NSDate date]];
    
    NSInteger sceond = dateCmp.second;
    CGFloat secArc = (sceond * kPerSecondArc) / 180.0 * M_PI;
    self.secLayer.transform = CATransform3DMakeRotation(secArc, 0, 0, 1);
    
    
    NSInteger minute = dateCmp.minute;
    CGFloat minArc = (minute * kPerMinuteArc) / 180.0 * M_PI;
    self.minLayer.transform = CATransform3DMakeRotation(minArc, 0, 0, 1);
    
    NSInteger hour = dateCmp.hour;
    CGFloat hourArc = (hour * kPerHourArc + minute * kPerSecondHourArc) / 180.0 * M_PI;
    self.hourLayer.transform = CATransform3DMakeRotation(hourArc, 0, 0, 1);
    
    
}

- (void)setupSecLayer{
    //创建layer层
    CALayer *layer = [CALayer layer];
    //设定锚点
    layer.anchorPoint = CGPointMake(0.5, 1);
    //设定位置
    layer.position = CGPointMake(self.imageView.bounds.size.width * 0.5, self.imageView.bounds.size.height * 0.5);
    layer.bounds = CGRectMake(0, 0, 1, 80);
    //设定背景色
    layer.backgroundColor = [UIColor redColor].CGColor;
    
    self.secLayer = layer;
    
    [self.imageView.layer addSublayer:layer];
    
}

- (void)setupMinLayer{
    //创建layer层
    CALayer *layer = [CALayer layer];
    //设定锚点
    layer.anchorPoint = CGPointMake(0.5, 1);
    //设定位置
    layer.position = CGPointMake(self.imageView.bounds.size.width * 0.5, self.imageView.bounds.size.height * 0.5);
    layer.bounds = CGRectMake(0, 0, 4, 60);
    //设定背景色
    layer.backgroundColor = [UIColor blackColor].CGColor;
    
    self.minLayer = layer;
    
    [self.imageView.layer addSublayer:layer];
    
}

- (void)setupHourLayer{
    //创建layer层
    CALayer *layer = [CALayer layer];
    //设定锚点
    layer.anchorPoint = CGPointMake(0.5, 1);
    //设定位置
    layer.position = CGPointMake(self.imageView.bounds.size.width * 0.5, self.imageView.bounds.size.height * 0.5);
    layer.bounds = CGRectMake(0, 0, 4, 50);
    //设定背景色
    layer.backgroundColor = [UIColor blackColor].CGColor;
    
    
    self.hourLayer = layer;
    
    [self.imageView.layer addSublayer:layer];
    
}


@end
