//
//  XMTopScrollView.h
//  CloudClassRoom
//
//  Created by rgshio on 15/11/26.
//  Copyright © 2015年 like. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, XMTopItemShowType) {
    XMTopItemShowTypeNone,              //默认,无显示类型
    XMTopItemShowTypeCenter,            //居中显示(单数)
    XMTopItemShowTypeAll                //完整显示
};
@protocol XMTopScrollViewDelegate <NSObject>

- (void)selectClickAction:(NSInteger)index;

@end

@interface XMTopScrollView : UIView 

@property (nonatomic, weak) id <XMTopScrollViewDelegate> delegate;

- (void)reloadViewWith:(NSMutableArray *)dataArray;

/**
 * 背景图片
 **/
@property (nonatomic, strong) UIImage *topImage;

/**
 * 背景色
 **/
@property (nonatomic, strong) UIColor *topColor;

/**
 * 当前页面cell的数量
 **/
@property (nonatomic, assign) NSInteger cellCount;

/**
 * cell分割线是否隐藏,默认显示
 **/
@property (nonatomic, assign) BOOL separatorHidden;

/**
 * cell分割线距离顶部的距离
 **/
@property (nonatomic, assign) CGFloat separatorTop;

/**
 * 滑线的高度,默认为2
 **/
@property (nonatomic, assign) NSInteger lineHeight;

/**
 * collectionView的偏移量
 **/
@property (nonatomic, assign) CGPoint contentOffset;

/**
 * 字体默认颜色
 **/
@property (nonatomic, strong) UIColor *textDefaultColor;

/**
 * 字体选中颜色
 **/
@property (nonatomic, strong) UIColor *textSelectedtColor;

/**
 * 被选中对象显示方式
 **/
@property (nonatomic, assign) XMTopItemShowType showType;

@end
