//
//  SQMyLotteryController.m
//  0825 案例 - 彩票
//
//  Created by 张思琦 on 15/8/25.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import "SQMyLotteryController.h"
#import "SQSettingBaseController.h"
#import "SQSettingController.h"

@interface SQMyLotteryController ()
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@end

@implementation SQMyLotteryController

- (void)viewDidLoad {
    [super viewDidLoad];
    /******************************* 给button加载图片 *******************/
    //获取button的图片
    UIImage *image = [self.loginButton currentBackgroundImage];
    //对图片做拉伸保护
    image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10) resizingMode:UIImageResizingModeStretch];
    //重新为button加载图片
    [self.loginButton setBackgroundImage:image forState:UIControlStateNormal];
    
    
    /******************************* 给NavigationBar加载左部按钮 *******************/
    UIButton *mm = [UIButton buttonWithType:UIButtonTypeCustom];
    [mm setImage:[UIImage imageNamed:@"FBMM_Barbutton"] forState:UIControlStateNormal];
    [mm setTitle:@"客服" forState:UIControlStateNormal];
    [mm sizeToFit];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:mm];
    
    /******************************* 给NavigationBar加载右部按钮 *******************/
    UIButton *setting  = [UIButton buttonWithType:UIButtonTypeCustom];
    [setting setImage:[UIImage imageNamed:@"Mylottery_config"] forState:UIControlStateNormal];
    [setting sizeToFit];
    [setting addTarget:self action:@selector(nextPage) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:setting];
    
    
    
    // Do any additional setup after loading the view.
}

- (void)nextPage{
    
    SQSettingBaseController *vc  = [[SQSettingController alloc] init];
    //生效
//    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController  pushViewController:vc animated:YES];
    //失效
//        vc.hidesBottomBarWhenPushed = YES;

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
