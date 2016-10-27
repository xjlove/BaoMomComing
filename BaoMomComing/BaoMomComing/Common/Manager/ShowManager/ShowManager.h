//
//  ShowManager.h
//  CloudClassRoom
//
//  Created by xj_love on 16/7/29.
//  Copyright © 2016年 Xander. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"

#define MANAGER_SHOW [ShowManager sharedManager]

@interface ShowManager : NSObject <MBProgressHUDDelegate>

@property (nonatomic, assign) CGFloat progress;

/**
 *  ShowManager Init
 **/
+ (instancetype)sharedManager;

- (void)showInfo:(NSString *)info;
- (void)showInfo:(NSString *)info inView:(UIView *)view;
- (void)showWithInfo:(NSString *)info;
- (void)showWithInfo:(NSString *)info inView:(UIView *)view;
- (void)showProgressWithInfo:(NSString *)info;

- (void)dismiss;

@end
