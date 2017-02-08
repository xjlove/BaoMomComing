//
//  NewsHeaderCellView.m
//  BaoMomComing
//
//  Created by xj_love on 2016/11/11.
//  Copyright © 2016年 Xander. All rights reserved.
//

#import "NewsHeaderCellView.h"

@interface NewsHeaderCellView ()<CycleScrollViewDelegate>{
    BOOL isFirst;
    int newsType;
}

@property (nonatomic, strong) CycleScrollView *newsCycleScrollView;
@property (nonatomic, strong) UIPageControl *newsPageView;

@property (nonatomic, strong) NSMutableArray *dataArrM;

@end

@implementation NewsHeaderCellView

- (void)awakeFromNib {
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self loadAllView];
    }
    return self;
}

#pragma mark - **************************** 添加所有控件 *************************************
- (void)loadAllView{
    [self.contentView addSubview:self.newsCycleScrollView];
    [self.contentView addSubview:self.newsPageView];
}

#pragma mark - **************************** 配置数据 *************************************
- (void)setNewsHeaderCellWithData:(NSMutableArray *)dataArrM withType:(int)type{
    self.dataArrM = dataArrM;
    self.newsPageView.numberOfPages = dataArrM.count;
    newsType = type;
    
    __block  NSMutableArray *viewArray = [[NSMutableArray alloc] init];
    if (dataArrM.count == 1) {
        for (int i = 0; i < 3; i++) {
            NewsModel *newsModel = [dataArrM firstObject];
            [viewArray addObject:[self loadScrollDataViewWithModel:newsModel]];
        }
        
    }else if (dataArrM.count == 2) {
        
        for (int i = 0; i < 4; i++) {
            NewsModel *newsModel = [dataArrM objectAtIndex:i%2];
            [viewArray addObject:[self loadScrollDataViewWithModel:newsModel]];
        }
        
    }else {
        
        for (int i = 0; i < dataArrM.count; i++) {
            NewsModel *newsModel = dataArrM[i];
            [viewArray addObject:[self loadScrollDataViewWithModel:newsModel]];
        }
        
    }
    self.newsCycleScrollView.fetchContentViewAtIndex = ^UIView *(NSInteger pageIndex){
        return viewArray[pageIndex];
    };
    self.newsCycleScrollView.totalPagesCount = ^NSInteger(void){
        return viewArray.count;
    };
    
    __block UIPageControl *control = self.newsPageView;
    self.newsCycleScrollView.getCurrentPage = ^(NSInteger pageIndex){
        NSInteger index = 0;
        if (dataArrM.count == 1) {
            index = 0;
        }else if (dataArrM.count == 2) {
            index = pageIndex % 2;
        }else {
            index = pageIndex;
        }
        control.currentPage = index;
    };
}

- (UIImageView*)loadScrollDataViewWithModel:(NewsModel*)newsModel{
    
    CGFloat width = self.newsCycleScrollView.width;
    CGFloat height = self.newsCycleScrollView.height;
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    [imageView sd_setImageWithURL:IMAGE_URL_News(newsModel.img) placeholderImage:[UIImage imageNamed:@"scrollBackImg"]];
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, height-30, width, 30)];
    backView.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.5];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, backView.height-25, width-100, 20)];
    titleLabel.font = [UIFont systemFontOfSize:13];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.text = newsModel.title;
    
    [backView addSubview:titleLabel];
    [imageView addSubview:backView];
    
    return imageView;
}

#pragma mark - **************************** cycleScrollView方法 *************************************
- (void)tapActionWithPageIndex:(NSInteger)pageIndex {
    NSInteger index = 0;
    if (self.dataArrM.count == 1) {
        index = 0;
    }else if (self.dataArrM.count == 2) {
        index = pageIndex % 2;
    }else {
        index = pageIndex;
    }
    
    NewsModel *newsModel = self.dataArrM[index];
    
    NewsDetailViewController *newsDetailVC = [[NewsDetailViewController alloc] init];
    newsDetailVC.hidesBottomBarWhenPushed = YES;
    newsDetailVC.newsDetailID = newsModel.newsID;
    newsDetailVC.type = newsType;
    newsDetailVC.newsTitle = newsModel.title;
    newsDetailVC.img = [NSString stringWithFormat:@"%@%@",Host_news_img,newsModel.img];
    
    [[self viewController].navigationController pushViewController:newsDetailVC animated:YES];
    
}

#pragma mark - **************************** 懒加载 *************************************
- (CycleScrollView *)newsCycleScrollView{
    if (_newsCycleScrollView == nil) {
        _newsCycleScrollView = [[CycleScrollView alloc] initWithFrame:CGRectMake(0, 0, self.width,SCREEN_WIDTH*0.5) animationDuration:3];
        _newsCycleScrollView.delegate = self;
    }
    return _newsCycleScrollView;
}

- (UIPageControl *)newsPageView{
    if (_newsPageView == nil) {
        _newsPageView = [[UIPageControl alloc] init];
        _newsPageView.numberOfPages = 3;
        _newsPageView.currentPageIndicatorTintColor = ALLBACK_COLOR;
    }
    return _newsPageView;
}

- (NSMutableArray *)dataArrM{
    if (_dataArrM == nil) {
        _dataArrM = [NSMutableArray array];
    }
    return _dataArrM;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.newsCycleScrollView.frame = CGRectMake(0, 0, self.width, self.height);
    self.newsPageView.frame = CGRectMake(self.newsCycleScrollView.right-80, self.bottom-32,60, 37);
    
}

- (UIViewController *)viewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

@end
