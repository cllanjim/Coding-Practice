//
//  ViewController.m
//  0418 block的扩充
//
//  Created by 张思琦 on 16/4/18.
//  Copyright © 2016年 SketchK. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
#import "Car.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //[self text1];
    
    //[self text2];
    
    //[self text3];
    
    [self text4];
    
}

- (void)text1{
    Person *zsq = [[Person alloc] init];
    zsq.name = @"张思琦";
    zsq.eatFood = ^ void (NSString *fruit01, NSString *fruit02) {
        NSLog(@"Enter in block");
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSLog(@"%@",zsq.name);
            NSLog(@"%@----%@", fruit01, fruit02);
        });
        NSLog(@"Get out block");
    };
    zsq.eatFood(@"苹果",@"橘子");
}

- (void)text2{
    Person *zsq = [[Person alloc] init];
    zsq.name = @"张思琦";
    __weak typeof(zsq) weakZsq = zsq;
    zsq.eatFood = ^ void (NSString *fruit01, NSString *fruit02) {
        NSLog(@"Enter in block");
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSLog(@"%@",weakZsq.name);
            NSLog(@"%@----%@", fruit01, fruit02);
        });
        NSLog(@"Get out block");
    };
    zsq.eatFood(@"苹果",@"橘子");
}

- (void)text3{
    Person *zsq = [[Person alloc] init];
    zsq.name = @"张思琦";
    
    __weak typeof(zsq) weakZsq = zsq;
    zsq.eatFood = ^ void (NSString *fruit01, NSString *fruit02) {
        NSLog(@"Enter in block");
        Person *strongZsq = weakZsq;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSLog(@"%@",strongZsq.name);
            NSLog(@"%@----%@", fruit01, fruit02);
        });
        NSLog(@"Get out block");
    };
    zsq.eatFood(@"苹果",@"橘子");
}


- (void)text4{
    Person *zsq = [[Person alloc] init];
    zsq.name = @"张思琦";
    
    __weak typeof(zsq) weakZsq = zsq;
    zsq.eatFood = ^ void (NSString *fruit01, NSString *fruit02) {
        NSLog(@"Enter in block1");
        Person *strongZsq = weakZsq;
        
        weakZsq.playBall = ^ void (NSString *ball01, NSString *ball02) {
            NSLog(@"Enter in block2");

            NSLog(@"%@",strongZsq.name);
            NSLog(@"%@----%@", ball01, ball02);
            
            NSLog(@"Get out block2");
        };
        
        NSLog(@"%@----%@", fruit01, fruit02);
        NSLog(@"Get out block1");
        
        strongZsq.playBall(@"篮球",@"足球");
    };
    zsq.eatFood(@"苹果",@"橘子");

}

@end
