//
//  SQEssenceViewController.m
//  1105 BaiSiBuDeJie
//
//  Created by 张思琦 on 15/11/7.
//  Copyright © 2015年 SQ Software Group. All rights reserved.
//

#import "SQEssenceViewController.h"
#import "SQTitleViewButton.h"

#import "SQAllTableViewController.h"
#import "SQVideoTableViewController.h"
#import "SQVoiceTableViewController.h"
#import "SQPhotoTableViewController.h"
#import "SQWordTableViewController.h"


@interface SQEssenceViewController () <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *titleView;

@property (nonatomic, strong) SQTitleViewButton *selectedButton;
@property (nonatomic, strong) UIView *indicativeLineView;


@end

@implementation SQEssenceViewController

#pragma mark - 生命周期相关的方法
- (void)viewDidLoad {
    [super viewDidLoad];
    //设置背景色
    self.view.backgroundColor = SQCommonBgColor;
    
    //设置导航栏
    [self setUpNavigation];

    [self setUpChildViewController];
    
    [self setUpScrollView];
    
    [self setUpTitleView];

    //加载第一个tableView
    [self addChildTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 左上角的按钮
- (void)leftNavbuttonClick{
    SQLOGFUNC;
}


#pragma mark - setUpNavigation
- (void)setUpNavigation{
    //设置NavigationBar中部的titleView
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" highImage:@"MainTagSubIconClick" target:self action:@selector(leftNavbuttonClick)];
}


- (void)setUpChildViewController{
    
    SQAllTableViewController *all = [[SQAllTableViewController alloc] init];
    [self addChildViewController:all];
    
    SQVideoTableViewController *video = [[SQVideoTableViewController alloc] init];
    [self addChildViewController:video];
    
    SQVoiceTableViewController *voice = [[SQVoiceTableViewController alloc] init];
    [self addChildViewController:voice];
    
    SQPhotoTableViewController *photo = [[SQPhotoTableViewController alloc] init];
    [self addChildViewController:photo];
    
    SQWordTableViewController *word = [[SQWordTableViewController alloc] init];
    [self addChildViewController:word];
    
}


#pragma mark - setUpScrollView
- (void)setUpScrollView{

    //以self.view.bounds为基准创建scrollview
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    self.scrollView = scrollView;

    //设置scrollview的背景色为随机色
    scrollView.backgroundColor = SQRandomColor;
    
    scrollView.pagingEnabled = YES;
    
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    
    scrollView.delegate = self;
    
    //向viewController中添加scrollView
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    
    //修订scrollView对其第一个子控件的偏移量
    self.automaticallyAdjustsScrollViewInsets = NO;
    //子控制器个数
    NSUInteger childViewControllersCount = self.childViewControllers.count;
    //设置scrollView的大小
    scrollView.contentSize = CGSizeMake(childViewControllersCount * scrollView.sq_width, 0);
    
}


#pragma mark - setUpTitleView
- (void)setUpTitleView{
   
    //添加titleView主体
    UIView *titleView = [[UIView alloc] init];
    self.titleView = titleView;
    //titleView的y值包含了顶部状态栏高度(20)和NavigationBar高度(44)
    titleView.frame = CGRectMake(0, StatesBarHeight + NavigationBarHeight, self.view.sq_width, TitleViewHeight);
    
    //设置titleView的透明度
    //思路一:直接修改titleView的透明度
    //弊端:整个titleView及titleView的子控件都会透明度降低
//    titleView.alpha = 0.2;
    
    //思路二:设置titleView的backgroundColor的透明度
    //方法一
//    titleView.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.5];
    //方法二
//    titleView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.5];
    //方法三
    titleView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
    
    [self.view addSubview:titleView];
    
    
    //往titleView里添加UIButton
    NSArray *titlesNameArray = @[@"全部",@"视频",@"声音",@"图片",@"段子"];
    NSUInteger titlesCount = titlesNameArray.count;
    CGFloat titleButtonWidth = titleView.sq_width / titlesCount;
    CGFloat titleButtonHeigth = titleView.sq_height;
    
    //在titleView中添加button
    for (int i = 0; i < titlesCount; i++) {
        //基本设置
        SQTitleViewButton  *titleViewButton = [SQTitleViewButton buttonWithType:UIButtonTypeCustom];
        titleViewButton.tag = i;
        titleViewButton.frame = CGRectMake(i * titleButtonWidth, 0, titleButtonWidth, titleButtonHeigth);
        [titleViewButton setTitle:titlesNameArray[i] forState:UIControlStateNormal];
        //监听button的点击事件
        [titleViewButton addTarget:self action:@selector(titleViewButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        //添加button到titleView
        [titleView addSubview:titleViewButton];
    }

    //取出titleView中的第一个button
    SQTitleViewButton *firstTitleViewButton = titleView.subviews.firstObject;
    //提前计算firstTitleViewButton的titleLabel大小
    [firstTitleViewButton.titleLabel sizeToFit];
    //改变firstTitleViewButton的状态为selected
    firstTitleViewButton.selected = YES;
    //赋值
    self.selectedButton = firstTitleViewButton;
    
    
    //设置titleViewButton底部的indicativeLineView
    UIView *indicativeLineView = [[UIView alloc] init];
    //保持indicativeLineView的颜色与字体的selected状态下相同
    indicativeLineView.backgroundColor = [firstTitleViewButton titleColorForState:UIControlStateSelected];
    
    //设置indicativeLineView高度为1
    indicativeLineView.sq_height = 1;
    //indicativeLineView添加到titleView,其x,y值的坐标系要参考titleView
    indicativeLineView.sq_y = titleView.sq_height - indicativeLineView.sq_height;

    //设定indicativeLineView的宽和中心点X(用于设置默认的firstTitleViewButton)
    //设置titleView中第一个button的indicativeLineView
    indicativeLineView.sq_width = firstTitleViewButton.titleLabel.sq_width;
    indicativeLineView.sq_centerX = firstTitleViewButton.sq_centerX;
    
    //添加到titleView
    [titleView addSubview:indicativeLineView];
    //赋值
    self.indicativeLineView = indicativeLineView;
    
}


- (void)titleViewButtonClick:(SQTitleViewButton *)titleViewButton{
    
//    //方法一利用selectedButton属性保存被点击按钮,通过设置titleColor实现button的颜色切换
//    [self.selectedButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
//    [titleViewButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
//    self.selectedButton = titleViewButton;
    
    //方法二将原先button的selected状态取消,将点击的button的selected状态变更
    self.selectedButton.selected = NO;
    titleViewButton.selected = YES;
    self.selectedButton = titleViewButton;
    
    
//    //方法三模仿思路二,利用disabled和normal状态实现button的颜色切换
//    self.selectedButton.enabled = YES;
//    titleViewButton.enabled = NO;
//    self.selectedButton = titleViewButton;
    
    [UIView animateWithDuration:0.25 animations:^{
        
        self.indicativeLineView.sq_centerX = titleViewButton.sq_centerX;
        self.indicativeLineView.sq_width = titleViewButton.titleLabel.sq_width;


        //计算indicativeLineView的宽度
        //方法一 sizeWithFont方法已经弃用,注意方法返回的数据是CGSize
//        CGFloat width = [titleViewButton.currentTitle sizeWithFont:titleViewButton.titleLabel.font].width;
        
        //方法二 sizeWithAttributes   
//        CGFloat width = [titleViewButton.currentTitle sizeWithAttributes:@{NSFontAttributeName : titleViewButton.titleLabel.font}].width;
        
        //方法三 sizeWithFont:constrainedToSize:已经被弃用,注意方法返回的数据是CGSize
//        [titleViewButton.currentTitle sizeWithFont:<#(UIFont *)#> constrainedToSize:<#(CGSize)#>];
        
        //方法四 boundingRectWithSize:
//        [titleViewButton.currentTitle boundingRectWithSize:<#(CGSize)#> options:<#(NSStringDrawingOptions)#> attributes:<#(nullable NSDictionary<NSString *,id> *)#> context:<#(nullable NSStringDrawingContext *)#>]
        
    }];

    //计算点击button后,scrollView的偏移量
    CGPoint offset = self.scrollView.contentOffset;
    //利用button的tag值计算偏移量
    offset.x = titleViewButton.tag * self.scrollView.sq_width;
    //滚动scrllView到对应的位置
    [self.scrollView setContentOffset:offset animated:YES];
    
}

#pragma mark - scrollViewDelegate
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    [self addChildTableView];
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    NSUInteger index = self.scrollView.contentOffset.x / self.scrollView.sq_width;
    SQTitleViewButton  *button = self.titleView.subviews[index];
    [self titleViewButtonClick:button];
    
    [self addChildTableView];
}

#pragma mark - 加载tableView
- (void)addChildTableView{
    
    //计算tableView的编号
    NSUInteger index = self.scrollView.contentOffset.x / self.scrollView.sq_width;
    
    //取出对应的tableView
    UITableViewController *childTableViewController = self.childViewControllers[index];
    
    //如果当前TableViewController的view被加载了,就不需要再加载
    if ([childTableViewController isViewLoaded]) {
        return;
    }

    //获取tableView
    UITableView *tableView = childTableViewController.tableView;
    
    //设定tabelView的frame值
    tableView.frame = self.scrollView.bounds;
    //设定背景色
    tableView.backgroundColor = SQRandomColor;
    //设置tableView的内边距
    tableView.contentInset = UIEdgeInsetsMake(StatesBarHeight + NavigationBarHeight + TitleViewHeight, 0, TabBarHeight, 0);
    //设置tableView右侧滑块指示器的内边距
    tableView.scrollIndicatorInsets = tableView.contentInset;
    
    //将childTableView添加到scrollView
    [self.scrollView addSubview:childTableViewController.view];
    
}

@end
