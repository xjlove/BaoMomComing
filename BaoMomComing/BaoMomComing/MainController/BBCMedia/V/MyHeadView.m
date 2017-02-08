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
    
    if (index == 101) {
        self.titleLabel.text = @"最新视频";
    }else if(index == 102){
        self.titleLabel.text = @"最热视频";
    }else{
        self.titleLabel.text = @"推荐视频";
    }
    self.moreButton.tag = index;
}

@end
