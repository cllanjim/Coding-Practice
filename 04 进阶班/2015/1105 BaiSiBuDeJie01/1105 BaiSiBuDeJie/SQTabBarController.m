//
//  SQTabBarController.m
//  1105 BaiSiBuDeJie
//
//  Created by 张思琦 on 15/11/5.
//  Copyright © 2015年 SQ Software Group. All rights reserved.
//

#import "SQTabBarController.h"

@interface SQTabBarController ()

@end

@implementation SQTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //在asset.xcassets中将图片重新设置,防止其被渲染
    
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
    
    
    
    //添加子控制器
    [self setupOneChildViewController:[[UITableViewController alloc] init] title:@"精华" image:@"tabBar_essence_icon" selectedImage:@"tabBar_essence_click_icon"];
     [self setupOneChildViewController:[[UITableViewController alloc] init] title:@"新帖" image:@"tabBar_new_icon" selectedImage:@"tabBar_new_click_icon"];
     [self setupOneChildViewController:[[UIViewController alloc] init] title:@"关注" image:@"tabBar_friendTrends_icon" selectedImage:@"tabBar_friendTrends_click_icon"];
     [self setupOneChildViewController:[[UITableViewController alloc] init] title:@"我" image:@"tabBar_me_icon" selectedImage:@"tabBar_me_click_icon"];
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)setupOneChildViewController:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage{
    
    vc.view.backgroundColor = SQRandomColor;
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:image];
    vc.tabBarItem.selectedImage = [UIImage  imageNamed:selectedImage];
    [self addChildViewController:vc];
    
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
