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




#pragma mark - 生命周期相关的方法

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置TabBar字体样式
    [self setUpTitleTextAttributes];
    //设置TabBarController的子控制器
    [self setUpChildrenViewController];
    //设置TabBarController的TabBar
    [self setupTabBar];
    
    
}




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

    
    //创建自定义的NavigationController,并以自己的ViewController为根控制器
    [self setupOneChildViewController:[[SQNavigationController alloc] initWithRootViewController:[[SQMeViewController alloc] init]] title:@"我" image:@"tabBar_me_icon" selectedImage:@"tabBar_me_click_icon"];
    [self setupOneChildViewController:[[SQNavigationController alloc] initWithRootViewController:[[SQFollowViewController alloc] init]] title:@"关注" image:@"tabBar_friendTrends_icon" selectedImage:@"tabBar_friendTrends_click_icon"];
    [self setupOneChildViewController:[[SQNavigationController alloc] initWithRootViewController:[[SQEssenceViewController alloc] init]] title:@"精华" image:@"tabBar_essence_icon" selectedImage:@"tabBar_essence_click_icon"];
    [self setupOneChildViewController:[[SQNavigationController alloc] initWithRootViewController:[[SQNewViewController alloc] init]] title:@"新帖" image:@"tabBar_new_icon" selectedImage:@"tabBar_new_click_icon"];

    
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
