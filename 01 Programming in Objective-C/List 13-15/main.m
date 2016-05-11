//
//  main.m
//  List 13-15
//
//  Created by 张思琦 on 15/6/16.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import <Foundation/Foundation.h>


//array[] = {};

//int *arrayP(int )

int arraySum(int array[], int n)//int arraySum(int *array, int n);
{
    int sum = 0, *ptr;
    
    int *arrayEnd = array + n;
    
    for (ptr = array; ptr < arrayEnd; ++ptr) {
        sum += *ptr;
        
    }
    return (sum);

}


int main(int argc, const char * argv[]) {
    @autoreleasepool {
        int arraySum(int array[], int n);
        
        int values[10] = { 3, 7 , -9, 3, 6, -1, 7 , 9 , 1, -5 };
        
        NSLog(@"The sum of array is %i", arraySum(values, 10));
        
        
        // insert code here...
        NSLog(@"Hello, World!");
    }
    return 0;
}
