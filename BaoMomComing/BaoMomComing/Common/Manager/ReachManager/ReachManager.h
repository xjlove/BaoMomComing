//
//  ReachManager.h
//  BaoMomComing
//
//  Created by xj_love on 2016/11/4.
//  Copyright © 2016年 Xander. All rights reserved.
//

#import <Foundation/Foundation.h>

#define MANAGER_Reach [ReachManager sharedManager]
#define UTIL_HOST @"www.baidu.com"

@interface ReachManager : NSObject

+ (instancetype)sharedManager;

/**
 *  开启网络监控
 */
- (void)startReachAbility;

/*
 * 是否wifi
 */
- (BOOL)isEnableWIFI;

/*
 * 是否3G
 */
- (BOOL)isEnable3G;

/*
 * 是否有网络
 */
- (BOOL)isEnableNetWork;

@end
