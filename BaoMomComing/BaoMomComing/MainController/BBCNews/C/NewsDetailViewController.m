//
//  NewsDetailViewController.m
//  BaoMomComing
//
//  Created by xj_love on 2016/11/14.
//  Copyright © 2016年 Xander. All rights reserved.
//

#import "NewsDetailViewController.h"
#import <WebKit/WebKit.h>

@interface NewsDetailViewController (){
    NSString *newsUrl;
}

@property (nonatomic, strong) NewsDetailWkWebView *newsWebView;
@property (nonatomic, strong) NewsDetailBottomMenuView *newsBottomView;

//@property (nonatomic, strong)

@end

@implementation NewsDetailViewController

- (void)viewDidDisappear:(BOOL)animated{
    self.newsWebView.navigationDelegate = nil;
    [self.newsWebView removeAllSubviews];
    [MANAGER_SHOW dismiss];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
//    [[UINavigationBar appearance] setBarTintColor:[UIColor whiteColor]];
    
    [self loadAllView];
    
}

#pragma mark - **************************** 加载所有控件 *************************************
- (void)loadAllView{
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame =CGRectMake(0, 0, 25, 25);
    [btn setBackgroundImage:[UIImage imageNamed:@"go_back"] forState:UIControlStateNormal];
    [btn addTarget: self action: @selector(goBack) forControlEvents: UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem =[[UIBarButtonItem alloc]initWithCustomView:btn];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame =CGRectMake(0, 0,60, 30);
    [btn2 setTitle:@"0跟帖" forState:UIControlStateNormal];
    btn2.titleLabel.font = [UIFont systemFontOfSize:14];
    btn.titleLabel.textAlignment = NSTextAlignmentCenter;
    btn.titleLabel.textColor = [UIColor whiteColor];
    [btn2 setBackgroundImage:[UIImage imageNamed:@"commentIco"] forState:UIControlStateNormal];
//    [btn2 addTarget: self action: @selector(goBack) forControlEvents: UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem =[[UIBarButtonItem alloc]initWithCustomView:btn2];
    
    [self.view addSubview:self.newsWebView];
}

#pragma mark - **************************** 返回按钮事件 *************************************
- (void)goBack{
    if (self.newsWebView.canGoBack) {
        [self.newsWebView goBack];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - **************************** WkWebView事件 *************************************
- (void)newsWebViewAction{
    WS(weakSelf);
    self.newsWebView.newsDetailSuccessBlock = ^(NSString *url){
        [weakSelf.view addSubview:weakSelf.newsBottomView];
        weakSelf->newsUrl = url;
    };
}

- (void)newsBottomViewAction{
    WS(weakSelf);
    self.newsBottomView.shareNewsBlock = ^{
        [MANAGER_Share shareMessagingWithShareBackImg:weakSelf.img text:weakSelf.newsTitle url:weakSelf->newsUrl title:@"宝妈来了测试版"];
    };
}

#pragma mark - **************************** 懒加载 *************************************
- (NewsDetailWkWebView *)newsWebView{
    if (_newsWebView == nil) {
        _newsWebView = [[NewsDetailWkWebView alloc] initWithFrame:CGRectMake(0, HEADER, self.view.width, self.view.height-HEADER)];
        [self.newsWebView loadNewsDetailWkWebViewWith:self.newsDetailID andWithType:self.type];
        [self newsWebViewAction];
    }
    return _newsWebView;
}

- (NewsDetailBottomMenuView *)newsBottomView{
    if (_newsBottomView == nil) {
        _newsBottomView = [[NewsDetailBottomMenuView alloc] initWithFrame:CGRectMake(0, self.view.height-40, self.view.width, 40)];
        [self newsBottomViewAction];
    }
    return _newsBottomView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
