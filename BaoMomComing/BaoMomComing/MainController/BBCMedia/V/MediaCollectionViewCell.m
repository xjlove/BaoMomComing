//
//  MediaCollectionViewCell.m
//  BaoMomComing
//
//  Created by xj_love on 2016/11/4.
//  Copyright © 2016年 Xander. All rights reserved.
//

#import "MediaCollectionViewCell.h"

@interface MediaCollectionViewCell ()
@property (strong, nonatomic) IBOutlet UILabel *mediaTItle;
@property (strong, nonatomic) IBOutlet UILabel *mediaWriter;
@property (strong, nonatomic) IBOutlet UILabel *mediaTime;
@property (strong, nonatomic) IBOutlet UIImageView *mediaImg;

@end

@implementation MediaCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

/**
 *  设置视频cell
 *
 *  @param dataArrM 视频数据
 */
- (void)setMediaCellWithDataArr:(NSMutableArray*)dataArrM withIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dict = dataArrM[indexPath.section-1];
    NSArray *array = [dict objectForKey:@"course"];
    NSDictionary *sub = array[indexPath.row];
    
//    UIImageView *imageView = (UIImageView *)[cell viewWithTag:7];
    _mediaImg.layer.cornerRadius = 4.0;
    _mediaImg.clipsToBounds = YES;
    [_mediaImg sd_setImageWithURL:IMAGE_URL([sub objectForKey:@"logo2"]) placeholderImage:[UIImage imageNamed:@"scrollBackImg"]];
    
//    UILabel *titleLabel = (UILabel *)[cell viewWithTag:8];
    _mediaTItle.text = [NSString stringWithFormat:@"%@\n\n\n", [sub objectForKey:@"course_name"]];
//    UILabel *nameLabel = (UILabel *)[cell viewWithTag:9];
    _mediaWriter.text = [sub objectForKey:@"lecturer"];
    
//    UILabel *label = (UILabel *)[cell viewWithTag:10];
    
    if ([[dict objectForKey:@"category_name"] isEqualToString:@"最新课程"]) {
        _mediaTime.text = [sub objectForKey:@"create_time"];
    }else if ([[dict objectForKey:@"category_name"] isEqualToString:@"最热课程"]) {
        
        NSString *elective = [NSString stringWithFormat:@"%@", [sub objectForKey:@"elective_count"]];
        _mediaTime.text = [NSString stringWithFormat:@"%@ 人在学", elective];
        
        //高亮选课人次
        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:_mediaTime.text];
        [string addAttribute:NSForegroundColorAttributeName value:ALLBACK_COLOR range:NSMakeRange(0, elective.length)];
        _mediaTime.attributedText = string;
        
    }else {
        _mediaTime.text = @"";
    }

}

@end
