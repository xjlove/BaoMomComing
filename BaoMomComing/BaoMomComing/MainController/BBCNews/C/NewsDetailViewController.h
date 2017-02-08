//
//  NewsDetailViewController.h
//  BaoMomComing
//
//  Created by xj_love on 2016/11/14.
//  Copyright © 2016年 Xander. All rights reserved.
//

#import "XJRootController.h"

@interface NewsDetailViewController : XJRootController

/**
 *  资讯详情ID
 */
@property (nonatomic, strong) NSString *newsDetailID;
/**
 *  类型0.头条，1.其它
 */
@property (nonatomic, assign) int type;

@property (nonatomic, strong) NSString *newsTitle;
@property (nonatomic, strong) NSString *img;

@end
