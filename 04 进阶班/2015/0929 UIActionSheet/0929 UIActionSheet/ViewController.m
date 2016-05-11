//
//  ViewController.m
//  0929 UIActionSheet
//
//  Created by 张思琦 on 15/9/29.
//  Copyright © 2015年 SQ Software Group. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIActionSheetDelegate>

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
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"警告" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"认真的?" otherButtonTitles:@"开玩笑!",@"再来一次!", nil];

    [actionSheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSLog(@"%ld",buttonIndex);
}


@end
