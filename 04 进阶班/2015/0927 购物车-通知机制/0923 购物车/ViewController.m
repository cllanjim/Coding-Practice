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
//view中的tableView控件
@property (weak, nonatomic) IBOutlet UITableView *tableView;
//底部view中的总价label控件
@property (weak, nonatomic) IBOutlet UILabel *totalPriceLabel;
//底部view中的购买按钮
@property (weak, nonatomic) IBOutlet UIButton *buyButton;
//底部view中的清空购物车按钮
@property (weak, nonatomic) IBOutlet UIButton *cleanButton;

//wine模型数组
@property (nonatomic, strong) NSMutableArray *groupOfCellModels;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(plusWine:) name:@"plusWine" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(minusWine:) name:@"minusWine" object:nil];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - buyButton







#pragma mark - totalPriceLabel
- (void)plusWine:(NSNotification *)note
{
    //获取发布通知的cell
    SQCell *cell = note.object;
    //计算价格
    //利用原先的价格+当前cell中酒的价格
    int newPrice = self.totalPriceLabel.text.intValue + cell.wineMoney.text.intValue;
    
    self.totalPriceLabel.text = [NSString stringWithFormat:@"%d",newPrice];
    
}

- (void)minusWine:(NSNotification *)note
{
    //获取发布通知的cell
    SQCell *cell = note.object;
    //计算价格
    //利用原先的价格-当前cell中酒的价格
    int newPrice = self.totalPriceLabel.text.intValue - cell.wineMoney.text.intValue;
    
    self.totalPriceLabel.text = [NSString stringWithFormat:@"%d",newPrice];
    
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
