//
//  ViewController.m
//  1023 iOS9新特性
//
//  Created by 张思琦 on 15/10/23.
//  Copyright © 2015年 SQ Software Group. All rights reserved.
//

#import "ViewController.h"
#import "Stack.h"


@interface ViewController ()


/**********************    nullability    *************************/
//该值可能为nil
@property (nonatomic, strong, nullable) NSArray *name00;
@property (nonatomic, strong) NSString *_Nullable name01;
@property (nonatomic, strong) NSString *__nullable name02;

//该值永远不为为nil
@property (nonatomic, strong, nonnull) NSArray *array03;
@property (nonatomic, strong) NSString *_Nonnull name04;
@property (nonatomic, strong) NSString *__nonnull name05;

//不确定是否为空
@property (nonatomic, strong, null_unspecified) NSArray *array06;
@property (nonatomic, strong) NSString *_Null_unspecified name07;
@property (nonatomic, strong) NSString *__null_unspecified name08;

//空属性
@property (nonatomic, strong, null_resettable) NSString *name09;


/************************ Lightwight Generics(泛型) *****************************/
@property (nonatomic, strong) NSArray<NSString *> *arrayOfString;
@property (nonatomic, strong) NSDictionary<NSString *, NSNumber *> *studentNumber;



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.arrayOfString = @[@"ZSQ", @"SQ"];
    self.studentNumber = @{
                           @"ZSQ":@11,
                           @"SQ" :@7
                           };
    
    Stack <NSString *> *stack = [[Stack alloc] init];
    [stack addSomething:@"ZSQ"];
    
    
    Stack *s1 = [Stack new];
    Stack<NSString *> *s2 = [Stack new];
    Stack<NSMutableString *> *s3 = [Stack new];

    //指定泛型的类型都可以转换到不指定泛型的类型
    s1 = s2;
    s1 = s3;
    
    //不指定泛型的类型都可以转换为指定泛型的类型
    s2 = s1;
    s3 = s1;
    
    //指定泛型的类型之间不能互相转换
    s2 = s3;
    s3 = s2;
    
    
    
// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
