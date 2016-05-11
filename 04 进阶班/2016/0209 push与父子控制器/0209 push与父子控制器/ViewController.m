//
//  ViewController.m
//  0209 push与父子控制器
//
//  Created by 张思琦 on 16/2/9.
//  Copyright © 2016年 SQ Software Group. All rights reserved.
//

#import "ViewController.h"
#import "SecondViewController.h"

@interface ViewController ()

@property (nonatomic, strong) SecondViewController *secondVC;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    SecondViewController *secondVC = [[SecondViewController alloc] init];
//    self.secondVC = secondVC;
//    
//    [self.view addSubview:self.secondVC.view];
//    [self addChildViewController:self.secondVC];
    
    
    
    SecondViewController *secondVC = [[SecondViewController alloc] init];
    
    [self.view addSubview:secondVC.view];
    //当前情况下由于viewController强引用了secondViewController
    //所以secondVC在当前方法执行完毕后不会被释放
    //由此可以监听secondVC的触摸事件
    [self addChildViewController:secondVC];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
