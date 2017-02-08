//
//  MediaDetailScrollView.h
//  BaoMomComing
//
//  Created by xj_love on 2016/11/9.
//  Copyright © 2016年 Xander. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MediaDetailScrollView : UIScrollView

/**
 *  滑动scrollView回调
 */
@property (nonatomic, copy)void (^movieDetailScrollViewBlock)(int page);
/**
 *  移动scrollView
 *
 *  @param page 根据页码
 */
- (void)moviewDetailScrollViewWithPage:(int)page;

@property (nonatomic, strong) MediaModel *mediaMode;

@property (nonatomic, strong) NSString *meidaID;

- (void)addAllView;

@end
