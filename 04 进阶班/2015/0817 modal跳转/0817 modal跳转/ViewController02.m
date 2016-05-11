//
//  ViewController02.m
//  0817 modal跳转
//
//  Created by 张思琦 on 15/8/17.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import "ViewController02.h"

@interface ViewController02 ()


@end

@implementation ViewController02
- (IBAction)prevPage:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
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
