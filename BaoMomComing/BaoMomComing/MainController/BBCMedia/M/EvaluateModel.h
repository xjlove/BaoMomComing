//
//  EvaluateModel.h
//  CloudClassRoom
//
//  Created by rgshio on 16/4/9.
//  Copyright (c) 2015年 like. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EvaluateModel : NSObject

@property (readwrite) int ID;
@property (nonatomic, strong) NSString *realname;
@property (nonatomic, strong) NSString *avatar;
@property (nonatomic, strong) NSString *comment;
@property (readwrite) int score;
@property (nonatomic, strong) NSString *create_time;

- (id)initWithDictionary:(NSDictionary *)dict;

@end
