//
//  SQAllTableViewController.m
//  1105 BaiSiBuDeJie
//
//  Created by 张思琦 on 16/3/9.
//  Copyright © 2016年 SQ Software Group. All rights reserved.
//

#import "SQAllTableViewController.h"
#import "SQTopicModel.h"
#import "SQTopicCell.h"
#import "SQMJRefreshHeader.h"
#import "SQMJRefreshFooter.h"
#import "SQHTTPSessionManager.h"
//#import <AFNetworking/AFNetworking.h>


#import <MJRefresh/MJRefresh.h>
#import <MJExtension/MJExtension.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import <SVProgressHUD/SVProgressHUD.h>

@interface SQAllTableViewController ()

//用于存储精华界面cell的模型数据数组,使用范型固定当前数组中存储数据的类型
@property (nonatomic, strong) NSMutableArray<SQTopicModel *> *groupOfModels;

//用于保存当前tableView中数据标示符
@property (nonatomic, strong) NSString *maxtime;

//用于管理网络请求的AFHTTPSessionManager
@property (nonatomic, strong) SQHTTPSessionManager *manager;

////DIY刷新控件中的Label
//@property (nonatomic, strong) UILabel *refreshLabel;

@end

@implementation SQAllTableViewController

static NSString * const SQTopicCellId = @"topic";


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
    self.tableView.rowHeight = 250;
    
    [self setupMJRefreshControl];
    
//    [self setupRefreshControl];
    
//    [self setupDIYRefreshControl];
    
    
//    [self setupRefreshControl];
//    //发送get请求获取数据
//    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
//    parameters[@"a"] = @"list";
//    parameters[@"c"] = @"data";
//    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        SQLOG(@"首次成功了");
//        //对返回的数据进行转换并保存到groupOfModels属性中
//        self.groupOfModels = [SQTopicModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
//        
//        //刷新当前tableView界面
//        [self.tableView reloadData];
//        
//    }failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        SQLOG(@"首次失败了-%@",error);
//    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    parameters[@"a"] = @"list";
    parameters[@"c"] = @"data";
    parameters[@"type"] = @"1";
    [self.manager GET:SQCommonURL parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        SQWriteToPlist(responseObject, @"New");
    
        self.maxtime = responseObject[@"info"][@"maxtime"];
        
        //对返回的数据进行转换并保存到groupOfModels属性中
        self.groupOfModels = [SQTopicModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        //刷新当前tableView界面
        [self.tableView reloadData];
        
        //停止动画
        [self.tableView.mj_header endRefreshing];
    }failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        SQLOG(@"失败了-%ld",(long)error.code);
        
        [self.tableView.mj_header endRefreshing];
        
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
    
//    [self.manager invalidateSessionCancelingTasks:YES];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"list";
    parameters[@"c"] = @"data";
    parameters[@"maxtime"] = self.maxtime;
    parameters[@"type"] = @"1";

    
    [self.manager GET:SQCommonURL parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //更新maxTime值
        self.maxtime = responseObject[@"info"][@"maxtime"];
        
        //获取服务器返回的数据
        NSArray <SQTopicModel *> *moreTopicModels = [SQTopicModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        //将数据添加到groupOfModels中
        [self.groupOfModels addObjectsFromArray:moreTopicModels];
        
        //刷新tableView
        [self.tableView reloadData];
        
        //结束刷新动画
        [self.tableView.mj_footer endRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        SQLOG(@"失败了-%ld",(long)error.code);
        
        [self.tableView.mj_header endRefreshing];
        
        if (error.code == NSURLErrorCancelled) {
            //如果出现错误的原因是任务被取消
        }else{
            //如果出现错误的原因是其他问题
            
            //添加HUD,提示用户网络错误
            [SVProgressHUD showErrorWithStatus:@"网络连接出问题啦" maskType:SVProgressHUDMaskTypeBlack];
        }
        
    }];
}


//#pragma mark - UIRefreshControl控件
//- (void)setupRefreshControl{
//    //添加Refresh控件
//    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
//    [refreshControl addTarget:self action:@selector(loadNewTopics:) forControlEvents:UIControlEventValueChanged];
//    [self.tableView addSubview:refreshControl];
//    
//    //刷新tableView
////    [refreshControl beginRefreshing];
////    [self loadNewTopics:refreshControl];
//}
//
//
//- (void)loadNewTopics:(UIRefreshControl *)refreshControl{
//    
//    //发送get请求获取数据
//    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
//    parameters[@"a"] = @"list";
//    parameters[@"c"] = @"data";
//    
//    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        
//        SQLOG(@"成功了");
//        
//        //对返回的数据进行转换并保存到groupOfModels属性中
//        self.groupOfModels = [SQTopicModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
//        
//        //刷新当前tableView界面
//        [self.tableView reloadData];
//        
//        //停止动画
//        [refreshControl endRefreshing];
//    }failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        SQLOG(@"失败了-%@",error);
//        
//        [refreshControl endRefreshing];
//        
//        //添加HUD,提示用户网络错误
//        [SVProgressHUD showErrorWithStatus:@"网络连接出问题啦" maskType:SVProgressHUDMaskTypeBlack];
//    }];
//}
//
//
//#pragma mark - DIYRefreshControl控件
//- (void)setupDIYRefreshControl{
//    //创建RefreshView
//    UIView *refreshView = [[UIView alloc] init];
//    refreshView.sq_x = 0;
//    refreshView.sq_y = -50;
//    refreshView.sq_width = self.tableView.sq_width;
//    refreshView.sq_height = 50;
//    refreshView.backgroundColor = SQRandomColor;
//    [self.tableView addSubview:refreshView];
//    
//    
//    //创建RefreshView中的label
//    UILabel *refreshLabel = [[UILabel alloc] init];
//    refreshLabel.text = @"下拉刷新控件";
//    [refreshLabel sizeToFit];
//    refreshLabel.center = CGPointMake(refreshView.sq_width * 0.5, refreshView.sq_height * 0.5);
//    [refreshView addSubview:refreshLabel];
//    
//    self.refreshLabel = refreshLabel;
//    
//}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.groupOfModels.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
//    static NSString * const ID = @"cell";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
//    
//    if (cell == nil) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
////        cell.backgroundColor = SQRandomColor;
//    }
//    
//    
//    //取出对应的数据模型
//    SQTopicModel *model = self.groupOfModels[indexPath.row];
//    
//    cell.textLabel.text = model.name;
//    cell.detailTextLabel.text = model.text;
//    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:model.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    
    SQTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:SQTopicCellId];
    cell.topicModel = self.groupOfModels[indexPath.row];
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

