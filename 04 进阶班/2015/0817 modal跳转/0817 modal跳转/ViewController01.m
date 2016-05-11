//
//  ViewController01.m
//  0817 modal跳转
//
//  Created by 张思琦 on 15/8/17.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import "ViewController01.h"
#import "ViewController02.h"

@interface ViewController01 ()

@property (nonatomic, strong) UIViewController *tempController;

@end

@implementation ViewController01
//返回至上一页
- (IBAction)prevPage:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        NSLog(@"%@",self.parentViewController);
    }];
    
}

//跳转到下一页
- (IBAction)nextPage:(id)sender {
/*****************  系统使用的方法 *****************/
//    ViewController02 *vc02 = [[ViewController02 alloc] init];
//    
//    //使用modal方法跳转界面
//    [self presentViewController:vc02 animated:YES completion:^{
//        //查看当前window的根控制器
//        UIViewController *rootVc = [UIApplication sharedApplication].keyWindow.rootViewController;
//        NSLog(@"%@",rootVc);
//        //查看当前控制器的presentedViewController属性
//        NSLog(@"%@", self.presentedViewController);
//    }];

    
/******************* 模仿系统的modal跳转 ******************/
    //1 创建要跳转的viewController
    ViewController02 *vc02 = [[ViewController02 alloc] initWithNibName:@"ViewController02" bundle:nil];
    //2 强引用vc02
    self.tempController = vc02;
    //vc02.tempController = self;
    //3 将vc02添加到keyWindow中
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:self.tempController.view];
    //3 设置动画
    self.tempController.view.transform = CGAffineTransformMakeTranslation(0 , keyWindow.bounds.size.height);
    [UIView animateWithDuration:0.5 animations:^{
        self.tempController.view.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        [self.view removeFromSuperview];
    }];

    //因为第01个controller是第00个controller modal过来的,所以肯定01被强引用
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
