
//
//  XJBMCMediaControllerView.m
//  BaoMomComing
//
//  Created by xj_love on 2016/11/4.
//  Copyright © 2016年 Xander. All rights reserved.
//

#import "XJBMCMediaControllerView.h"

@interface XJBMCMediaControllerView (){
//    MediaCollectionViewHeaderCell *headCell;
//    MediaCollectionViewCell *mediaCell;
}

//@property (nonatomic, strong)NSMutableArray *scrollDataArrM;//轮播图数据
//@property (nonatomic, strong)NSMutableArray *mediaDataArrM;//视屏数据

@end

@implementation XJBMCMediaControllerView

//static NSString * const reuseIdentifier = @"Cell";

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    [self.collectionView.mj_header endRefreshing];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self.collectionView registerNib:[UINib nibWithNibName:@"MyHeadView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"MyHeadView"];
//    [self.collectionView registerClass:[MediaCollectionViewHeaderCell class] forCellWithReuseIdentifier:@"MediaCollectionViewHeaderCell"];
//    [self.collectionView registerClass:[MediaCollectionViewCell class] forCellWithReuseIdentifier:@"MediaCollectionViewCell"];
//    
//    [self addMJRefresh];
//    [self loadData];
    
}

#pragma mark - **************************** 加载数据 *************************************
//加载数据
//- (void)loadData {
//    NSString *urlString = [NSString stringWithFormat:BMC_MdieaUrl,Host];
//    [MANAGER_Data parseJsonData:urlString FileName:@"BMC_Media.json" ShowLoadingMessage:YES JsonType:ParseJsonTypeBMCMedia finishCallbackBlock:^(NSMutableArray *result) {
//        [self.collectionView.mj_header endRefreshing];
//        self.scrollDataArrM = [result objectAtIndex:0];
//        self.mediaDataArrM = [result objectAtIndex:1];
//        
//        [self.collectionView reloadData];
//    }];
//}

#pragma mark - **************************** UICollectionView代理 *************************************
//- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
//    return self.scrollDataArrM.count;
//}
//
//- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
//    if (section == 0) {
//        return 1;
//    }else{
//        NSDictionary *dict = [self.mediaDataArrM objectAtIndex:section-1];
//        NSArray *array = [dict objectForKey:@"course"];
//        NSInteger count = [array count];
//        return count>6 ? 6 : count;
//    }
//}
//
//- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
//    static NSString *cellId = nil;
//    if (indexPath.section == 0) {
//        cellId = @"MediaCollectionViewHeaderCell";
//    }
//    else {
//        cellId = @"MediaCollectionViewCell";
//    }
//    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
//    
//    if (indexPath.section == 0) {
//        headCell = (MediaCollectionViewHeaderCell*)cell;
//        [headCell setMediaHeaderCellWithDataArr:self.scrollDataArrM];
//        
//    }else{
//        mediaCell = (MediaCollectionViewCell*)cell;
//        [mediaCell setMediaCellWithDataArr:self.mediaDataArrM withIndexPath:indexPath];
//    }
//    
//    return cell;
//}
//
//
//- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
//    
//}
//
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
//    CGSize size;
//    if (section == 0) {
//        size = CGSizeMake(0, 0);
//    }else {
//        size = CGSizeMake(self.view.frame.size.width, 25);
//    }
//    return size;
//}
//
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
//    if (indexPath.section == 0) {
//        return CGSizeMake(self.view.width, self.view.width*0.5+165);
//    }else {
//        return CGSizeMake((self.view.width-40)*0.5,((self.view.width-45)*0.5)*1.25);
//    }
//}
//
//- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
//    if (section == 0) {
//        return UIEdgeInsetsMake(0, 0, 0, 0);
//    }else {
//        return UIEdgeInsetsMake(10, 15, 20, 15);
//    }
//}
//
//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
//    
//    MyHeadView *headView = (MyHeadView *)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"MyHeadView" forIndexPath:indexPath];
//    [self selectedMoreAction];
//    NSString *category = nil;
//    NSDictionary *dict = [self.mediaDataArrM objectAtIndex:indexPath.section-1];
//    category = [dict objectForKey:@"category_name"];
//    [headView setLabelText:category Row:indexPath.section+100 isShow:YES];
//    
//    return headView;
//}
//
//#pragma mark - **************************** 轮播图方法 *************************************
//
//
//#pragma mark - **************************** 单击更多的方法 *************************************
//- (void)selectedMoreAction{
//    
//}
//
//#pragma mark - **************************** 添加下拉刷新 *************************************
//- (void)addMJRefresh{
//    
//    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
//        
//        if ([MANAGER_Reach isEnableNetWork]) {
//            [self loadData];
//        }else{
//            [MANAGER_SHOW showInfo:netWorkError];
//        }
//        
//    }];
//    // 设置普通状态的动画图片
//    NSMutableArray *idleImages = [NSMutableArray array];
//    for (NSUInteger i = 1; i<=60; i++) {
//        UIImage *image = [UIImage imageNamed:@"icon_refresh_1"];
//        [idleImages addObject:image];
//    }
//    [header setImages:idleImages forState:MJRefreshStateIdle];
//    
//    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
//    NSMutableArray *refreshingImages = [NSMutableArray array];
//    for (NSUInteger i = 1; i<=3; i++) {
//        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"icon_refresh_%zd", i]];
//        [refreshingImages addObject:image];
//    }
//    [header setImages:refreshingImages forState:MJRefreshStatePulling];
//    
//    // 设置正在刷新状态的动画图片
//    [header setImages:refreshingImages forState:MJRefreshStateRefreshing];
//    self.collectionView.mj_header = header;
//    
//    header.lastUpdatedTimeLabel.hidden = YES;
//    header.stateLabel.hidden = YES;
//    
//}
//
//#pragma mark - **************************** 懒加载 *************************************
//- (NSMutableArray *)scrollDataArrM{
//    if (_scrollDataArrM == nil) {
//        _scrollDataArrM = [[NSMutableArray alloc] init];
//    }
//    return _scrollDataArrM;
//}
//
//- (NSMutableArray *)mediaDataArrM{
//    if (_mediaDataArrM == nil) {
//        _mediaDataArrM = [[NSMutableArray alloc] init];
//    }
//    return _mediaDataArrM;
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end