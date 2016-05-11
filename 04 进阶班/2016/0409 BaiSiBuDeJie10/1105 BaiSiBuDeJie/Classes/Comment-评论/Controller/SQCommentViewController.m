//
//  SQCommentViewController.m
//  1105 BaiSiBuDeJie
//
//  Created by 张思琦 on 16/4/15.
//  Copyright © 2016年 SQ Software Group. All rights reserved.
//

#import "SQCommentViewController.h"

@interface SQCommentViewController () <UITableViewDelegate>

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomMargin;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation SQCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //基本设置
    [self setBaseInfo];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 基本设置
- (void)setBaseInfo{
    //修改控制器的title
    self.navigationItem.title = @"评论";
    //设置tableView代理
    self.tableView.delegate = self;
    
    //创建监听者,监听UIKeyboardWillChangeFrameNotification通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (void)dealloc{
    //在被释放时,消除监听者
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

//监听后的对应操作
- (void)keyboardWillChangeFrame:(NSNotification *)note{
    SQLOG(@"%@",note);
    //获取键盘弹出后的Y值
    CGFloat keyBoardY = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].origin.y;
    //获取屏幕高度
    CGFloat screenH = [UIScreen mainScreen].bounds.size.height;
    //底部工具条需要提升的高度为
    self.bottomMargin.constant = screenH - keyBoardY;
    
    //获取键盘弹出的时间
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:duration animations:^{
        //重新布局控件
        [self.view layoutIfNeeded];
    }];
}

#pragma mark - tableViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //结束编辑状态
    [self.view endEditing:YES];
}

@end
