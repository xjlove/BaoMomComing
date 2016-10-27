//
//  NSNull+XMCommon.h
//  XMCommon
//
//  Created by rgshio on 15/7/28.
//  Copyright (c) 2015年 rgshio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSNull (XMCommon)

/**
 *  null数据调用方法,崩溃处理
 *
 *  @return float 0.0
 */
- (float)floatValue;

/**
 *  null数据调用方法,崩溃处理
 *
 *  @return int 0
 */
- (int)intValue;

/**
 *  null数据调用方法,崩溃处理
 *
 *  @return 字符串长度 0
 */
- (int)length;

@end
