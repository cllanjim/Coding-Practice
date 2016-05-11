//
//  ViewController.m
//  1227 重绘下载进度
//
//  Created by 张思琦 on 15/12/27.
//  Copyright © 2015年 SQ Software Group. All rights reserved.
//

#import "ViewController.h"
#import "progressView.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UISlider *progress;
@property (weak, nonatomic) IBOutlet UILabel *progressLabel;
@property (weak, nonatomic) IBOutlet progressView *progressView;


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

- (IBAction)progressChange:(UISlider *)sender {
    self.progressLabel.text =  [NSString stringWithFormat:@"%0.2f%%", sender.value];
    self.progressView.progressValue = sender.value;
    
    
}

@end
