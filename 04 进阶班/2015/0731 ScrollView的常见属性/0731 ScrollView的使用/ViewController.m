//
//  ViewController.m
//  0731 ScrollView的使用
//
//  Created by 张思琦 on 15/7/31.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (strong, nonatomic)  UIScrollView *scrollView;
@property (strong, nonatomic)  UIScrollView *testScrollView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    /************************ 纯代码搭建UI界面 ************************/
    //1.新建UIScrollView
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 25, 375,375)];
    
    //2.给UIScrollView添加子控件
    UIImageView *iV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"movie_jf"]];
    //创建imageView的快速方法,根据图片创建,保证其尺寸与image一样
    [self.scrollView addSubview:iV];
    
    //3.给UIScrollView设定contentSize
    self.scrollView.contentSize = CGSizeMake(750, 750);
    
    //4.将scrollView添加到view中
    [self.view addSubview:self.scrollView];
    /***********************   end   *******************************/
    
    
    /************************ 测试ScrollView的基本属性 **********************/
    //便于显示增加背景图片
    self.scrollView.backgroundColor = [UIColor lightGrayColor];
    
    //bounces属性用来设置scrollView是否带弹簧效果
    //self.scrollView.bounces = NO ;
    
    //当scrollView的contentSize为0时,使用以下两种方式设置弹簧效果
    //self.scrollView.contentSize = CGSizeZero;
    //self.scrollView.alwaysBounceVertical = YES;
    //self.scrollView.alwaysBounceHorizontal = YES;
    
    //self.scrollView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
    //三种状态
    //UIScrollViewIndicatorStyleDefault, 默认值
    //UIScrollViewIndicatorStyleBlack, 黑色
    //UIScrollViewIndicatorStyleWhite  白色
    /***********************   end   *******************************/
    
    
    /********************** 测试contentOffset属性 ******************/
    //contentOffset是指ScrollView中的内容的偏移量
    //移动距离 = "UIScrollView控件左上角的坐标值" - "子控件内容左上角的坐标值"
    //scrollView左上角的坐标值不能改变
    //图片右移
    //self.scrollView.contentOffset = CGPointMake(-100,    0);
    //图片左移
    //self.scrollView.contentOffset = CGPointMake( 100,    0);
    //图片上移
    //self.scrollView.contentOffset = CGPointMake(   0,  100);
    //图片下移
    //self.scrollView.contentOffset = CGPointMake(   0, -100);
    
    //下面的方法用于设定在内容的移动过程中是否产生动画效果
    //setContentOffset代表    图片的偏移位置
    //animated代表            是否进行动画
    //[self.scrollView setContentOffset:CGPointMake(-200, -200) animated:NO];
    /***********************   end   *******************************/

    
    /********************** 测试contentInset属性 ******************/
    //contentInset是指在ScrollView的contentSize四周增加额外的范围
    //参数类型为UIEdgeInsets,四个数值依次代表上,左,下,右
    self.scrollView.contentInset = UIEdgeInsetsMake(20, 20, 20, 20);
    /***********************   end   *******************************/

    
    
    
    
    
    
    
    
    
    
    
    /*******************第二个ScrollView**********************************/
    //1.新建UIScrollView
    self.testScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 450, 375,200)];
    
    //2.给UIScrollView添加子控件
    UIImageView *iV2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"1"]];
    [self.testScrollView addSubview:iV2];
    
    //3.给UIScrollView设定contentSize
    self.testScrollView.contentSize = CGSizeMake(750, 750);
    
    //4.将scrollView添加到view中
    [self.view addSubview:self.testScrollView];
    /**************************************************************/

    
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//只要点击了控制器的view视图,就会调用该方法
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"X = %f ; Y = %f", self.scrollView.contentOffset.x, self.scrollView.contentOffset.y);
}

@end
