//
//  ViewController.m
//  0804 TableView的基本使用
//
//  Created by 张思琦 on 15/8/7.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置tableView的数据源代理人为viewController
    self.tableView.dataSource = self;

    //设置tableView的代理人为viewController
    self.tableView.delegate = self;
    
    /******************* tableView的常见属性 *****************/
    //设置表头,表尾的高度
    self.tableView.sectionHeaderHeight = 80;
    self.tableView.sectionFooterHeight = 100;
    //设置表头,表尾的视图view
    self.tableView.tableHeaderView = [[UISwitch alloc] init];
    self.tableView.tableFooterView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    
   /*********************  tableViewCell的常见属性   *************/
    //设置cell的高度
    self.tableView.rowHeight = 60;

    //设置cell的分割线
    self.tableView.separatorColor = [UIColor redColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    //设置cell右边的指示标示

    
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
    return 16;
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
    
    
    /*********************  tableViewCell的常见属性   *************/
    //从默认选项中设置右边的标示
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    //自定义设置右边的标示
    cell.accessoryView = [[UISwitch alloc] init];
    //设置背景色
    cell.backgroundColor = [UIColor purpleColor];
    
    UIView *backgroudView = [[UIView alloc] init];
    backgroudView.backgroundColor = [UIColor orangeColor];
    cell.backgroundView = backgroudView;
    
    //设置选中的颜色
    cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    
    UIView *selectionView = [[UIView alloc] init];
    selectionView.backgroundColor = [UIColor grayColor];
    cell.selectedBackgroundView = selectionView;
    

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


/********************* UITableViewDelegate的代理方法 *****************/
//选中某个cell时调用
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"现在选中的是第%zd段的第%zd个cell",indexPath.section, indexPath.row);
}

//取消某个选中的cell时调用
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"现在取消的是第%zd段的第%zd个cell",indexPath.section, indexPath.row);

}

//在段落头部显示一个控件
//会使- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section方法失效

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
     return [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
}


//在段落底部显示一个控件
//会使- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section方法失效

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [[UISwitch alloc] init];
}

//设置段首的高度 能设置不同段的高度
//self.tableView.sectionHeaderHeight = 80;

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section{
    return 40;
}

//设置断尾的高度 能设置不同段的高度
//self.tableView.sectionFooterHeight = 100;
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForFooterInSection:(NSInteger)section{
    return 40;
}

//设置cell的高度
//self.tableView.rowHeight = 60;
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}


@end
