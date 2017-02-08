//
//  NewsListTableViewCell.h
//  BaoMomComing
//
//  Created by xj_love on 2016/11/11.
//  Copyright © 2016年 Xander. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsListTableViewCell : UITableViewCell

/**
 *  配置资讯列表
 *
 *  @param dataArrM  数据，可变数字，NewsModel
 *  @param indexPath 哪一组，哪一行
 */
- (void)setNewsListCellWithData:(NSMutableArray *)dataArrM andWithIndexPath:(NSIndexPath*)indexPath;

@end
