//
//  main.m
//  List 16-1
//
//  Created by 张思琦 on 15/6/27.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSString        *fName = @"testfile";
        NSFileManager   *fm;
        NSDictionary    *attr;
        
        //需要创建文件管理器的实例
        
        fm = [NSFileManager defaultManager];
        
        //首先确认测试文件的存在
        
        if ([fm fileExistsAtPath:fName] == NO){
            NSLog(@"File doesn't exist!");
            return 1;
        }
        
        //创建一个副本
        if ([fm copyItemAtPath:fName toPath:@"newfile" error:NULL] == NO){
            NSLog(@"File Copy failed");
            return 2;
        }
        
        //测试两个文件是否一致
        if ([fm contentsEqualAtPath:fName andPath:@"newfile"]) {
            NSLog(@"Files are not equal!");
            return 3;
        }
        
        //重命名副本
        if([fm moveItemAtPath:@"newfile" toPath:@"newfile" error:NULL] == NO){
            NSLog(@"File rename Failed");
            return 4;
        }
        
        //获取newfile2的大小
        if ((attr = [fm attributesOfItemAtPath:@"newfile2" error:NULL]) == nil){
            NSLog(@"Couldn't get file attributes!");
        }
        
        NSLog(@"File size is %llu bytes",[[attr objectForKey:NSFileSize] unsignedLongLongValue]);
        
        //最后删除原始文件
        if ([fm removeItemAtPath:fName error:NULL] == NO){
            NSLog(@"file removal failed");
            return 6;
        }
        
        NSLog(@"All operations were successful");
        
        //显示新创建的文件内容
        NSLog(@"%@",[NSString stringWithContentsOfFile:@"newfile2" encoding:NSUTF8StringEncoding error:NULL]);
        
        // insert code here...
        NSLog(@"Hello, World!");
    }
    return 0;
}
