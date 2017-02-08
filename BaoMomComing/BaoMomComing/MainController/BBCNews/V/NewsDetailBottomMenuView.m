//
//  NewsDetailBottomMenuView.m
//  BaoMomComing
//
//  Created by xj_love on 2016/11/29.
//  Copyright © 2016年 Xander. All rights reserved.
//

#import "NewsDetailBottomMenuView.h"

@interface NewsDetailBottomMenuView ()<UITextViewDelegate,UIGestureRecognizerDelegate>{
    BOOL isFull;
    NSInteger keyboardHeight;
}

@property (nonatomic, strong) UIView *blackBackView;//黑色背景
@property (nonatomic, strong) UIView *grayBackView;//大的灰色背景

@property (nonatomic, strong) UITextView *smallNewsCommentTextVW;//评论textView
@property (nonatomic, strong) UIImageView *writeImg;//提示图
@property (nonatomic, strong) UILabel *placeholderLab;//提示字

@property (nonatomic, strong) UIButton *newsShareBtn;//分享按钮

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *commitBtn;//提交
@property (nonatomic, strong) UIButton *cancelBtn;//取消

@end

@implementation NewsDetailBottomMenuView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor groupTableViewBackgroundColor];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHidden:) name:UIKeyboardWillHideNotification object:nil];
        [self loadAllView];
    }
    return self;
}

#pragma mark - **************************** 添加所有控件 *************************************
- (void)loadAllView{
    
    [self addSubview:self.smallNewsCommentTextVW];
    [self.smallNewsCommentTextVW addSubview:self.writeImg];
    [self.smallNewsCommentTextVW addSubview:self.placeholderLab];
    [self addSubview:self.newsShareBtn];
}

