//
//  main.m
//  List 16-8
//
//  Created by 张思琦 on 15/6/28.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSfileHandle    *inFile, *outFile;
        NSData          *buffer;
        
        //打开文件fileA进行读取
        inFile = [NSFileHandle fileHandleForReadingAtPath:@"fileA"];
        
        if (inFile == nil) {
            NSLog(@"Open of fileA for reading failed");
            return 1;
        }
        
        //打开文件fileB进行更新
        
        outFile = [NSFileHandle fileHandleForWritingAtPath:@"fileB"];
        
        if (outFile == nil) {
            NSLog(@"Open of fileB for Writing failed");
            return 2;
        }
        
        //在outFile的末尾进行查找
        [outFile seekToEndOfFile];
        
        //从inFile中读取数据,将它写到outFile
        
        buffer = [inFile readDataToEndOfFile];
        [outFile writeData:buffer];
        
        //关闭这两个文件
        
        [inFile closeFile];
        [outFile closeFile];
        
        //验证它的内容
        NSLog(@"%@",[NSString stringWithContentsOfFile:@"fileB" encoding:NSUTF8StringEncoding error:NULL]);
        
        
        // insert code here...
        NSLog(@"Hello, World!");
    }
    return 0;
}
