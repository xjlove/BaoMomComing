//
//  MediaCollectionViewCell.h
//  BaoMomComing
//
//  Created by xj_love on 2016/11/4.
//  Copyright © 2016年 Xander. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MediaCollectionViewCell : UICollectionViewCell

/**
 *  设置视频cell
 *
 *  @param dataArrM 视频数据
 */
- (void)setMediaCellWithDataArr:(NSMutableArray*)dataArrM withIndexPath:(NSIndexPath *)indexPath;

@end
