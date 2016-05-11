//
//  SQSettingBaseController.m
//  0825 案例 - 彩票
//
//  Created by 张思琦 on 15/8/30.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import "SQSettingBaseController.h"
#import "SQSectionModel.h"
#import "SQRowModel.h"
#import "SQSettingBaseCell.h"
#import "SQPushController.h"

static NSString *ID = @"cell";

@interface SQSettingBaseController ()

@property (nonatomic, strong) NSArray *groupOfSectionModel;


@end

@implementation SQSettingBaseController

#pragma mark - groupOfSectionModel的懒加载
- (NSArray *)groupOfSectionModel
{
    if (_groupOfSectionModel == nil) {
        _groupOfSectionModel = [NSMutableArray array];
    }
    return _groupOfSectionModel;
}


- (instancetype)initWithStyle:(UITableViewStyle)style
{
    return [super initWithStyle:UITableViewStyleGrouped];
}



- (void)viewDidLoad {
    [super viewDidLoad];
/****************************** 设置NavigationBar和NavigationItem ********************/
    //设置tableViewController的标题
    self.navigationItem.title = @"设置";
    //设置右部的按钮
    UIBarButtonItem *help = [[UIBarButtonItem alloc] initWithTitle:@"常见问题" style:UIBarButtonItemStylePlain target:self action:nil];
    self.navigationItem.rightBarButtonItem = help;
    //设置cell的分割线形式
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
/*************************** 设置groupOfSectionModel数据 *************************/
    
//    UIImageView *style1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow_right"]];
//    UISwitch *style2 = [[UISwitch alloc] init];

   /*************************** section1 ************************/
    SQSectionModel *section1 = [SQSectionModel sectionModelWithHeaderTitle:nil FooterTitle:nil];
    
    SQRowModel *row11 = [SQRowModel rowModelWithTitle:@"使用兑换码" subTitle:nil];
    row11.iconImage = [UIImage imageNamed:@"RedeemCode"];
    row11.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow_right"]];
    
    section1.groupOfRowModel = @[row11];
    
    /*************************** section2 ************************/
    SQSectionModel *section2 = [SQSectionModel sectionModelWithHeaderTitle:nil FooterTitle:nil];
    
    SQRowModel *row21 = [SQRowModel rowModelWithTitle:@"推送和提醒" subTitle:nil];
    row21.iconImage = [UIImage imageNamed:@"MorePush"];
    row21.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow_right"]];

    
    SQRowModel *row22 = [SQRowModel rowModelWithTitle:@"使用摇一摇精选" subTitle:nil];;
    row22.iconImage = [UIImage imageNamed:@"more_homeshake"];
    row22.accessoryView = [[UISwitch alloc] init];
    
    SQRowModel *row23 = [SQRowModel rowModelWithTitle:@"声音效果" subTitle:nil];;
    row23.iconImage = [UIImage imageNamed:@"sound_Effect"];
    row23.accessoryView = [[UISwitch alloc] init];
    
//    row23.optionBlock =  ^(NSIndexPath *indexPath){
//        
//        []
//        
//    };


    
    SQRowModel *row24 = [SQRowModel rowModelWithTitle:@"采购小助手" subTitle:nil];;
    row24.iconImage = [UIImage imageNamed:@"More_LotteryRecommend"];
    row24.accessoryView = [[UISwitch alloc] init];

    
    section2.groupOfRowModel = @[row21, row22, row23, row24];
    
    /*************************** section3 ************************/
    SQSectionModel *section3 = [SQSectionModel sectionModelWithHeaderTitle:nil FooterTitle:nil];
    
    SQRowModel *row31 = [SQRowModel rowModelWithTitle:@"检查新版本" subTitle:nil];;
    row31.iconImage = [UIImage imageNamed:@"MoreUpdate"];
    row31.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow_right"]];

    
    SQRowModel *row32 = [SQRowModel rowModelWithTitle:@"分享" subTitle:nil];;
    row32.iconImage = [UIImage imageNamed:@"MoreShare"];
    row32.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow_right"]];

    
    SQRowModel *row33 = [SQRowModel rowModelWithTitle:@"产品推荐" subTitle:nil];;
    row33.iconImage = [UIImage imageNamed:@"MoreNetease"];
    row33.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow_right"]];

    
    SQRowModel *row34 = [SQRowModel rowModelWithTitle:@"关于" subTitle:nil];;
    row34.iconImage = [UIImage imageNamed:@"MoreAbout"];
    row34.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow_right"]];

    
    section3.groupOfRowModel = @[row31, row32, row33, row34];

    
    
    self.groupOfSectionModel = @[section1,section2,section3];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
//设置section数量
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    //返回当前集合中section的数量
    return self.groupOfSectionModel.count;
}

//设置每个section的row数量
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //取出当前section的模型
    SQSectionModel *sectionModel = self.groupOfSectionModel[section];
    //返回当前section中row的数量
    return sectionModel.groupOfRowModel.count;
}

//设置section的头部内容
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    //取出当前section的模型
    SQSectionModel *sectionModel = self.groupOfSectionModel[section];
    return sectionModel.headerTitle;

}

//设置section的尾部内容
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
    //取出当前section的模型
    SQSectionModel *sectionModel = self.groupOfSectionModel[section];
    return sectionModel.footerTitle;
}

//设置cell的样式
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //根据SQSettingBaseCell类提供的方法创建cell
    //传入的参数tableView确保从正确的缓存池中取出数据
    //传入的style参数保证创建的cell类型正确
    SQSettingBaseCell *cell = [SQSettingBaseCell cellWithTableView:tableView style:UITableViewCellStyleValue1];
    
    SQSectionModel *sectionModel = self.groupOfSectionModel[indexPath.section];
    SQRowModel *rowModel = sectionModel.groupOfRowModel[indexPath.row];
    
    cell.model = rowModel;

    return cell;
}

//设置当cell被选中时的方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"选中");
    
    SQSectionModel *sectionModel = self.groupOfSectionModel[indexPath.section];
    SQRowModel *rowModel = sectionModel.groupOfRowModel[indexPath.row];
    //判断block中是否有要执行的操作
    //如果操作非空就执行操作
    if (rowModel.optionBlock != nil) {
        rowModel.optionBlock(indexPath);
        return;
    }
    //判断是否要跳转
    if ([rowModel.accessoryView isKindOfClass:[UIImageView class]]) {
        
        SQPushController *pushController = [[SQPushController alloc] init];
        [self.navigationController pushViewController:pushController animated:YES];
    }
    
}

@end
