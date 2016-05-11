//
//  SQCell.m
//  0923 购物车
//
//  Created by 张思琦 on 15/9/23.
//  Copyright © 2015年 SQ Software Group. All rights reserved.
//

#import "SQCell.h"
#import "SQButton.h"

@interface SQCell () 

@property (nonatomic, weak) IBOutlet UIImageView *wineImageView;
@property (nonatomic, weak) IBOutlet UILabel *wineName;
@property (nonatomic, weak) IBOutlet UILabel *wineMoney;
@property (weak, nonatomic) IBOutlet UILabel *wineCount;
@property (weak, nonatomic) IBOutlet SQButton *minusButton;
@property (weak, nonatomic) IBOutlet SQButton *addButton;

@end

@implementation SQCell

#pragma mark ---- dataModel的set方法
- (void)setDataModel:(SQCellDataModel *)dataModel{
    _dataModel = dataModel;
    self.wineImageView.image = [UIImage imageNamed:dataModel.image];
    self.wineName.text = dataModel.name;
    self.wineMoney.text = dataModel.money;
    
    //必须要对count的值进行赋值,否则会出现问题
    self.wineCount.text = [NSString stringWithFormat:@"%d",dataModel.count];
    
    //对minusButton进行enable判断
    if([self.wineCount.text isEqualToString:@"0"]){
        self.minusButton.enabled = NO;
    }else{
        self.minusButton.enabled = YES;
    }
    
}


#pragma mark ---- FunctionButton
- (IBAction)minusClick:(id)sender {
    //减少酒模型的数量值
    self.dataModel.count--;
    //根据模型中最新的数值设置Label
    self.wineCount.text = [NSString stringWithFormat:@"%d",self.dataModel.count];
    
    //当数量值等于0的时候,就禁止减号button功能
    if (self.dataModel.count == 0) {
        self.minusButton.enabled = NO;
    }
    
    
    //发送通知
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"minusWine" object:self];
    
}

- (IBAction)addClick:(id)sender {
    //增加酒模型的数量值
    self.dataModel.count++;
    
    self.wineCount.text = [NSString stringWithFormat:@"%d",self.dataModel.count];
    
    self.minusButton.enabled = YES;
    
    //发送通知
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"plusWine" object:self];
    
    
}


@end
