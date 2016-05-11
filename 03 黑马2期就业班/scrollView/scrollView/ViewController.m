//
//  ViewController.m
//  scrollView
//
//  Created by 张思琦 on 15/7/25.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UILabel *label;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.scrollView.contentInset = UIEdgeInsetsMake(80, 0, 0, 0);
    
    //设置scroView的大小
    //self.scrollView.contentSize = CGSizeMake(0, 0);
   self.scrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(self.label.frame)+200);

    // Do any additional setup after loading the view, typically from a nib.

    //设置scrollView的contentInset属性
    //代表当前内容视图与scrollView四边的间距
    
    //设置scrollView的contentOffset属性
    //代表手机屏幕与内容视图的坐标位置关系,内容视图为坐标系,手机屏幕左上角的点在内容视图的坐标
//    self.scrollView.contentOffset = CGPointMake(-70, -70);





}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
