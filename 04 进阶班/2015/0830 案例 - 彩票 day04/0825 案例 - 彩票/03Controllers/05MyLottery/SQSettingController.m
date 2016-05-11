//
//  SQSettingController.m
//  0825 案例 - 彩票
//
//  Created by 张思琦 on 15/9/1.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import "SQSettingController.h"
#import "SQPushController.h"
#import "SQBlurView.h"
#import "MBProgressHUD+XMG.h"

@interface SQSettingController ()

@end

@implementation SQSettingController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpSction01];
    [self setUpSction02];
    [self setUpSction03];
    // Do any additional setup after loading the view.
}

- (void)setUpSction01{
    /*************************** section1 ************************/
    SQSectionModel *section1 = [SQSectionModel sectionModelWithHeaderTitle:nil FooterTitle:nil];
    
    SQArrowRowModel *row11 = [SQArrowRowModel rowModelWithTitle:@"使用兑换码" subTitle:nil];
    row11.iconImage = [UIImage imageNamed:@"RedeemCode"];
    //    row11.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow_right"]];
    row11.className = [SQPushController class];
    
    section1.groupOfRowModel = @[row11];
    
    [self.groupOfSectionModel addObject:section1];
    
}

- (void)setUpSction02{
    /*************************** section2 ************************/
    SQSectionModel *section2 = [SQSectionModel sectionModelWithHeaderTitle:nil FooterTitle:nil];
    
    SQArrowRowModel *row21 = [SQArrowRowModel rowModelWithTitle:@"推送和提醒" subTitle:nil];
    row21.iconImage = [UIImage imageNamed:@"MorePush"];
    //    row21.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow_right"]];
    row21.className = [SQPushController class];
    
    
    SQSwitchRowModel *row22 = [SQSwitchRowModel rowModelWithTitle:@"使用摇一摇精选" subTitle:nil];;
    row22.iconImage = [UIImage imageNamed:@"more_homeshake"];
    //    row22.accessoryView = [[UISwitch alloc] init];
    
    SQSwitchRowModel *row23 = [SQSwitchRowModel rowModelWithTitle:@"声音效果" subTitle:nil];;
    row23.iconImage = [UIImage imageNamed:@"sound_Effect"];
    //    row23.accessoryView = [[UISwitch alloc] init];
    
    SQSwitchRowModel *row24 = [SQSwitchRowModel rowModelWithTitle:@"采购小助手" subTitle:nil];;
    row24.iconImage = [UIImage imageNamed:@"More_LotteryRecommend"];
    //    row24.accessoryView = [[UISwitch alloc] init];
    
    
    section2.groupOfRowModel = @[row21, row22, row23, row24];
    
    [self.groupOfSectionModel addObject:section2];
    
}


- (void)setUpSction03{
    /*************************** section3 ************************/
    SQSectionModel *section3 = [SQSectionModel sectionModelWithHeaderTitle:nil FooterTitle:nil];
    
    SQArrowRowModel *row31 = [SQArrowRowModel rowModelWithTitle:@"检查新版本" subTitle:nil];;
    row31.iconImage = [UIImage imageNamed:@"MoreUpdate"];
    //    row31.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow_right"]];
    
    row31.optionBlock = ^(NSIndexPath *indexPath){
        
//        //创建蒙版
//         SQBlurView *blurView = [[SQBlurView alloc] initWithFrame:self.view.frame];
//        //将蒙版添加到主窗口
//        [[UIApplication sharedApplication].keyWindow addSubview:blurView];
//        
//        //延迟一段时间后移除蒙版
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [blurView removeFromSuperview];
//        });
//        
        [MBProgressHUD showSuccess:@"当前没有最新版本"];
        
    };

    
    
    
    
    
    SQArrowRowModel *row32 = [SQArrowRowModel rowModelWithTitle:@"分享" subTitle:nil];;
    row32.iconImage = [UIImage imageNamed:@"MoreShare"];
    //    row32.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow_right"]];
    
    
    SQArrowRowModel *row33 = [SQArrowRowModel rowModelWithTitle:@"产品推荐" subTitle:nil];;
    row33.iconImage = [UIImage imageNamed:@"MoreNetease"];
    //    row33.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow_right"]];
    
    
    SQArrowRowModel *row34 = [SQArrowRowModel rowModelWithTitle:@"关于" subTitle:nil];;
    row34.iconImage = [UIImage imageNamed:@"MoreAbout"];
    //    row34.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow_right"]];
    
    
    section3.groupOfRowModel = @[row31, row32, row33, row34];
    
    [self.groupOfSectionModel addObject:section3];
    
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
