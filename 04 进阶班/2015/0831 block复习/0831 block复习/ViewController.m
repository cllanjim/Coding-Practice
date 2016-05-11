//
//  ViewController.m
//  0831 block复习
//
//  Created by 张思琦 on 15/8/31.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import "ViewController.h"
typedef void (^MyBlock) (int x, int y);



@interface ViewController ()

//当block为某个类的属性,如何定义
//@property (nonatomic, copy) returnType (^blockName)(parameterType)
@property (nonatomic, copy) int(^propertyBlock) (int);
@property (nonatomic, strong) NSArray *array;

//当block为某个方法的参数时,如何定义
//- (void)someMethodThatTakesABlock:(returnType(^)(parameterTypes))blockName;
//- (void)isContainInArray:(int  (^)(int a))myblock02;

@end

@implementation ViewController

//a>b a<b
//- (void)compareTwoNumberA:(int)a B:(int)b block:(void (^)(int , int ))myblock02{
//    
////   //具体化myBlock
////    myblock02 = ^BOOL (int a, int b){
////        if (a >= b) {
////            NSLog(@"%@", @"a >= b ");
////            return YES;
////        }else{
////            NSLog(@"%@", @"a < b ");
////            return NO;
////        }
////    };
//    
////    return myblock02(a, b);
//    myblock02(a, b);
//    
//}
//


- (void)compareTwoNumberblock:(void (^)(int a, int b))myblock02{
    
    //   //具体化myBlock
    //    myblock02 = ^BOOL (int a, int b){
    //        if (a >= b) {
    //            NSLog(@"%@", @"a >= b ");
    //            return YES;
    //        }else{
    //            NSLog(@"%@", @"a < b ");
    //            return NO;
    //        }
    //    };
    
    //    return myblock02(a, b);
    
}

- (void)viewDidLoad {
    [super viewDidLoad];

/***********************block类型的属性使用方法*************************/
    //标准类型的block
    // returnType (^blockName) (parameterType) = ^returnType(parameters){
    //  code.....
    //  };
//    int (^myblock00)(int) = ^ int (int a)
//    {
//        return a;
//    };
//    NSLog(@"%i", myblock00(10));
    
/***********************block类型的属性使用方法*************************/
    //自定义block别名
    //#typedef returnType (^TypeName)(parameterTypes)
    //typedef int (^intBlock)(int);
    //TypeName blockName = ^returnType (parameterTypes){
    //  //code.....
    //  };
//    intBlock myblock01 = ^int (int b){
//        return b;
//    };
//    NSLog(@"%i", myblock01(2));
    
/***********************block类型的属性使用方法*************************/
//    self.propertyBlock = ^ int (int a){
//        return a;
//    };
//    NSLog(@"%i", self.propertyBlock(10));

/***********************block作为方法参数时的调用*************************/

    

    
    // Do any additional setup after loading the view, typically from a nib.
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
