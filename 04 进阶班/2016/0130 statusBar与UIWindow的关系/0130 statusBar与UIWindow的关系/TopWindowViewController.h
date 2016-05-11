//
//  TopWindowViewController.h
//  0130 statusBar与UIWindow的关系
//
//  Created by 张思琦 on 16/1/30.
//  Copyright © 2016年 SQ Software Group. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TopWindowViewController : UIViewController

@property (nonatomic, assign) UIStatusBarStyle statusBarStyle;
@property (nonatomic, assign) BOOL statusBarHidden;

+ (instancetype)sharedTopWindowViewController;

@end
