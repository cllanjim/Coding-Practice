//
//  SQMeViewController.m
//  1105 BaiSiBuDeJie
//
//  Created by 张思琦 on 15/11/7.
//  Copyright © 2015年 SQ Software Group. All rights reserved.
//

#import "SQMeViewController.h"
#import "SQSettingViewController.h"
#import "SQMeCell.h"
#import "SQFooterView.h"



@interface SQMeViewController ()

@end

@implementation SQMeViewController

- (instancetype)init{
    return [self initWithStyle:UITableViewStyleGrouped];

}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundColor = SQCommonBgColor;
    //设置NavigationBar
    [self setNavegationBar];
    //设置tableView中Section的header和footer
    [self setSectionHeaderAndFooter];

    //设置tableView的自动调整属性
//    self.automaticallyAdjustsScrollViewInsets = NO;
    //
//    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 20)];
//    self.tableView.tableHeaderView.backgroundColor = [UIColor orangeColor];
//    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 50)];
//    self.tableView.tableFooterView.backgroundColor = [UIColor greenColor];
    
}

- (void)setSectionHeaderAndFooter{
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.sectionFooterHeight = SQCommonMargin;
    //调整偏移量
    self.tableView.contentInset = UIEdgeInsetsMake(SQCommonMargin - 35, 0, 0, 0);
    
    //设置footerView
    //此时footerView存在,但没有高度
    SQFooterView *footerView = [[SQFooterView alloc] init];
//    footerView.sq_height = 1000;
    self.tableView.tableFooterView = footerView;
    self.tableView.tableFooterView.backgroundColor = SQRandomColor;
}

- (void)setNavegationBar{
    // 标题
    self.navigationItem.title = @"我的";
    
    UIBarButtonItem *settingItem = [UIBarButtonItem itemWithImage:@"mine-setting-icon" highImage:@"mine-setting-icon-click" target:self action:@selector(settingClick)];
    
    UIBarButtonItem *moonItem = [UIBarButtonItem itemWithImage:@"mine-moon-icon" highImage:@"mine-moon-icon-click" target:self action:@selector(moonClick)];
    
    self.navigationItem.rightBarButtonItems = @[settingItem, moonItem];

}


- (void)settingClick
{
    SQLOGFUNC;
    SQSettingViewController *vc = [[SQSettingViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)moonClick
{
    SQLOGFUNC;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

static NSString *ID = @"meCell";
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    SQMeCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[SQMeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    
    if (indexPath.section == 0) {
        cell.textLabel.text = @"登录/注册";
        cell.imageView.image = [UIImage imageNamed:@"setup-head-default"];
    }else{
        cell.textLabel.text = @"离线下载";
        cell.imageView.image = nil;
    
    }
    return cell;
    
}

#pragma mark - UITableViewDelegate

//用于设置cell的高度
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//        return 44;
//}

//////设置高度
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    return 0;
//}
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//    return 0;
//}
////设置view
//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 100)];
//    view.backgroundColor = [UIColor redColor];
//    return view;
//}
//-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 100)];
//    view.backgroundColor = [UIColor yellowColor];
//    return view;
//}
////设置cell被选中的操作
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//    NSLog(@"%@",NSStringFromCGRect(cell.frame));
//}

@end
