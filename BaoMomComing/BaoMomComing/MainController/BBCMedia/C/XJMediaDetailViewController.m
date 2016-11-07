//
//  XJMediaDetailViewController.m
//  BaoMomComing
//
//  Created by xj_love on 2016/11/3.
//  Copyright © 2016年 Xander. All rights reserved.
//

#import "XJMediaDetailViewController.h"

@interface XJMediaDetailViewController ()<XjAVPlayerSDKDelegate>{
    XjAVPlayerSDK *BMCAVPlayer;
}

@end

@implementation XJMediaDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor blackColor];
    
    [self addAVPlayer];
}

- (void)addAVPlayer{
    
    BMCAVPlayer = [[XjAVPlayerSDK alloc] initWithFrame:CGRectMake(0, 20, self.view.width, self.view.width*0.5)];
    BMCAVPlayer.xjPlayerUrl = @"http://static.tripbe.com/videofiles/20121214/9533522808.f4v.mp4";
    BMCAVPlayer.xjPlayerTitle = @"宝妈来了";
    BMCAVPlayer.xjAutoOrient = YES;
    BMCAVPlayer.XjAVPlayerSDKDelegate = self;
    
    [self.view addSubview:BMCAVPlayer];
}

- (void)xjGoBack{
    [BMCAVPlayer xjStopPlayer];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)xjNextPlayer{
    BMCAVPlayer.xjPlayerUrl = [[NSBundle mainBundle] pathForResource:@"Swift.mp4" ofType:nil];
    BMCAVPlayer.xjPlayerTitle = @"谢大大的自传";
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
