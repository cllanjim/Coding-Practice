//
//  SQInfoView.m
//  0825 案例 - 彩票
//
//  Created by 张思琦 on 15/8/26.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import "SQInfoView.h"



@implementation SQInfoView

+ (instancetype)infoView
{
    SQInfoView *infoView = [[[NSBundle mainBundle] loadNibNamed:@"SQInfoView" owner:nil options:nil] lastObject];
    return infoView;

}


- (void)showInPoint:(CGPoint)point{
    
    self.center = point;
    
    [[UIApplication sharedApplication].keyWindow addSubview:self];
}

- (void)hideInPoint:(CGPoint)point completion:(void (^)())completionBlock
{
    [UIView animateWithDuration:0.5 animations:^{
        self.center = point;
        self.transform = CGAffineTransformMakeScale(0.01, 0.01);
        
        
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        if (completionBlock) {
            completionBlock();
        }
    }];

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (IBAction)backToController:(id)sender {
    
    if ([self.delegate respondsToSelector:@selector(removeInfoViewAndCover:)]) {
        
        //[self hideInPoint:CGPointMake(44, 44)];
        [self.delegate removeInfoViewAndCover:self];
    }
    
}

@end
