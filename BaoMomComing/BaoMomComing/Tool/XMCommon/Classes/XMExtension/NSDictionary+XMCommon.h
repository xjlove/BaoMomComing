//
//  NSDictionary+XMCommon.h
//  XMCommon
//
//  Created by rgshio on 15/7/28.
//  Copyright (c) 2015年 rgshio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (XMCommon)

/**
 *  处理json数据中的null数据
 *
 *  @return 返回非空字段的字典
 */
- (NSDictionary *)nonull;

/**
 *  处理json数据中的null字段
 *
 *  @param aKey 字典的key值
 *
 *  @return 返回非null的数据
 */
- (id)objectWithKey:(id)aKey;

@end
