//
//  NewsTableView.m
//  BaoMomComing
//
//  Created by xj_love on 2016/11/11.
//  Copyright © 2016年 Xander. All rights reserved.
//

#import "NewsTableView.h"

static int page;
@interface NewsTableView ()<UITableViewDelegate,UITableViewDataSource>{
    NewsHeaderCellView *headerCell;
    NewsListTableViewCell *listCell;
    BOOL isFirst;
}

@property (nonatomic, strong)NSMutableArray *newsHeadScoArrM;
@property (nonatomic, strong)NSMutableArray *newsListDataArrM;

@end

@implementation NewsTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    if (self = [super initWithFrame:frame style:style]) {
        self.delegate = self;
        self.dataSource = self;
        page = 1;
        
        [self addMJRefresh];
    }
    return self;
}

#pragma mark - **************************** 加载数据 *************************************
- (void)loadData{
    NSString *headerUrl;
    NSString *headerFileName;
    if(self.type == 0){
        headerUrl = [NSString stringWithFormat:BMC_News_ScrollUrl,Host_news,self.newsClassID];
        headerFileName = [NSString stringWithFormat:@"news_header_to%d.json",self.newsClassID];
    }else if (self.type == 1){
        headerUrl = [NSString stringWithFormat:BMC_News_ListUrl,Host_news,self.newsClassID,page];
        headerFileName = [NSString stringWithFormat:@"news_List_to%d_%d.json",self.newsClassID,page];
    }
    
    [MANAGER_Data parseJsonData:headerUrl FileName:headerFileName ShowLoadingMessage:NO JsonType:ParseJsonTypeBMCNews finishCallbackBlock:^(NSMutableArray *result) {
        [self.mj_header endRefreshing];
        if (self.newsListDataArrM.count>0||self.newsHeadScoArrM.count>0) {
            self.newsHeadScoArrM = nil;
            self.newsListDataArrM = nil;
        }
        for (int i=0; i<result.count; i++) {
            if (i<=4) {
                [self.newsHeadScoArrM addObject:result[i]];
            }else{
                [self.newsListDataArrM addObject:result[i]];
            }
        }
        [self reloadData];
    }];
    
}

- (void)setNewsClassID:(int)newsClassID{
    _newsClassID = newsClassID;
}

#pragma mark - **************************** tableView代理方法 *************************************
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else{
        return self.newsListDataArrM.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = nil;
    
    if (indexPath.section == 0) {
        cellID = @"NewsHeaderCellView";
    }else{
        cellID = @"NewsListTableViewCell";
    }
    
    if (indexPath.section == 0) {
        [tableView registerClass:[NewsHeaderCellView class] forCellReuseIdentifier:cellID];
        headerCell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
        [headerCell setNewsHeaderCellWithData:self.newsHeadScoArrM withType:self.type];
        
        return headerCell;
    }else{
        [tableView registerClass:[NewsListTableViewCell class] forCellReuseIdentifier:cellID];
        listCell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
        [listCell setNewsListCellWithData:self.newsListDataArrM andWithIndexPath:indexPath];
        
        return listCell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 1) {
        NewsDetailViewController *newsDetailVC = [[NewsDetailViewController alloc] init];
        NewsModel *newsModel = self.newsListDataArrM[indexPath.row];
        newsDetailVC.newsDetailID = newsModel.newsID;
        newsDetailVC.type = self.type;
        newsDetailVC.newsTitle = newsModel.title;
        newsDetailVC.img = [NSString stringWithFormat:@"%@%@",Host_news_img,newsModel.img];
        newsDetailVC.hidesBottomBarWhenPushed = YES;
        [[self viewController].navigationController pushViewController:newsDetailVC animated:YES];
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return self.width*0.5;
    }else{
        return 100;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.00000001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.00000001;
}

#pragma mark - **************************** 懒加载 *************************************
- (NSMutableArray *)newsListDataArrM{
    if (_newsListDataArrM == nil) {
        _newsListDataArrM = [NSMutableArray array];
    }
    return _newsListDataArrM;
}

- (NSMutableArray *)newsHeadScoArrM{
    if (_newsHeadScoArrM == nil) {
        _newsHeadScoArrM = [NSMutableArray array];
    }
    return _newsHeadScoArrM;
}

#pragma mark - **************************** 添加下拉刷新 *************************************
- (void)addMJRefresh{
    
    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
        
        if (!isFirst) {
            isFirst = YES;
        }else{
            if ([MANAGER_Reach isEnableNetWork]) {
                if (self.type !=0) {
                    page++;
                }else{
                    
                    if (self.newsClassID<7) {
                        self.newsClassID++;
                    }else{
                        self.newsClassID = 1;
                    }
                }
            }else{
                [MANAGER_SHOW showInfo:netWorkError];
                [self.mj_header endRefreshing];
            }
        }
        [self loadData];
    }];
    // 设置普通状态的动画图片
    NSMutableArray *idleImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=60; i++) {
        UIImage *image = [UIImage imageNamed:@"icon_refresh_1"];
        [idleImages addObject:image];
    }
    [header setImages:idleImages forState:MJRefreshStateIdle];
    
    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    NSMutableArray *refreshingImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=3; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"icon_refresh_%zd", i]];
        [refreshingImages addObject:image];
    }
    [header setImages:refreshingImages forState:MJRefreshStatePulling];
    
    // 设置正在刷新状态的动画图片
    [header setImages:refreshingImages forState:MJRefreshStateRefreshing];
    self.mj_header = header;
    
    header.lastUpdatedTimeLabel.hidden = YES;
    header.stateLabel.hidden = YES;
    
    [self.mj_header beginRefreshing];
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
