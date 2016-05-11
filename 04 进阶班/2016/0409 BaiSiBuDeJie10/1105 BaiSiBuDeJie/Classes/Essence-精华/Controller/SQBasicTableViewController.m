//
//  SQBasicTableViewController.m
//  1105 BaiSiBuDeJie
//
//  Created by 张思琦 on 16/3/29.
//  Copyright © 2016年 SQ Software Group. All rights reserved.
//

#import "SQBasicTableViewController.h"
#import "SQTopicModel.h"
#import "SQTopicCell.h"
#import "SQMJRefreshHeader.h"
#import "SQMJRefreshFooter.h"
#import "SQHTTPSessionManager.h"
#import "SQNewViewController.h"
#import "SQCommentViewController.h"


#import <MJRefresh/MJRefresh.h>
#import <MJExtension/MJExtension.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import <SVProgressHUD/SVProgressHUD.h>
@interface SQBasicTableViewController ()

//用于存储精华界面cell的模型数据数组,使用范型固定当前数组中存储数据的类型
@property (nonatomic, strong) NSMutableArray<SQTopicModel *> *groupOfModels;

//用于保存当前tableView中数据标示符
@property (nonatomic, strong) NSString *maxtime;

//用于管理网络请求的AFHTTPSessionManager
@property (nonatomic, strong) SQHTTPSessionManager *manager;


//用于判定tableView中获取的数据类型
@property (nonatomic, assign) SQTopicType type;
//用于判断
@property (nonatomic, strong) NSString *parentVCName;

@end

@implementation SQBasicTableViewController

static NSString * const SQTopicCellId = @"topic";

#pragma mark - getter
//此处设置只是为了避免出现意外,具体的实现交给子类完成
- (SQTopicType)type{
    return 0;
}

- (NSString *)parentVCName{
    if(self.parentViewController.class == [SQNewViewController class]){
        return @"newlist";
    }
    return @"list";
}


#pragma mark - lazy
- (NSMutableArray *)groupOfModels{
    if (_groupOfModels == nil) {
        _groupOfModels = [NSMutableArray array];
    }
    return _groupOfModels;
}

- (NSString *)maxtime{
    if (_maxtime == nil) {
        _maxtime = [NSString string];
    }
    return _maxtime;
}

- (SQHTTPSessionManager *)manager{
    if (_manager == nil) {
        _manager = [SQHTTPSessionManager manager];
    }
    return _manager;
}

#pragma mark - life circle
- (void)viewDidLoad {
    [super viewDidLoad];

    //取消系统自带cell的分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    //注册自定义cell
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SQTopicCell class]) bundle:nil] forCellReuseIdentifier:SQTopicCellId];

    [self setupMJRefreshControl];

}

#pragma mark - MJRefreshControl控件
- (void)setupMJRefreshControl{

    //添加下拉刷新控件
    self.tableView.mj_header = [SQMJRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopics)];
    [self.tableView.mj_header beginRefreshing];

    //添加上拉刷新控件
    self.tableView.mj_footer = [SQMJRefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopics)];
}

//下拉刷新action
- (void)loadNewTopics{

    //取消所有请求
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];

    //发送get请求获取数据
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    parameters[@"a"] = self.parentVCName;
    parameters[@"c"] = @"data";
    parameters[@"type"] = @(self.type);
    
//    if ( [NSStringFromClass([self class]) isEqualToString:@"SQAllTableViewController"]) {
//        parameters[@"type"] = @"1";
//    }else if([NSStringFromClass([self class]) isEqualToString:@"SQVideoTableViewController"]){
//        parameters[@"type"] = @"41";
//    }else if([NSStringFromClass([self class]) isEqualToString:@"SQVoiceTableViewController"]){
//        parameters[@"type"] = @"31";
//    }else if ([NSStringFromClass([self class]) isEqualToString:@"SQPhotoTableViewController"]){
//        parameters[@"type"] = @"10";
//    }else if([NSStringFromClass([self class]) isEqualToString:@"SQWordTableViewController"]){
//        parameters[@"type"] = @"29";
//    }
    
    __weak typeof(self) weakSelf = self;
    
    [self.manager GET:SQCommonURL parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        weakSelf.maxtime = responseObject[@"info"][@"maxtime"];

        //对返回的数据进行转换并保存到groupOfModels属性中
        weakSelf.groupOfModels = [SQTopicModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];

        //刷新当前tableView界面
        [weakSelf.tableView reloadData];

        //停止动画
        [weakSelf.tableView.mj_header endRefreshing];
    }failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        SQLOG(@"失败了-%ld",(long)error.code);

        [weakSelf.tableView.mj_header endRefreshing];

        if (error.code == NSURLErrorCancelled) {
            //如果出现错误的原因是任务被取消
        }else{
            //如果出现错误的原因是其他问题

            //添加HUD,提示用户网络错误
            [SVProgressHUD showErrorWithStatus:@"网络连接出问题啦" maskType:SVProgressHUDMaskTypeBlack];
        }

    }];
}

//上拉刷新的action
- (void)loadMoreTopics{

    //取消所有请求
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];

    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = self.parentVCName;
    parameters[@"c"] = @"data";
    parameters[@"maxtime"] = self.maxtime;
    parameters[@"type"] = @(self.type);

    __weak typeof(self) weakSelf = self;
    [self.manager GET:SQCommonURL parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //更新maxTime值
        weakSelf.maxtime = responseObject[@"info"][@"maxtime"];

        //获取服务器返回的数据
        NSArray <SQTopicModel *> *moreTopicModels = [SQTopicModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        //将数据添加到groupOfModels中
        [weakSelf.groupOfModels addObjectsFromArray:moreTopicModels];

        //刷新tableView
        [weakSelf.tableView reloadData];

        //结束刷新动画
        [weakSelf.tableView.mj_footer endRefreshing];

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        SQLOG(@"失败了-%ld",(long)error.code);

        [weakSelf.tableView.mj_header endRefreshing];

        if (error.code == NSURLErrorCancelled) {
            //如果出现错误的原因是任务被取消
        }else{
            //如果出现错误的原因是其他问题

            //添加HUD,提示用户网络错误
            [SVProgressHUD showErrorWithStatus:@"网络连接出问题啦" maskType:SVProgressHUDMaskTypeBlack];
        }

    }];
}


#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.groupOfModels.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    SQTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:SQTopicCellId];
    cell.topicModel = self.groupOfModels[indexPath.row];

    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    SQTopicModel *model = self.groupOfModels[indexPath.row];
    return model.cellHeight;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    SQCommentViewController *commentVC = [[SQCommentViewController alloc] init];
    [self.navigationController pushViewController:commentVC animated:YES];
    
}

@end

