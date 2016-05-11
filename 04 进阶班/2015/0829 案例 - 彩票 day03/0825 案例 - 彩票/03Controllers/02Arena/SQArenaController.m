//
//  SQArenaController.m
//  0825 案例 - 彩票
//
//  Created by 张思琦 on 15/8/25.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

/***************** 目标 ***************/
//1 设置背景
//2 增加控件


#import "SQArenaController.h"

//导入自定义的view
#import "SQArenaView.h"

@interface SQArenaController ()

@end

@implementation SQArenaController

//方法二 使用绘制的自定义view
//该方法加载view会自动调整大小至合适位置
- (void)loadView
{
    SQArenaView *arenaView =[[SQArenaView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.view = arenaView;

}



- (void)viewDidLoad {
    [super viewDidLoad];
    

/**************************  加载view ****************/
//    //方法一 加载imageView
//    //该方法加载imageView会使得内容超出屏幕范围
//    UIImageView *imageView = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
//    imageView.image = [UIImage imageNamed:@"NLArenaBackground"];
//    [self.view addSubview:imageView];
//
//    //方法二 加载绘制的自定义view
//    SQArenaView *arenaView =[[SQArenaView alloc] initWithFrame:[UIScreen mainScreen].bounds];
//    self.view = arenaView;
/************************ 设定导航条的样式 ****************/
    
//    UIImage *image = [UIImage imageNamed:@"NLArenaNavBar64"];
//    //拉伸的方法 苹果推荐使用的新方法
//    image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(1, 1, 1, 1) resizingMode:UIImageResizingModeStretch];
//    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
//    
/*********************** 设定导航条上的SegMentedControl **************/
    
    //创建titles中的标题
    NSArray *titles = @[@"足球", @"篮球"];
    //根据titles中的字符内容创建SegmentedControl
    UISegmentedControl *myTitle = [[UISegmentedControl alloc] initWithItems:titles];
    //设置默认选中第一个按钮
    myTitle.selectedSegmentIndex = 0;
    //设置正常的图片
    [myTitle setBackgroundImage:[UIImage imageNamed:@"CPArenaSegmentBG"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];

    // 设置选中的背景图片
    [myTitle setBackgroundImage:[UIImage imageNamed:@"CPArenaSegmentSelectedBG"] forState:UIControlStateSelected barMetrics:UIBarMetricsDefault];

    // 设置主题颜色
    myTitle.tintColor = [UIColor colorWithRed:0 green:142/255.0 blue:143/255.0 alpha:1];

    // 设置选中的文字颜色
    NSDictionary *dict = @{
                           NSForegroundColorAttributeName : [UIColor whiteColor]
                           };
    [myTitle setTitleTextAttributes:dict forState:UIControlStateSelected];
    
    //设置navigationItem.title为SegMentedControl
    self.navigationItem.titleView = myTitle;
    
    
    /*****************  测试代码   **************/
//    NSLog(@"%@", self.navigationController.navigationBar.subviews);
//    NSLog(@"%@", self.navigationController);
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
