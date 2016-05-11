//
//  ViewController.m
//  0801 图片轮播器
//
//  Created by 张思琦 on 15/8/2.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"

@interface ViewController () <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIImageView *imageView;
/**
 *  分页控制器
 */
@property (nonatomic, strong) UIPageControl *pageControl;

/**
 *  计时器
 */
@property (nonatomic, weak) NSTimer *time;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

/************************************  1 Masonry的使用步骤    **********************************/

    //1.1 创建scrollView控件
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    self.scrollView = scrollView;
    self.scrollView.backgroundColor = [UIColor grayColor];
    
    //1.2 添加scrollView控件到view视图中
    [self.view addSubview:self.scrollView];
    self.scrollView.backgroundColor = [UIColor redColor];
    
    //1.3 禁用scrollView的autoresizing功能
    self.scrollView.translatesAutoresizingMaskIntoConstraints = NO;
    
    //1.4 添加约束
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).with.offset(100);
        make.left.equalTo(self.view.mas_left).with.offset(37.5);
        make.right.equalTo(self.view.mas_right).with.offset(-37.5);
        make.height.equalTo(@150);
    }];
    //self.scrollView.frame = CGRectMake(37.5, 100, 300, 150);
/*************************************    end    *********************************************/


/************************************  2 UIScrollView的设置    **********************************/

    //2.为scrollView中添加imageView
    int photoNumber = 5;
    for (int i = 0; i < photoNumber; i++) {
    
            //2.1创建ImageView
            self.imageView = [[UIImageView alloc] init];;
            
            //2.2布局imageView
            CGFloat imageWidth = 300;
            CGFloat imageHeight = 150;
            CGFloat imageViewX = 0 + i * imageWidth;
            CGFloat imageViewY = 0;
            self.imageView.frame = CGRectMake(imageViewX, imageViewY, imageWidth, imageHeight);
                
            //2.3为imageView中添加图像
            NSString *photoName = [NSString stringWithFormat:@"img_%02d",i];
            self.imageView.image = [UIImage imageNamed:photoName];
            
            //2.4将imageView放入ScrollView中
            [self.scrollView addSubview:self.imageView];
        
    }
    
    //设置ScrollView的滚动范围
    self.scrollView.contentSize = CGSizeMake(1500, 150);
    
    //设置ScrollView的分页功能
    self.scrollView.pagingEnabled = YES ;
/*************************************    end    *********************************************/

    
/************************************   UIPageControl的设置    **********************************/

    UIPageControl *pageControl = [[UIPageControl alloc] init];
    pageControl.backgroundColor = [UIColor grayColor];
    self.pageControl = pageControl;
    
    //[self.scrollView addSubview:self.pageControl];
    [self.view addSubview:self.pageControl];

    
    self.pageControl.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@200);
        make.height.equalTo(@30);
        make.centerX.equalTo(self.scrollView.mas_centerX);
        make.bottom.equalTo(self.scrollView.mas_bottom).with.offset(0);
    }];
    
    
    //设置pageControl的页码数量
    self.pageControl.numberOfPages = 5;
    //设置pageControl的页码颜色
    self.pageControl.pageIndicatorTintColor = [UIColor yellowColor];
    self.pageControl.currentPageIndicatorTintColor = [UIColor blackColor];
    
    
    //替换页码的图片
    //[self.pageControl setValue:[UIImage imageNamed:@"current"] forKeyPath:@"_currentPageImage"];
    //[self.pageControl setValue:[UIImage imageNamed:@"other"] forKeyPath:@"_pageImage"];
/*************************************    end    *********************************************/
    
/************************************  监听UIScrollView内容的翻页    **********************************/
    //需求:
    //1.监听ScrollView中内容的翻页情况
    //2.在翻页后使得PageControl中的页数变化
    
    //监听翻页的方法
    //1.为ScrollView设置代理
        //1.1 遵守协议
        //1.2 实现方法
        //1.3 设置代理
        self.scrollView.delegate = self;
    
    //1.4.1翻页结束后再设置
    //应当监听滚动结束
 
    
    //1.4.2.实时更新
    //应当监听滚动状态
    
    
/*************************************    end    *********************************************/
    
    
/************************************  监听pageControl内容的变化    **********************************/
    //需求:
    //1.通过addTarget方法监听页码的改变
    //2.根据点按的情况决定图片变化位置,使其实现内容滚动
    
    //监听pageControl的方法
    //对viewControler使用addTarget方法监听pageControl
    [pageControl addTarget:self action:@selector(nextPage) forControlEvents:UIControlEventValueChanged];
  
/*************************************    end    *********************************************/


/************************************  添加NSTimer类    **********************************/
    //需求:每隔两秒页面滚动一次
    

    //创建Timer类对象的方法有
    //TimeInterval参数代表:时间间隔
    //target:监听者
    //selector:监听者调用的方法
    //userInfo:调用方法时传递的参数
    //repeats:是否循环监听
    
    //需要注意的是
    //如果使用scheduledTimerWihtInterval方法生成的Timer类对象,系统会自动将该对象添加到RunLoop中,此时RunLoop会对该对象进行强引用,这使得即使在声明属性时选择weak关键字,该对象也不会被释放的原因
    self.time = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
    
    
    //
    [[NSRunLoop mainRunLoop] addTimer:self.time forMode:NSRunLoopCommonModes];
    

/*************************************    end    *********************************************/




}


/****************************************  监听pageControl的变化    **************************************/

- (void)nextPage
{
    // 1.获取跳转后的页码
    NSUInteger page = self.pageControl.currentPage + 1;
    
    //判断当前页是否到达最后一页
    if (page  == self.pageControl.numberOfPages) {
        page = 0;
    };

    // 2.让图片滚动到跳转后页码对应的位置
    [self.scrollView setContentOffset:CGPointMake(page * self.scrollView.bounds.size.width, 0) animated:YES];
    
}

/*************************************    end    *********************************************/


/****************************************  监听滚动状态    **************************************/
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    //当超过页面一半即翻页
//    self.pageControl.currentPage = self.scrollView.contentOffset.x / self.scrollView.bounds.size.width + 0.5;
//}
/*************************************    end    *********************************************/


/**********************************  优化监听scrollView滚动的补充    *************************/

//开始拖拽
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
//方案一
    //销毁NSTimer对象
    [self.time invalidate];
//方案二
    //暂停NSTimer对象
//    [self.time setFireDate:[NSDate distantFuture]];
}


//停止拖拽
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
//方案一
    //创建Timer对象
    self.time = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
//方案二
    //启动Timer对象
    //立即启动
    [self.time fire];
    //从过去的某个时间启动
    //[self.time setFireDate:[NSDate distantPast]];
    //在2秒后启动
//    [self.time setFireDate:[NSDate dateWithTimeIntervalSinceNow:2.0]];
}


/*******************************    end    ********************************/


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}






@end
