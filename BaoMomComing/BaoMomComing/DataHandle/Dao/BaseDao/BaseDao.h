//
//  BaseDao.h
//  CloudClassRoom
//
//  Created by rgshio on 16/3/15.
//  Copyright © 2016年 like. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseDao : NSObject

@property (nonatomic, strong) FMDatabaseQueue *databaseQueue;

@end
