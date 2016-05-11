//
//  ViewController.m
//  MJExtension的映射机制
//
//  Created by 张思琦 on 16/3/25.
//  Copyright © 2016年 SQ Software Group. All rights reserved.
//

#import "ViewController.h"
#import "SQPerson.h"
#import "SQOther.h"
#import <MJExtension.h>

@interface ViewController ()




@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    NSDictionary *myPractice = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle  mainBundle] pathForResource:@"myPractice.plist" ofType:nil]];
//    
//    SQPerson *person = [SQPerson mj_objectWithKeyValues:myPractice];
//    
//    NSLog(@"%@",person.name);
//    
//    if (person.name.length != 0) {
//        NSLog(@"%@",person.name);
//    }else if(person.nickname != 0){
//        NSLog(@"%@",person.nickname);
//    }else {
//        NSLog(@"没有合适的");
//    }
//    
//    NSLog(@"%@",myPractice);
//    NSLog(@"%@",person.other);

    
    
    NSDictionary *other = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle  mainBundle] pathForResource:@"other.plist" ofType:nil]];
    NSLog(@"%@",other);
    
    SQOther *date = [SQOther mj_objectWithKeyValues:other];
    
    NSLog(@"%zd",date.sqAge);
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
