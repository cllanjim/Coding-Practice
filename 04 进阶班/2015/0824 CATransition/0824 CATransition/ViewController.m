//
//  ViewController.m
//  0824 CATransition
//
//  Created by 张思琦 on 15/8/24.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic, assign) int index;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.index = 0;
    
    
    // Do any additional setup after loading the view, typically from a nib.
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (++self.index > 3) {
        self.index = 1;
    }
    NSString *imageName = [NSString stringWithFormat:@"%d", self.index];
    UIImage *image = [UIImage imageNamed:imageName];
    
    self.imageView.image = image;
    
    //1.创建动画
    CATransition *transition = [CATransition animation];
    //2.设置动画参数
    
    //设置动画的基本类型
    transition.type = @"pageCurl";
    /* The name of the transition. Current legal transition types include
     * `fade', `moveIn', `push' and `reveal'. Defaults to `fade'. */
    /* Common transition types. */
    
    CA_EXTERN NSString * const kCATransitionFade
    __OSX_AVAILABLE_STARTING (__MAC_10_5, __IPHONE_2_0);
    CA_EXTERN NSString * const kCATransitionMoveIn
    __OSX_AVAILABLE_STARTING (__MAC_10_5, __IPHONE_2_0);
    CA_EXTERN NSString * const kCATransitionPush
    __OSX_AVAILABLE_STARTING (__MAC_10_5, __IPHONE_2_0);
    CA_EXTERN NSString * const kCATransitionReveal
    __OSX_AVAILABLE_STARTING (__MAC_10_5, __IPHONE_2_0);
    
    //设置动画的转场方向
    transition.subtype = @"fromLeft";
    /* An optional subtype for the transition. E.g. used to specify the
     * transition direction for motion-based transitions, in which case
     * the legal values are `fromLeft', `fromRight', `fromTop' and
     * `fromBottom'. */
    /* Common transition subtypes. */
    
    CA_EXTERN NSString * const kCATransitionFromRight
    __OSX_AVAILABLE_STARTING (__MAC_10_5, __IPHONE_2_0);
    CA_EXTERN NSString * const kCATransitionFromLeft
    __OSX_AVAILABLE_STARTING (__MAC_10_5, __IPHONE_2_0);
    CA_EXTERN NSString * const kCATransitionFromTop
    __OSX_AVAILABLE_STARTING (__MAC_10_5, __IPHONE_2_0);
    CA_EXTERN NSString * const kCATransitionFromBottom
    __OSX_AVAILABLE_STARTING (__MAC_10_5, __IPHONE_2_0);
    
    //设置动画的进度
    transition.startProgress = 0.3;
    transition.endProgress = 0.9;
    
    transition.duration = 2;
    transition.repeatCount = 2;
    
    
    //3.添加动画至对应的layer
    [self.imageView.layer addAnimation:transition forKey:nil];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
