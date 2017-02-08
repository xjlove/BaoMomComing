//
//  MediaEvaluateTableViewCell.m
//  BaoMomComing
//
//  Created by xj_love on 2016/12/7.
//  Copyright © 2016年 Xander. All rights reserved.
//

#import "MediaEvaluateTableViewCell.h"

@interface MediaEvaluateTableViewCell ()

@property (nonatomic, strong) UIImageView *eImageView;
@property (nonatomic, strong) UILabel *eRealNameLab;
@property (nonatomic, strong) UILabel *eCreateTimeLab;
@property (nonatomic, strong) UILabel *eCommentLab;

@end

@implementation MediaEvaluateTableViewCell

- (void)awakeFromNib {
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self loadAllView];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

#pragma mark - **************************** 配置cell *************************************
- (void)setMediaEvaluateTableViewCellWithData:(EvaluateModel *)evaluateModel{
    [self.eImageView sd_setImageWithURL:IMAGE_URL_Media(evaluateModel.avatar) placeholderImage:[UIImage imageNamed:@"nullpic"]];
    self.eRealNameLab.text = evaluateModel.realname;
    self.eCreateTimeLab.text = evaluateModel.create_time;
    self.eCommentLab.text = evaluateModel.comment;
    
    int count = 5-evaluateModel.score;
    for (int i=5; i>count; i--) {
        UIImageView *imageView = (UIImageView *)[self viewWithTag:10+i];
        if (i > count) {
            imageView.image = [UIImage imageNamed:@"large_star_full"];
        }else {
            imageView.image = [UIImage imageNamed:@"large_star_empty"];
        }
    }
}

#pragma mark - **************************** 加载所有控件 *************************************
- (void)loadAllView{
    [self.contentView addSubview:self.eImageView];
    [self.contentView addSubview:self.eRealNameLab];
    [self.contentView addSubview:self.eCreateTimeLab];
    [self addMenuStarImg];
    [self.contentView addSubview:self.eCommentLab];
}

- (void)addMenuStarImg{
    CGFloat imgWidth = 15;
    CGFloat imgHeight = 15;
    for (int i = 5; i >0; i--) {
        UIImageView *starImg = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-(imgWidth+1)*(i)-10, self.top+10, imgWidth, imgHeight)];
        starImg.image = [UIImage imageNamed:@"large_star_empty"];
        starImg.tag = 10+i;
        
        [self.contentView addSubview:starImg];
    }
    
}

#pragma mark - **************************** 懒加载 *************************************
- (UIImageView *)eImageView{
    if (_eImageView == nil) {
        _eImageView = [[UIImageView alloc] init];
        _eImageView.layer.cornerRadius = _eImageView.height*0.5;
        _eImageView.clipsToBounds = YES;
    }
    return _eImageView;
}

- (UILabel *)eRealNameLab{
    if (_eRealNameLab == nil) {
        _eRealNameLab = [[UILabel alloc] init];
        _eRealNameLab.font = [UIFont systemFontOfSize:14];
    }
    return _eRealNameLab;
}

- (UILabel *)eCreateTimeLab{
    if (_eCreateTimeLab == nil) {
        _eCreateTimeLab = [[UILabel alloc] init];
        _eCreateTimeLab.font = [UIFont systemFontOfSize:14];
        _eCreateTimeLab.textColor = [UIColor grayColor];
    }
    return _eCreateTimeLab;
}

- (UILabel *)eCommentLab{
    if (_eCommentLab == nil) {
        _eCommentLab = [[UILabel alloc] init];
        _eCommentLab.font = [UIFont systemFontOfSize:13];
        _eCommentLab.textColor = [UIColor grayColor];
        _eCommentLab.numberOfLines = 0;
    }
    return _eCommentLab;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.eImageView.frame = CGRectMake(self.left+10,10, 50, 50);
    self.eRealNameLab.frame = CGRectMake(self.eImageView.right+10,10, 50, 21);
    self.eCreateTimeLab.frame = CGRectMake(self.eRealNameLab.right+10,10, 90, 21);
    
    CGSize size = [self.eCommentLab.text boundingRectWithSize:CGSizeMake(self.width-self.eImageView.right-20, 1000) options:
                    NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: self.eCommentLab.font} context:nil].size;
    if (size.height >20) {
        self.eCommentLab.frame = CGRectMake(self.eImageView.right+10, self.eRealNameLab.bottom+10, self.width-self.eImageView.right-20, size.height);
    }
    
}

@end
