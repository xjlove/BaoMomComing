//
//  MediaCollectionViewCell.m
//  BaoMomComing
//
//  Created by xj_love on 2016/11/4.
//  Copyright © 2016年 Xander. All rights reserved.
//

#import "MediaCollectionViewCell.h"

@interface MediaCollectionViewCell ()
@property (strong, nonatomic)  UILabel *mediaTitle;
@property (strong, nonatomic)  UILabel *mediaWriter;
@property (strong, nonatomic)  UILabel *mediaTime;
@property (strong, nonatomic)  UIImageView *mediaImg;

@end

@implementation MediaCollectionViewCell

- (void)awakeFromNib {
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
    }
    return self;
}

#pragma mark - **************************** 配置cell数据 *************************************
- (void)setMediaCellWithDataArr:(NSMutableArray*)dataArrM withIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dict = dataArrM[indexPath.section-1];
    NSArray *array = [dict objectForKey:@"course"];
    NSDictionary *sub = array[indexPath.row];
    
    [self.mediaImg sd_setImageWithURL:IMAGE_URL_Media([sub objectForKey:@"logo2"]) placeholderImage:[UIImage imageNamed:@"scrollBackImg"]];
    
    self.mediaTitle.text = [NSString stringWithFormat:@"%@\n\n\n", [sub objectForKey:@"course_name"]];
    self.mediaWriter.text = [sub objectForKey:@"lecturer"];
    
    if ([[dict objectForKey:@"category_name"] isEqualToString:@"最新课程"]) {
        self.mediaTime.text = [sub objectForKey:@"create_time"];
    }else if ([[dict objectForKey:@"category_name"] isEqualToString:@"最热课程"]) {
        
        NSString *elective = [NSString stringWithFormat:@"%@", [sub objectForKey:@"elective_count"]];
        self.mediaTime.text = [NSString stringWithFormat:@"%@ 人在看", elective];
        
        //高亮选课人次
        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:self.mediaTime.text];
        [string addAttribute:NSForegroundColorAttributeName value:ALLBACK_COLOR range:NSMakeRange(0, elective.length)];
        self.mediaTime.attributedText = string;
        
    }else {
        self.mediaTime.text = @"";
    }
    
}

#pragma mark - **************************** 懒加载 *************************************
- (UILabel *)mediaTitle{
    if (_mediaTitle == nil) {
        _mediaTitle = [[UILabel alloc] init];
        _mediaTitle.numberOfLines = 0;
        _mediaTitle.lineBreakMode = NSLineBreakByCharWrapping;
        _mediaTitle.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:_mediaTitle];
    }
    return _mediaTitle;
}

- (UILabel *)mediaWriter{
    if (_mediaWriter == nil) {
        _mediaWriter = [[UILabel alloc] init];
        _mediaWriter.font = [UIFont systemFontOfSize:14];
        _mediaWriter.textColor = [UIColor colorWithRed:108.0/255.0 green:108.0/255.0 blue:108.0/255.0 alpha:1.0];
        [self.contentView addSubview:_mediaWriter];
    }
    return _mediaWriter;
}

- (UILabel *)mediaTime{
    if (_mediaTime == nil) {
        _mediaTime = [[UILabel alloc] init];
        _mediaTime.textAlignment = NSTextAlignmentRight;
        _mediaTime.font = [UIFont systemFontOfSize:14];
        _mediaTime.textColor = [UIColor colorWithRed:108.0/255.0 green:108.0/255.0 blue:108.0/255.0 alpha:1.0];
        [self.contentView addSubview:_mediaTime];
    }
    return _mediaTime;
}

- (UIImageView *)mediaImg{
    if (_mediaImg == nil) {
        _mediaImg = [[UIImageView alloc] init];
        _mediaImg.layer.cornerRadius = 4.0;
        _mediaImg.clipsToBounds = YES;
        [self.contentView addSubview:_mediaImg];
    }
    return  _mediaImg;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.mediaImg.frame = CGRectMake(0, 0, self.width, self.width*0.8);
    self.mediaTitle.frame = CGRectMake(0, self.mediaImg.bottom+2, self.width, 41);
    self.mediaWriter.frame = CGRectMake(0, self.mediaTitle.bottom+4, self.width*0.4, 20);
    self.mediaTime.frame = CGRectMake(self.mediaWriter.width, self.mediaTitle.bottom+4, self.width*0.6, 20);
}

@end
