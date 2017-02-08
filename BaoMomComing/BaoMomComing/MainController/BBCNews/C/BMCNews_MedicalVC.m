//
//  BMCNews_MedicalVC.m
//  BaoMomComing
//
//  Created by xj_love on 2016/11/11.
//  Copyright © 2016年 Xander. All rights reserved.
//

#import "BMCNews_MedicalVC.h"

@interface BMCNews_MedicalVC ()

@property (nonatomic, strong)NewsTableView *headLineTableView;

@end

@implementation BMCNews_MedicalVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
    
    [self loadAllView];
}

#pragma mark - **************************** 加载所有控件 *************************************
- (void)loadAllView{
    [self.view addSubview:self.headLineTableView];
}

#pragma mark - **************************** 懒加载 *************************************
- (NewsTableView *)headLineTableView{
    if (_headLineTableView == nil) {
        _headLineTableView = [[NewsTableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height-HEADER-FOOT-44) style:UITableViewStyleGrouped];
        _headLineTableView.type = 1;
        _headLineTableView.newsClassID = 2;
    }
    return _headLineTableView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end