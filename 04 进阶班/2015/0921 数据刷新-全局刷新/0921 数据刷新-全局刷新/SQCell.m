//
//  SQCell.m
//  0921 数据刷新-全局刷新
//
//  Created by 张思琦 on 15/9/21.
//  Copyright © 2015年 SQ Software Group. All rights reserved.
//

#import "SQCell.h"
#import "SQCellModel.h"


@implementation SQCell

- (void)setModelData:(SQCellModel *)modelData{
    
    _modelData = modelData;
    self.textLabel.text = modelData.wineName;
    self.detailTextLabel.text = modelData.winePrice;
    self.imageView.image = [UIImage imageNamed:modelData.winePicture];

}


@end
