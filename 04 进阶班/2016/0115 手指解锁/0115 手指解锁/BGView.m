//
//  BGView.m
//  0115 手指解锁
//
//  Created by 张思琦 on 16/1/15.
//  Copyright © 2016年 SQ Software Group. All rights reserved.
//

#import "BGView.h"

@implementation BGView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    UIImage *backgroundImage = [UIImage imageNamed:@"Home_refresh_bg"];
    [backgroundImage drawInRect:rect];
}

@end
