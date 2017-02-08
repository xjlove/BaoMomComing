//
//  EvaluateModel.m
//  CloudClassRoom
//
//  Created by rgshio on 16/4/9.
//  Copyright (c) 2015年 like. All rights reserved.
//

#import "EvaluateModel.h"

@implementation EvaluateModel

- (id)initWithDictionary:(NSDictionary *)dict {
    if (self = [super init]) {
        _ID = [[dict objectForKey:@"id"] intValue];
        _realname = [dict objectForKey:@"realname"];
        _avatar = [dict objectForKey:@"avatar"];
        _comment = [dict objectForKey:@"comment"];
        _score = [[dict objectForKey:@"score"] intValue];
        _create_time = [dict objectForKey:@"create_time"];
    }
    return self;
}

@end
