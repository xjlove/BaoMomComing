//
//  ShareManager.h
//  BaoMomComing
//
//  Created by xj_love on 2016/12/2.
//  Copyright © 2016年 Xander. All rights reserved.
//

#import <Foundation/Foundation.h>

#define MANAGER_Share [ShareManager sharedManager]

@interface ShareManager : NSObject

+ (instancetype)sharedManager;

- (void)registShareSDK;

- (void)shareMessagingWithShareBackImg:(NSString *)Img text:(NSString*)text url:(NSString *)url title:(NSString *)title;

@end
