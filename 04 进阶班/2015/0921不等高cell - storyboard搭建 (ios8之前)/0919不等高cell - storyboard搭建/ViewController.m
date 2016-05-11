//
//  ViewController.m
//  0919不等高cell - storyboard搭建
//
//  Created by 张思琦 on 15/9/19.
//  Copyright © 2015年 SQ Software Group. All rights reserved.
//

#import "ViewController.h"
#import "SQCell.h"
#import "SQCellModel.h"
#import "MJExtension.h"


@interface ViewController ()

@property (nonatomic, strong) NSArray *groupOfModels;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"%@",self.groupOfModels);
//    // 告诉tableView所有cell的真实高度是自动计算（根据设置的约束来计算）
//    self.tableView.rowHeight = UITableViewAutomaticDimension;
    // 告诉tableView所有cell的估算高度
    self.tableView.estimatedRowHeight = 44;
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - groupOfModel Lazy
- (NSArray *)groupOfModels
{
    if (_groupOfModels == nil) {
        
        [SQCellModel setupReplacedKeyFromPropertyName:^NSDictionary *{
          return   @{
                    @"name_ImageView_name"   : @"icon",
                    @"name_Label_name"       : @"name",
                    @"isVIP"                 : @"vip",
                    @"text_Label_text"       : @"text",
                    @"text_ImageView_name"   : @"picture"
                    };
        }];
        
        _groupOfModels = [SQCellModel objectArrayWithFilename:@"statuses.plist"];
        
    }
    return _groupOfModels;
}


#pragma mark - UITableViewDataDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.groupOfModels.count;
}


static NSString *ID = @"cell";
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SQCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];

    cell.cellModel = self.groupOfModels[indexPath.row];
    
    return cell;
}


SQCell *cell;
#pragma mark - 代理方法
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(cell == nil){
        cell = [tableView dequeueReusableCellWithIdentifier:ID];
    }
    cell.cellModel = self.groupOfModels[indexPath.row];
    
    return cell.cellHeight;
    
}



@end
