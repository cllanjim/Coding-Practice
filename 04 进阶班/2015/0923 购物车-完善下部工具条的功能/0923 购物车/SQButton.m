//
//  SQButton.m
//  0923 购物车
//
//  Created by 张思琦 on 15/9/23.
//  Copyright © 2015年 SQ Software Group. All rights reserved.
//

#import "SQButton.h"

@implementation SQButton

- (void)awakeFromNib{
    self.layer.borderColor = [UIColor redColor].CGColor;
    
    self.layer.borderWidth = 2;
    
    self.layer.cornerRadius = self.frame.size.width * 0.5;

}

@end
