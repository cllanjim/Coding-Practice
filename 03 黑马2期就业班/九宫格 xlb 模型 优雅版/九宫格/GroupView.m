//
//  GroupView.m
//  九宫格
//
//  Created by 张思琦 on 15/7/18.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import "GroupView.h"
#import "GroupViewInfo.h"

@interface GroupView ()

@property (nonatomic, weak)IBOutlet UIImageView *iconImageView;
@property (nonatomic, weak)IBOutlet UILabel *iconLabel;

@end


@implementation GroupView

+ (instancetype)groupView
{
    GroupView *example = [[[NSBundle mainBundle] loadNibNamed:@"GroupView" owner:nil options:nil] firstObject];
    return example;
    
    
}



+ (instancetype)groupViewWithGroupViewInfo:(GroupViewInfo *)groupViewInfo
{
    GroupView *example = [GroupView groupView];
    [example setGroupViewInfo:groupViewInfo];
    return example;
}

//重写了groupViewInfo的set方法
- (void)setGroupViewInfo:(GroupViewInfo *)groupViewInfo
{
    _groupViewInfo = groupViewInfo;
    
    _iconLabel.text = groupViewInfo.name;
    _iconImageView.image = groupViewInfo.iconImage;
    
}




- (IBAction)clickIconButton:(UIButton *)iconButton
//- (IBAction)clickIconButton
{
    
    UILabel *labelOfLoading = [[UILabel alloc] initWithFrame:CGRectMake(80, 400, 200, 50)];
    labelOfLoading.backgroundColor = [UIColor colorWithWhite:0 alpha:0.2];
    
    labelOfLoading.text = self.groupViewInfo.name;
    labelOfLoading.textAlignment = NSTextAlignmentCenter;
    
    [self.superview addSubview:labelOfLoading];
    
    iconButton.enabled = NO;
    
    labelOfLoading.alpha = 0.2;
    
    [UIView animateWithDuration:1.0f animations:^{
        labelOfLoading.alpha = 1.0;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:1.0f animations:^{
            labelOfLoading.alpha = 0.0;
        } completion:^(BOOL finished) {
            [labelOfLoading removeFromSuperview];
        }];
    }];
}


@end
