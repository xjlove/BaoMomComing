//
//  UIImage+XMCommon.h
//  XMCommon
//
//  Created by rgshio on 15/3/25.
//  Copyright (c) 2015年 rgshio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (XMCommon)

/**
 *  播放GIF动画
 *  @param imageData 图片的data数据
 */
+ (UIImage *)animatedImageWithAnimatedGIFData:(NSData *)imageData;

/**
 *  播放GIF动画
 *  @param imageURL 图片的url
 */
+ (UIImage *)animatedImageWithAnimatedGIFURL:(NSURL *)imageURL;

/**
 *  根据颜色得到图片
 *  @param color 图片的颜色
 */
+ (UIImage *)imageWithColor:(UIColor *)color;

/**
 *  图片压缩
 *
 *  @param scaleSize 压缩比例
 */
- (UIImage *)scaleToSize:(float)scaleSize;

@end
