//
//  ShowManager.m
//  CloudClassRoom
//
//  Created by xj_love on 16/7/29.
//  Copyright © 2016年 Xander. All rights reserved.
//

#import "ShowManager.h"

#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

@interface ShowManager () {
    UIWindow                    *window;
    MBProgressHUD               *hud;
}

@end

static ShowManager *showManager = nil;
@implementation ShowManager

#pragma mark - Private
+ (instancetype)sharedManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        showManager = [[ShowManager alloc] init];
    });
    
    return showManager;
}

+ (instancetype)alloc {
    NSAssert(showManager == nil, @"Attempted to allocate a second instance of a singleton.");
    return [super alloc];
}

- (instancetype)init {
    if (self = [super init]) {
        window = [[[UIApplication sharedApplication] windows] firstObject];
    }
    
    return self;
}

#pragma mark - property
- (void)setProgress:(CGFloat)progress {
    hud.progress = progress;
    if (progress == 1) {
        [self dismiss];
    }
}

#pragma mark - selector
- (void)setProgressHUD {
    hud.color = [UIColor colorWithRed:(float)210/255 green:(float)210/255 blue:(float)210/255 alpha:0.9];
    hud.labelColor = [UIColor colorWithRed:(float)0/255 green:(float)113/255 blue:(float)220/255 alpha:1];
}

- (void)setHUDOrientation {
    switch ([[UIApplication sharedApplication] statusBarOrientation]) {
        case UIInterfaceOrientationUnknown:
            break;
        case UIInterfaceOrientationPortrait:
            break;
        case UIInterfaceOrientationPortraitUpsideDown:
            break;
        case UIInterfaceOrientationLandscapeLeft:
            hud.transform = CGAffineTransformMakeRotation(0);
            break;
        case UIInterfaceOrientationLandscapeRight:
            hud.transform = CGAffineTransformMakeRotation(0);
            break;
            
        default:
            break;
    }
}

- (void)removeHUD {
    [hud removeFromSuperview];
    hud = nil;
}

#pragma mark - MBProgressHUD
- (void)showInfo:(NSString *)info {
    [self showInfo:info inView:window];
}

- (void)showInfo:(NSString *)info inView:(UIView *)view {
    if (hud) {
        return;
    }
    
    hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = info;
    hud.delegate = self;
    [hud hide:YES afterDelay:2];
    
    [self setProgressHUD];
    
    if (IS_IPAD) {
        [self setHUDOrientation];
    }
}

- (void)showWithInfo:(NSString *)info {
    [self showWithInfo:info inView:window];
}

- (void)showWithInfo:(NSString *)info inView:(UIView *)view {
    if (hud) {
        return;
    }
    
    hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.labelText = info;
    
    [self setProgressHUD];
    
    if (IS_IPAD) {
        [self setHUDOrientation];
    }
}

- (void)showProgressWithInfo:(NSString *)info {
    if (hud) {
        return;
    }
    
    hud = [MBProgressHUD showHUDAddedTo:window animated:YES];
    //设置模式为进度框形的
    hud.mode = MBProgressHUDModeDeterminate;
    hud.labelText = info;
    hud.progress = 0;
    
    [self setProgressHUD];
    
    if (IS_IPAD) {
        [self setHUDOrientation];
    }
}

- (void)dismiss {
    [hud hide:YES];
    [self removeHUD];
}

#pragma mark - MBProgressHUDDelegate
- (void)hudWasHidden:(MBProgressHUD *)hud {
    [self removeHUD];
}

@end
