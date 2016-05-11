//
//  ViewController.m
//  0805 添加索引条
//
//  Created by 张思琦 on 15/8/8.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import "ViewController.h"
#import "SQModelOfSectionInfo.h"
#import "SQModelOfCarInfo.h"


@interface ViewController ()

@property (nonatomic, strong) NSArray *groupOfSectionInfo;


@end




@implementation ViewController


static NSString *ID = @"CAR";


- (NSArray *)groupOfSectionInfo
{
    if (_groupOfSectionInfo == nil) {
        _groupOfSectionInfo = [SQModelOfSectionInfo groupOfSectionInfo];
    }
    return _groupOfSectionInfo;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置数据源代理
    self.tableView.dataSource = self;
    
    
    
    NSLog(@"%@",self.groupOfSectionInfo);
    // Do any additional setup after loading the view, typically from a nib.
}


#pragma mark - 数据源代理的相关方法
//多少段
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.groupOfSectionInfo.count;
}


//每段多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    SQModelOfSectionInfo *sectionInfo = self.groupOfSectionInfo[section];
    return sectionInfo.groupOfCarInfo.count;
}

//每一行的内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //1. 从缓存池中取出cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    //2. 判断cell是否为空
    if(cell == nil){
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    //3.设置数据
    SQModelOfSectionInfo *sectionInfo = self.groupOfSectionInfo[indexPath.section];
    SQModelOfCarInfo *carInfo = sectionInfo.groupOfCarInfo[indexPath.row];
    //设置图片
    cell.imageView.image = carInfo.image;
    //设置文字
    cell.textLabel.text = carInfo.name;
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    SQModelOfSectionInfo *sectionInfo = self.groupOfSectionInfo[section];

    return sectionInfo.title;
}


#pragma mark - 控制器的方法

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

#pragma mark - 索引条方法
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    NSArray *indexTitle = [self.groupOfSectionInfo valueForKeyPath:@"title"];
    self.tableView.sectionIndexColor = [UIColor redColor];
    self.tableView.sectionIndexBackgroundColor = [UIColor blackColor];
    self.tableView.sectionIndexTrackingBackgroundColor = [UIColor blueColor];
    return indexTitle;
    
    
}



@end
