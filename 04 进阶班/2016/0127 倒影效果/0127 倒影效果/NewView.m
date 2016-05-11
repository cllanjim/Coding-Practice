//
//  NewView.m
//  0127 倒影效果
//
//  Created by 张思琦 on 16/1/27.
//  Copyright © 2016年 SQ Software Group. All rights reserved.
//

#import "NewView.h"

@implementation NewView

//为view类创建指定的layer层
+ (Class)layerClass{
    return [CAReplicatorLayer class];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
