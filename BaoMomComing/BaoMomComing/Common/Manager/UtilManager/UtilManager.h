//
//  UtilManager.h
//  CloudClassRoom
//
//  Created by xj_love on 15/12/24.
//  Copyright © 2015年 like. All rights reserved.
//

#import <Foundation/Foundation.h>

#define MANAGER_UTIL [UtilManager sharedManager]

@interface UtilManager : NSObject

+ (instancetype)sharedManager;

#pragma mark 
//NSInteger intSort(id num1, id num2, void *context);
//NSInteger intSortPhoto(id num1, id num2, void *context);
//NSInteger intSortChat(id num1, id num2, void *context);
//NSInteger intSortPhotoDesc(id num1, id num2, void *context);
//NSInteger intSortChatDesc(id num1, id num2, void *context);
//NSInteger intSortCourse(id num1, id num2, void *context);

#pragma mark

/**
 * 获取当前屏幕显示的viewcontroller
 */
//- (UITabBarController *)getCurrentShowVC;

/**
 * 时间转换(时分秒转分钟)
 */
- (NSString *)timeToString:(NSString *)time;

/*
 * 取当前时间
 */
- (NSString *)getDateTime:(TimeType)type;

/**
 * 判断空字符串
 */
- (BOOL)isBlankString:(NSString*)string;

/*
 *是否可以在相册中选择图片
 */
- (BOOL)canUserPickPhotosFromPhotoLibrary;

/**
 * 获取MD5字符串
 */
- (NSString *)MD5String:(NSString *)str;

/**
 * DES加密
 */
- (NSString *)encryptWithText:(NSString *)sText;

/**
 * DES解密
 */
- (NSString *)decryptWithText:(NSString *)sText;

/**
 * 数字转汉字(1 -> 一)
 */
- (NSString *)intToString:(int)num;

@end
