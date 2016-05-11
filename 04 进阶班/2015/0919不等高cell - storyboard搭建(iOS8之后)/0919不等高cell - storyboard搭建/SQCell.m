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
        self.imageHeight.constant = 100;
        self.imageBottom.constant = 10;
        self.text_ImageView.image = [UIImage imageNamed:cellModel.text_ImageView_name];
    }else{
        self.imageHeight.constant = 0;
        self.imageBottom.constant = 0;
    }
}


@end
