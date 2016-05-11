//
//  ViewController.m
//  0804 单组数据
//
//  Created by 张思琦 on 15/8/7.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import "ViewController.h"
#import "SQWineInfo.h"

@interface ViewController () <UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSArray *groupOfWine;
@end

@implementation ViewController

- (NSArray *)groupOfWine
{
    if (_groupOfWine == nil) {
        _groupOfWine = [SQWineInfo groupOfWineInfo];
    }
    return _groupOfWine;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.dataSource = self;
    
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//多少段
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.groupOfWine.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
    SQWineInfo *wineInfo = self.groupOfWine[indexPath.row];
    
    cell.imageView.image = wineInfo.imageOfWine;
    cell.textLabel.text = wineInfo.name;
    cell.detailTextLabel.text =  [NSString stringWithFormat:@"￥%@", wineInfo.money];
    cell.detailTextLabel.textColor = [UIColor orangeColor];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

@end
