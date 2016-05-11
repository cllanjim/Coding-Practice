//
//  main.m
//  List 13-5
//
//  Created by 张思琦 on 15/6/15.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import <Foundation/Foundation.h>

int gcd (int u , int v)
{
    int temp;
    
    while ( v != 0){
        temp = u % v;
        u = v;
        v = temp;
    }
    return u;
}

void NSLog(NSString *format,...);


int main(int argc, const char * argv[]) {
    @autoreleasepool {
        int result;
        
        result = gcd(150, 35);
        NSLog(@"The gcd of 150 and 35 is %i",result);
        
        result = gcd(1026, 405);
        NSLog(@"The gcd of 1026 and 405 is %i",result);
        
        NSLog(@"The gcd of 83 and 240 is %i",gcd(83, 240));
        // insert code here...
        NSLog(@"Hello, World!");
        
        
    }
    return 0;
}
