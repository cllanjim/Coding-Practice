//
//  SQMainNavigationController.m
//  0825 案例 - 彩票
//
//  Created by 张思琦 on 15/8/25.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import "SQMainNavigationController.h"

@interface SQMainNavigationController () <UINavigationControllerDelegate, UIGestureRecognizerDelegate>

@property (nonatomic, strong) id popDelegate;


@end

@implementation SQMainNavigationController

+ (void)initialize{
    
    if (self == [SQMainNavigationController class]) {
        UINavigationBar *naviBar = [UINavigationBar appearanceWhenContainedIn:self, nil];
        [naviBar setBackgroundImage:[UIImage imageNamed:@"NavBar64"] forBarMetrics:UIBarMetricsDefault];
        
        NSDictionary *dict = @{
                               NSForegroundColorAttributeName :  [UIColor whiteColor] ,
                               NSFontAttributeName : [UIFont systemFontOfSize:20]
                               };
        
        [naviBar setTitleTextAttributes:dict];
    }
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
   
    
    //当使用自定义的UIBarButtonItem时,滑动功能失效
    //以下内容,是让使MainNaviController拥有滑动返回功能
    //当self.interactivePopGestureRecognizer.delegate == nil 时, 能够滑动界面
    //self.interactivePopGestureRecognizer.delegate == 原始值 时, 不能够滑动界面
    
    //利用自身属性记录当前self.interactivePopGestureRecognizer.delegate的值
    //self.popDelegate = self.interactivePopGestureRecognizer.delegate;
  
    //设置代理,监听子控制器有没有完全显示
    //遵守UINavigationControllerDelegate协议
    //self.delegate = self;
    
    
/****************************** 实现全局滑动 **************************/

    //禁止使用系统自带的手势
    self.interactivePopGestureRecognizer.enabled = NO;
    //设置自定义手势
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self.interactivePopGestureRecognizer.delegate action:@selector(handleNavigationTransition:)];
    //设置手势的代理
    pan.delegate = self;
    //添加手势值控制器
    [self.view addGestureRecognizer:pan];
    
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


// 判断是否允许触发当前手势
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    // 如果是根控制器,就不触发手势
    if(self.childViewControllers.count <= 1){return NO;}
    // 如果不是根控制器,就触发手势
    else{return YES;}
    
}



/***************** 自定义所有NavigationController中子控制器左上角的返回按钮 ********************/
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
    [super pushViewController:viewController animated:animated];

    //如果栈内的控制器数量大于1(即不是根控制器),就在NavigationItem上创建自定义的返回按钮
    if (self.childViewControllers.count > 1) {
        UIImage *image = [UIImage imageNamed:@"NavBack"];
        image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStyleDone target:self action:@selector(back)];
    }
}

//返回至上一个页面
- (void)back{
    [self popViewControllerAnimated:YES];
}

/***************** 实现自定义的UIBarButtonItem的滑动返回功能 ***************************************/
//判断滑动完毕后的界面是否为根控制器,决定是否恢复代理值
//- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
//{
//    //判断显示的控制器是否为根控制器
//    if (viewController == self.childViewControllers[0]) {
//        //滑动功能失效
//        self.interactivePopGestureRecognizer.delegate = self.popDelegate;
//    }else
//    {
//        //恢复滑动功能
//        self.interactivePopGestureRecognizer.delegate = nil;
//    }
//
//}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
