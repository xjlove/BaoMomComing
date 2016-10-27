//
//  XMTopCell.h
//  CloudClassRoom
//
//  Created by rgshio on 15/11/26.
//  Copyright © 2015年 like. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XMTopCell : UICollectionViewCell
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UIView *lineView;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *lineViewTopLayout;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *lineViewBottomLayout;

@end
