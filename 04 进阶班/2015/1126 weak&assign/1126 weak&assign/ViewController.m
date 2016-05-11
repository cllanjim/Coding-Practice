//
//  ViewController.m
//  1126 weak&assign
//
//  Created by 张思琦 on 15/11/26.
//  Copyright © 2015年 SQ Software Group. All rights reserved.
//

#import "ViewController.h"
#import "SQPerson.h"

@interface ViewController ()

@property (nonatomic, strong) SQPerson *person0;
@property (nonatomic, weak) SQPerson *person1;
@property (nonatomic, assign) SQPerson *person2;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    SQPerson *person = [[SQPerson alloc] init];
    
    //
//    self.person0 = person;
//    //_Nullable__weak
    self.person1 = person;
    //__unsafe_unretained
//    self.person2 = person;
    
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    NSLog(@"%@", self.person0);
    NSLog(@"%@", self.person1);
//    NSLog(@"%@", self.person2);

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
