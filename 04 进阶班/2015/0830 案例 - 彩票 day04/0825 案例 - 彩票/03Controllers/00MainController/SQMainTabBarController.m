//
//  SQMainTabBarController.m
//  0825 案例 - 彩票
//
//  Created by 张思琦 on 15/8/25.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import "SQMainTabBarController.h"
#import "SQMainNavigationController.h"

//导入所有控制器的头文件
#import "SQLotteryHallController.h"     //tableViewController
#import "SQArenaController.h"           //navigationController
#import "SQDiscoverController.h"        //tableViewController
#import "SQHistoryController.h"         //tableViewController
#import "SQMyLotteryController.h"       //navigationController

//
#import "SQArenaNaviController.h"

//导入自定义的tabBar
#import "SQMainTabBar.h"

@interface SQMainTabBarController ()<SQMainTabBarDelegate>

//用于保存所有NavigationController的BarItem的信息(主要为图片)
@property (nonatomic, strong) NSMutableArray *items;



@end

@implementation SQMainTabBarController

#pragma mark - items的懒加载
//利用自身的属性保存数据时,主要要先进行懒加载
- (NSMutableArray *)items
{
    if (_items == nil) {
        _items = [NSMutableArray array];
    }
    return _items;
}

#pragma mark - SQMainTabBar的代理方法
- (void)tabBar:(UIButton *)btn changeViewControllerWithTag:(NSInteger)tag
{
    self.selectedIndex = btn.tag;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置tabBarController中所有子控制器
    [self setupAllChildrenViewController];
    
    //设置tabBar下发的工具条
    [self setupTabBar];
    
    
    // Do any additional setup after loading the view.
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    for (UIView *childView in self.tabBar.subviews) {
        if ([childView isKindOfClass:[SQMainTabBar class]]== NO) {
            [childView removeFromSuperview];
        }
    }

}


//设置tabBarController中所有子控制器
- (void)setupTabBar
{
    //移除原先的tabBar
   // [self.tabBar removeFromSuperview];
    
    //创建自定义tabBar
    SQMainTabBar *myTabBar = [[SQMainTabBar alloc] init];
    //设定tabBar的位置尺寸
    myTabBar.frame = self.tabBar.bounds;
    //设置tabBar的图像
    myTabBar.items = self.items;
    //设置tabBar的代理
    myTabBar.delegate = self;
    //添加myTabBar至当前控制器
    [self.tabBar addSubview:myTabBar];
    
//    myTabBar.frame = self.tabBar.frame;
//    [self.view addSubview:myTabBar];
    
    
}






//设置tabBarController中所有子控制器
- (void)setupAllChildrenViewController
{
//方法一
//    //创建LotteryHall界面的根控制器
//    SQLotteryHallController *lotteryHallVC = [[SQLotteryHallController alloc] init];
//    //创建LotteryHall的Navi
//    SQMainNavigationController *lotterHallNavi = [[SQMainNavigationController alloc] initWithRootViewController:lotteryHallVC];
//    [self addChildViewController:lotterHallNavi];
//    
//    
//    //同理创建Arena界面
//    SQArenaController *arenaVC = [[SQArenaController alloc] init];
//    SQMainNavigationController *arenaNavi = [[SQMainNavigationController alloc] initWithRootViewController:arenaVC];
//    [self addChildViewController:arenaNavi];
//    
//    
//    
//    //创建Discover界面
//    SQDiscoverController *discoverVC = [[SQDiscoverController alloc] init];
//    SQMainNavigationController *discoverNavi = [[SQMainNavigationController alloc] initWithRootViewController:discoverVC];
//    [self addChildViewController:discoverNavi];
//    
//    
//    //创建History界面
//    SQHistoryController *historyVC = [[SQHistoryController alloc] init];
//    SQMainNavigationController *historyNavi = [[SQMainNavigationController alloc] initWithRootViewController:historyVC];
//    [self addChildViewController:historyNavi];
//    
//
//    
//    //创建MyLottery界面
//    SQMyLotteryController *myLotteryVC = [[SQMyLotteryController alloc] init];
//    SQMainNavigationController *myLotteryNavi = [[SQMainNavigationController alloc] initWithRootViewController:myLotteryVC];
//    [self addChildViewController:myLotteryNavi];
    
//方法二
    SQLotteryHallController *lotteryHallVC = [[SQLotteryHallController alloc] init];
    [self setupChildrenController:lotteryHallVC image:[UIImage imageNamed:@"TabBar_LotteryHall_new"] selectedImage:[UIImage imageNamed:@"TabBar_LotteryHall_selected_new"] title:@"购彩大厅"];

    SQArenaController *arenaVC = [[SQArenaController alloc] init];
    [self setupChildrenController:arenaVC image:[UIImage imageNamed:@"TabBar_Arena_new"] selectedImage:[UIImage imageNamed:@"TabBar_Arena_selected_new"] title:nil];

//    SQDiscoverController *discoverVC = [[SQDiscoverController alloc] init];
    
    UIStoryboard *discoverStoryBoard = [UIStoryboard storyboardWithName:@"SQDiscoverController" bundle:nil];
    SQDiscoverController *discoverVC = [discoverStoryBoard instantiateInitialViewController];
    [self setupChildrenController:discoverVC image:[UIImage imageNamed:@"TabBar_Discovery_new"] selectedImage:[UIImage imageNamed:@"TabBar_Discovery_selected_new"] title:@"发现"];

    SQHistoryController *historyVC = [[SQHistoryController alloc] init];
    [self setupChildrenController:historyVC image:[UIImage imageNamed:@"TabBar_History_new"] selectedImage:[UIImage imageNamed:@"TabBar_History_selected_new"] title:@"开奖信息"];
    
    SQMyLotteryController *myLotteryVC = [[SQMyLotteryController alloc] init];
    [self setupChildrenController:myLotteryVC image:[UIImage imageNamed:@"TabBar_MyLottery_new"] selectedImage:[UIImage imageNamed:@"TabBar_MyLottery_selected_new"] title:@"我的彩票"];
    
}


//
- (void)setupChildrenController:(UIViewController *)vc image:(UIImage *)image selectedImage:(UIImage *)selectedImage title:(NSString *)title
{
    
    UINavigationController *naviVC;
    
    
    
    if ([vc isKindOfClass:[SQArenaController class]]) {
        //如果是ArenaViewController,就使用自定义的NaviController
        naviVC = [[SQArenaNaviController alloc] initWithRootViewController:vc];
    }else{
        //根据传入的VC创建Navi控制器
        naviVC = [[SQMainNavigationController alloc] initWithRootViewController:vc];

    }
    
    
    //获取不经过渲染的图片
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //设置控制器的tabBar信息
    naviVC.tabBarItem.image = image;
    naviVC.tabBarItem.selectedImage = selectedImage;
    
    
    //设置导航条背景
    //方法一
//    [naviVC.navigationBar setBackgroundImage:[UIImage imageNamed:@"NavBar64"] forBarMetrics:UIBarMetricsDefault];
    //方法二
    //在NavigationController中的initialize方法中实现
    
    //设置标题的两种方法
    vc.navigationItem.title = title;
//    vc.title = title;
    [self.items addObject:naviVC.tabBarItem];
    [self addChildViewController:naviVC];
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
