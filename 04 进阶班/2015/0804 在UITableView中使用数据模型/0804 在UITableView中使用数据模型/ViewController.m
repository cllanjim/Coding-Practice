//
//  ViewController.m
//  0804 在UITableView中使用数据模型
//
//  Created by 张思琦 on 15/8/7.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import "ViewController.h"
#import "SQModelOfSection.h"
#import "SQModelOfCarInfo.h"

@interface ViewController () <UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSArray *tableViewInfo;

@end

@implementation ViewController

- (NSArray *)tableViewInfo
{
    if (_tableViewInfo == nil) {
        _tableViewInfo = [SQModelOfSection groupOfSectionInfo];
    }
    return _tableViewInfo;
}




- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置tableView的dataSource代理
    self.tableView.dataSource = self;
    
    
    //测试数据模型
    NSArray *info = self.tableViewInfo;
    NSLog(@"%@", info);
//    SQModelOfSection
    
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//有多少段
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.tableViewInfo.count;
}

//每段有多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    SQModelOfSection *sectionInfo =  self.tableViewInfo[section];
    return sectionInfo.groupOfModel.count;
}

//每段每行的内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SQModelOfSection *sectionInfo =  self.tableViewInfo[indexPath.section];
    SQModelOfCarInfo *carInfo = sectionInfo.groupOfModel[indexPath.row];
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"car"];
    cell.textLabel.text = carInfo.name;
    cell.imageView.image = carInfo.image;
    
    
    return cell;
    
}


//段开头的内容
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    SQModelOfSection *sectionInfo =  self.tableViewInfo[section];
    NSString *titleOfHeader = [NSString stringWithFormat:@"%@", sectionInfo.titleOfHeader];
    return titleOfHeader;
}

//段结尾的内容
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
    SQModelOfSection *sectionInfo =  self.tableViewInfo[section];
    NSString *titleOfFooter = [NSString stringWithFormat:@"%@", sectionInfo.titleOfFooter];
    return titleOfFooter;
}


@end
