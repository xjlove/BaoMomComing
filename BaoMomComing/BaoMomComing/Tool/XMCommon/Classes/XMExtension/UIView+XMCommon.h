//
//  UIView+XMCommon.h
//  XMCommon
//
//  Created by rgshio on 15-1-22.
//  Copyright (c) 2015年 rgshio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (XMCommon)

/**
 *  Shortcut for frame.origin.x.
 *
 *  Sets frame.origin.x = originX
 */
@property (nonatomic) CGFloat originX;

/**
 *  Shortcut for frame.origin.y
 *
 *  Sets frame.origin.y = originY
 */
@property (nonatomic) CGFloat originY;

/**
 *  Shortcut for frame.origin.x + frame.size.width
 *
 *  Sets frame.origin.x = right - frame.size.width
 */
@property (nonatomic) CGFloat right;

/**
 *  Shortcut for frame.origin.y + frame.size.height
 *
 *  Sets frame.origin.y = bottom - frame.size.height
 */
@property (nonatomic) CGFloat bottom;

/**
 *  Shortcut for frame.size.width
 *
 *  Sets frame.size.width = width
 */
@property (nonatomic) CGFloat width;

/**
 *  Shortcut for frame.size.height
 *
 *  Sets frame.size.height = height
 */
@property (nonatomic) CGFloat height;

/**
 *  Shortcut for center.x
 *
 *  Sets center.x = centerX
 */
@property (nonatomic) CGFloat centerX;

/**
 *  Shortcut for center.y
 *
 *  Sets center.y = centerY
 */
@property (nonatomic) CGFloat centerY;

/**
 *  Return the x coordinate on the screen.
 */
@property (nonatomic, readonly) CGFloat ttScreenX;

/**
 *  Return the y coordinate on the screen.
 */
@property (nonatomic, readonly) CGFloat ttScreenY;

/**
 *  Return the x coordinate on the screen, taking into account scroll views.
 */
@property (nonatomic, readonly) CGFloat screenViewX;

/**
 *  Return the y coordinate on the screen, taking into account scroll views.
 */
@property (nonatomic, readonly) CGFloat screenViewY;

/**
 *  Return the view frame on the screen, taking into account scroll views.
 */
@property (nonatomic, readonly) CGRect screenFrame;

/**
 *  Shortcut for frame.origin
 */
@property (nonatomic) CGPoint origin;

/**
 *  Shortcut for frame.size
 */
@property (nonatomic) CGSize size;

/**
 *  移除子视图
 */
- (void)removeAllSubviews;

/**
 *  圆角化对象(4个角)
 *  @param radius 圆角半径
 */
- (void)setRCornerRadius:(CGFloat)radius;

/**
 *  圆角化对象(4个角中的任意一个或几个)
 *  @param radius 圆角半径
 *  @param options 圆角的位置
 */
- (void)setRCornerRadius:(CGFloat)radius options:(UIRectCorner)options;

/**
 *  返回一个UIView的截屏, UIImage对象
 */
- (UIImage *)screenShot;

/**
 *  给对象加边框
 */
- (void)setBorderWidth:(CGFloat)width withColor:(UIColor *)color;

@end
