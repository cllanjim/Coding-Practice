//
//  ViewController.m
//  0131 scrollView的几种布局
//
//  Created by 张思琦 on 16/1/31.
//  Copyright © 2016年 SQ Software Group. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIScrollViewDelegate>
@property (nonatomic, strong) UIView *bar;

@end

@implementation ViewController

//创建ScrollView的悬停效果
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //创建UISCrollView
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame = self.view.bounds;
    scrollView.delegate = self;
    scrollView.contentSize = CGSizeMake(self.view.frame.size.width, 3000);
    scrollView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:scrollView];
    
    [scrollView addSubview:[[UISwitch alloc] init]];
    
    UIView *bar = [[UIView alloc] initWithFrame:CGRectMake(0, 70, self.view.frame.size.width, 100)];
    bar.backgroundColor = [UIColor redColor];
    [scrollView addSubview:bar];
    self.bar = bar;
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.y >= 70) {
        self.bar.frame = CGRectMake(0, 0, self.view.frame.size.width, 100);
        [self.view addSubview:self.bar];
    }else{
        self.bar.frame = CGRectMake(0, 70, self.view.frame.size.width, 100);
        [scrollView addSubview:self.bar];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
