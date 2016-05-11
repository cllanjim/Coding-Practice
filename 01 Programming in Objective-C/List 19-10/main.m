//
//  main.m
//  List 19-10
//
//  Created by 张思琦 on 15/7/5.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Foo.h"
#import "AddressBook.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        Foo *myfoo1 = [[Foo alloc] init];
        NSMutableData *dataArea;
        NSKeyedArchiver *archiver;
        
        //插入代码清单19-7中的代码创建地址簿
        //在mybook里包含四个地址卡
        NSString *aName = @"Julia Kochan";
        NSString *aEmail = @"jewls337@axlc.com";
        NSString *bName = @"Tony Iannino";
        NSString *bEmail = @"tony.iannino@techfitness.com";
        NSString *cName = @"Stephen Kochan";
        NSString *cEmail = @"steve@classroomM.com";
        NSString *dName = @"Jamie Baker";
        NSString *dEmail = @"jbaker@classroomM.com";
        
        AddressCard *card1 = [[AddressCard alloc] init];
        AddressCard *card2 = [[AddressCard alloc] init];
        AddressCard *card3 = [[AddressCard alloc] init];
        AddressCard *card4 = [[AddressCard alloc] init];
        
        
        //创建四个卡片地址
        [card1 setName:aName andEmail:aEmail];
        [card2 setName:bName andEmail:bEmail];
        [card3 setName:cName andEmail:cEmail];
        [card4 setName:dName andEmail:dEmail];
        
        //地址簿的初始化及命名
        AddressBook *myBook = [AddressBook alloc];
        myBook = [myBook initWithName:@"Steve's AddressBook"];
        
        //将卡片添加到地址簿
        [myBook addCard:card1];
        [myBook addCard:card2];
        [myBook addCard:card3];
        [myBook addCard:card4];
        
        [myBook sort];
        
        myfoo1.strVal = @"This is a string";
        myfoo1.intVal = 12345;
        myfoo1.floatVal = 98.6;
        
        
        //设置数据区,并将其连接到一个NSKeyedArchiver对象
        dataArea = [NSMutableData data];
        
        archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:dataArea];
        
        //现在开始可以存对象
        [archiver encodeObject:myBook forKey:@"myaddrbook"];
        [archiver encodeObject:myfoo1 forKey:@"myfoo1"];
        [archiver finishEncoding];
        
        //将存档的数据写到文件
        if ([dataArea writeToFile:@"myArchive" atomically:YES] == NO)
        {
            NSLog(@"Archiving failed!");
        }
        
        NSData *dataArea2;
        NSKeyedUnarchiver *unarchiver2;
        Foo *myFoo2;
        AddressBook *mybook2;
        
        //从归档文件中读取并连接
        //NSKeyedUnarchiver对象
        
        dataArea2 = [NSData dataWithContentsOfFile:@"myArchive"];
        
        if (! dataArea2) {
            NSLog(@"Can't read back archive file!");
            return 1;
        }
        
        unarchiver2 = [[NSKeyedUnarchiver alloc] initForReadingWithData:dataArea];
        
        mybook2 = [unarchiver2 decodeObjectForKey:@"myaddrbook"];
        myFoo2 = [unarchiver2 decodeObjectForKey:@"myfoo1"];
        
        [unarchiver2 finishDecoding];
        
        //验证是否还原成功
        [mybook2 list];
        
        NSLog(@"%@\n%i\n%g", myFoo2.strVal, myFoo2.intVal, myFoo2.floatVal);
        
        // insert code here...
        NSLog(@"Hello, World!");
    }
    return 0;
}
