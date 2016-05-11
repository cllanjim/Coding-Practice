//
//  SQSettingBaseCell.m
//  0825 案例 - 彩票
//
//  Created by 张思琦 on 15/8/30.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import "SQSettingBaseCell.h"

@interface SQSettingBaseCell ()

//@property (nonatomic, strong) UIImageView *arrowView;
//@property (nonatomic, strong) UISwitch *switchView;

@end


@implementation SQSettingBaseCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

///******************** 右部添加 箭头 懒加载 **********************/
//- (UIImageView *)arrowView{
//    if (_arrowView == nil) {
//        UIImageView *img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow_right"]];
//        self.accessoryView = img;
//        _arrowView = img;
//    }
//    return _arrowView;
//}
///******************** 右部添加 开关 懒加载 **********************/
//- (UISwitch *)switchView
//{
//    if (_switchView == nil) {
//        UISwitch *swith = [[UISwitch alloc] init];
//        self.accessoryView = swith;
//        _switchView = swith;
//    }
//    return _switchView;
//}

/***************** 创建cell的方法 ********************/
+ (instancetype)cellWithTableView:(UITableView *)tableView style:(UITableViewCellStyle)style
{
    static NSString *ID = @"cell";
    
    SQSettingBaseCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[SQSettingBaseCell alloc] initWithStyle:style reuseIdentifier:ID];
        
    }
    
    //背景view
    cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"GroupCell"]];
    cell.selectedBackgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"GroupCellSelected"]];
    
    return cell;
}



- (void)setModel:(SQRowModel *)model
{
    _model = model;
    
    //设置基本属性
    self.textLabel.text = model.title;
    self.detailTextLabel.text = model.subTitle;
    self.imageView.image = model.iconImage;
    
    //设置右部的accessoryView
    self.accessoryView = model.accessoryView;
}




@end
