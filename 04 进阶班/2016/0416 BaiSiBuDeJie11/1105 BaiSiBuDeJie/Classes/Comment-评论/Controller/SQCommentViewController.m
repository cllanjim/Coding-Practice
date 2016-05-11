//
//  SQCommentViewController.m
//  1105 BaiSiBuDeJie
//
//  Created by 张思琦 on 16/4/15.
//  Copyright © 2016年 SQ Software Group. All rights reserved.
//

#import "SQCommentViewController.h"
#import "SQHTTPSessionManager.h"
#import "SQMJRefreshHeader.h"
#import "SQMJRefreshFooter.h"
#import "SQCommentModel.h"
#import "SQUserModel.h"
#import "SQCommentHeaderFooterView.h"
#import "SQCommentCell.h"
#import "SQTopicCell.h"


#import <MJExtension/MJExtension.h>


@interface SQCommentViewController () <UITableViewDelegate, UITableViewDataSource>

//工具栏底部与边框底部的距离约束
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomMargin;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

//网络请求管理者
@property (nonatomic, strong) SQHTTPSessionManager *manager;

//保存服务器返回的数据
@property (nonatomic, strong) NSMutableArray  <SQCommentModel *> *hotestComment;
@property (nonatomic, strong) NSMutableArray  <SQCommentModel *> *latestComment;

@property (nonatomic, strong) NSMutableArray *newcomment;


@property (nonatomic, strong) SQCommentModel *savedTopCmt;


@end

@implementation SQCommentViewController


//底部用于显示话题评论
static NSString * const SQCommentCellID = @"comment";
static NSString * const SQSectionHeaderlId = @"header";


