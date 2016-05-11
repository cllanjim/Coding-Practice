//
//  ViewController.m
//  0923 购物车
//
//  Created by 张思琦 on 15/9/23.
//  Copyright © 2015年 SQ Software Group. All rights reserved.
//

#import "ViewController.h"
#import "SQCell.h"
#import "SQCellDataModel.h"
#import "MJExtension.h"


@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *groupOfCellModels;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark ---- UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.groupOfCellModels.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *ID = @"cell";
    //1从缓存池中获取cell
    SQCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    //2为cell设置数据
    cell.dataModel = self.groupOfCellModels[indexPath.row];

    return cell;
}

#pragma mark ---- lazy of groupOfCellModels
- (NSMutableArray *)groupOfCellModels{
    if (_groupOfCellModels == nil) {
        _groupOfCellModels = [SQCellDataModel objectArrayWithFilename:@"wine.plist"];
    }
    return _groupOfCellModels;
}

@end
