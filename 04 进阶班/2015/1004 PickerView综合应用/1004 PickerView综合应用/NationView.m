//
//  NationView.m
//  1004 PickerView综合应用
//
//  Created by 张思琦 on 15/10/11.
//  Copyright © 2015年 SQ Software Group. All rights reserved.
//

#import "NationView.h"
#import "NationDataModel.h"

@interface NationView ()
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UIImageView *icon;

@end

@implementation NationView

+ (instancetype)nationView{
    return [[[NSBundle mainBundle] loadNibNamed:@"NationView" owner:nil options:nil] firstObject];

}

- (void)setDataModel:(NationDataModel *)dataModel{
    //设置模型数据
    _dataModel = dataModel;
    
    //对具体参数赋值
    self.name.text = dataModel.name;
//    self.icon.image = [UIImage imageNamed:dataModel.icon];
    self.icon.image = dataModel.icon;
    
}
@end
