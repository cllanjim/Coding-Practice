//
//  NewsViewController.m
//  0213 网易新闻的简易界面
//
//  Created by 张思琦 on 16/2/13.
//  Copyright © 2016年 SQ Software Group. All rights reserved.
//

#import "NewsViewController.h"
#import "SourceViewController.h"

#define SQScreecWidth  [UIScreen mainScreen].bounds.size.width
#define SQScreecHeight [UIScreen mainScreen].bounds.size.height


static CGFloat  labelX = 0;
static CGFloat  labelY = 0;
static CGFloat const labelH = 44;
static CGFloat const labelW = 100;


@interface NewsViewController () <UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *titleScrollview;
@property (weak, nonatomic) IBOutlet UIScrollView *contentScrollview;

//用于保存当前被选中的label
@property (nonatomic, strong) UILabel *label;
//用于保存所有的label
@property (nonatomic, strong) NSMutableArray *labelArray;



@end

@implementation NewsViewController
- (NSMutableArray *)labelArray{
    if (_labelArray == nil) {
        _labelArray = [NSMutableArray array];
    }
    return _labelArray;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupChildViewController];
    
    [self setupScrollViewInfo];
    
    [self setupTitleView];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 加载childViewController
- (void)setupChildViewController{
    
    SourceViewController *topline = [[SourceViewController alloc] init];
    topline.title = @"头条";
    [self addChildViewController:topline];
    
    SourceViewController *hot = [[SourceViewController alloc] init];
    hot.title = @"热点";
    [self addChildViewController:hot];
    
    SourceViewController *video = [[SourceViewController alloc] init];
    video.title = @"头条";
    [self addChildViewController:video];
    
    SourceViewController *society = [[SourceViewController alloc] init];
    society.title = @"社会";
    [self addChildViewController:society];
    
    SourceViewController *reader = [[SourceViewController alloc] init];
    reader.title = @"阅读";
    [self addChildViewController:reader];
    
    SourceViewController *science = [[SourceViewController alloc] init];
    science.title = @"科技";
    [self addChildViewController:science];
    
}

#pragma mark - 初始化scrollView
- (void)setupScrollViewInfo{
    
    //获取childViewController个数
    NSInteger count = self.childViewControllers.count;
    
    //调整顶部scrollView的自动偏移量
    //当scrollView在NavigationController中,且为第一个子控件时,会自动偏移,需要调整
    self.automaticallyAdjustsScrollViewInsets = NO;
    //设置contentSize
    self.titleScrollview.contentSize = CGSizeMake(count * labelW, 0);
    self.titleScrollview.showsHorizontalScrollIndicator = NO;
    
    
    // 设置内容滚动条
    self.contentScrollview.contentSize = CGSizeMake(count * SQScreecWidth, 0);
    // 开启分页
    self.contentScrollview.pagingEnabled = YES;
    // 没有弹簧效果
    self.contentScrollview.bounces = NO;
    // 隐藏水平滚动条
    self.contentScrollview.showsHorizontalScrollIndicator = NO;
    // 设置代理
    self.contentScrollview.delegate = self;
    
}


#pragma mark - 加载titleScrollView
- (void)setupTitleView{
    //获取子控制器的个数
    NSInteger count = self.childViewControllers.count;

    //在titleScrollView中创建label
    for (int i = 0; i < count; i++) {
        //创建label
        UILabel *label = [[UILabel alloc] init];
        //获取label对应的vc
        //从childViewControllers中获取对应的控制器
        UIViewController *vc = self.childViewControllers[i];
        
        
        //计算label的坐标位置
        labelX = i * labelW;
        label.frame = CGRectMake(labelX, labelY, labelW, labelH);
        //设置label的text
        label.text = vc.title;
        //设置标签
        label.tag = i;
        //设置label的交互功能
        label.userInteractionEnabled = YES;
        //文字居中
        label.textAlignment = NSTextAlignmentCenter;
       
        
        //在label上添加tap手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(titleClick:)];
        [label addGestureRecognizer:tap];
        
        
        //默认情况下选中第一个label
        if (i == 0) {
            [self titleClick:tap];
        }
        
        //把label添加到lableArray数组中
        [self.labelArray addObject:label];
        
        //添加label到titleScrollView
        [self.titleScrollview addSubview:label];
    }
}

