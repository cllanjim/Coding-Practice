//
//  main.m
//  List 5.5
//
//  Created by 张思琦 on 15/6/10.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        int n, number, trianguleNumber, counter;
        
        for ( counter = 1 ; counter <= 5; ++counter)
        {
            NSLog(@"What trianguleNumber do you want?");
            scanf("%i", &number);
            
            trianguleNumber = 0;
            
            for ( n = 1; n <= number; ++n )
            {
                trianguleNumber += n;
            }
        
            NSLog(@"TrianguleNumber number %i is %i", number, trianguleNumber);
        }
        
        NSLog(@"Hello, World!");
    }
    return 0;
}
