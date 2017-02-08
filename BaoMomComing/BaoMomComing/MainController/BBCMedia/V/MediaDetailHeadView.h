//
//  MediaDetailHeadView.h
//  BaoMomComing
//
//  Created by xj_love on 2016/11/8.
//  Copyright © 2016年 Xander. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MediaDetailHeadView : UIView

/**
 *  移动头部菜单回调
 */
@property (nonatomic, copy)void (^movieDetailHeadViewBlock)(int page);
/**
 *  设置头部信息
 *
 *  @param mediaModel
 */
- (void)setMediaDetailHeadInfoWith:(MediaModel*)mediaModel;
/**
 *  移动下划线
 *
 *  @param page 当前页码
 */
- (void)moveDetailHeadLineViewWithPage:(int)page;

@end
