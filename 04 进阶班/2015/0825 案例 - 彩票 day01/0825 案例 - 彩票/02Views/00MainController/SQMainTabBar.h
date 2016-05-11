//
//  SQMainTabBar.h
//  0825 案例 - 彩票
//
//  Created by 张思琦 on 15/8/25.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import <UIKit/UIKit.h>

/*************** TabBarButton的页面跳转协议 **************/
@protocol SQMainTabBarDelegate <NSObject>

@required

- (void)tabBar:(UIButton *)btn changeViewControllerWithTag:(NSInteger)tag;

@end


/*******************************************************/

@interface SQMainTabBar : UIView

@property (nonatomic, strong) NSMutableArray *items;
@property (nonatomic, weak) id<SQMainTabBarDelegate> delegate;




@end
