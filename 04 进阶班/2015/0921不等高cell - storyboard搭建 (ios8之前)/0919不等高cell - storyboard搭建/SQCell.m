//
//  SQCell.m
//  0919不等高cell - storyboard搭建
//
//  Created by 张思琦 on 15/9/19.
//  Copyright © 2015年 SQ Software Group. All rights reserved.
//

#import "SQCell.h"
#import "SQCellModel.h"

@implementation SQCell



- (void)setCellModel:(SQCellModel *)cellModel{
    _cellModel = cellModel;
    
    self.name_ImageView.image = [UIImage imageNamed:cellModel.name_ImageView_name];
    self.name_Label.text = cellModel.name_Label_name;
    self.text_Label.text = cellModel.text_Label_text;

    if (cellModel.isVIP) {
        self.vip_ImageView.hidden = NO;
        self.name_Label.textColor = [UIColor orangeColor];
        self.vip_ImageView.image = [UIImage imageNamed:@"vip"];
    }else{
        self.vip_ImageView.hidden = YES;
        self.name_Label.textColor = [UIColor blackColor];
    }
    
    if (cellModel.text_ImageView_name) {
//        self.imageHeight.constant = 100;
//        self.imageBottom.constant = 10;
        self.text_ImageView.hidden = NO;
        self.text_ImageView.image = [UIImage imageNamed:cellModel.text_ImageView_name];
    }else{
        self.text_ImageView.hidden = YES;

//        self.imageHeight.constant = 0;
//        self.imageBottom.constant = 0;
    }
}

- (CGFloat)cellHeight{
    //手动设置文字的最大宽度
    self.text_Label.preferredMaxLayoutWidth = [UIScreen mainScreen].bounds.size.width - 2 * 10;
    //强制布局cell内部的所有子控件
    [self layoutIfNeeded];
    
    if(self.cellModel.text_ImageView_name)
    {
        return CGRectGetMaxY(self.text_ImageView.frame) + 10;
    }else{
        return CGRectGetMaxY(self.text_Label.frame) + 10;
    }

}


@end