//    SQTopicModel *model = self.groupOfModels[indexPath.row];
//    return model.cellHeight;

    return 250;
}

#pragma mark - scrollView的代理方法
////拖动控件时候调用
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
//
//    //当refreshView的上部内边距为149时,需要跳出该方法,避免label的内容被修改
//    if (scrollView.contentInset.top == 149) return;
//    
//    if (scrollView.contentOffset.y <= -149) {
//        //当偏移量超过-149就代表在固定位置下面
//        self.refreshLabel.text = @"松开刷新哦";
//    }else{
//        //当偏移量小于-149就代表在固定位置上面
//        self.refreshLabel.text = @"下拉刷新哦";
//    }
//    
//}
//
//
//- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
//    
//    if (scrollView.contentOffset.y <= -149) {
//        //当前情况就要刷新数据
//        self.refreshLabel.text = @"正在刷新";
//        
//        //将RefreshView固定在某个位置
//        [UIView animateWithDuration:0.5 animations:^{
//            UIEdgeInsets insets = scrollView.contentInset;
//            insets.top = 149;
//            scrollView.contentInset = insets;
//        }];
//        
//        //此处为耗时操作,应该开启新线程
//        
//        dispatch_async(dispatch_get_global_queue(0, 0), ^{
//            
//            //此处开始进行数据更新操作
//
//            //数据更新完毕后,应当回到主线程刷新UI
//            dispatch_async(dispatch_get_main_queue(), ^{
//                //返回refreshControl到原先的位置
//                [UIView animateWithDuration:0.5 animations:^{
//                    UIEdgeInsets insets = scrollView.contentInset;
//                    insets.top = 99;
//                    scrollView.contentInset = insets;
//                }];
//                
//                //刷新tableView的数据
//                [self.tableView reloadData];
//            });
//        });
//    }
//}

@end
