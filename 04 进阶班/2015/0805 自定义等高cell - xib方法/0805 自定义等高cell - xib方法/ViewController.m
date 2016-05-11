//
//  ViewController.m
//  0805 自定义等高cell - xib方法
//
//  Created by 张思琦 on 15/8/8.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import "ViewController.h"
#import "SQModelOfShopCell.h"
#import "SQModelOfShopInfo.h"
#import "MJExtension.h"

@interface ViewController ()

@property (nonatomic, strong) NSArray *groupOfShopInfo;

@end

@implementation ViewController

#pragma mark - groupOfShopInfo的懒加载

- (NSArray *)groupOfShopInfo
{
    if (_groupOfShopInfo == nil) {
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"tgs" ofType:@"plist"];
        _groupOfShopInfo = [SQModelOfShopInfo objectArrayWithFile:filePath];
    }
    return _groupOfShopInfo;
}

#pragma mark - viewDidLoad入口

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.rowHeight = 100;
    NSLog(@"%@",self.groupOfShopInfo);
    
    //UINib *nibName = [UINib nibWithNibName:NSStringFromClass([SQModelOfShopCell class]) bundle:nil];
    //[self.tableView registerNib:nibName forCellReuseIdentifier:@"SHOPCELL"];
    // Do any additional setup after loading the view, typically from a nib.
}


#pragma mark - 数据源方法

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.groupOfShopInfo.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//传统方法
    //1. 缓存池中寻找cell
    SQModelOfShopCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SHOPCELL"];
    
    //2. 判断cell是否为空
    if (cell == nil) {
        //2.1找到xib所在的bundle
        NSBundle *bundleName = [NSBundle mainBundle];
        //2.2找到nib的名称
        NSString *nibName = NSStringFromClass([SQModelOfShopCell class]);
        //2.3取出xib中的所有视图模型
        NSArray *groupOfView = [bundleName loadNibNamed:nibName owner:nil options:nil];
        //2.4找到对应的cell视图
        cell = [groupOfView lastObject];
    }
    
    //3.为cell赋值
    cell.modelOfShopInfo = self.groupOfShopInfo[indexPath.row];
    
    return cell;
  
}

@end
