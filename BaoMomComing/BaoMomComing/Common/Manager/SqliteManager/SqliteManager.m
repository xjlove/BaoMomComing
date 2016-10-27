//
//  SqliteManager.m
//  CloudClassRoom
//
//  Created by xj_love on 15/12/14.
//  Copyright © 2015年 like. All rights reserved.
//

#import "SqliteManager.h"

static SqliteManager *sqliteManager = nil;
@implementation SqliteManager

+ (instancetype)sharedManager {
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sqliteManager = [[SqliteManager alloc] init];
    });
    
    return sqliteManager;
}

+ (instancetype)alloc {
    NSAssert(sqliteManager == nil, @"Attempted to allocate a second instance of a singleton.");
    return [super alloc];
}

- (instancetype)init {
    if (self = [super init]) {
        
    }
    
    return self;
}

/*********** 数据库使用示例   ******************/

- (void)createDatabase {
    NSString *filePath = [[MANAGER_FILE CSDownloadPath] stringByAppendingPathComponent:[NSString stringWithFormat:@"db/%@", databaseName]];
    //创建数据库，并加入到队列中，此时已经默认打开了数据库，无须手动打开，只需要从队列中去除数据库即可
    _queue = [FMDatabaseQueue databaseQueueWithPath:filePath];
    
    [self createMultiTables];
}

- (void)createMultiTables {
    NSArray *sqlCreateTableArray = @[
                                     @"CREATE TABLE IF NOT EXISTS downBook (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, book_id VARCHAR, book_title VARCHAR, book_author VARCHAR,book_publisher VARCHAR,book_publish_time VARCHAR,book_summary VARCHAR,book_cover VARCHAR,book_file VARCHAR,book_create_time FLOAT,book_readPage VARCHAR,book_type VARCHAR);"
                                     ];
    
    [_queue inDatabase:^(FMDatabase *db) {
        for (NSString *sql in sqlCreateTableArray) {
            if ([db executeUpdate:sql]) {
                NSLog(@"create table %@ ok", [[sql componentsSeparatedByString:@" "] objectAtIndex:5]);
            }
        }
    }];
    
    [DAO_DownBook createTable];
    
    //最后更新数据结构
    [self upgradeTheSqlite];
}

#pragma mark - 数据库升级
- (void)upgradeTheSqlite {
    __block int version;
    [_queue inDatabase:^(FMDatabase *db) {
        FMResultSet *rs = [db executeQuery:@"PRAGMA user_version;"];
        while ([rs next]) {
            NSLog(@"user_version = %d", [rs intForColumnIndex:0]);
            version = [rs intForColumnIndex:0];
        }
    }];
    
    //升级操作
    [self upgradeTheSqlite:version];
    
    [_queue inDatabase:^(FMDatabase *db) {
        NSString* sqlStr = [NSString stringWithFormat:@"PRAGMA user_version = %d;",DATABASE_VERSION];
        if ([db executeUpdate:sqlStr]) {
            NSLog(@"Set Version OK!");
        };
    }];
}

- (void)upgradeTheSqlite:(int)version {
    if (version >= DATABASE_VERSION) {
        return;
    }
    
    switch (version) {
        case 0:
            break;
            
        default:
            break;
    }
    version++;
    
    // 递归判断是否需要升级
    [self upgradeTheSqlite:version];
}

#pragma mark -
- (void)executeUpdateWithSql:(NSString *)sql {
    [self executeUpdateWithSql:sql withSuccessBlock:nil];
}

- (void)executeUpdateWithSql:(NSString *)sql withSuccessBlock:(GetBackBoolBlock)successBlock {
    __block BOOL result = NO;
    [_queue inDatabase:^(FMDatabase *db) {
        result = [db executeUpdate:sql];
        
        if (result) {
//            NSLog(@"execute update object success sql = %@", sql);
        }else {
            NSLog(@"execute update object failed sql = %@", sql);
        }
    }];
    
    BLOCK_SUCCESS(result);
}

- (void)executeQueryWithSql:(NSString *)sql withExecuteBlock:(GetBackDictionaryBlock)successBlock {
    [self executeQueryWithSql:sql withExecuteBlock:successBlock withEndBlock:nil];
}

- (void)executeQueryWithSql:(NSString *)sql withExecuteBlock:(GetBackDictionaryBlock)successBlock withEndBlock:(GetEndBlock)endBlock {
    [_queue inDatabase:^(FMDatabase *db) {
        FMResultSet *rs = [db executeQuery:sql];
        
        if (rs) {
//            NSLog(@"execute query object success sql = %@", sql);
        }else {
            NSLog(@"execute query object failed sql = %@", sql);
        }
        
        while ([rs next]) {
            BLOCK_SUCCESS(rs.resultDictionary);
        }
    }];
    
    BLOCK_END;
}

- (void)beginTransactionWithSqlArray:(NSMutableArray *)sqlArray {
    [self beginTransactionWithSqlArray:sqlArray withSuccessBlock:nil];
}

- (void)beginTransactionWithSqlArray:(NSMutableArray *)sqlArray withSuccessBlock:(GetBackBoolBlock)successBlock {
    if (sqlArray.count > 0) {
        __block BOOL result = NO;
        [_queue inTransaction:^(FMDatabase *db, BOOL *rollback) {
            
            for (NSString *sql in sqlArray) {
                if (! [db executeUpdate:sql]) {
                    NSLog(@"execute update object failed sql = %@", sql);
                    *rollback = YES;
                    result = NO;
                    return;
                }
                result = YES;
//                NSLog(@"execute update object success sql = %@", sql);
            }
        }];
        BLOCK_SUCCESS(result);
    }else {
        BLOCK_SUCCESS(NO);
    }
}

@end
