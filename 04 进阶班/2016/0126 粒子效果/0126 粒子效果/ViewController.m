//
//  ViewController.m
//  0126 粒子效果
//
//  Created by 张思琦 on 16/1/26.
//  Copyright © 2016年 SQ Software Group. All rights reserved.
//

#import "ViewController.h"
#import "DrawView.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet DrawView *contentView;
@end

@implementation ViewController


- (IBAction)startDraw:(id)sender {
    [self.contentView startAnimation];
}


- (IBAction)reDraw:(id)sender {
    [self.contentView clearAnimation];
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
