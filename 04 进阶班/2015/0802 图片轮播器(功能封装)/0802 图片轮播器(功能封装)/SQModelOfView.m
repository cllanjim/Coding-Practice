//
//  SQModelOfView.m
//  0802 图片轮播器(功能封装)
//
//  Created by 张思琦 on 15/8/6.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

/**********    说明     **********/
//1 提供一个类工厂方法 用于加载xib中的视图模型,并为数据模型赋值
//2 重写awakeFromNib方法,进行初始化操作
//3 重写数据模型的set方法,为视图模型赋值
//4 选择SQModelOfView做为监听者
/**********    end     **********/


#import "SQModelOfView.h"

@interface SQModelOfView ()

@property (nonatomic, strong) NSTimer *timer;

@end

@implementation SQModelOfView



+ (instancetype)modelOfView
{
    //确定xib的文件路径并读取其中的视图模型集合
    SQModelOfView *newView = [[[NSBundle mainBundle] loadNibNamed:@"ModelOfView" owner:nil options:nil] lastObject];
//    newView.scrollView.backgroundColor = [UIColor grayColor];
//    newView.scrollView.pagingEnabled = YES;
//    newView.pageControl.backgroundColor = [UIColor grayColor];
//    newView.scrollView.delegate = newView;
    return newView;
}


+ (instancetype)modelOfViewWithArray:(NSArray *)classOfImageView{
    
    //确定xib的文件路径并读取其中的视图模型集合
    SQModelOfView *newView = [[[NSBundle mainBundle] loadNibNamed:@"ModelOfView" owner:nil options:nil] lastObject];
    
    
    newView.classOfImageView = classOfImageView;
    for (int i = 0 ; i < newView.classOfImageView.count; i++) {
        //从模型数组中取出第i个数据
        SQModelOfData *data = newView.classOfImageView[i];
        //取出第i个数据的imageView数据
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView =data.imageView;
        //取出第i个数据的image数据
        UIImage *image =[[UIImage alloc] init];
        image = data.image;
        //将image赋值给ImageView
        imageView.image = image;
        imageView.frame = CGRectMake(i * 300, 0, 300, 150);
        [newView.scrollView addSubview:imageView];
    }
    
    //设置scrollView的滚动范围
    newView.scrollView.contentSize = CGSizeMake(newView.classOfImageView.count * 300, 150);
    //设置pageControl的页码数量
    newView.pageControl.numberOfPages = newView.classOfImageView.count;

    
    
    return newView;
}



- (void)awakeFromNib{
    //scrollView初始化设置
    self.scrollView.backgroundColor = [UIColor grayColor];
    self.scrollView.pagingEnabled = YES;
    self.scrollView.delegate = self;
    
    //pageControl初始化设置
    self.pageControl.backgroundColor = [UIColor grayColor];
    [self.pageControl addTarget:self action:@selector(nextPage) forControlEvents:UIControlEventValueChanged];
    
    //timer初始化设置
    self.timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(nextPageAuto) userInfo:nil repeats:YES];
    
    
    NSLog(@"123");
}


- (void)setClassOfImageView:(NSArray *)classOfImageView
{
    _classOfImageView = classOfImageView;
    for (int i = 0 ; i < _classOfImageView.count; i++) {
        //从模型数组中取出第i个数据
        SQModelOfData *data = _classOfImageView[i];
        //取出第i个数据的imageView数据
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView =data.imageView;
        //取出第i个数据的image数据
        UIImage *image =[[UIImage alloc] init];
        image = data.image;
        //将image赋值给ImageView
        imageView.image = image;
        imageView.frame = CGRectMake(i * 300, 0, 300, 150);
        [self.scrollView addSubview:imageView];
    }
    
    //设置scrollView的滚动范围
    self.scrollView.contentSize = CGSizeMake(_classOfImageView.count * 300, 150);
    //设置pageControl的页码数量
    self.pageControl.numberOfPages = _classOfImageView.count;
    
    
}



//当SQModelOfView成为scrollView的监听者时,使用该方法可以动态计算pageControl中的当前页码
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    int pageNumber = self.scrollView.contentOffset.x / self.scrollView.bounds.size.width;
    self.pageControl.currentPage = pageNumber + 0.5;
}

//在点击pageControl的页码能够使用该方法自动转换页面
- (void)nextPage{
    [self.scrollView setContentOffset:CGPointMake(300 * self.pageControl.currentPage, 0) animated:YES];
}

//NSTimer自动更新页面时调用的方法
- (void)nextPageAuto
{
    int currentPage = (int)self.pageControl.currentPage + 1;;
    if (self.pageControl.currentPage  == 4) {
        currentPage = 0;
    }
    [self.scrollView setContentOffset:CGPointMake(300 * currentPage, 0) animated:YES];
    NSLog(@"我进来了!");
}

//
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.timer setFireDate:[NSDate distantFuture]];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    
    [self.timer fire];
    
    //[self.timer setFireDate:[NSDate distantPast]];
    //在两秒后开启计时器
    //[self.timer setFireDate:[NSDate dateWithTimeIntervalSinceNow:2.0]];

}


@end
