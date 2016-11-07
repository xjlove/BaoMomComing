//
//  MyHeadView.h
//  BaoMomComing
//
//  Created by xj_love on 2016/11/4.
//  Copyright © 2016年 Xander. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyHeadView : UICollectionReusableView

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UIButton *moreButton;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *lineViewRightLayout;

- (void)setLabelText:(NSString *)text Row:(NSInteger)index isShow:(BOOL)flag;

@end