- (void)viewDidLoad {
    [super viewDidLoad];
    //基本设置
    [self setupBaseInfo];
    //设置tableView
    [self setupTableView];
    //设置Refresh
    [self setupRefresh];
    //设置headerView
    [self setupHeaderView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - lazy
- (SQHTTPSessionManager *)manager{
    if (_manager == nil) {
        _manager = [SQHTTPSessionManager manager];
    }
    return _manager;
}

- (NSMutableArray *)hotestComment{
    if (_hotestComment == nil) {
        _hotestComment = [NSMutableArray array];
    }
    return _hotestComment;
}

- (NSMutableArray *)latestComment{
    if (_latestComment == nil) {
        _latestComment = [NSMutableArray array];
    }
    return _latestComment;
}

#pragma mark - 基本设置
- (void)setupBaseInfo{
    //修改控制器的title
    self.navigationItem.title = @"评论";
    
    //创建监听者,监听UIKeyboardWillChangeFrameNotification通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

#pragma mark - 设置tableView
- (void)setupTableView{
    //设置tableView代理
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    //设置tableView
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = SQCommonBgColor;
    
    //注册cell
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SQCommentCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:SQCommentCellID];
    //注册SQCommentHeaderFooterView
    [self.tableView registerClass:[SQCommentHeaderFooterView class] forHeaderFooterViewReuseIdentifier:SQSectionHeaderlId];
    
    //设置cell的高度
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 80;
    
}

- (void)dealloc{
    //在被释放时,消除监听者
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - 设置Refresh
- (void)setupRefresh{
    self.tableView.mj_header = [SQMJRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewComment)];
    
    self.tableView.mj_footer = [SQMJRefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreComment)];
    
    self.tableView.mj_footer.automaticallyHidden = YES;
    
    //进行下拉刷新
    [self.tableView.mj_header beginRefreshing];
}


- (void)loadNewComment{
    //取消原有的网络请求
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    //发送网络参数
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    parameter[@"a"] = @"dataList";
    parameter[@"c"] = @"comment";
    parameter[@"data_id"] = self.topicModel.ID;
    parameter[@"hot"] = @1; // @"1";
    
    __weak typeof(self) weakSelf = self;
    
    [self.manager GET:SQCommonURL parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        SQWriteToPlist(responseObject, @"newModel");

        //判断当前帖子有没有返回数据
        if(![responseObject isKindOfClass:[NSDictionary class]]){
            //如果返回数据是字典,则说明当前帖子没有评论数据,需要停止刷新
            [weakSelf.tableView.mj_header endRefreshing];
            return;
        }
        
        //如果有数据,就进行如下操作
        weakSelf.hotestComment = [SQCommentModel mj_objectArrayWithKeyValuesArray:responseObject[@"hot"]];
        weakSelf.latestComment = [SQCommentModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        
        //刷新表格
        [weakSelf.tableView reloadData];
        
        //停止刷新
        [weakSelf.tableView.mj_header endRefreshing];
        
        //
        NSInteger total = [responseObject[@"total"] integerValue];
        
        if(weakSelf.latestComment.count == total){
            weakSelf.tableView.mj_footer.hidden = YES;
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //如果出现问题,停止刷新
        [weakSelf.tableView.mj_header endRefreshing];
    }];
}

- (void)loadMoreComment{
    //取消原有的网络请求
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    //发送网络参数
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    parameter[@"a"] = @"dataList";
    parameter[@"c"] = @"comment";
    parameter[@"data_id"] = self.topicModel.ID;
    parameter[@"lastcid"] = self.latestComment.lastObject.ID;
    
    __weak typeof(self) weakSelf = self;
    
    [self.manager GET:SQCommonURL parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        SQWriteToPlist(responseObject, @"loadMore");
        
        //判断当前帖子有没有返回数据
        if(![responseObject isKindOfClass:[NSDictionary class]]){
            //如果返回数据是字典,则说明当前帖子没有评论数据,需要停止刷新
            [weakSelf.tableView.mj_footer endRefreshing];
            return;
        }
        
        //如果有数据,就进行如下操作
        NSArray *newCommentData = [SQCommentModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        [weakSelf.latestComment addObjectsFromArray:newCommentData];
        
        //刷新表格
        [weakSelf.tableView reloadData];
        
        //获取总的评论数量
        NSInteger total = [responseObject[@"total"] integerValue];
        //判断是否加载完毕
        if(total == weakSelf.latestComment.count){
            //说明加载完毕
            weakSelf.tableView.mj_footer.hidden = YES;
            //[weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
        }else {
            //说明没有加载完毕,结束当前刷新
            [weakSelf.tableView.mj_footer endRefreshing];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //如果出现问题,停止刷新
        [weakSelf.tableView.mj_footer endRefreshing];
    }];
}

#pragma mark - 键盘处理
//监听后的对应操作
- (void)keyboardWillChangeFrame:(NSNotification *)note{
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

#pragma mark - tableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    //方法一
//    NSInteger number = 0;
//    if (self.latestComment.count && self.hotestComment.count) {
//        //此时说明最热评论和最新评论中都包含数据
//        number = 2;
//    };
//    if (self.latestComment.count && (self.hotestComment.count == 0)) {
//        //此时说明最新评论中包含数据,最热评论中不包含数据
//        number = 1;
//    }
//    
//    return number;

    //方法二
    NSInteger number = 0;

    if(self.hotestComment.count != 0){
        number = 2;
    }else if (self.latestComment.count != 0) {
        number = 1;
    }
    return number;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //方法一
    NSInteger number = 0;
    if(section == 0){//当在section = 0的情形时
        if(self.hotestComment.count != 0){//说明存在最热评论
            number = self.hotestComment.count;
        }else {//说明不存在最热评论,
            number = self.latestComment.count;
        }
    }else{//当在section = 1的情形时
        //此时该处只可能时最新评论
        number = self.latestComment.count;
    }
    return number;
    
//    NSInteger number = 0;
//    
//    if(section == 0 && (self.hotestComment.count != 0)){
//        //此时有最热评论和最新评论
//        number = self.hotestComment.count;
//    }else if(self.latestComment.count != 0){
//        number = self.latestComment.count;
//    }
//    
//    return number;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SQCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:SQCommentCellID];
    
    if(indexPath.section == 0 && (self.hotestComment.count != 0)){
        cell.commentModel = self.hotestComment[indexPath.row];
    }else if(self.latestComment.count != 0){
        cell.commentModel = self.latestComment[indexPath.row];
    }
 
    return cell;
}

#pragma mark - UITableViewHeaderFooterView的相关设定
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    SQCommentHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:SQSectionHeaderlId];
    
    if(section == 0 && (self.hotestComment.count != 0)){
        //此时有最热评论和最新评论
        headerView.textLabel.text = @"最热评论";
    }else if(self.latestComment.count != 0){
        headerView.textLabel.text = @"最新评论";
    }
    
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return SQCommentSectionHeaderFont.lineHeight + 8;
}


#pragma mark - 设置headerView
- (void)setupHeaderView{
    //保存原始数据
    self.savedTopCmt = self.topicModel.top_cmt;
    //处理数据模型
    self.topicModel.top_cmt = nil;
    self.topicModel.cellHeight = 0;
    
    
    
    UIView *headerView = [[UIView alloc] init];
    
    //向headerContentView中添加headerView
    SQTopicCell *contentView = [SQTopicCell viewFromXib];
    contentView.topicModel = self.topicModel;
    contentView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, self.topicModel.cellHeight);
    [headerView addSubview:contentView];
    
    //设置headerView的高度
    headerView.sq_height = contentView.sq_height + SQCommonMargin * 2;
    
    self.tableView.tableHeaderView = headerView;
}

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
//    NSString *title = nil;
//
//    if(section == 0 && (self.hotestComment.count != 0)){
//        //此时有最热评论和最新评论
//        title = @"最热评论";
//    }else if(self.latestComment.count != 0){
//        title = @"最新评论";
//    }
//    return title;
//}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    //当section == 2的时候
//    return 100;
//}

@end
