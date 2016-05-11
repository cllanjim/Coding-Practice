//
//  ViewController.m
//  0805 自定义等高cell - storyboard
//
//  Created by 张思琦 on 15/8/8.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//


#import "ViewController.h"
#import "MJExtension.h"
#import "SQModelOfShopInfo.h"
#import "SQModelOfShopCell.h"

@interface ViewController ()

@property (nonatomic, strong) NSArray *groupOfShopInfo;

@end

@implementation ViewController

- (NSArray *)groupOfShopInfo{
    if (_groupOfShopInfo == nil) {
        
        _groupOfShopInfo = [SQModelOfShopInfo objectArrayWithFilename:@"tgs.plist"];
        
    }
    return _groupOfShopInfo;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.groupOfShopInfo.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
 
    SQModelOfShopCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SHOPCELL"];
    
    cell.modelOfShopInfo = self.groupOfShopInfo[indexPath.row];
    
    return cell;
    
}

@end
