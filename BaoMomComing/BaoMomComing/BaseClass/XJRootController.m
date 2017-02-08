//
//  XJRootController.m
//  BaoMomComing
//
//  Created by xj_love on 2016/10/26.
//  Copyright © 2016年 Xander. All rights reserved.
//

#import "XJRootController.h"

@implementation XJRootController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];
}

//更改状态栏颜色
- (UIStatusBarStyle)preferredStatusBarStyle{
    return  UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
