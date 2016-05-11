//
//  main.m
//  List 16-2
//
//  Created by 张思琦 on 15/6/27.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSFileManager *fm;
        NSData *fileData;
        
        fm = [NSFileManager defaultManager];
        
        //读取文件newfile2
        fileData = [fm contentsAtPath:@"newfile2"];
        
        if (fileData == nil) {
            NSLog(@"File read failed!");
            return 1;
        }
        
        //将数据写入newfile3
        
        if ([fm createFileAtPath:@"newfile3" contents:fileData attributes:nil] == NO){
            NSLog(@"Couldn't creat the copy!");
            return 2;
        }
        
        NSLog(@"File copy was succseeful!");
        // insert code here...
        NSLog(@"Hello, World!");
    }
    return 0;
}
