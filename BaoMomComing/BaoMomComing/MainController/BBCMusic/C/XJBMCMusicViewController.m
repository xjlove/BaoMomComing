//
//  XJBMCMusicViewController.m
//  BaoMomComing
//
//  Created by xj_love on 16/7/28.
//  Copyright © 2016年 Xander. All rights reserved.
//

#import "XJBMCMusicViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>

@interface XJBMCMusicViewController ()

@end

@implementation XJBMCMusicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [MANAGER_SHOW showInfo:loadingMessage];

    NSURL *sourceMovieURL = [[NSBundle mainBundle] URLForResource:@"G.E.M.邓紫棋 - 夜空中最亮的星" withExtension:@"mp3"];
    
    //    AVAsset *movieAsset = [AVURLAsset URLAssetWithURL:sourceMovieURL options:nil];
    AVPlayerItem *playerItem = [AVPlayerItem playerItemWithURL:sourceMovieURL];
    AVPlayer *player = [AVPlayer playerWithPlayerItem:playerItem];
    AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:player];
    playerLayer.frame = CGRectMake(0, 0, self.view.frame.size.height, self.view.frame.size.width);
    playerLayer.backgroundColor = [UIColor blackColor].CGColor;
    playerLayer.videoGravity = AVLayerVideoGravityResizeAspect;
    
    [self.view.layer addSublayer:playerLayer];
    [player play];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
