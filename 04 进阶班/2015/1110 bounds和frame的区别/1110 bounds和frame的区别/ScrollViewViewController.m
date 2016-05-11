//
//  ScrollViewViewController.m
//  1110 bounds和frame的区别
//
//  Created by 张思琦 on 15/11/11.
//  Copyright © 2015年 SQ Software Group. All rights reserved.
//

#import "ScrollViewViewController.h"

@interface ScrollViewViewController ()<UIScrollViewDelegate>

@property (weak, nonatomic) UISwitch *st;
@property (weak, nonatomic) UIScrollView *scrollView;
@end

@implementation ScrollViewViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    UIScrollView *sc = [[UIScrollView alloc] init];
    sc.backgroundColor = [UIColor lightGrayColor];
    sc.frame = CGRectMake(0, 0, 300, 600);
    sc.center = CGPointMake(self.view.bounds.size.width / 2, self.view.bounds.size.height / 2);
    sc.contentSize = CGSizeMake(600, 1200);
    sc.delegate = self;
    sc.contentInset = UIEdgeInsetsMake(50, 0, 0, 0);
    [self.view addSubview:sc];
    self.scrollView = sc;
    
    UISwitch *st = [[UISwitch alloc] init];
    self.st = st;
    
    [self.scrollView addSubview:self.st];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"%@",NSStringFromCGPoint(self.st.bounds.origin));
    NSLog(@"%@",NSStringFromCGPoint(self.scrollView.bounds.origin));

}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSLog(@"%@",NSStringFromCGPoint(self.st.bounds.origin));
    NSLog(@"%@",NSStringFromCGPoint(self.scrollView.bounds.origin));
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
