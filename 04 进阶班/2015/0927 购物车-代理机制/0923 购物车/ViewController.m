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


@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,SQCellDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UILabel *totalPriceLabel;

@property (nonatomic, strong) NSMutableArray *groupOfCellModels;
@property (weak, nonatomic) IBOutlet UIButton *buyButton;
@property (weak, nonatomic) IBOutlet UIButton *cleanButton;

@end

@implementation ViewController

- (void)sqcelldidClickPlusButton:(SQCell *)cell{
    
    int totalPrice = self.totalPriceLabel.text.intValue + cell.dataModel.money.intValue;

    self.totalPriceLabel.text = [NSString stringWithFormat:@"%d",totalPrice];
    
    self.buyButton.enabled = YES;

}


- (void)sqcelldidClickMinusButton:(SQCell *)cell{

    int totalPrice = self.totalPriceLabel.text.intValue - cell.dataModel.money.intValue;
    
    self.totalPriceLabel.text = [NSString stringWithFormat:@"%d",totalPrice];
    
    if ([self.totalPriceLabel.text isEqualToString:@"0"]) {
        self.buyButton.enabled = NO;
    }
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //在初始状态下buyButton键禁用
    self.buyButton.enabled = NO;
    
    // Do any additional setup after loading the view, typically from a nib.
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//底部view的购买按钮
- (IBAction)buyButtonClick:(id)sender {
    
    //将wine模型数组中的所有count归零
    for (SQCellDataModel *dataModel in self.groupOfCellModels) {
        //如果个数不为0
        if (dataModel.count != 0) {
        NSLog(@"wineName%@-----wineNumber%d-----winePrice%@ ",dataModel.name,dataModel.count,dataModel.money);
        }
    }
    NSLog(@"%@",self.totalPriceLabel.text);

}


//底部view的清楚购物车按钮
- (IBAction)cleanButtonClick:(id)sender {
    
    //将wine模型数组中的所有count归零
    for (SQCellDataModel *dataModel in self.groupOfCellModels) {
        dataModel.count = 0;
    }
    
    [self.tableView reloadData];
    self.buyButton.enabled = NO;

    //将totalPriceLabel的价格归0
    self.totalPriceLabel.text = @"0";

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

    //设置cell的代理
    cell.delegate = self;
    
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
