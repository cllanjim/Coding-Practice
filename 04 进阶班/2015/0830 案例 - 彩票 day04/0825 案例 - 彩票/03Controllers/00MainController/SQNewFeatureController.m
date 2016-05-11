//
//  SQNewFeatureController.m
//  0825 案例 - 彩票
//
//  Created by 张思琦 on 15/8/27.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import "SQNewFeatureController.h"
#import "SQNewFeatureCell.h"

@interface SQNewFeatureController ()

@property (nonatomic, strong) UIImageView *bigImageView;
@property (nonatomic, strong) UIImageView *bigTitle;
@property (nonatomic, strong) UIImageView *smallTitle;


@property (nonatomic, assign) CGFloat offsetX;

@end

@implementation SQNewFeatureController

static NSString * const reuseIdentifier = @"Cell";

- (instancetype)init{

    //布局参数的生成
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    
    SQNewFeatureController *collectionVC = [[SQNewFeatureController alloc] initWithCollectionViewLayout:flowLayout];
    
    
    //设置collectionVC的界面大小
    flowLayout.itemSize = [UIScreen mainScreen].bounds.size;
    //设置collection的滚动方向为左右
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    //minimumLineSpacing 根据滚动方向决定, 滚动方向的间距
    flowLayout.minimumLineSpacing = 1;
    //minimumInteritemSpacing根据滚动方向确定 , 是非滚动方向的间距
    flowLayout.minimumInteritemSpacing = 0;
    
    return collectionVC;

}



- (void)viewDidLoad {
    [super viewDidLoad];
   
    
/******************************* 设置collectionView ********************/
    //设置界面的背景颜色
    //self.view.backgroundColor = [UIColor whiteColor];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    //设置界面的分页效果
    self.collectionView.pagingEnabled = YES;
    //设置页面的弹性效果
    self.collectionView.bounces = NO;
    //设置页面的滚动条
    self.collectionView.showsHorizontalScrollIndicator = NO;
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    
    // 注册collectionView中的Cell
    [self.collectionView registerClass:[SQNewFeatureCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
/*************************    设置大背景图片    *******************/
    UIImageView *guideLine = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"guideLine"]];
    [guideLine sizeToFit];
    CGRect frame = guideLine.frame;
    frame.origin.x -= 160;
    guideLine.frame = frame;
    [self.collectionView addSubview:guideLine];
                              
    
/***************************  设置背景图片 ***********************/
    //如果放到cell中
    CGFloat centerX = self.view.center.x;
    CGPoint location;
   
    NSString *bigImageName = [NSString stringWithFormat:@"guide%i", 1];
    NSString *bigTitleName = [NSString stringWithFormat:@"guideLargeText%i",1];
    NSString *smallTitleName = [NSString stringWithFormat:@"guideSmallText%i",1];

    
    self.bigImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:bigImageName]];
    self.bigTitle = [[UIImageView alloc] initWithImage:[UIImage imageNamed:bigTitleName]];
    self.smallTitle = [[UIImageView alloc] initWithImage:[UIImage imageNamed:smallTitleName]];

    [self.bigImageView sizeToFit];
    location = CGPointMake(centerX, self.collectionView.bounds.size.height * 0.45);
    self.bigImageView.center = location;
    
    [self.bigTitle sizeToFit];
    location = CGPointMake(centerX, self.collectionView.bounds.size.height * 0.7);
    self.bigTitle.center = location;
    
    [self.smallTitle sizeToFit];
    location = CGPointMake(centerX, self.collectionView.bounds.size.height * 0.8);
    self.smallTitle.center = location;
    
    [self.collectionView addSubview:self.bigImageView];
    [self.collectionView addSubview:self.bigTitle];
    [self.collectionView addSubview:self.smallTitle];
    
/***************************  获取偏移量  ***********************/
    
    
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>
// 确定有多少section
//- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
//    return 1;
//}


// 确定每个section中的cell数量
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 4;
}


// 确定cell的内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SQNewFeatureCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor lightGrayColor];
    NSString *backgroundName = [NSString stringWithFormat:@"guide%liBackground", indexPath.row + 1];

    cell.image = [UIImage imageNamed:backgroundName];
    
    [cell setIndexPath:indexPath count:4];
    
    return cell;
}

//当停止拖拽的时候调用
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (decelerate == NO) {
        [self scrollViewDidEndDecelerating:scrollView];
    }
}

//当停止减速时候调用
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{

    
    //scrollView相对contentView的移动距离
    CGFloat currentOffsetX = scrollView.contentOffset.x;
    //scrollView自身移动的距离
    CGFloat distance = currentOffsetX - self.offsetX;
    
    
    __block CGRect frame;
    //重新布局控件
    frame = self.bigTitle.frame;
    frame.origin.x += distance * 2;
    self.bigTitle.frame = frame;
    
    frame = self.smallTitle.frame;
    frame.origin.x += distance * 2;
    self.smallTitle.frame = frame;
    
    frame = self.bigImageView.frame;
    frame.origin.x += distance * 2;
    self.bigImageView.frame = frame;
    
    
    //动画 根据滑动方向飞入
    [UIView animateWithDuration:0.25 animations:^{
        frame = self.bigTitle.frame;
        frame.origin.x -= distance;
        self.bigTitle.frame = frame;
        
        frame = self.smallTitle.frame;
        frame.origin.x -= distance;
        self.smallTitle.frame = frame;
        
        frame = self.bigImageView.frame;
        frame.origin.x -= distance;
        self.bigImageView.frame = frame;
    }];
    
    
    
    //更换图片
    //利用scrollView相对contentView移动的距离计算当前图片的序号(由于图片从1开始,所以计算结果+1)
    int index = ( currentOffsetX / ([UIScreen mainScreen].bounds.size.width) ) + 1;
    
    
    NSString *bigImageName = [NSString stringWithFormat:@"guide%i", index];
    NSString *bigTitleName = [NSString stringWithFormat:@"guideLargeText%i",index];
    NSString *smallTitleName = [NSString stringWithFormat:@"guideSmallText%i",index];
    self.bigImageView.image = [UIImage imageNamed:bigImageName];
    self.bigTitle.image = [UIImage imageNamed:bigTitleName];
    self.smallTitle.image = [UIImage imageNamed:smallTitleName];
    
    
    //重新赋值原始的offSet值
    self.offsetX = currentOffsetX;
    
    
    

}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
