//
//  MediaIntroductionView.m
//  BaoMomComing
//
//  Created by xj_love on 2016/11/9.
//  Copyright © 2016年 Xander. All rights reserved.
//

#import "MediaIntroductionView.h"

#define OFFSIZEX 10
#define OFFSIZEY 15

@interface MediaIntroductionView ()

@end

@implementation MediaIntroductionView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithRed:(float)247/255 green:(float)247/255 blue:(float)247/255 alpha:1];
        self.delegate = self;
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
    }
    return self;
}

- (void)setMediaIntroductionWith:(MediaModel*)mediaModel{
    
    int width = self.frame.size.width - OFFSIZEX * 2;
    
    //简介
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 5.0;
    
    NSDictionary *attributes = @{
                                 NSFontAttributeName:[UIFont systemFontOfSize:15],
                                 NSParagraphStyleAttributeName:paragraphStyle
                                 };
    
    info = [[UILabel alloc] init];
    NSString *str = mediaModel.courseIntroduction;
    if ([MANAGER_UTIL isBlankString:str]) {
        str = @"";
    }
    info.attributedText = [[NSAttributedString alloc] initWithString:str attributes:attributes];
    info.font = [UIFont systemFontOfSize:15.0];
    info.textColor = [UIColor grayColor];
    info.numberOfLines = 0;
    
    contentSize = [mediaModel.courseIntroduction boundingRectWithSize:CGSizeMake(width, 1000) options:
                   NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:info.font} context:nil].size;
    
    singleSize = [@"课堂" boundingRectWithSize:CGSizeMake(width, 1000) options:
                  NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:info.font} context:nil].size;
    
    if (contentSize.height/singleSize.height > 5) {
        info.frame = CGRectMake(OFFSIZEX, OFFSIZEY, width, (singleSize.height + 5.0) * 5);
    }else {
        info.frame = CGRectMake(OFFSIZEX, OFFSIZEY, width, contentSize.height + (contentSize.height/singleSize.height) * 5);
    }
    infoRect = info.frame;
    [self addSubview:info];
    
    moveView = [[UIView alloc] initWithFrame:CGRectMake(0, info.frame.origin.y + info.height, self.width, 200)];
    [self addSubview:moveView];
    
    UIButton *openButton = [UIButton buttonWithType:UIButtonTypeCustom];
    openButton.frame = CGRectMake(self.frame.size.width - OFFSIZEX - 58, 5, 58, 27);
    [openButton setBackgroundImage:[UIImage imageNamed:@"btn_group_open1"] forState:UIControlStateNormal];
    openButton.tag = 10;
    [openButton addTarget:self action:@selector(openContent:) forControlEvents:UIControlEventTouchUpInside];
    [moveView addSubview:openButton];
    
    CGFloat originY = openButton.frame.origin.y + openButton.frame.size.height + OFFSIZEY;
    
    if (contentSize.height/singleSize.height <= 5) {
        openButton.hidden = YES;
        originY = OFFSIZEY;
    }
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(OFFSIZEX, originY, width, 1)];
    lineView.backgroundColor = [UIColor colorWithRed:(float)200/255 green:(float)200/255 blue:(float)200/255 alpha:1];
    [moveView addSubview:lineView];
    
    //机构／讲师介绍
    UILabel *teacherTitle = [[UILabel alloc] init];
    teacherTitle.text = @"机构/讲师介绍";
    teacherTitle.font = [UIFont systemFontOfSize:18.0];
    teacherTitle.textColor = [UIColor blackColor];
    teacherTitle.frame = CGRectMake(OFFSIZEX, lineView.frame.origin.y + lineView.height + OFFSIZEY, 200, 30);
    [moveView addSubview:teacherTitle];
    
    int offsizeY = 0;
    
    //教师头像
    UIImageView *logo = [[UIImageView alloc] init];
    logo.frame = CGRectMake(OFFSIZEX, teacherTitle.frame.origin.y + teacherTitle.frame.size.height + OFFSIZEY + offsizeY ,80, 106);
    [logo sd_setImageWithURL:IMAGE_URL_Media(mediaModel.avatar) placeholderImage:[UIImage imageNamed:@"person_null"]];
    logo.layer.shadowOffset=CGSizeMake(0, 3);
    logo.layer.shadowColor=[UIColor blackColor].CGColor;
    [logo.layer setShadowOpacity:1];
    [moveView addSubview:logo];
    
    UILabel *teacherName = [[UILabel alloc] init];
    teacherName.text = mediaModel.lecturer;
    teacherName.font = [UIFont systemFontOfSize:17.0];
    teacherName.textColor = [UIColor blackColor];
    teacherName.frame = CGRectMake(OFFSIZEX * 10,teacherTitle.frame.origin.y + teacherTitle.height + OFFSIZEY + offsizeY ,150,30);
    [moveView addSubview:teacherName];
    
    UILabel *teacherInfo = [[UILabel alloc] init];
    teacherInfo.text = mediaModel.lecturerIntroduction;
    teacherInfo.font = [UIFont systemFontOfSize:16.0];
    teacherInfo.textColor = [UIColor grayColor];
    teacherInfo.numberOfLines = 0;
    CGSize size = [teacherInfo.text boundingRectWithSize:CGSizeMake(width- OFFSIZEX * 10, 1000) options:
                   NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:teacherInfo.font} context:nil].size;
    teacherInfo.frame = CGRectMake(OFFSIZEX * 10,teacherName.frame.origin.y + teacherName.height + OFFSIZEY/3 ,width - OFFSIZEX * 10 ,size.height);
    [moveView addSubview:teacherInfo];
    
    if (teacherInfo.frame.origin.y>logo.frame.origin.y+logo.frame.size.height) {
        moveView.frame = CGRectMake(moveView.frame.origin.x, moveView.frame.origin.y, moveView.width, teacherInfo.frame.origin.y + OFFSIZEY);
    }else{
        moveView.frame = CGRectMake(moveView.frame.origin.x, moveView.frame.origin.y, moveView.width, logo.frame.origin.y+logo.height + OFFSIZEY);
    }
    
    
    offsizeY = moveView.frame.origin.y + moveView.height;
    
    if (offsizeY < self.height+1) {
        offsizeY = self.height+1;
    }
    
    self.contentSize = CGSizeMake(self.width, offsizeY);
}

