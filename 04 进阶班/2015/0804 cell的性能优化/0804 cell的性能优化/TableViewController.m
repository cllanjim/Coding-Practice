//
//  TableViewController.m
//  0804 cell的性能优化
//
//  Created by 张思琦 on 15/8/7.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import "TableViewController.h"

@interface TableViewController ()

@end

@implementation TableViewController


//设置标示符
static NSString *ID = @"number";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.rowHeight = 100;
    
    
    //注册某个重用的cell
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ID];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 200;
}


//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    static NSString *ID = @"number";
//    
//    //1.从缓存池中取出cell
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
//    
//    //2.检查缓存池中是否存在非空的cell
//    if(cell == nil){
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
//        //此处可以进行cell的初始化设置,这里的设置的内容会在循环过程中保持一致不会改变
//        cell.backgroundColor = [UIColor grayColor];
//    }
//    
//    //3.设置数据
//    cell.textLabel.text = [NSString stringWithFormat:@"%zd", indexPath.row];
//    if (indexPath.row % 2 == 0) {
//        cell.imageView.image = [UIImage imageNamed:@"add"];
//        cell.accessoryType = UITableViewCellAccessoryCheckmark;
//    }
//    else{
//        cell.imageView.image = [UIImage imageNamed:@"remove"];
//        cell.accessoryType = UITableViewCellAccessoryDetailButton;
//    }
//
//    return cell;
//}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    
    //1.从缓存池中取出cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    //2.设置数据
    cell.backgroundColor = [UIColor grayColor];
    cell.textLabel.text = [NSString stringWithFormat:@"%zd", indexPath.row];
    if (indexPath.row % 2 == 0) {
        cell.imageView.image = [UIImage imageNamed:@"add"];
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else{
        cell.imageView.image = [UIImage imageNamed:@"remove"];
        cell.accessoryType = UITableViewCellAccessoryDetailButton;
    }
    
    return cell;
}


@end
