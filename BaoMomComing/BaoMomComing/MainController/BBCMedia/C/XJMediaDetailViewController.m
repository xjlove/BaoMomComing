//
//  XJMediaDetailViewController.m
//  BaoMomComing
//
//  Created by xj_love on 2016/11/3.
//  Copyright © 2016年 Xander. All rights reserved.
//

#import "XJMediaDetailViewController.h"
#import "UIDevice+XJDevice.h"

@interface XJMediaDetailViewController ()<XjAVPlayerSDKDelegate>{
    
}

@property (nonatomic, strong)XjAVPlayerSDK *BMCAVPlayer;
@property (nonatomic, strong)MediaDetailHeadView *headView;
@property (nonatomic, strong)MediaDetailScrollView *scrollView;

@end

@implementation XJMediaDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addAllView];
    [self loadData];
}

#pragma mark - **************************** 添加所有控件 *************************************
- (void)addAllView{
    
    [self.view addSubview:self.headView];
    [self.view addSubview:self.BMCAVPlayer];
    [self.view addSubview:self.scrollView];
    
    [self.scrollView addAllView];
    
    [self.view bringSubviewToFront:self.BMCAVPlayer];
    
}

#pragma mark - **************************** 加载数据 *************************************
- (void)loadData{
    NSString *urlStr = [NSString stringWithFormat:BMC_Media_DetailURL,Host_media,self.mediaID];
    [MANAGER_Data parseJsonData:urlStr FileName:@"media_detia.json" ShowLoadingMessage:NO JsonType:ParseJsonTypeMediaDetail finishCallbackBlock:^(NSMutableArray *result) {
        MediaModel *mediaModel = [result firstObject];
        [self.headView setMediaDetailHeadInfoWith:mediaModel];
        self.scrollView.mediaMode = mediaModel;
        self.scrollView.meidaID = self.mediaID;
    }];
}

#pragma mark - **************************** XjAVPlayerSDKDelegate *************************************
- (void)xjGoBack{
    [self.BMCAVPlayer xjStopPlayer];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)xjNextPlayer{
    self.BMCAVPlayer.xjPlayerUrl = [[NSBundle mainBundle] pathForResource:@"Swift.mp4" ofType:nil];
    self.BMCAVPlayer.xjPlayerTitle = @"谢大大的自传";
}

#pragma mark - **************************** headView方法 *************************************
- (void)headViewBlockAction{
    WS(weakSelf);
    self.headView.movieDetailHeadViewBlock = ^(int page){
        [weakSelf.scrollView moviewDetailScrollViewWithPage:page];
    };
}

#pragma mark - **************************** detailScroll方法 *************************************
- (void)detaileScrollBlockAction{
    WS(weakSelf);
    self.scrollView.movieDetailScrollViewBlock = ^(int page){
        [weakSelf.headView moveDetailHeadLineViewWithPage:page];
    };
}

#pragma mark - **************************** 懒加载 *************************************
- (XjAVPlayerSDK *)BMCAVPlayer{
    if (_BMCAVPlayer == nil) {
        _BMCAVPlayer = [[XjAVPlayerSDK alloc] initWithFrame:CGRectMake(0, 20, self.view.width, self.view.width*0.5)];
        _BMCAVPlayer.xjPlayerUrl = @"http://cela.gwypx.com.cn:84/tm/course/021402292/sco1/1.mp4";
        _BMCAVPlayer.xjAutoOrient = YES;
        _BMCAVPlayer.XjAVPlayerSDKDelegate = self;
    }
    return _BMCAVPlayer;
}

- (MediaDetailHeadView *)headView{
    if (_headView == nil) {
        _headView = [[MediaDetailHeadView alloc] initWithFrame:CGRectMake(0, 20, self.view.width, self.view.width*0.5+130)];
        _headView.backgroundColor = [UIColor whiteColor];
        [self headViewBlockAction];
    }
    return _headView;
}

- (MediaDetailScrollView *)scrollView{
    if (_scrollView == nil) {
        _scrollView = [[MediaDetailScrollView alloc] initWithFrame:CGRectMake(0, self.headView.bottom, self.view.width, self.view.height-self.headView.bottom)];
        _scrollView.backgroundColor = [UIColor whiteColor];
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.contentSize = CGSizeMake(_scrollView.frame.size.width * 3, _scrollView.frame.size.height);
        _scrollView.contentOffset = CGPointMake(_scrollView.width, 0);
        _scrollView.pagingEnabled = YES;
        [self detaileScrollBlockAction];
    }
    return _scrollView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
