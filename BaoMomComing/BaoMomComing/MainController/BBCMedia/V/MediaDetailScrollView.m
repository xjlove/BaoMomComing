//
//  MediaDetailScrollView.m
//  BaoMomComing
//
//  Created by xj_love on 2016/11/9.
//  Copyright © 2016年 Xander. All rights reserved.
//

#import "MediaDetailScrollView.h"

@interface MediaDetailScrollView ()<UIScrollViewDelegate>

@property (nonatomic, strong)MediaIntroductionView *introductionView;
@property (nonatomic, strong)MediaPlayListTableView *playListView;
@property (nonatomic, strong)MediaEvaluateTableView *evaluateView;
@property (nonatomic, strong)MediaSubmitEvaluateView *submitView;

@end

@implementation MediaDetailScrollView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
//        [self addAllView];
        self.delegate = self;
    }
    return self;
}

#pragma mark - **************************** 添加所有控件 *************************************
- (void)addAllView{
    [self addSubview:self.introductionView];
    [self addSubview:self.playListView];
    [self addSubview:self.evaluateView];
    
    NSLog(@"%@",self.superview);
//    [self.superview addSubview:self.submitView];
//    [self.superview bringSubviewToFront:self.submitView];
}

#pragma mark - **************************** 控件方法 *************************************
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    int page = scrollView.contentOffset.x/scrollView.width;
    if (self.movieDetailScrollViewBlock) {
        self.movieDetailScrollViewBlock(page);
    }
}

#pragma mark - **************************** 外部接口 *************************************
- (void)moviewDetailScrollViewWithPage:(int)page{
    [self scrollRectToVisible:CGRectMake(page * self.width,0,self.width,self.height) animated:YES];
}

#pragma mark - **************************** 懒加载 *************************************
- (MediaIntroductionView *)introductionView{
    if (_introductionView == nil) {
        _introductionView = [[MediaIntroductionView alloc] init];
    }
    return _introductionView;
}

- (MediaPlayListTableView *)playListView{
    if (_playListView == nil) {
        _playListView = [[MediaPlayListTableView alloc] init];
    }
    return _playListView;
}

- (MediaEvaluateTableView *)evaluateView{
    if (_evaluateView == nil) {
        _evaluateView = [[MediaEvaluateTableView alloc] init];
    }
    return _evaluateView;
}

- (MediaSubmitEvaluateView *)submitView{
    if (_submitView == nil) {
        _submitView = [[MediaSubmitEvaluateView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _submitView.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.3];
//        _submitView.hidden = YES;
    }
    return _submitView;
}

- (void)setMediaMode:(MediaModel *)mediaMode{
    _mediaMode = mediaMode;
    [self.introductionView setMediaIntroductionWith:mediaMode];
}

- (void)setMeidaID:(NSString *)meidaID{
    _meidaID = meidaID;
    self.playListView.meidaID = meidaID;
    self.evaluateView.meidaID = meidaID;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.introductionView.frame = CGRectMake(0, 0, self.width, self.height);
    self.playListView.frame = CGRectMake(self.width, 0, self.width, self.height);
    self.evaluateView.frame = CGRectMake(self.width*2, 0, self.width, self.height);
//    self.submitView.frame = CGRectMake(0, 0,SCREEN_WIDTH, SCREEN_HEIGHT);
}
@end
