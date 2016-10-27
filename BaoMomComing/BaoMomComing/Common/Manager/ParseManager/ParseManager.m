//
//  ParseManager.m
//  CloudClassRoom
//
//  Created by xj_love on 16/1/19.
//  Copyright © 2016年 like. All rights reserved.
//

#import "ParseManager.h"

static ParseManager *parseManager = nil;
@implementation ParseManager

#pragma mark - Private
+ (instancetype)sharedManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        parseManager = [[ParseManager alloc] init];
    });
    
    return parseManager;
}

+ (instancetype)alloc {
    NSAssert(parseManager == nil, @"Attempted to allocate a second instance of a singleton.");
    return [super alloc];
}

- (instancetype)init {
    if (self = [super init]) {
        
    }
    
    return self;
}

#pragma mark - Common
- (NSDictionary *)parseJsonToDict:(id)obj {
    
    if (obj) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:obj options:kNilOptions error:nil];
        if (dict) {
            return [dict nonull];
        }else {
            NSLog(@"parse json failure");
            return nil;
        }
    }else {
        NSLog(@"data is nil");
        return nil;
    }
}

- (NSString *)parseJsonToStr:(id)obj {
    NSString *str = [[NSString alloc] initWithData:obj encoding:NSUTF8StringEncoding];
    return str;
}

@end
