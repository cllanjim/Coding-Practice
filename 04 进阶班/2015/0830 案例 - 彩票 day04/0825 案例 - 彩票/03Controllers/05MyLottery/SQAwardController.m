//
//  SQAwardController.m
//  0825 案例 - 彩票
//
//  Created by 张思琦 on 15/9/1.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import "SQAwardController.h"

@interface SQAwardController ()

@end

@implementation SQAwardController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 第一组
    [self addGroup0];
    
    // 第二组
    [self addGroup1];
    
    // 第三组
    [self addGroup2];
    
    // 第三组
    [self addGroup2];
    
    // 第三组
    [self addGroup2];
    
    // 第三组
    [self addGroup2];
    
    // 第三组
    [self addGroup2];
    
}


- (void)addGroup0
{
    SQSectionModel *group = [SQSectionModel sectionModelWithHeaderTitle:nil FooterTitle:@"开启后，当我投注或关注的比赛开始、进球和结束时，会自动发送推送消息提醒我"];
    SQRowModel *item = [SQRowModel rowModelWithTitle:@"推送我关注的比赛" subTitle:nil];
    
    group.groupOfRowModel = @[item];
    
    [self.groupOfSectionModel addObject:group];
    
}

- (void)addGroup1
{

    SQSectionModel *group = [SQSectionModel sectionModelWithHeaderTitle:@"只在以下时间段接收比分直播推送" FooterTitle:nil];
    SQRowModel *item = [SQRowModel rowModelWithTitle:@"起始时间" subTitle:@"00:00"];
    
    group.groupOfRowModel = @[item];
    
    [self.groupOfSectionModel addObject:group];
    
}

- (void)addGroup2
{
    
    SQSectionModel *group = [SQSectionModel sectionModelWithHeaderTitle:nil FooterTitle:nil];
    SQRowModel *item = [SQRowModel rowModelWithTitle:@"结束时间" subTitle:@"23:59"];
    
    group.groupOfRowModel = @[item];
    
    
    __weak typeof(self) weakSelf = self;
    
    item.optionBlock = ^(NSIndexPath *indexPath){
        
        
        UITableViewCell *cell = [weakSelf.tableView cellForRowAtIndexPath:indexPath];
        
        UITextField *textField = [[UITextField alloc] init];
        
        [textField becomeFirstResponder];
        
        [cell addSubview:textField];
        
    };
    
    [self.groupOfSectionModel addObject:group];
 
}

- (void)dealloc
{
    NSLog(@"%s",__func__);
}

@end
