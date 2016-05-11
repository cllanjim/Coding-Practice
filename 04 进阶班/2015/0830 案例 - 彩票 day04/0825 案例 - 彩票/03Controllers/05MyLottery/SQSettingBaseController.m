//
//  SQSettingBaseController.m
//  0825 案例 - 彩票
//
//  Created by 张思琦 on 15/8/30.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import "SQSettingBaseController.h"


static NSString *ID = @"cell";


@interface SQSettingBaseController ()
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
    if ([rowModel isKindOfClass:[SQArrowRowModel class]]) {
        //将SQRowModel强制转换为SQArrowRowModel类型
        SQArrowRowModel *model = (SQArrowRowModel *)rowModel;
        //如果存在要跳转页面的类就执行括号内的动作
        if(model.className != nil){
            //根据类生成跳转的控制器,并进行跳转
            UIViewController *nextPage = [[model.className alloc] init];
            [self.navigationController pushViewController:nextPage animated:YES];
        
        }
        
    }
    
}

@end
