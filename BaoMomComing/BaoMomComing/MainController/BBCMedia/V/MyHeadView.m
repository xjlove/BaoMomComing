//
//  MyHeadView.m
//  BaoMomComing
//
//  Created by xj_love on 2016/11/4.
//  Copyright © 2016年 Xander. All rights reserved.
//

#import "MyHeadView.h"

@implementation MyHeadView

- (void)setLabelText:(NSString *)text Row:(NSInteger)index isShow:(BOOL)flag {
    self.titleLabel.text = text;
    self.moreButton.tag = index;
}

@end
