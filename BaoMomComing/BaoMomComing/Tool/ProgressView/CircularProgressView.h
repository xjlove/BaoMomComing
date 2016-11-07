//
//  CircularProgressView.h
//  CloudClassRoom
//
//  Created by xj_love on 2014/11/27.
//  Copyright (c) 2014年 like. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EVCircularProgressView.h"
@class CircularProgressView;

typedef NS_ENUM(NSInteger, ProgressStatus) {
    Normal = 0,
    Init   = 1,
    Wait  = 2,
    Downloading  = 3,
    Finished  = 4,
    Failed = 5,
    Pause = 6
};

@protocol CircularProgressViewDelegate

-(void) CPVClick:(CircularProgressView *)cpv;

@end

@interface CircularProgressView : UIView {
    CGFloat _progress;
    ProgressStatus _status;
    
    EVCircularProgressView *progressView;
    UIImageView *imageView;
}


@property (nonatomic, strong) id <CircularProgressViewDelegate> delegate;
@property (nonatomic, assign) BOOL isPlay;
@property (nonatomic, strong) NSString *ID;
@property (nonatomic, strong) NSIndexPath *indexPath;

/*
 *改变下载按钮的显示图片
 */
- (void)changProgressStatus:(ProgressStatus)status;


/*
 *设置进度
 *@param progress 进度数值
 */
- (void)setProgress:(float)progress;


/*
 *进度条是否显示
 *@param flag YES:显示 NO:不显示
 */
- (void)showProgressView:(BOOL)flag;

@end
