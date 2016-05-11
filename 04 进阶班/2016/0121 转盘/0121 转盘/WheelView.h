//
//  WheelView.h
//  0121 转盘
//
//  Created by 张思琦 on 16/1/21.
//  Copyright © 2016年 SQ Software Group. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WheelView : UIView

- (void)startRotate;
- (void)pauseRotate;

+ (instancetype)wheel;

@end
