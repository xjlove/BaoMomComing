
//
//  XJBMCMediaCollectionViewController.m
//  BaoMomComing
//
//  Created by xj_love on 2016/11/4.
//  Copyright © 2016年 Xander. All rights reserved.
//

#import "XJBMCMediaCollectionViewController.h"

@interface XJBMCMediaCollectionViewController (){
    MediaCollectionViewHeaderCell *headCell;
    MediaCollectionViewCell *mediaCell;
}

@property (nonatomic, strong)NSMutableArray *scrollDataArrM;//轮播图数据
@property (nonatomic, strong)NSMutableArray *mediaDataArrM;//视屏数据

@end

@implementation XJBMCMediaCollectionViewController

//static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"MyHeadView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"MyHeadView"];
    
    [self loadData];
    
}

//加载数据
- (void)loadData {
    NSString *urlString = [NSString stringWithFormat:BMC_MdieaUrl,Host];
    [MANAGER_Data parseJsonData:urlString FileName:@"BMC_Media.json" ShowLoadingMessage:YES JsonType:ParseJsonTypeBMCMedia finishCallbackBlock:^(NSMutableArray *result) {
        self.scrollDataArrM = [result objectAtIndex:0];
        self.mediaDataArrM = [result objectAtIndex:1];
        
        [self.collectionView reloadData];
    }];
}

#pragma mark - UICollectionView
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.scrollDataArrM.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }else{
        NSDictionary *dict = [self.mediaDataArrM objectAtIndex:section-1];
        NSArray *array = [dict objectForKey:@"course"];
        NSInteger count = [array count];
        return count>6 ? 6 : count;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = nil;
    if (indexPath.section == 0) {
        cellId = @"MediaCollectionViewHeaderCell";
    }
    else {
        cellId = @"MediaCollectionViewCell";
    }
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    
    if (indexPath.section == 0) {
        headCell = (MediaCollectionViewHeaderCell*)cell;
        [headCell setMediaHeaderCellWithDataArr:self.scrollDataArrM];
        [self headerCellAction];
        
    }else{
        mediaCell = (MediaCollectionViewCell*)cell;
        [mediaCell setMediaCellWithDataArr:self.mediaDataArrM withIndexPath:indexPath];
        [self mediaSelectedAction];
    }
    
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    CGSize size;
    if (section == 0) {
        size = CGSizeMake(0, 0);
    }else {
        size = CGSizeMake(self.view.frame.size.width, 25);
    }
    return size;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return CGSizeMake(self.view.frame.size.width, self.view.frame.size.width*0.5+155);
    }else {
        return CGSizeMake(90, 226);
    }
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    if (section == 0) {
        return UIEdgeInsetsMake(0, 0, 0, 0);
    }else {
        return UIEdgeInsetsMake(10, 15, 20, 15);
    }
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    MyHeadView *headView = (MyHeadView *)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"MyHeadView" forIndexPath:indexPath];
    
    NSString *category = nil;
    NSDictionary *dict = [self.mediaDataArrM objectAtIndex:indexPath.section-1];
    category = [dict objectForKey:@"category_name"];
    [headView setLabelText:category Row:indexPath.section+100 isShow:YES];
    
    return headView;
}

#pragma mark - Config Cell
- (void)setSmallCell:(UICollectionViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark - **************************** 轮播图方法 *************************************
- (void)headerCellAction{
    WS(weakSelf);
    headCell.headerScrollViewClicked = ^(NSUInteger index){
        XJMediaDetailViewController *mediaDeail = [[XJMediaDetailViewController alloc] init];
        [weakSelf presentViewController:mediaDeail animated:YES completion:nil];
    };
}

#pragma mark - **************************** 单击视频方法 *************************************
- (void)mediaSelectedAction{
    
}


#pragma mark - **************************** 懒加载 *************************************
- (NSMutableArray *)scrollDataArrM{
    if (_scrollDataArrM == nil) {
        _scrollDataArrM = [[NSMutableArray alloc] init];
    }
    return _scrollDataArrM;
}

- (NSMutableArray *)mediaDataArrM{
    if (_mediaDataArrM == nil) {
        _mediaDataArrM = [[NSMutableArray alloc] init];
    }
    return _mediaDataArrM;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end