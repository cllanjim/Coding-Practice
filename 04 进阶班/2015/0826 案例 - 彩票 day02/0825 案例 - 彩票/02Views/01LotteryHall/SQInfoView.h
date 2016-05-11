//
//  SQInfoView.h
//  0825 案例 - 彩票
//
//  Created by 张思琦 on 15/8/26.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SQInfoView;

@protocol SQInfoViewDelegate <NSObject>

@required
- (void)removeInfoViewAndCover:(SQInfoView *)infoView;

@end

@interface SQInfoView : UIView

@property (nonatomic, weak) id<SQInfoViewDelegate> delegate;

+ (instancetype)infoView;
- (void)showInPoint:(CGPoint)point;
//- (void)hideInPoint:(CGPoint)point completion:(void (^)())completionBlock;
- (void)hideInPoint:(CGPoint)point completion:(void (^)())completionBlock;



@end
