//
//  SQCell.m
//  0921 数据刷新-全局刷新
//
//  Created by 张思琦 on 15/9/21.
//  Copyright © 2015年 SQ Software Group. All rights reserved.
//

#import "SQCell.h"
#import "SQCellModel.h"

@interface SQCell ()
@property (weak, nonatomic) IBOutlet UIImageView *selectedImageView;


@end

@implementation SQCell

- (void)setModelData:(SQCellModel *)modelData{
    
    _modelData = modelData;
    self.textLabel.text = modelData.wineName;
    self.detailTextLabel.text = modelData.winePrice;
    self.imageView.image = [UIImage imageNamed:modelData.winePicture];
    
    //将selectedImageView放到最上面
    [self.contentView  bringSubviewToFront:self.selectedImageView];
    //对selectedImageView进行赋值
    //当被选中时出现ImageView
    //当没被选中时不出现ImageView
    self.selectedImageView.hidden = !modelData.isSelected;
    
}


@end
