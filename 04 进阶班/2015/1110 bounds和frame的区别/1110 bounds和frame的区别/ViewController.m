//
//  ViewController.m
//  1110 bounds和frame的区别
//
//  Created by 张思琦 on 15/11/10.
//  Copyright © 2015年 SQ Software Group. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIView *baseView;
@property (weak, nonatomic) IBOutlet UIView *childrenView;
@property (weak, nonatomic) IBOutlet UIView *parentsView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.childrenView setBounds:CGRectMake(-30, -30, self.childrenView.frame.size.width, self.childrenView.frame.size.height)];
    NSLog(@"%@",NSStringFromCGPoint(self.parentsView.bounds.origin));
    NSLog(@"%@",NSStringFromCGPoint(self.childrenView.bounds.origin));
    NSLog(@"%@",NSStringFromCGPoint(self.baseView.bounds.origin));


}

@end
