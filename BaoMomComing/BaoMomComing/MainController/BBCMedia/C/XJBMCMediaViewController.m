
//
//  XJBMCMediaViewController.m
//  BaoMomComing
//
//  Created by xj_love on 2016/11/4.
//  Copyright © 2016年 Xander. All rights reserved.
//

#import "XJBMCMediaViewController.h"

@interface XJBMCMediaViewController ()

@property (nonatomic, strong)MediaCollectionView *mainCollectionView;

@end

@implementation XJBMCMediaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadAllView];
}

#pragma mark - **************************** 加载所有视图 *************************************
- (void)loadAllView{
    [self.view addSubview:self.mainCollectionView];
}

#pragma mark - **************************** 懒加载 *************************************
- (MediaCollectionView *)mainCollectionView{
    if (_mainCollectionView == nil) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        _mainCollectionView = [[MediaCollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:flowLayout];
        
    }
    return _mainCollectionView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end