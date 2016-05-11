//
//  SQScoreController.m
//  0825 案例 - 彩票
//
//  Created by 张思琦 on 15/9/1.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import "SQScoreController.h"

@interface SQScoreController ()

@end

@implementation SQScoreController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addGroup1];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)addGroup1
{
    
    SQSwitchRowModel *item1 = [SQSwitchRowModel rowModelWithTitle:@"双色球" subTitle:@"每周二、四、日开奖"];
    SQSwitchRowModel *item2 = [SQSwitchRowModel rowModelWithTitle:@"大乐透" subTitle:@"每周一、三、六开奖"];

    SQSwitchRowModel *item3 = [SQSwitchRowModel rowModelWithTitle:@"3D" subTitle:@"每天开奖、包括试机号提醒"];

    SQSwitchRowModel *item4 = [SQSwitchRowModel rowModelWithTitle:@"七乐彩" subTitle:@"每周一、三、五开奖"];

    SQSwitchRowModel *item5 = [SQSwitchRowModel rowModelWithTitle:@"七星彩" subTitle:@"每周二、五、日开奖"];
    SQSwitchRowModel *item6 = [SQSwitchRowModel rowModelWithTitle:@"排列3" subTitle:@"每天开奖"];

    SQSwitchRowModel *item7 = [SQSwitchRowModel rowModelWithTitle:@"排列5" subTitle:@"每天开奖"];
    
    
    

    
    SQSectionModel *group = [[SQSectionModel alloc] init];
    group.groupOfRowModel = @[item1,item2,item3,item4,item5,item6,item7];
    
    
    [self.groupOfSectionModel addObject:group];
    
}

//设置cell的样式
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //根据SQSettingBaseCell类提供的方法创建cell
    //传入的参数tableView确保从正确的缓存池中取出数据
    //传入的style参数保证创建的cell类型正确
    SQSettingBaseCell *cell = [SQSettingBaseCell cellWithTableView:tableView style:UITableViewCellStyleSubtitle];
    
    SQSectionModel *sectionModel = self.groupOfSectionModel[indexPath.section];
    SQRowModel *rowModel = sectionModel.groupOfRowModel[indexPath.row];
    
    cell.model = rowModel;
    
    return cell;
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
