//
//  SqliteManager.h
//  CloudClassRoom
//
//  Created by xj_love on 15/12/14.
//  Copyright © 2015年 like. All rights reserved.
//

#import <Foundation/Foundation.h>

#define DATABASE_VERSION 0

#define MANAGER_SQLITE [SqliteManager sharedManager]

@interface SqliteManager : NSObject

@property (nonatomic, strong) FMDatabaseQueue *queue;

/**
 *  @brief 初始化
 */
+ (instancetype)sharedManager;

/**
 *  @brief 创建数据库
 */
- (void)createDatabase;

/**
 *  @brief 执行更新操作
 *
 *  @param sql sql语句
 */
- (void)executeUpdateWithSql:(NSString *)sql;

/**
 *  @brief 执行更新操作
 *
 *  @param sql              sql语句
 *  @param successBlock     执行更新操作成功或失败
 */
- (void)executeUpdateWithSql:(NSString *)sql withSuccessBlock:(GetBackBoolBlock)successBlock;

/**
 *  @brief 执行查询操作
 *
 *  @param sql              sql语句
 *  @param successBlock     执行查询操作返回每条数据(字典)
 */
- (void)executeQueryWithSql:(NSString *)sql withExecuteBlock:(GetBackDictionaryBlock)successBlock;

/**
 *  @brief 使用事务执行sql语句
 */
- (void)beginTransactionWithSqlArray:(NSMutableArray *)sqlArray;

/**
 *  @brief 使用事务执行sql语句
 *
 *  @param successBlock     执行操作成功或失败
 */
- (void)beginTransactionWithSqlArray:(NSMutableArray *)sqlArray withSuccessBlock:(GetBackBoolBlock)successBlock;

@end
