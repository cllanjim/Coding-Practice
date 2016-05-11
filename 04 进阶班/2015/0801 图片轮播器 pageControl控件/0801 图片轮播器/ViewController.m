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
@property (nonatomic, strong) UIPageControl *pageControl;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
/*******************   Masonry的使用步骤    *****************/
    //Masonry的使用注意事项
    //1.创建控件
    //2.添加控件到父控件中
    //3.禁用控件的autoresizing功能
    //4.添加约束
/**********************    end    *******************************/
 
    
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
        make.width.equalTo(@100);
        make.height.equalTo(@30);
        make.centerX.equalTo(self.scrollView.mas_centerX);
        make.bottom.equalTo(self.scrollView.mas_bottom).with.offset(0);
    }];
    
    
    //设置pageControl的页码数量
    self.pageControl.numberOfPages = 5;
    //设置pageControl的页码颜色
    self.pageControl.pageIndicatorTintColor = [UIColor yellowColor];
    self.pageControl.currentPageIndicatorTintColor = [UIColor blackColor];
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
   
    // Do any additional setup after loading the view, typically from a nib.
}

/****************************************  监听滚动结束    **************************************/
////当停止拖拽时调用
//- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
//    if(decelerate == NO)
//    {
//        [self scrollViewDidEndDecelerating:scrollView];
//    }
//}
////当停止减速时调用
//- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
//    //利用scrollView中视图内容的X坐标除以scrollView自身的宽度就得到第几张照片
//    self.pageControl.currentPage = self.scrollView.contentOffset.x / self.scrollView.bounds.size.width;
//}

/*************************************    end    *********************************************/



/****************************************  监听滚动状态    **************************************/
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //当超过页面一半即翻页
    self.pageControl.currentPage = self.scrollView.contentOffset.x / self.scrollView.bounds.size.width + 1;
}

/*************************************    end    *********************************************/


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
