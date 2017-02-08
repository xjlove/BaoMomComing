//
//  NewsDetailBottomMenuView.h
//  BaoMomComing
//
//  Created by xj_love on 2016/11/29.
//  Copyright © 2016年 Xander. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsDetailBottomMenuView : UIView
/**
 *  移除键盘监听
 */
- (void)removeNewsdetailBMObserver;

@property (nonatomic, copy) void (^shareNewsBlock)();

@end
