//
//  ParseManager.h
//  CloudClassRoom
//
//  Created by xj_love on 16/1/19.
//  Copyright © 2016年 like. All rights reserved.
//

#import <Foundation/Foundation.h>

#define MANAGER_PARSE [ParseManager sharedManager]

@interface ParseManager : NSObject

+ (instancetype)sharedManager;

/**
 * PARSE json data
 */
- (NSDictionary *)parseJsonToDict:(id)obj;

/**
 * PARSE json data
 */
- (NSString *)parseJsonToStr:(id)obj;


@end
