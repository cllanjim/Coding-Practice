//
//  SQTabBarController.m
//  1105 BaiSiBuDeJie
//
//  Created by 张思琦 on 15/11/5.
//  Copyright © 2015年 SQ Software Group. All rights reserved.
//

#import "SQTabBarController.h"

//导入自定义的TabBar
#import "SQTabBar.h"

//导入子控制器的头文件
#import "SQEssenceViewController.h"
#import "SQNewViewController.h"
#import "SQFollowViewController.h"
#import "SQMeViewController.h"

//导入自定义的NavigationController
#import "SQNavigationController.h"


@interface SQTabBarController ()

//使用自定义子控制器增加发布按钮时使用的代码
//@property (nonatomic, strong) UIButton *addButton;
@end

@implementation SQTabBarController

//使用自定义子控制器增加发布按钮时使用的代码
//#pragma mark - lazy of addBarButton
//- (UIButton *)addButton{
//if (_addButton == nil) {
//        //UIButton要使用自定义的创建方式
//        _addButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        //设置背景颜色
//        _addButton.backgroundColor = SQRandomColor;
//        //设置不同状态下的图片样式
//        [_addButton setImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
//        [_addButton setImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateSelected];
//        //设置位置
//        _addButton.frame = CGRectMake(0, 0, self.tabBar.bounds.size.width / 5, self.tabBar.bounds.size.height);
//        _addButton.center = CGPointMake(self.tabBar.bounds.size.width * 0.5 , self.tabBar.bounds.size.height * 0.5);
//        //此处使用tabBar会出现问题,初步认为是由于TabBar没有设定好位置,此时调用其中心位置会出现错误
//        //_addButton.center = CGPointMake(self.tabBar.center.x, self.tabBar.center.y);
//        //监听button的点击事件
//        [_addButton addTarget:self action:@selector(addClick) forControlEvents:UIControlEventTouchUpInside];
//    }
//    return _addButton;
//}
//
//- (void)addClick
//{
//    NSLog(@"%zd",__func__);
//}


#pragma mark - 生命周期相关的方法

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    //在asset.xcassets中将图片重新设置,防止其被渲染
//    
//    //设置UITabBarItem的文字属性
//    //UITabBar 指整个TabBar
//    //UITabBarItem 指TabBar中的元素
//    UITabBarItem *item = [UITabBarItem appearance];
//    //设置普通状态下的UITabBarItem的状态
//    NSMutableDictionary *noramalAttrs = [NSMutableDictionary dictionary];
//    noramalAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:14];
//    noramalAttrs[NSForegroundColorAttributeName] = [UIColor grayColor];
//    [item setTitleTextAttributes:noramalAttrs forState:UIControlStateNormal];
//    //设置选中状态下的UITabBarItem的状态
//    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
//    selectedAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:14];
//    selectedAttrs[NSForegroundColorAttributeName] = [UIColor grayColor];
//    [item setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
    
    
//    //添加子控制器
//    [self setupOneChildViewController:[[UITableViewController alloc] init] title:@"精华" image:@"tabBar_essence_icon" selectedImage:@"tabBar_essence_click_icon"];
//    [self setupOneChildViewController:[[UITableViewController alloc] init] title:@"新帖" image:@"tabBar_new_icon" selectedImage:@"tabBar_new_click_icon"];
//    
//    //使用自定义子控制器增加发布按钮时使用的代码
//
//    /*****************添加一个占位控制器**************/
//    //[self setupOneChildViewController:[[UIViewController alloc] init] title:@"" image:@"" selectedImage:@""];
//    /*****************添加一个占位控制器**************/
//
//    [self setupOneChildViewController:[[UIViewController alloc] init] title:@"关注" image:@"tabBar_friendTrends_icon" selectedImage:@"tabBar_friendTrends_click_icon"];
//    [self setupOneChildViewController:[[UITableViewController alloc] init] title:@"我" image:@"tabBar_me_icon" selectedImage:@"tabBar_me_click_icon"];
    

    //设置TabBar字体样式
    [self setUpTitleTextAttributes];
    //设置TabBarController的子控制器
    [self setUpChildrenViewController];
    //设置TabBarController的TabBar
    [self setupTabBar];
    
    
}

////使用自定义子控制器增加发布按钮时使用的代码
//- (void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//    [self.tabBar addSubview:self.addButton];
//}


