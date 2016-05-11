//
//  SQArenaView.m
//  0825 案例 - 彩票
//
//  Created by 张思琦 on 15/8/26.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import "SQArenaView.h"

@implementation SQArenaView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    UIImage *image = [UIImage imageNamed:@"NLArenaBackground"];
    [image drawInRect:rect];

}


@end
