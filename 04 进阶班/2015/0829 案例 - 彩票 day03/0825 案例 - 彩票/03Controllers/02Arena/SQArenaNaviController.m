//
//  SQArenaNaviController.m
//  0825 案例 - 彩票
//
//  Created by 张思琦 on 15/8/26.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import "SQArenaNaviController.h"

@interface SQArenaNaviController ()

@end

@implementation SQArenaNaviController

+ (void)initialize
{
    //当加载的控制器为SQArenaNaviController时才执行
    if (self == [SQArenaNaviController class]) {

        //获取NavigationBar对象
        UINavigationBar *naviBar = [UINavigationBar appearanceWhenContainedIn:self, nil];
        //获取拉伸后的背景图像
        UIImage *image = [UIImage imageNamed:@"NLArenaNavBar64"];
        //拉伸的方法 苹果推荐使用的新方法
        image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(1, 1, 1, 1) resizingMode:UIImageResizingModeStretch];
        //设置NavigationBar的背景图片
        [naviBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
        
    }

}

- (void)viewDidLoad {
    [super viewDidLoad];
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
