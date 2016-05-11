//
//  main.m
//  List 6-10
//
//  Created by 张思琦 on 15/6/10.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool
        {
        /*
        int p, d,isPrime;
        
        for (p = 2; p <= 50; p++) {
            isPrime = 1;
            
            for (d = 2; d < p; ++d)
            {
                if (0 == p % d)
                {
                    isPrime = 0;
                }
            }
            
            if (1 == isPrime) {
                NSLog(@"%i", p);
            }
          */
            int     p, d;
            BOOL    isPrime;
            
            for (p = 2; p <= 50; ++p)
            {
                isPrime = YES;
                
                for (d = 2; d < p; ++d)
                {
                    if(0 == p % d)
                    {
                        isPrime = NO;
                    }
                }
            
                if (YES == isPrime)
                {
                    NSLog(@"%i",p);
                }
            }
            
            
            

        
        
        
        NSLog(@"Hello, World!");
    }
    return 0;
}
