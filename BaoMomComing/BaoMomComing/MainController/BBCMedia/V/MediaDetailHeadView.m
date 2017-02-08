//
//  MediaDetailHeadView.m
//  BaoMomComing
//
//  Created by xj_love on 2016/11/8.
//  Copyright © 2016年 Xander. All rights reserved.
//

#import "MediaDetailHeadView.h"

@interface MediaDetailHeadView (){
    int btnWidth;
    BOOL isFirst;
}
@property (nonatomic, strong)UIView *cutView1;
@property (nonatomic, strong)UIView *cutView2;
@property (nonatomic, strong)UIView *lineView;
@property (nonatomic, strong)CBAutoScrollLabel *mediaTitleLabel;//轮播标题
@property (nonatomic, strong)UILabel *scoreLabel;
@property (nonatomic, strong)UIImageView *defaultImg;
@property (nonatomic, strong)UILabel *watchCountLabel;

@end

@implementation MediaDetailHeadView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        isFirst = YES;
        [self addAllView];
    }
    return self;
}

#pragma mark - **************************** 添加所有控件 *************************************
- (void)addAllView{
    
    [self addSubview:self.cutView1];
    [self addSubview:self.cutView2];
    [self addSubview:self.lineView];
    [self addSubview:self.mediaTitleLabel];
    [self addMenuStarImg];
    [self addSubview:self.scoreLabel];
    [self addSubview:self.defaultImg];
    [self addSubview:self.watchCountLabel];
    [self addMenuBtn];
    
}

#pragma mark - **************************** 控件方法 *************************************
- (void)buttonClick:(UIButton *)sender {
    [self moveDetailHeadLineViewWithPage:(int)sender.tag-100];
    if (self.movieDetailHeadViewBlock) {
        self.movieDetailHeadViewBlock((int)sender.tag-100);
    }
}

#pragma mark - **************************** 外部接口 *************************************
- (void)moveDetailHeadLineViewWithPage:(int)page {
    for (UIView *view in [self subviews]) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *button = (UIButton *)view;
            [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        }
    }
    
    UIButton *button = (UIButton *)[self viewWithTag:100+page];
    [button setTitleColor:ALLBACK_COLOR forState:UIControlStateNormal];
    
    [UIView animateWithDuration:0.3
                     animations:^{
                         
                         self.lineView.frame = CGRectMake(1 + page * btnWidth, self.frame.size.height-2, btnWidth, 2);
                         
                     } completion:^(BOOL finished) {
                         
                     }];
}

- (void)setMediaDetailHeadInfoWith:(MediaModel*)mediaModel{
    self.mediaTitleLabel.text = mediaModel.courseName;
    self.scoreLabel.text = [NSString stringWithFormat:@"(%d)",mediaModel.commentCount];
    self.watchCountLabel.text = [NSString stringWithFormat:@"%d人在看",mediaModel.elective];
    
    int count = mediaModel.score;
    
    for (int i=count; i<5; i++) {
        UIImageView *imageView = (UIImageView *)[self viewWithTag:i+11];
        imageView.image = [UIImage imageNamed:@"large_star_empty.png"];
    }
}

#pragma mark - **************************** 懒加载 *************************************
- (UIView *)cutView1{
    if (_cutView1 == nil) {
        _cutView1 = [[UIView alloc] init];
        _cutView1.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
    return _cutView1;
}

- (UIView *)cutView2{
    if (_cutView2 == nil) {
        _cutView2 = [[UIView alloc] init];
        _cutView2.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
    return _cutView2;
}

- (UIView *)lineView{
    if (_lineView == nil) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = ALLBACK_COLOR;
    }
    return _lineView;
}

- (CBAutoScrollLabel *)mediaTitleLabel{
    if (_mediaTitleLabel == nil) {
        _mediaTitleLabel = [[CBAutoScrollLabel alloc] init];
//        _mediaTitleLabel.text = @"谢大大的自传 谢大大的自传 谢大大的自传 谢大大的自传";
        _mediaTitleLabel.pauseInterval = 3.f;
        _mediaTitleLabel.font = [UIFont boldSystemFontOfSize:20];
        _mediaTitleLabel.textColor = ALLBACK_COLOR;
        [_mediaTitleLabel observeApplicationNotifications];
    }
    return _mediaTitleLabel;
}

- (UILabel *)scoreLabel{
    if (_scoreLabel == nil) {
        _scoreLabel = [[UILabel alloc] init];
//        _scoreLabel.text = @"(888)";
        _scoreLabel.font = [UIFont systemFontOfSize:14];
        _scoreLabel.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0];
    }
    return _scoreLabel;
}

- (UIImageView *)defaultImg{
    if (_defaultImg == nil) {
        _defaultImg = [[UIImageView alloc] init];
        _defaultImg.image = [UIImage imageNamed:@"learnerIcon"];
    }
    return _defaultImg;
}

- (UILabel *)watchCountLabel{
    if (_watchCountLabel == nil) {
        _watchCountLabel = [[UILabel alloc] init];
//        _watchCountLabel.text = @"8888人在看";
        _watchCountLabel.font = [UIFont systemFontOfSize:14];
    }
    return _watchCountLabel;
}

- (void)addMenuBtn{
    
    btnWidth = self.width/3;
    int height = 40 ;
    
    for (int i = 0; i < 3; i++) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        btn.frame = CGRectMake(i * btnWidth, self.height-height-2, btnWidth, height);
        switch (i) {
            case 0:
            {
                [btn setTitle:@"简介" forState:UIControlStateNormal];
            }
                break;
            case 1:
                [btn setTitle:@"播单" forState:UIControlStateNormal];
                break;
            case 2:
                [btn setTitle:@"评价" forState:UIControlStateNormal];
                break;
            default:
                break;
        }
        
        [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [btn.titleLabel setFont:[UIFont systemFontOfSize:18]];
        [btn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 100+i;
        [self addSubview:btn];
        
        if (i == 1) {
            [btn setTitleColor:ALLBACK_COLOR forState:UIControlStateNormal];
        }
    }

}

- (void)addMenuStarImg{
    CGFloat imgWidth = 15;
    CGFloat imgHeight = 15;
    for (int i = 1; i <= 5; i++) {
        UIImageView *starImg = [[UIImageView alloc] initWithFrame:CGRectMake(self.left+10+(imgWidth+1)*(i-1), self.height-70, imgWidth, imgHeight)];
        starImg.image = [UIImage imageNamed:@"large_star_full"];
        starImg.tag = 10+i;
        
        [self addSubview:starImg];
    }
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.cutView1.frame = CGRectMake(self.left, self.height-44, self.width, 1);
    self.cutView2.frame = CGRectMake(self.left, self.height-1,self.width, 1);
    if (isFirst) {
        self.lineView.frame = CGRectMake(self.width/3+1, self.height-2, self.width/3, 2);
        self.mediaTitleLabel.frame = CGRectMake(self.left+10, self.height-110, self.width-20, 24);
        isFirst = NO;
    }
    self.scoreLabel.frame = CGRectMake(((UIImageView*)[self viewWithTag:15]).right+5, self.height-72, 74, 21);
    self.watchCountLabel.frame = CGRectMake(self.right-110, self.height-73, 100, 21);
    self.defaultImg.frame = CGRectMake(self.watchCountLabel.left-12, self.height-67, 9, 10);
}

@end
