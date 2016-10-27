//
//  DownBookDao.m
//  CloudClassRoom
//
//  Created by xj_love on 16/5/13.
//  Copyright © 2016年 like. All rights reserved.
//

#import "DownBookDao.h"

static DownBookDao *downBookDao = nil;

@implementation DownBookDao

#pragma private
+ (instancetype)sharedInstance {
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        downBookDao = [[DownBookDao alloc] init];
    });
    return downBookDao;
}

+ (instancetype)alloc {
    NSAssert(downBookDao == nil, @"Attempted to allocate a second instance of a singleton.");
    return [super alloc];
}

- (instancetype)init {
    if (self = [super init]) {
    }
    return self;
}

#pragma mark - common
- (void)createTable {
    NSString *sql = @"CREATE TABLE IF NOT EXISTS downBook (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, book_id VARCHAR, book_title VARCHAR, book_author VARCHAR,book_publisher VARCHAR,book_publish_time VARCHAR,book_summary VARCHAR,book_cover VARCHAR,book_file VARCHAR,book_create_time VARCHAR,book_readPage VARCHAR,book_type VARCHAR);";
    
    [self.databaseQueue inDatabase:^(FMDatabase *db) {
        
        
        if ([db executeUpdate:sql]) {
            NSLog(@"create table %@ ok", [[sql componentsSeparatedByString:@" "] objectAtIndex:5]);
        }
        
    }];
}
- (void)insertBook:(NSMutableArray *)bookInfoArrM withBookID:(NSString *)bookID{
    
    [self.databaseQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        
        NSString *delsql = @"delete from downBook where book_id = ?";
        
        if (![db executeUpdate:delsql, bookID]) {
            *rollback = YES;
            return;
        }
        
//        NSString *sql = @"insert into downBook (book_id, book_title, book_author,book_publisher,book_publish_time,book_summary,book_cover,book_file,book_create_time,book_readPage,book_type) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ? ,?,?)";
//        BookListEntity *bookInfo = bookInfoArrM[0];
        
//        NSString *page;
//        NSString *subString = [bookInfo.file substringFromIndex:bookInfo.file.length-3];
//        if ([bookInfo.book_type intValue] == 2) {
//            if ([subString isEqualToString:@"txt"]) {
//                page = @"0";
//            }
//        }
//        else if([bookInfo.book_type intValue] == 1){
//            if ([subString isEqualToString:@"pdf"]) {
//                page = @"1";
//            }
//        }
        
//        if(![db executeUpdate:sql, (NSString *)bookInfo.ID, bookInfo.title,bookInfo.author,bookInfo.publisher,bookInfo.publish_time,bookInfo.summary,bookInfo.cover,bookInfo.file,bookInfo.create_time,page,bookInfo.book_type]) {
//            *rollback = YES;
//            return;
//        }
    }];

}

- (NSMutableArray *)selectAllBookInDatabase{
    
    NSMutableArray *list = [NSMutableArray new];
    
    [self.databaseQueue inDatabase:^(FMDatabase *db) {
        
//        NSString *sql = @"select * from downBook";
        
//        FMResultSet *rs = [db executeQuery:sql];
//        DownBookInfoEntity *bookInfo;
//        while ([rs next]) {
//            
//            bookInfo = [[DownBookInfoEntity alloc] initWithDictionary:[rs.resultDictionary nonull]];
//            
//            [list addObject:bookInfo];
//            
//        }
        
    }];
    
    return list;
}

- (NSMutableArray *)selectBookInDatabaseWithBookID:(NSString *)bookID{
    
    NSMutableArray *list = [NSMutableArray array];
    
    [self.databaseQueue inDatabase:^(FMDatabase *db) {
        
//        NSString *sql = @"select * from downBook where book_id = ?";
        
//        FMResultSet *rs = [db executeQuery:sql,bookID];
//        DownBookInfoEntity *bookInfo;
//        while ([rs next]) {
//            
//            bookInfo = [[DownBookInfoEntity alloc] initWithDictionary:[rs.resultDictionary  nonull]];
//            [list addObject:bookInfo];
//        }
        
    }];
    
    return list;
}

- (void)deleteBookInfoWithBookID:(NSString *)bookID{
    
    [self.databaseQueue inDatabase:^(FMDatabase *db) {
        
        NSString *sql = @"delete from downBook where book_id = ?";
        
        [db executeUpdate:sql, bookID];
        
    }];
}

- (void)updateReadBookPage:(int)page WithBookID:(NSString *)bookID{
    
    [self.databaseQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        
        NSString *updatesql = @"update downBook set book_readPage = ? where book_id = ?";
        
        [db executeUpdate:updatesql,[NSString stringWithFormat:@"%d",page],bookID];
        
    }];

}
- (int)selectReadBookPageWithBookID:(NSString *)bookID{
    
    __block int page = 0;

    [self.databaseQueue inDatabase:^(FMDatabase *db) {
        
        NSString *sql = @"select book_readPage from downBook where book_id = ?";
        FMResultSet *rs = [db executeQuery:sql, bookID];
        while ([rs next]) {
            
            NSString *readPage = [[rs.resultDictionary allValues] lastObject];
            
            page = [readPage intValue];
        }
        
    }];
    
    return page;
}

@end
