//
//  main.m
//  List 15-12
//
//  Created by 张思琦 on 15/6/25.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AddressBook.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
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
        
        //创建一个新的地址簿
        AddressBook *myBook = [[AddressBook alloc] initWithName:@"Linda's Address Book"];
        
        NSLog(@"Entries in address book after creation: %lu", [myBook entries]);
        
        //创建四个卡片地址
        [card1 setName:aName andEmail:aEmail];
        [card2 setName:bName andEmail:bEmail];
        [card3 setName:cName andEmail:cEmail];
        [card4 setName:dName andEmail:dEmail];

        //将卡片添加到地址簿
        [myBook addCard:card1];
        [myBook addCard:card2];
        [myBook addCard:card3];
        [myBook addCard:card4];
        
        
        NSLog(@"Entries in address book after creation: %lu", [myBook entries]);

        [myBook list];
        // insert code here...
        NSLog(@"Hello, World!");
    }
    return 0;
}
