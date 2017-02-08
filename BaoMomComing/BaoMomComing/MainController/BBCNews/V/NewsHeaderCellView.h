//
//  NewsHeaderCellView.h
//  BaoMomComing
//
//  Created by xj_love on 2016/11/11.
//  Copyright © 2016年 Xander. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsHeaderCellView : UITableViewCell

/**
 *  配置头部滑动图数据
 *
 *  @param dataArrM 数据，可变数组，NewsModel
 *  @param type ，咨询类型 0.头条 1.其它
 */
- (void)setNewsHeaderCellWithData:(NSMutableArray *)dataArrM withType:(int)type;

@end
