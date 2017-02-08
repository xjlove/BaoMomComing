//
//  MediaEvaluateHeadTableViewCell.m
//  BaoMomComing
//
//  Created by xj_love on 2016/12/7.
//  Copyright © 2016年 Xander. All rights reserved.
//

#import "MediaEvaluateHeadTableViewCell.h"

@interface MediaEvaluateHeadTableViewCell ()

@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) DXStarRatingView *starView;

@end

@implementation MediaEvaluateHeadTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self loadAllView];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

#pragma mark - **************************** 加载所有控件 *************************************
- (void)loadAllView{
    [self.contentView addSubview:self.titleLab];
    [self.contentView addSubview:self.starView];
    
}

#pragma mark - **************************** 懒加载 ************************************
- (UILabel *)titleLab{
    if (_titleLab == nil) {
        _titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, 21)];
        _titleLab.text = @"评价该视频";
        _titleLab.font = [UIFont systemFontOfSize:17];
        _titleLab.textColor = [UIColor grayColor];
        _titleLab.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLab;
}

- (DXStarRatingView *)starView{
    if (_starView == nil) {
        _starView = [[DXStarRatingView alloc] initWithFrame:CGRectMake(0, self.titleLab.bottom+1, SCREEN_WIDTH, 40)];
        __block DXStarRatingView *_starRatingView = _starView;
        [_starView setStars:0 callbackBlock:^(NSNumber *newRating) {
            NSLog(@"newRating = %@", newRating);
            if ([newRating intValue] > 0) {
//                [_scrollDelegate doEvaluation:[newRating intValue] Content:nil];
                [_starRatingView setStars:0];
            }
        }];
    }
    return _starView;
}


@end