- (void)openContent:(UIButton *)button {
    if (button.tag == 10) {
        [button setBackgroundImage:[UIImage imageNamed:@"btn_group_close1"] forState:UIControlStateNormal];
        button.tag = 11;
        
        [UIView animateWithDuration:0.0 animations:^{
            info.frame = CGRectMake(OFFSIZEX, OFFSIZEY, self.frame.size.width-OFFSIZEX*2, contentSize.height + (contentSize.height/singleSize.height) * 5);
            moveView.frame = CGRectMake(moveView.frame.origin.x, info.frame.origin.y + info.frame.size.height, moveView.width, moveView.height);
        }];
        
    }else {
        [button setBackgroundImage:[UIImage imageNamed:@"btn_group_open1"] forState:UIControlStateNormal];
        button.tag = 10;
        
        [UIView animateWithDuration:0.0 animations:^{
            info.frame = CGRectMake(OFFSIZEX, OFFSIZEY, self.frame.size.width-OFFSIZEX*2, (singleSize.height + 5.0) * 5);
            moveView.frame = CGRectMake(moveView.frame.origin.x, info.frame.origin.y + info.height, moveView.width, moveView.height);
        }];
    }
    
    
    CGFloat offsizeY = moveView.frame.origin.y + moveView.height;
    
    if (offsizeY < self.height+1) {
        offsizeY = self.height+1;
    }
    
    self.contentSize = CGSizeMake(self.width, offsizeY);
}

- (void)scrollViewDidScroll:(UIScrollView *)sv {
    if (sv.contentOffset.y < 0) {
        
//        [_scrollDelegate scrollDown:YES];
        
    }else if (sv.contentOffset.y > 0)
    {
//        [_scrollDelegate scrollDown:NO];
    }
    
}

@end
