//
//  main.m
//  List 13-17
//
//  Created by 张思琦 on 15/6/16.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import <Foundation/Foundation.h>
#include <stdio.h>

//void copyString(char *to, char *from)
//{
//    while (*from)
//    {
//        *to++ = *from++;
//    }
//    *to = '\0';
//}


int main(int argc, const char * argv[]) {
    @autoreleasepool {
       
        char test[50];
        char *testP = test;
        
        
        while ((*testP++ = getchar()) != '9')
            ;
        
//        void copyString(char *to, char *from);
//        char string1[] = "A Sting to be copied";
//        char string2[50];
//        
//        copyString(string2, string1);
//        NSLog(@"%s",string2);
//        
//        copyString(string2, "So is this");
//        NSLog(@"%s",string2);
//        
//        // insert code here...
//        NSLog(@"Hello, World!");
    }
    return 0;
}
