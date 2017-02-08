//
//  NewsModel.h
//  BaoMomComing
//
//  Created by xj_love on 2016/11/14.
//  Copyright © 2016年 Xander. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsModel : NSObject
/**
 *  id编码
 */
@property (nonatomic, strong) NSString *newsID;
/**
 *  关键字
 */
@property (nonatomic, strong) NSString *keyWords;
/**
 *  标题
 */
@property (nonatomic, strong) NSString *title;
/**
 *  简介
 */
@property (nonatomic, strong) NSString *descriptionNews;
/**
 *  图片
 */
@property (nonatomic, strong) NSString *img;
/**
 *  分类
 */
@property (nonatomic, strong) NSString *loreClass;
/**
 *  访问数
 */
@property (nonatomic, strong) NSString *count;
/**
 *  评论数
 */
@property (nonatomic, strong) NSString *rcount;
/**
 *  收藏数
 */
@property (nonatomic, strong) NSString *fcount;
/**
 *  发布时间
 */
@property (nonatomic, strong) NSString *time;

- (instancetype)initWithDictionary:(NSDictionary *)dict;

@end
