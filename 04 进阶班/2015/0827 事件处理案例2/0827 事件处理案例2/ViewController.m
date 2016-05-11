//
//  ViewController.m
//  0827 事件处理案例2
//
//  Created by 张思琦 on 15/8/27.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import "ViewController.h"
#import "MyButton.h"

@interface ViewController ()


@property (weak, nonatomic) IBOutlet MyButton *talkButton;

@property (nonatomic, strong) UIButton *btn;

@end

@implementation ViewController

- (IBAction)btnClick:(id)sender {

    UIButton *newButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [newButton setBackgroundColor:[UIColor lightGrayColor]];
    
    [newButton setImage:[UIImage imageNamed:@"对话框"] forState:UIControlStateNormal];
    [newButton setImage:[UIImage imageNamed:@"小孩"] forState:UIControlStateHighlighted];
    
    //这个方法好神奇!
    //Resizes and moves the receiver view so it just encloses its subviews.
    [newButton sizeToFit];
    
    newButton.center = CGPointMake(newButton.bounds.size.width * 0.5, - newButton.bounds.size.height * 0.5);
    
    
    self.talkButton.btn = newButton;
    
    [self.talkButton addSubview:newButton];
    NSLog(@"%@", NSStringFromCGRect(newButton.frame));

    

}




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