#pragma mark - **************************** 外部接口 *************************************
- (void)removeNewsdetailBMObserver{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - **************************** UITextView代理 *************************************
- (void)textViewDidBeginEditing:(UITextView *)textView{
    
    if ([MANAGER_UTIL isBlankString:textView.text]) {
        [self.commitBtn setEnabled:NO];
        [self.commitBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    }
    
    self.writeImg.hidden = YES;
    self.placeholderLab.hidden = YES;
    
}

- (void)textViewDidChange:(UITextView *)textView{
    if (![MANAGER_UTIL isBlankString:textView.text]) {
        [self.commitBtn setEnabled:YES];
        [self.commitBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }else{
        [self.commitBtn setEnabled:NO];
        [self.commitBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    }
}

#pragma mark - **************************** 键盘通知方法 *************************************
-(void)keyboardWillShow:(NSNotification *)notification{
    
    //这样就拿到了键盘的位置大小信息frame，然后根据frame进行高度处理之类的信息
    isFull = YES;
    CGRect frame = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    if (frame.size.height > keyboardHeight) {
        [self.superview addSubview:self.blackBackView];
        [self.blackBackView addSubview:self.grayBackView];
        [self.grayBackView addSubview:self.titleLabel];
        [self.grayBackView addSubview:self.commitBtn];
        [self.grayBackView addSubview:self.cancelBtn];
    }
    
    [self.grayBackView addSubview:self.smallNewsCommentTextVW];
    
    keyboardHeight = frame.size.height;
    
    [self layoutSubviews];
    
}

-(void)keyboardWillHidden:(NSNotification *)notification{
    isFull = NO;
    keyboardHeight = self.superview.height;
    [self layoutSubviews];
    
    [self addSubview:self.smallNewsCommentTextVW];
}

#pragma mark - **************************** 控件方法 *************************************
//隐藏键盘是的操作
- (void)hideKeyboard{
    if ([MANAGER_UTIL isBlankString:self.smallNewsCommentTextVW.text]) {
        self.writeImg.hidden = NO;
        self.placeholderLab.hidden = NO;
    }
    [self.smallNewsCommentTextVW resignFirstResponder];
}

- (void)commitUserComment{
    if(![MANAGER_UTIL isBlankString:self.smallNewsCommentTextVW.text]){
        self.smallNewsCommentTextVW.text = @"";
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [MANAGER_SHOW showInfo:@"跟帖成功" inView:self.superview];
    });
}

- (void)newsShareAction{
    if (self.shareNewsBlock) {
        self.shareNewsBlock();
    }
}

#pragma mark - **************************** 懒加载 *************************************
- (UITextView *)smallNewsCommentTextVW{
    if (_smallNewsCommentTextVW == Nil) {
        _smallNewsCommentTextVW = [[UITextView alloc] init];
        _smallNewsCommentTextVW.clipsToBounds = YES;
        _smallNewsCommentTextVW.layer.cornerRadius = 10.0f;
        _smallNewsCommentTextVW.delegate = self;
        _smallNewsCommentTextVW.font = [UIFont systemFontOfSize:16];
    }
    return _smallNewsCommentTextVW;
}

- (UIButton *)newsShareBtn{
    if (_newsShareBtn == nil) {
        _newsShareBtn = [[UIButton alloc] init];
        [_newsShareBtn setBackgroundImage:[UIImage imageNamed:@"icon_share"] forState:UIControlStateNormal];
        [_newsShareBtn addTarget:self action:@selector(newsShareAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _newsShareBtn;
}

- (UIImageView *)writeImg{
    if (_writeImg == nil) {
        _writeImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"news_write"]];
    }
    return _writeImg;
}

- (UILabel *)placeholderLab{
    if (_placeholderLab == nil) {
        _placeholderLab = [[UILabel alloc] init];
        _placeholderLab.font = [UIFont systemFontOfSize:15];
        _placeholderLab.text = @"写跟帖";
        _placeholderLab.textColor = [UIColor lightGrayColor];
    }
    return _placeholderLab;
}

- (UIView *)blackBackView{
    if (_blackBackView == nil) {
        _blackBackView = [[UIView alloc] init];
        _blackBackView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
        tap.delegate = self;
        [_blackBackView addGestureRecognizer:tap];
    }
    return _blackBackView;
}

- (UIView *)grayBackView{
    if (_grayBackView == nil) {
        _grayBackView = [[UIView alloc] init];
        _grayBackView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
    return _grayBackView;
}

- (UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:18];
        _titleLabel.text = @"写跟帖";
        _titleLabel.textColor = ALLBACK_COLOR;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

- (UIButton *)commitBtn{
    if (_commitBtn == nil) {
        _commitBtn = [[UIButton alloc] init];
        [_commitBtn setTitle:@"发送" forState:UIControlStateNormal];
        _commitBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_commitBtn addTarget:self action:@selector(commitUserComment) forControlEvents:UIControlEventTouchUpInside];
    }
    return _commitBtn;
}

- (UIButton *)cancelBtn{
    if (_cancelBtn == nil) {
        _cancelBtn = [[UIButton alloc] init];
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        _cancelBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_cancelBtn addTarget:self action:@selector(hideKeyboard) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    if (isFull) {
        self.blackBackView.frame = CGRectMake(0, 0, self.width,self.superview.height-keyboardHeight);
        self.grayBackView.frame = CGRectMake(0, self.blackBackView.height-120, self.blackBackView.width, 120);
        self.smallNewsCommentTextVW.frame = CGRectMake(10, 40, self.grayBackView.width-20, self.grayBackView.height-50);
        
        self.titleLabel.frame = CGRectMake(self.grayBackView.centerX-30, 10, 60, 20);
        self.commitBtn.frame = CGRectMake(self.grayBackView.width-50, 10, 40, 20);
        self.cancelBtn.frame = CGRectMake(10, 10, 40, 20);
    }else{
        self.blackBackView.frame = CGRectMake(0, 0, self.width,self.superview.height-keyboardHeight);
        self.grayBackView.frame = CGRectMake(0, self.blackBackView.height-120, self.blackBackView.width, 120);
        self.smallNewsCommentTextVW.frame = CGRectMake(10, 5, self.width-30-30, 30);
        
        self.newsShareBtn.frame = CGRectMake(self.smallNewsCommentTextVW.right+10, 5, 30, 30);
        self.writeImg.frame = CGRectMake(5, 5, 20, 20);
        self.placeholderLab.frame = CGRectMake(self.writeImg.right+5, 5, 50, 20);
    }
    
}

#pragma mark - **************************** 手势处理 *************************************
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    for (UIView *subView in self.blackBackView.subviews) {
        if ([touch.view isDescendantOfView:subView]) {
            return NO;
        }
    }
    return YES;
}

@end
