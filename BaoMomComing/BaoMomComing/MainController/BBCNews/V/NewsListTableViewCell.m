//
//  NewsListTableViewCell.m
//  BaoMomComing
//
//  Created by xj_love on 2016/11/11.
//  Copyright © 2016年 Xander. All rights reserved.
//

#import "NewsListTableViewCell.h"

@interface NewsListTableViewCell ()

@property (nonatomic, strong) UIImageView *newsListImg;
@property (nonatomic, strong) UILabel *newsListTitleLab;
@property (nonatomic, strong) UILabel *newsListTimeLab;
@property (nonatomic, strong) UILabel *newsListCountLab;

@end

@implementation NewsListTableViewCell

- (void)awakeFromNib {
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self loadAllView];
    }
    return self;
}

#pragma mark - **************************** 添加所有控件 *************************************
- (void)loadAllView{
    [self.contentView addSubview:self.newsListImg];
    [self.contentView addSubview:self.newsListTitleLab];
    [self.contentView addSubview:self.newsListTimeLab];
    [self.contentView addSubview:self.newsListCountLab];
}

#pragma mark - **************************** 配置数据 *************************************
- (void)setNewsListCellWithData:(NSMutableArray *)dataArrM andWithIndexPath:(NSIndexPath*)indexPath{
    
    NewsModel *newsModel = dataArrM[indexPath.row];
    [self.newsListImg sd_setImageWithURL:IMAGE_URL_News(newsModel.img) placeholderImage:[UIImage imageNamed:@"scrollBackImg"]];
    self.newsListTitleLab.text = [NSString stringWithFormat:@"%@\n\n\n",newsModel.title];
    self.newsListTimeLab.text = newsModel.time;
    self.newsListCountLab.text = [NSString stringWithFormat:@"%@阅览",newsModel.count];
    
}

#pragma mark - **************************** 懒加载 *************************************
- (UIImageView *)newsListImg{
    if (_newsListImg == nil) {
        _newsListImg = [[UIImageView alloc] init];
    }
    return _newsListImg;
}

- (UILabel *)newsListTitleLab{
    if (_newsListTitleLab == nil) {
        _newsListTitleLab = [[UILabel alloc] init];
        _newsListTitleLab.numberOfLines = 0;
        _newsListTitleLab.lineBreakMode = NSLineBreakByCharWrapping;
        _newsListTitleLab.font = [UIFont systemFontOfSize:15];
    }
    return _newsListTitleLab;
}

- (UILabel *)newsListTimeLab{
    if (_newsListTimeLab == nil) {
        _newsListTimeLab = [[UILabel alloc] init];
        _newsListTimeLab.font = [UIFont systemFontOfSize:13];
        _newsListTimeLab.textColor = [UIColor colorWithRed:108.0/255.0 green:108.0/255.0 blue:108.0/255.0 alpha:1.0];
    }
    return _newsListTimeLab;
}

- (UILabel *)newsListCountLab{
    if (_newsListCountLab == nil) {
        _newsListCountLab = [[UILabel alloc] init];
        _newsListCountLab.font = [UIFont systemFontOfSize:13];
        _newsListCountLab.textColor = [UIColor colorWithRed:108.0/255.0 green:108.0/255.0 blue:108.0/255.0 alpha:1.0];
        _newsListCountLab.textAlignment = NSTextAlignmentRight;
    }
    return _newsListCountLab;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.newsListImg.frame = CGRectMake(10, 10, 100, 80);
    self.newsListTitleLab.frame = CGRectMake(self.newsListImg.right+10, 10, self.width-self.newsListImg.width-25, 53);
    self.newsListTimeLab.frame = CGRectMake(self.newsListImg.right+10, self.height-24, self.newsListTitleLab.width*0.5-5, 17);
    self.newsListCountLab.frame = CGRectMake(self.newsListTimeLab.right+5, self.height-24, self.newsListTitleLab.width*0.5-5, 17);
}

@end
