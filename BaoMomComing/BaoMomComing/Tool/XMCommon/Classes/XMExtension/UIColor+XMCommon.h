//
//  UIColor+XMCommon.h
//  XMCommon
//
//  Created by rgshio on 15-1-22.
//  Copyright (c) 2015年 rgshio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (XMCommon)
/**
 *  返回随机色
 */
+ (UIColor *)randomColor;

/**
 *  十六进制转换颜色
 */
+ (UIColor *)colorWithHexString:(NSString *)hexString;

@end
