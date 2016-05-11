//
//  main.m
//  List 16-4
//
//  Created by 张思琦 on 15/6/28.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSString *path;
        NSFileManager *fm;
        NSDirectoryEnumerator *dirEnum;
        NSArray *dirArray;
        
        //需要创建文件管理器的实例
        fm = [NSFileManager defaultManager];
        
        //获取当前工作目录的路径
        path = [fm currentDirectoryPath];
        
        //枚举目录
        dirEnum = [fm enumeratorAtPath:path];
        
        NSLog(@"Contents of %@", path);
        
        while ((path = [dirEnum nextObject])!= nil) {
            NSLog(@"%@", path);
        }
        
        //另一种枚举目录的方法
        dirArray = [fm contentsOfDirectoryAtPath:[fm currentDirectoryPath] error:NULL];
        NSLog(@"Contents using contentsofDirectoryAtPath:error:");
        
        for (path in dirArray) {
            NSLog(@"%@",path);
        }
        
        
        // insert code here...
        NSLog(@"Hello, World!");
    }
    return 0;
}
