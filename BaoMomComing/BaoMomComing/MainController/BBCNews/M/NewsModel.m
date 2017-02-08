//
//  NewsModel.m
//  BaoMomComing
//
//  Created by xj_love on 2016/11/14.
//  Copyright © 2016年 Xander. All rights reserved.
//

#import "NewsModel.h"

@implementation NewsModel

- (instancetype)initWithDictionary:(NSDictionary *)dict{
    if (self = [super init]) {
        self.newsID = [dict objectForKey:@"id"];
        self.keyWords = [dict objectForKey:@"keywords"];
        self.title = [dict objectForKey:@"title"];
        self.descriptionNews = [dict objectForKey:@"description"];
        self.img = [dict objectForKey:@"img"];
        self.loreClass = [dict objectForKey:@"loreclass"];
        self.count = [dict objectForKey:@"count"];
        self.rcount = [dict objectForKey:@"rcount"];
        self.fcount = [dict objectForKey:@"fcount"];
        self.time = [MANAGER_UTIL timeWithTimeIntervalString:[dict objectForKey:@"time"]];
    }
    return self;
}

@end
