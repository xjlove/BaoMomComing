//
//  CircularProgressView.m
//  CloudClassRoom
//
//  Created by like on 2014/11/27.
//  Copyright (c) 2014年 like. All rights reserved.
//

#import "CircularProgressView.h"
#import "EVCircularProgressView.h"

@implementation CircularProgressView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


- (id)init {
    self = [super init];
    if (self) {
        [self commonInit];
    }
    
    return self;
}

- (id)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    
    if (self) {
        [self commonInit];
    }
    
    return self;
}


/*
 *下载按钮初始化
 */
- (void)commonInit {
    imageView = [[UIImageView alloc] init];
    imageView.frame = CGRectMake(CGRectGetWidth(self.frame)-34, 0, 23, 23);
    [self addSubview:imageView];
    
    progressView = [[EVCircularProgressView alloc] initWithFrame:CGRectMake(CGRectGetMinX(imageView.frame)-1.5, CGRectGetMinY(imageView.frame)-1.5, imageView.frame.size.width+3, imageView.frame.size.height+3)];
    progressView.tintColor = [UIColor colorWithRed:(float)0/255 green:(float)155/255 blue:(float)76/255 alpha:1];
    progressView.progress = 0;
    [self addSubview:progressView];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture:)];
    [tapGesture setNumberOfTapsRequired:1];
    [self addGestureRecognizer:tapGesture];
}


/*
 *下载按钮点击操作
 */
- (void)tapGesture:(UITapGestureRecognizer *)recognizer {
    [_delegate CPVClick:self];
}


/*
 *改变下载按钮的显示图片
 */
- (void)changProgressStatus:(ProgressStatus)status {
    _status = status;
    switch (status) {
        case Normal:
        {
            imageView.image = [UIImage imageNamed:@"download_normal"];
            progressView.hidden = YES;
            break;
        }
        case Init:
        {
            imageView.image = [UIImage imageNamed:@"download_init"];
            progressView.hidden = NO;
            break;
        }
        case Wait:
        {
            imageView.image = [UIImage imageNamed:@"download_wait"];
            progressView.hidden = YES;
            break;
        }
        case Downloading:
        {
            imageView.image = [UIImage imageNamed:@"download_wait"];
            progressView.hidden = NO;
            [self ifShowProgressView];
            break;
        }
        case Finished:
        {
            if (self.isPlay) {
                imageView.image = [UIImage imageNamed:@"download_play"];
            }else {
                imageView.image = [UIImage imageNamed:@"download_finished"];
            }
            progressView.hidden = YES;
            break;
        }
        case Pause:
        {
            imageView.image = [UIImage imageNamed:@"download_pause"];
            progressView.hidden = NO;
            [self ifShowProgressView];
            break;
        }
            
        default:
            break;
    }
}


/*
 *设置进度
 *@param progress 进度数值
 */
- (void)setProgress:(float)progress {
    _progress = progress;
    progressView.progress = progress;
    [self ifShowProgressView];
}


/*
 *进度条是否显示
 *@param flag YES:显示 NO:不显示
 */
- (void)showProgressView:(BOOL)flag {
    progressView.hidden = _progress==0 ? YES : !flag;
}

- (void)ifShowProgressView {
    if (_progress == 0) {
        switch (_status) {
            case Downloading:
            case Pause:
                progressView.hidden = YES;
                break;
                
            default:
                break;
        }
    }
}

@end
