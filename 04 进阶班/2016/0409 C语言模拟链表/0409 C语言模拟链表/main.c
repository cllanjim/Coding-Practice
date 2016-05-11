//
//  main.c
//  0409 C语言模拟链表
//
//  Created by 张思琦 on 16/4/9.
//  Copyright © 2016年 SketchK. All rights reserved.
//

#include <stdio.h>
#include <stdlib.h>

struct node {
    int data;
    struct node *next;
};

int main(int argc, const char * argv[]) {
    // insert code here...
    struct node *head, *p, *q = NULL, *t;
    int i, n, a;
    scanf("%d",&n);
    head = NULL;//头指针为空
    
    for ( i = 1; i <= n; i++) {
        scanf("%d",&a);
        //动态申请一个空间,用来存放一个结点,并用临时指针p指向这个结点
        p = (struct node *)malloc(sizeof(struct node));
        p->data = a;//将数据存储到当前结点的data域中
        p->next = NULL;//设置当前结点的后继指针指向空,也就是当前结点的下一个结点为空
        
        if (head == NULL)
            head = p;//如果这是第一个创建的结点,则将头指针指向这个结点
        else
            q->next = p;//如果不是第一个创建的结点,则将上一个结点的后继指针指向当前结点
        
        q = p;//指针q也指向当前结点
    }
    
    
}
