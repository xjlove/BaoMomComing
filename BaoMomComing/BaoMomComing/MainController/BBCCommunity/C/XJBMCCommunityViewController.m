//
//  XJBMCCommunityViewController.m
//  BaoMomComing
//
//  Created by xj_love on 16/7/29.
//  Copyright © 2016年 Xander. All rights reserved.
//

#import "XJBMCCommunityViewController.h"

@interface XJBMCCommunityViewController ()

@end

@implementation XJBMCCommunityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64, self.view.width, self.view.height-HEADER-FOOT)];
    img.image = [UIImage imageNamed:@"noSome"];
    [self.view addSubview:img];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
