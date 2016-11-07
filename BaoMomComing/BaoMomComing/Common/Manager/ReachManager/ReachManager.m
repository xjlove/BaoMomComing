//
//  ReachManager.m
//  BaoMomComing
//
//  Created by xj_love on 2016/11/4.
//  Copyright © 2016年 Xander. All rights reserved.
//

#import "ReachManager.h"

@interface ReachManager ()

@property (strong, nonatomic) Reachability *hostReach;

@end

static ReachManager *reachManager = nil;
@implementation ReachManager

#pragma mark - Private
+ (instancetype)sharedManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        reachManager = [[ReachManager alloc] init];
    });
    
    return reachManager;
}

+ (instancetype)alloc {
    NSAssert(reachManager == nil, @"Attempted to allocate a second instance of a singleton.");
    return [super alloc];
}

/**
 *  开启网络监控
 */
- (void)startReachAbility{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
    self.hostReach = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    [self.hostReach startNotifier];
}

#pragma mark - NSNotificationCenter
- (void)reachabilityChanged:(NSNotification *)noti {
    Reachability *curReach = [noti object];
    NSParameterAssert([curReach isKindOfClass:[Reachability class]]);
    
    NetworkStatus status = [curReach currentReachabilityStatus];
    
    switch (status) {
        case NotReachable:
            NSLog(@"NotReachable");
            break;
        case ReachableViaWiFi:
        {
            NSLog(@"ReachableViaWiFi");
        }
            break;
        case ReachableViaWWAN:
        {
            NSLog(@"ReachableViaWWAN");
            [[NSNotificationCenter defaultCenter] postNotificationName:@"isEnable3G" object:nil];
        }
            break;
            
        default:
            break;
    }
}

/**
 * 是否wifi
 */
- (BOOL)isEnableWIFI {
    return [[Reachability reachabilityForInternetConnection] isReachableViaWiFi];
}

/**
 * 是否3G
 */
- (BOOL)isEnable3G {
    return [[Reachability reachabilityForInternetConnection] isReachableViaWWAN];
}

/*
 * 是否有网络
 */
- (BOOL)isEnableNetWork {
    BOOL status = NO;
    Reachability *r = [Reachability reachabilityWithHostName:UTIL_HOST];
    switch ([r currentReachabilityStatus]) {
        case NotReachable:
            status = NO;
            break;
        case ReachableViaWWAN:
            status = YES;
            break;
        case ReachableViaWiFi:
            status = YES;
            break;
    }
    
    return status;
}

@end
