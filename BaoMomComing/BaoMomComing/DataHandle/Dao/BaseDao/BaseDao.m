//
//  BaseDao.m
//  CloudClassRoom
//
//  Created by rgshio on 16/3/15.
//  Copyright © 2016年 like. All rights reserved.
//

#import "BaseDao.h"

@implementation BaseDao

- (FMDatabaseQueue *)databaseQueue {
    return MANAGER_SQLITE.queue;
}

@end
