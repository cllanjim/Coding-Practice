//
//  ViewController.m
//  0731 ScrollView的使用
//
//  Created by 张思琦 on 15/7/31.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIScrollViewDelegate>
@property (strong, nonatomic)  UIScrollView *scrollView;
@property (strong, nonatomic)  UIScrollView *testScrollView;
@property (nonatomic, strong) UIImageView *imageView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    /************************ 纯代码搭建UI界面 ************************/
    //1.新建UIScrollView
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 200, 375,375)];
    
    //2.给UIScrollView添加子控件
    UIImageView *iV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"movie_jf"]];
    //创建imageView的快速方法,根据图片创建,保证其尺寸与image一样
    self.imageView = iV;
    [self.scrollView addSubview:self.imageView];
    
    //3.给UIScrollView设定contentSize
    self.scrollView.contentSize = CGSizeMake(750, 750);
    
    //4.将scrollView添加到view中
    [self.view addSubview:self.scrollView];
    /***********************   end   *******************************/
    
    
    /************************ 测试ScrollView的基本属性 **********************/
    //便于显示增加背景图片
    self.scrollView.backgroundColor = [UIColor lightGrayColor];
    
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
    
    /***********************   end   *******************************/

    
    /********************** 测试contentInset属性 ******************/
    //contentInset是指在ScrollView的contentSize四周增加额外的范围
    //参数类型为UIEdgeInsets,四个数值依次代表上,左,下,右
    //self.scrollView.contentInset = UIEdgeInsetsMake(20, 20, 20, 20);
    /***********************   end   *******************************/

    /********************** 为scrollView设置代理 ******************/
    //  监听控件的两种方法
    //1.继承于UIControl的子类,通过addTarget被监听
    //2.没有继承于UIControol的子类,通过代理模式被监听
    
    //  使用代理模式的步骤
            //1.让代理者(即监听者)遵守被监听控件的协议
            //协议的名称一般以被监听者的类名开头,后面跟上Delegate
            //例如UIScrollView的代理为UIScrollViewDelegate
    
            //2.实现协议中规定的方法
            //协议的方法一般以被监听者的类名开头(去掉前缀),同时谁触发这个方法,就将谁传递出去
    
            //3.给需要被监听的控件的代理属性赋值
            //被监听的控件在声明代理的数据类型时,应选择id类型
            //被监听的控件在声明代理的关键字时,应选择weak关键字,主要是为了避免循环引用
            //一般状况下,控件的代理为视图控制器,而控件又是添加到控制器的view中
    
    
    //  代理的应用场景:(1对1)
    //1.当A对象想监听B对象的变化时, 就可以使用代理, 让A成为B的代理
    //2.当B对象想通知A对象的时候, 就可以使用代理, 让A成为B的代理
    
    /**********监听滚动**********/
    //1.遵守协议
    //2.实现方法
    //3.设置代理属性
    self.scrollView.delegate = self;
    //4.监听滚动时常用的方法
    
    //5.会遇到的问题
    //如何正确监听到停止滚动?
    
    
    
    
    /***********监听缩放*************/
    //1.遵守协议
    //2.实现方法
    //3.设置代理属性
    self.scrollView.delegate = self;
    //4.设置要缩放的控件
    //实现- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView方法
    //需要注意的是返回值应当为ScrollView中的子控件
    
    //5.设置缩放的比例
    self.scrollView.maximumZoomScale = 10 ;
    self.scrollView.minimumZoomScale = 0.1;
    
    //6.监听缩放时常用的方法
    
        //用户使用捏合手势时调用    方法返回的控件就是需要进行缩放的控件
        //- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{    }
    
        //只要子控件缩放就会调用
        //- (void)scrollViewDidZoom:(UIScrollView *)scrollView{    }
    
        //缩放完毕时调用
        //-(void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale{    }
    
    
    //7.如何在缩放过程中保持图片处于ScrollView的正中央
    
    
    
    
    
    
    
    /*******************第二个ScrollView**********************************/
    //1.新建UIScrollView
    self.testScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 450, 375,200)];
    
    //2.给UIScrollView添加子控件
    UIImageView *iV2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"1"]];
    [self.testScrollView addSubview:iV2];
    
    //3.给UIScrollView设定contentSize
    self.testScrollView.contentSize = CGSizeMake(750, 750);
    
    //4.将scrollView添加到view中
    //®[self.view addSubview:self.testScrollView];
    /**************************************************************/

    
    // Do any additional setup after loading the view, typically from a nib.
}

#pragma mark - 拖拽的方法
/*
//scrollView滚动时候调用
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSLog(@"X = %f ; Y = %f", self.scrollView.contentOffset.x, self.scrollView.contentOffset.y);
}

//将要开始拖拽时调用
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    NSLog(@"%s", __func__);
}

//UIScrollView停止"拖拽"时候调用
//停止拖拽并不代表停止滚动,也就是说UIScrollView的滚动是有惯性的
//scrllViewDidEndDragging是没有办法准确监听到UIScrollView停止滚动的
// decelerate等于YES代表有惯性, 会继续滚动; 如果等于NO代表没有惯性,会停止滚动
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    //当"拖拽"不带有加速度的时候,仍然调用停止"减速"的方法
    if (decelerate == NO) {
        [self scrollViewDidEndDecelerating:scrollView];
    }
}

//UIScrollView停止"减速"时候调用
//scrollViewDidEndDecelerating不一定会调用,只有scrollView有惯性的时候才会调用
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    //由于在停止"拖拽"的方法中强制要求无加速度情况时,进入到此方法中,
    //所以通过该方法可以监听到任意情况下停止滚动的信息
    
}
*/



/*******************缩放时候调用*************************/
//用户使用捏合手势时调用    方法返回的控件就是需要进行缩放的控件
//注意:缩放的是ScrollView中的控件,而不是ScrollView本身
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    //正确
    return self.imageView;
    //错误
    //return self.scrollView;
}


//只要子控件缩放就会调用
- (void)scrollViewDidZoom:(UIScrollView *)scrollView{
    //如果当前视图内容的尺寸小于ScrollView控件的尺寸
    if (self.scrollView.contentSize.height < self.scrollView.bounds.size.height ||
        self.scrollView.contentSize.width  < self.scrollView.bounds.size.width
        ) {
        //根据scrollView的大小决定imageView的位置即可
        self.imageView.center = CGPointMake(self.scrollView.bounds.size.width * 0.5, self.scrollView.bounds.size.height * 0.5);
    }
}

//缩放完毕时调用
-(void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale
{

}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//只要点击了控制器的view视图,就会调用该方法
//点击view视图有效,点击子控件无效
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
   // NSLog(@"X = %f ; Y = %f", self.scrollView.contentOffset.x, self.scrollView.contentOffset.y);
}

@end
