//
//  SQPushController.m
//  0825 案例 - 彩票
//
//  Created by 张思琦 on 15/9/1.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import "SQPushController.h"
#import "SQScoreController.h"
#import "SQAwardController.h"

@interface SQPushController ()

@end

@implementation SQPushController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpSction01];
    // Do any additional setup after loading the view.
}

- (void)setUpSction01{
    /*************************** section2 ************************/
    SQSectionModel *section1 = [SQSectionModel sectionModelWithHeaderTitle:nil FooterTitle:nil];
    
    SQArrowRowModel *row11 = [SQArrowRowModel rowModelWithTitle:@"开奖推送" subTitle:nil];
//    row21.iconImage = [UIImage imageNamed:@"MorePush"];
    //    row21.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow_right"]];
    row11.className = [SQScoreController class];
    
    
    SQArrowRowModel *row12 = [SQArrowRowModel rowModelWithTitle:@"比分直播推送" subTitle:nil];;
//    row22.iconImage = [UIImage imageNamed:@"more_homeshake"];
    //    row22.accessoryView = [[UISwitch alloc] init];
    row12.className = [SQAwardController class];

    
    SQArrowRowModel *row13 = [SQArrowRowModel rowModelWithTitle:@"中奖动画" subTitle:nil];;
//    row23.iconImage = [UIImage imageNamed:@"sound_Effect"];
    //    row23.accessoryView = [[UISwitch alloc] init];
    
    SQArrowRowModel *row14 = [SQArrowRowModel rowModelWithTitle:@"采购提醒" subTitle:nil];;
//    row24.iconImage = [UIImage imageNamed:@"More_LotteryRecommend"];
    //    row24.accessoryView = [[UISwitch alloc] init];
    
    
    section1.groupOfRowModel = @[row11, row12, row13, row14];
    
    [self.groupOfSectionModel addObject:section1];
    
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
