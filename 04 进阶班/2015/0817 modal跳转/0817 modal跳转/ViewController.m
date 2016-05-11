//
//  ViewController.m
//  0817 modal跳转
//
//  Created by 张思琦 on 15/8/17.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import "ViewController.h"
#import "ViewController01.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *nextPage;


@end

@implementation ViewController
- (IBAction)nextPage:(id)sender {

    ViewController01 *vc01 = [[ViewController01 alloc] init];
    
    [self presentViewController:vc01 animated:YES completion:^{
       // NSLog(@"%@",self.parentViewController);
    }];

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
