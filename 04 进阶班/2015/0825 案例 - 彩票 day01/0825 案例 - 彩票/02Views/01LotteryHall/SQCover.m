//
//  SQCover.m
//  0825 案例 - 彩票
//
//  Created by 张思琦 on 15/8/26.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import "SQCover.h"

@implementation SQCover

+ (void)show{
    SQCover *cover = [[SQCover alloc] initWithFrame:[UIScreen mainScreen].bounds];
    cover.backgroundColor = [UIColor blackColor];
    cover.alpha = 0.4;
    [[UIApplication sharedApplication].keyWindow addSubview:cover];

}

+ (void)hide
{
    for (UIView *cover in [UIApplication sharedApplication].keyWindow.subviews) {
        if ([cover isKindOfClass:[SQCover class]]) {
            [cover removeFromSuperview];
        }
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
