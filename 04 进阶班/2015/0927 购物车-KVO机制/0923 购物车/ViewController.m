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

@property (weak, nonatomic) IBOutlet UILabel *totalPriceLabel;

@property (nonatomic, strong) NSMutableArray *groupOfCellModels;
@property (weak, nonatomic) IBOutlet UIButton *buyButton;
@property (weak, nonatomic) IBOutlet UIButton *cleanButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(plusWine:) name:@"plusWine" object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(minusWine:) name:@"minusWine" object:nil];
    
    //在初始状态下buyButton键禁用
    self.buyButton.enabled = NO;
    
    // Do any additional setup after loading the view, typically from a nib.
}

//在控制器自身充当监听者时,要在其被销毁时移除
//- (void)dealloc{
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
//
//}


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


#pragma mark - totalPriceLabel的监听方法
//- (void)plusWine:(NSNotification *)note
//{
//    //获取发布通知的cell
//    SQCell *cell = note.object;
//    //计算价格
//    //利用原先的价格+当前cell中酒的价格
//    //从cell的模型数据中取单价!!!!
//    int newPrice = self.totalPriceLabel.text.intValue + cell.dataModel.money.intValue;
//    
//    self.totalPriceLabel.text = [NSString stringWithFormat:@"%d",newPrice];
//    
//    //一旦用户点了+号,就应当可以点击购买按钮
//    self.buyButton.enabled = YES;
//    
//}
//
//
//- (void)minusWine:(NSNotification *)note
//{
//    //获取发布通知的cell
//    SQCell *cell = note.object;
//    //计算价格
//    //利用原先的价格-当前cell中酒的价格
//    //从cell的模型数据中取单价!!!!
//    int newPrice = self.totalPriceLabel.text.intValue - cell.dataModel.money.intValue;
//    
//    self.totalPriceLabel.text = [NSString stringWithFormat:@"%d",newPrice];
//    
//    //当总价为0时,应当禁止购买
//    if([self.totalPriceLabel.text isEqualToString:@"0"])
//    {
//        self.buyButton.enabled = NO;
//    }
//}




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
        
        //为每个模型增加监听者
//        NSKeyValueObservingOptionNew = 0x01,
//        NSKeyValueObservingOptionOld = 0x02,
//        NSKeyValueObservingOptionInitial = 0x04,
//        NSKeyValueObservingOptionPrior = 0x08
        for (SQCellDataModel *dataModel in self.groupOfCellModels) {
            [dataModel addObserver:self forKeyPath:@"count" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
        }
        
    }
    return _groupOfCellModels;
}


#pragma mark - KVO对应的方法
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    
//    NSString *const NSKeyValueChangeKindKey;
//    NSString *const NSKeyValueChangeNewKey;
//    NSString *const NSKeyValueChangeOldKey;
//    NSString *const NSKeyValueChangeIndexesKey;
//    NSString *const NSKeyValueChangeNotificationIsPriorKey;
    int new = [change[NSKeyValueChangeNewKey] intValue];
    int old = [change[NSKeyValueChangeOldKey] intValue];
    
    if(new > old){
    //增加总价
        SQCellDataModel *dataModel = (SQCellDataModel *)object;
        self.totalPriceLabel.text = [NSString stringWithFormat:@"%d",self.totalPriceLabel.text.intValue + dataModel.money.intValue];
        
        self.buyButton.enabled = YES;
        
        ;
    }else{
    //减少总价
        SQCellDataModel *dataModel = (SQCellDataModel *)object;
        self.totalPriceLabel.text = [NSString stringWithFormat:@"%d",self.totalPriceLabel.text.intValue - dataModel.money.intValue];
        
        if ([self.totalPriceLabel.text isEqualToString:@"0"]) {
            self.buyButton.enabled = NO;
        }
    }
}
#pragma mark - dealloc方法 用于移除dataModel中的监听者
- (void)dealloc{
    for (SQCellDataModel *dataModel in self.groupOfCellModels) {
        [dataModel removeObserver:self forKeyPath:@"count"];
    }
    
}

@end
