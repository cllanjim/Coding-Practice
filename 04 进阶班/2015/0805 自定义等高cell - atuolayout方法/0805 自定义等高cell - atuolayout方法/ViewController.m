//
//  ViewController.m
//  0805 自定义等高cell - atuolayout方法
//
//  Created by 张思琦 on 15/8/8.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import "ViewController.h"
#import "SQModelOfShop.h"
#import "SQModelOfShopInfo.h"



static NSString *ID = @"SHOP";

@interface ViewController ()

@property (nonatomic, strong) NSArray *groupOfShopInfo;


@end

@implementation ViewController

- (NSArray *)groupOfShopInfo
{
    if (_groupOfShopInfo == nil) {
        _groupOfShopInfo = [SQModelOfShopInfo groupOfShopInfo];
    }
    return _groupOfShopInfo;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.rowHeight = 100;
    NSLog(@"%@", self.groupOfShopInfo);
    
    //使用注册方法优化cell
    [self.tableView registerClass:[SQModelOfShop class] forCellReuseIdentifier:ID];
    
    
    // Do any additional setup after loading the view, typically from a nib.
}

#pragma mark - 数据源方法

//section number
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


//row number
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.groupOfShopInfo.count;
}


//content of cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //1. 从缓存池中取出cell
    SQModelOfShop *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
//    //2. 判断缓存池中的cell是否为空
//    if (cell == nil) {
//        cell = [[SQModelOfShop alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
//    }
    
    //3. 给内容赋值
    cell.shopInfo = self.groupOfShopInfo[indexPath.row];
    
    return cell;
}

@end