#pragma mark - titleClick
- (void)titleClick:(UITapGestureRecognizer *)tap{
    //获取触发当前方法的label
    UILabel *label = (UILabel *)tap.view;
    //将传入的label状态更新
    [self changeLabelState:label];
    //将传入的label位置居中
    [self moveLabelToCenter:label];
    

    //更新contentScrollview中的内容
    //获得label的角标
    NSInteger index = label.tag;
    //计算偏移量
    CGFloat offsetX = index * SQScreecWidth;
    //移动contentScrollview
    self.contentScrollview.contentOffset = CGPointMake(offsetX, 0);
    //向contentScrollView中添加vc
    [self addViewControllerByIndex:index];
    

}

- (void)changeLabelState:(UILabel *)label{
    
    //将原先label的状态还原
    //取消高亮状态
    self.label.highlighted = NO;
    //恢复形变
    self.label.transform = CGAffineTransformIdentity;
    //恢复黑色
    self.label.textColor = [UIColor blackColor];
    
    
    //将传入的label的状态更新
    //更新颜色
    label.textColor = [UIColor redColor];
    //更新形变
    label.transform = CGAffineTransformMakeScale(1.6, 1.6);
    
    
    //将label赋值给self.label
    self.label = label;
}

- (void)moveLabelToCenter:(UILabel *)laber{
    //计算label移动到中间的偏移量
    CGFloat offsetX = laber.center.x - SQScreecWidth * 0.5;
    
    //计算label能够移动的最大距离
    CGFloat maxOffsetX = self.titleScrollview.contentSize.width - SQScreecWidth;
    
    
    //如果偏移量量小于0,就说明当前label在屏幕的左半边,不需要移动
    if (offsetX < 0) {
        offsetX = 0;
    }
    //如果偏移量大于最大距离,就说明当前label在scrollView的最右边,不需要居中
    if(offsetX > maxOffsetX){
        offsetX = maxOffsetX;
    }
    
    
    //移动titleView到中央
    [self.titleScrollview setContentOffset:CGPointMake(offsetX, 0) animated:YES];
    
}


- (void)addViewControllerByIndex:(NSUInteger)index{
    //获取需要添加的viewController
    UIViewController *vc = self.childViewControllers[index];
    
    //如果当前viewController的view没有被加载过,就进行加载
    if(vc.isViewLoaded)
    {
        return;
    }
    
    //计算偏移量
    CGFloat offsetX = index * SQScreecWidth;
    //设定view的frame
    vc.view.frame = CGRectMake(offsetX, 0, SQScreecWidth, SQScreecHeight);
    //将view添加到contentScrollview
    [self.contentScrollview addSubview:vc.view];
    
    
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    //注意点
    //CGFloat是浮点数
    //NSInteger是整数
    
    //根据偏移量获得当前页面的编号
    CGFloat curPage = scrollView.contentOffset.x / scrollView.bounds.size.width;
    NSLog(@"%f",curPage);
    NSInteger leftPage = curPage;

    NSInteger rightPage = leftPage + 1;
    
    //获取左边的lable
    UILabel *leftLabel = self.labelArray[leftPage];
    
    
    UILabel *rightLabel;
    if(rightPage < self.labelArray.count){
        rightLabel = self.labelArray[rightPage];
    }
    
    //计算向右边滑动时的缩放比例
    CGFloat rightScale = curPage - leftPage;
    rightLabel.transform = CGAffineTransformMakeScale(rightScale * 0.3 + 1, rightScale *0.3 +1);
    
    
    //计算向左边滑动时的缩放比例
    CGFloat leftScale = 1 - rightScale;
    leftLabel.transform = CGAffineTransformMakeScale(leftScale * 0.3 + 1, leftScale *0.3 +1);
    
    
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    //根据偏移量获取当前的index
    NSInteger index = scrollView.contentOffset.x / scrollView.bounds.size.width;
    //在contentScrollView添加对应的viewController
    [self addViewControllerByIndex:index];
    
    
    //获取对应标题
    UILabel *label = self.labelArray[index];
    //在titleScrollView中调整lable的位置和状态
    [self changeLabelState:label];
    [self moveLabelToCenter:label];
    
}





/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
