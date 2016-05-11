//
//  ViewController.m
//  0804 TableView的基本使用
//
//  Created by 张思琦 on 15/8/7.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置tableView的数据源代理人为viewController
    self.tableView.dataSource = self;
    //self.tableView.style  = UITableViewStyleGrouped;
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/********************* UITableViewDataSource数据代理的方法 *****************/
//通过该方法可以设定返回多少组数据
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;

}
//通过该方法可以设定每组中有多少行数据
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}
//通过该方法可以设定特定组特定行中的cell里的内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"ZSQ"];
    
    if (indexPath.section == 0) {
        cell.textLabel.text = @"ZSQ" ;
        cell.imageView.image  = [UIImage imageNamed:@"remove"];
        cell.detailTextLabel.text = @"一点都不帅的帅锅-----真的只是锅而已";
        
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }else if (indexPath.section == 1){
        cell.textLabel.text = @"XiXi";
        cell.imageView.image = [UIImage imageNamed:@"add"];
        cell.detailTextLabel.text = @"镁铝";
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    return cell;
}





- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSMutableString *title = [NSMutableString string];
    
    if (section == 0) {
        title = [NSMutableString stringWithFormat:@"男人"];
    }else if(section == 1){
        title = [NSMutableString stringWithFormat:@"女人"];

    }
    return title;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
    NSMutableString *title = [NSMutableString string];
    
    if (section == 0) {
        title = [NSMutableString stringWithFormat:@"联系方式5毛钱"];
    }else if(section == 1){
        title = [NSMutableString stringWithFormat:@"联系方式8毛钱"];
        
    }
    
    return title;
    
}

@end
