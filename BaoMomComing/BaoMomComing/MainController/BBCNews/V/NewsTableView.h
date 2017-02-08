//
//  NewsTableView.h
//  BaoMomComing
//
//  Created by xj_love on 2016/11/11.
//  Copyright © 2016年 Xander. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsTableView : UITableView
/**
 *  资讯ID
 */
@property (nonatomic, assign)int newsClassID;
/**
 *  资讯类型 0，头条，1，其它
 */
@property (nonatomic, assign)int type;

@end
