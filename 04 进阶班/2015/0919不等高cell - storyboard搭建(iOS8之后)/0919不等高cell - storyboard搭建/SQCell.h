//
//  SQCell.h
//  0919不等高cell - storyboard搭建
//
//  Created by 张思琦 on 15/9/19.
//  Copyright © 2015年 SQ Software Group. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SQCellModel;

@interface SQCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UIImageView *name_ImageView;
@property (nonatomic, strong) IBOutlet UILabel *name_Label;
@property (nonatomic, strong) IBOutlet UIImageView *vip_ImageView;
@property (nonatomic, strong) IBOutlet UILabel *text_Label;
@property (nonatomic, strong) IBOutlet UIImageView *text_ImageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageBottom;

@property (nonatomic, strong) SQCellModel *cellModel;

@end
