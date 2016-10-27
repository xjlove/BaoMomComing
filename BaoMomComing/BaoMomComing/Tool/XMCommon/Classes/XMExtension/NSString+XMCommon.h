//
//  NSString+XMCommon.h
//  XMCommon
//
//  Created by rgshio on 15/6/24.
//  Copyright (c) 2015年 rgshio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (XMCommon)

/**
 *  URL中特殊字符转换16进制
 */
- (NSString *)urlEncode;

/**
 *  获取Documents路径
 *
 *  @return 返回documents路径
 */
- (NSString *)documentPath;

/**
 *  获取缓存路径
 *
 *  @return 返回cache路径
 */
- (NSString *)cachePath;

/**
 *  验证邮箱是否有效
 *
 *  @return YES or NO
 */
- (BOOL)isValidEmail;

/**
 *  验证手机号是否有效
 *
 *  @return YES or NO
 */
- (BOOL)isValidPhoneNumber;

/**
 *   验证身份证是否有效
 *
 *  @return YES or NO
 */
- (BOOL)isValidPersonID;

/**
 *  判断字符串是否为空
 *
 *  @return YES or NO
 */
- (BOOL)ifnull;


/**
 *  判断字符是否为数字
 *
 *  @return YES or NO
 */
- (BOOL)isPureInt;

@end
