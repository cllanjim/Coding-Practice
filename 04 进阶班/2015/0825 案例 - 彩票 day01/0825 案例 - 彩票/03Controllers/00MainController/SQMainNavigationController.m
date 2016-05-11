//
//  SQMainNavigationController.m
//  0825 案例 - 彩票
//
//  Created by 张思琦 on 15/8/25.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import "SQMainNavigationController.h"

@interface SQMainNavigationController ()

@end

@implementation SQMainNavigationController

+ (void)initialize{
    if (self == [SQMainNavigationController class]) {
        UINavigationBar *naviBar = [UINavigationBar appearanceWhenContainedIn:self, nil];
        [naviBar setBackgroundImage:[UIImage imageNamed:@"NavBar64"] forBarMetrics:UIBarMetricsDefault];
        
        NSDictionary *dict = @{
                               NSForegroundColorAttributeName :  [UIColor whiteColor] ,
                               NSFontAttributeName : [UIFont systemFontOfSize:20]
                               };
        
        [naviBar setTitleTextAttributes:dict];
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
