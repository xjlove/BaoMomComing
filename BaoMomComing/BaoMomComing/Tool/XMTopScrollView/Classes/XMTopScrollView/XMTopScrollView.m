//
//  XMTopScrollView.m
//  CloudClassRoom
//
//  Created by rgshio on 15/11/26.
//  Copyright © 2015年 like. All rights reserved.
//

#import "XMTopScrollView.h"
#import "XMTopCell.h"

#define BACK_COLOR [UIColor colorWithRed:(float)225/255 green:(float)225/255 blue:(float)225/255 alpha:1.0f]

@interface XMTopScrollView ()  <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout> {
    UICollectionView                *_mainCollectionView;
    UIScrollView                    *_mainScrollView;
    UIView                          *_lineView;
    
    NSMutableArray                  *_list;
    
    NSInteger                       _selectRow;
    NSInteger                       _cellWidth;
    
}

@end

@implementation XMTopScrollView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self loadParam];
        [self loadMainView];
    }
    return self;
}

- (void)loadParam {
    _selectRow = 0;
    
    self.textSelectedtColor = [UIColor colorWithRed:(float)0/255 green:(float)113/255 blue:(float)220/255 alpha:1.0f];
    
    self.lineHeight = 2;
    self.separatorTop = 8;
    self.separatorHidden = YES;
    self.textDefaultColor = [UIColor blackColor];
    self.showType = XMTopItemShowTypeNone;
    
    _list = [[NSMutableArray alloc] init];
}

- (void)loadMainView {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    flowLayout.minimumLineSpacing = 0;
    
    _mainCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) collectionViewLayout:flowLayout];
    _mainCollectionView.showsVerticalScrollIndicator = NO;
    _mainCollectionView.showsHorizontalScrollIndicator = NO;
    _mainCollectionView.backgroundColor = BACK_COLOR;
    _mainCollectionView.delegate = self;
    _mainCollectionView.dataSource = self;
    [self addSubview:_mainCollectionView];
    
    _lineView = [[UIView alloc] init];
    _lineView.backgroundColor = self.textSelectedtColor;
    [_mainCollectionView addSubview:_lineView];
    
    UINib *nib = [UINib nibWithNibName:@"XMTopCell" bundle:[NSBundle mainBundle]];
    [_mainCollectionView registerNib:nib forCellWithReuseIdentifier:@"XMTopCell"];
}

- (void)moveLineView {
    [UIView animateWithDuration:0.3f animations:^{
        _lineView.frame = CGRectMake(_cellWidth*_selectRow, self.frame.size.height-self.lineHeight, _cellWidth, self.lineHeight);
    } completion:^(BOOL finished) {
        _mainCollectionView.userInteractionEnabled = YES;
    }];
}

- (void)reloadLineView {
    _lineView.frame = CGRectMake(0, self.frame.size.height-self.lineHeight, _cellWidth, self.lineHeight);
}

- (void)showItemWith:(NSInteger)index {
    switch (self.showType) {
        case XMTopItemShowTypeNone:
            break;
        case XMTopItemShowTypeCenter:
        {
            if (_cellCount%2 == 0) {
                return;
            }
            
            if (index >= _cellCount/2 && _list.count > _cellCount/2+1) {
                if (index < _list.count-_cellCount/2) {
                    [_mainCollectionView setContentOffset:CGPointMake((index-_cellCount/2)*_cellWidth, 0) animated:YES];
                }else{
                    [_mainCollectionView setContentOffset:CGPointMake((_list.count-_cellCount)*_cellWidth, 0) animated:YES];
                }
            }else {
                [_mainCollectionView setContentOffset:CGPointMake(0, 0) animated:YES];
            }
        }
            break;
        case XMTopItemShowTypeAll:
        {
            NSInteger offsetX = _mainCollectionView.contentOffset.x;
            if (offsetX < _cellWidth*(index-_cellCount+1)) {
                [_mainCollectionView setContentOffset:CGPointMake(_cellWidth*(index-_cellCount+1), 0) animated:YES];
            }else if (offsetX > _cellWidth*index) {
                [_mainCollectionView setContentOffset:CGPointMake(_cellWidth*index, 0) animated:YES];
            }
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - Config Param 
- (void)setTopImage:(UIImage *)topImage {
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = topImage;
    _mainCollectionView.backgroundView = imageView;
}

- (void)setTopColor:(UIColor *)topColor {
    _mainCollectionView.backgroundColor = topColor;
}

- (void)setCellCount:(NSInteger)cellCount {
    _cellCount = cellCount;
    _cellWidth = self.frame.size.width/cellCount;
    [self reloadLineView];
}

- (void)setSeparatorHidden:(BOOL)separatorHidden {
    _separatorHidden = separatorHidden;
}

- (void)setLineHeight:(NSInteger)lineHeight {
    _lineHeight = lineHeight;
    [self reloadLineView];
}

- (void)setContentOffset:(CGPoint)contentOffset {
    [_mainCollectionView setContentOffset:contentOffset animated:YES];
}

- (CGPoint)contentOffset {
    return _mainCollectionView.contentOffset;
}

#pragma mark - UICollectionView
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 8;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"XMTopCell";
    XMTopCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    
    cell.titleLabel.text = _list[indexPath.row];
    cell.lineViewTopLayout.constant = self.separatorTop;
    cell.lineViewBottomLayout.constant = self.separatorTop;
    
    if (indexPath.row == _selectRow) {
        cell.titleLabel.textColor = self.textSelectedtColor;
    }else {
        cell.titleLabel.textColor = self.textDefaultColor;
    }
    
    if (indexPath.row == 0) {
        cell.lineView.hidden = YES;
    }else {
        cell.lineView.hidden = self.separatorHidden;
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (_selectRow != indexPath.row) {
        _mainCollectionView.userInteractionEnabled = NO;
        _selectRow = indexPath.row;
        [self reloadView];
        [self showItemWith:_selectRow];
        [self moveLineView];
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(selectClickAction:)]) {
            [self.delegate selectClickAction:indexPath.row];
        }
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGSize size = CGSizeMake(_cellWidth, self.frame.size.height);
    return size;
}

#pragma mark - API
- (void)reloadViewWith:(NSMutableArray *)dataArray {
    _list = dataArray;
    [self reloadView];
}

- (void)reloadView {
    [_mainCollectionView reloadData];
}

@end
