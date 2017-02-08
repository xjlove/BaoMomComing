
//
//  MediaSubmitEvaluateView.m
//  BaoMomComing
//
//  Created by xj_love on 2016/12/7.
//  Copyright © 2016年 Xander. All rights reserved.
//

#import "MediaSubmitEvaluateView.h"

@interface MediaSubmitEvaluateView ()

@property (nonatomic, strong) UIView *whiteBackView;

@end

@implementation MediaSubmitEvaluateView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

#pragma mark - **************************** 懒加载 ************************************
- (UIView *)whiteBackView{
    if (_whiteBackView == nil) {
        _whiteBackView = [[UIView alloc] init];
    }
    return _whiteBackView;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.whiteBackView.frame = CGRectMake((self.width-213)*0.5,(self.height-287)*0.5 , 287, 213);
}

@end
