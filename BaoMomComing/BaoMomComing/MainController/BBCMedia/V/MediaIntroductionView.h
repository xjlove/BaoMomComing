//
//  MediaIntroductionView.h
//  BaoMomComing
//
//  Created by xj_love on 2016/11/9.
//  Copyright © 2016年 Xander. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MediaIntroductionView : UIScrollView<UIScrollViewDelegate>
{
    UIView                      *moveView;
    UILabel                     *info;
    
    CGSize                      contentSize;
    CGSize                      singleSize;
    CGRect                      infoRect;
}

/**
 *  设置视频简介信息
 *
 *  @param mediaModel
 */
- (void)setMediaIntroductionWith:(MediaModel*)mediaModel;

@end