- (void)setUpTitleTextAttributes{
    //设置UITabBarItem的文字属性
    //UITabBar 指整个TabBar
    //UITabBarItem 指TabBar中的元素
    UITabBarItem *item = [UITabBarItem appearance];
    //设置普通状态下的UITabBarItem的状态
    NSMutableDictionary *noramalAttrs = [NSMutableDictionary dictionary];
    noramalAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:14];
    noramalAttrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    [item setTitleTextAttributes:noramalAttrs forState:UIControlStateNormal];
    //设置选中状态下的UITabBarItem的状态
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:14];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    [item setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
}


- (void)setUpChildrenViewController{
    //添加子控制器
//    [self setupOneChildViewController:[[UITableViewController alloc] init] title:@"精华" image:@"tabBar_essence_icon" selectedImage:@"tabBar_essence_click_icon"];
//    [self setupOneChildViewController:[[UITableViewController alloc] init] title:@"新帖" image:@"tabBar_new_icon" selectedImage:@"tabBar_new_click_icon"];
//    [self setupOneChildViewController:[[UIViewController alloc] init] title:@"关注" image:@"tabBar_friendTrends_icon" selectedImage:@"tabBar_friendTrends_click_icon"];
//    [self setupOneChildViewController:[[UITableViewController alloc] init] title:@"我" image:@"tabBar_me_icon" selectedImage:@"tabBar_me_click_icon"];
    
//    //创建NavigationController,并以自己的ViewController为根控制器
//    [self setupOneChildViewController:[[UINavigationController alloc] initWithRootViewController:[[SQEssenceViewController alloc] init]] title:@"精华" image:@"tabBar_essence_icon" selectedImage:@"tabBar_essence_click_icon"];
//    [self setupOneChildViewController:[[UINavigationController alloc] initWithRootViewController:[[SQNewViewController alloc] init]] title:@"新帖" image:@"tabBar_new_icon" selectedImage:@"tabBar_new_click_icon"];
//    [self setupOneChildViewController:[[UINavigationController alloc] initWithRootViewController:[[SQFollowViewController alloc] init]] title:@"关注" image:@"tabBar_friendTrends_icon" selectedImage:@"tabBar_friendTrends_click_icon"];
//    [self setupOneChildViewController:[[UINavigationController alloc] initWithRootViewController:[[SQMeViewController alloc] init]] title:@"我" image:@"tabBar_me_icon" selectedImage:@"tabBar_me_click_icon"];
    
    
    //创建自定义的NavigationController,并以自己的ViewController为根控制器
    [self setupOneChildViewController:[[SQNavigationController alloc] initWithRootViewController:[[SQFollowViewController alloc] init]] title:@"关注" image:@"tabBar_friendTrends_icon" selectedImage:@"tabBar_friendTrends_click_icon"];
    [self setupOneChildViewController:[[SQNavigationController alloc] initWithRootViewController:[[SQEssenceViewController alloc] init]] title:@"精华" image:@"tabBar_essence_icon" selectedImage:@"tabBar_essence_click_icon"];
    [self setupOneChildViewController:[[SQNavigationController alloc] initWithRootViewController:[[SQNewViewController alloc] init]] title:@"新帖" image:@"tabBar_new_icon" selectedImage:@"tabBar_new_click_icon"];
    [self setupOneChildViewController:[[SQNavigationController alloc] initWithRootViewController:[[SQMeViewController alloc] init]] title:@"我" image:@"tabBar_me_icon" selectedImage:@"tabBar_me_click_icon"];
    
}



- (void)setupOneChildViewController:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage{
    //此处加载view的颜色会使得系统加载当前ViewController的View,没有做多需要时候才调用的原则,会浪费性能
    //vc.view.backgroundColor = SQRandomColor;
    //增加判断,当传入的内容有空值时就不为传入的controller赋值
    if (title.length && image && selectedImage) {
        vc.tabBarItem.title = title;
        vc.tabBarItem.image = [UIImage imageNamed:image];
        vc.tabBarItem.selectedImage = [UIImage  imageNamed:selectedImage];
    }
    [self addChildViewController:vc];
}

-(void)setupTabBar{
    //使用自定义的TabBar替换系统的TabBar,利用KVC
    [self setValue:[[SQTabBar alloc] init] forKey:@"tabBar"];    
}


@end
