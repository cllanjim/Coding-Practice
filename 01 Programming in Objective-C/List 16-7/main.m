//
//  main.m
//  List 16-7
//
//  Created by 张思琦 on 15/6/28.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSFileHandle    *inFile, *outFile;
        NSData          *buffer;
        
        //打开文件testfile并读取
        
        inFile = [NSFileHandle fileHandleForReadingAtPath:@"testfile"];
        
        if (inFile == nil) {
            NSLog(@"Open of testfile for reeading failed");
            return 1;
        }
        
        //如果需要,首先创建输出文件
        
        [[NSFileManager defaultManager] createFileAtPath:@"testout" contents:nil attributes:nil];
        
        //打开outfile文件进行写入
        
        outFile = [NSFileHandle fileHandleForWritingAtPath:@"testout"];
        
        if (outFile == nil) {
            NSLog(@"Open of testout for writing failed");
            return 2;
        }
        
        //因为它可能包含数据,截断输出文件
        [outFile truncateFileAtOffset:0];
        
        //从inFile中读取数据,将它写到outFile
        buffer = [inFile readDataToEndOfFile];
        
        [outFile writeData:buffer];
        
        //关闭这两个文件
        [inFile closeFile];
        [outFile closeFile];
        
        //验证文件内容
        
        NSLog(@"%@", [NSString stringWithContentsOfFile:@"testout" encoding:NSUTF8StringEncoding error:NULL]);
        
        
        // insert code here...
        NSLog(@"Hello, World!");
    }
    return 0;
}
