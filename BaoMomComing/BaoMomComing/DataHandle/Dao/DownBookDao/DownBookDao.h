//
//  DownBookDao.h
//  CloudClassRoom
//
//  Created by xj_love on 16/5/13.
//  Copyright © 2016年 like. All rights reserved.
//

#import "BaseDao.h"

#define DAO_DownBook [DownBookDao sharedInstance]

@interface DownBookDao : BaseDao

/********************* 数据库具体使用示例 ******************************/

/**
 *  @brief 初始化
 */
+ (instancetype)sharedInstance;
/**
 *  @brief 创建表
 */
- (void)createTable;
/**
 *  插入书籍详细信息 
 *
 *  @param bookInfo 书籍信息
 *  @param bookID   书籍id
 */
- (void)insertBook:(NSMutableArray *)bookInfo withBookID:(NSString *)bookID;
/**
 *  查询数据库所有书籍信息（已下载）
 *
 *  @return 返回书籍信息（BookListModel类型）
 */
- (NSMutableArray *)selectAllBookInDatabase;
/**
 *  根据书籍id查找书籍信息
 *
 *  @param bookID 书籍id
 *
 *  @return 数组（不为空说明已下载）
 */
- (NSMutableArray *)selectBookInDatabaseWithBookID:(NSString *)bookID;
/**
 *  根据书籍id删除书籍信息
 *
 *  @param bookID 书籍id
 */
- (void)deleteBookInfoWithBookID:(NSString *)bookID;
/**
 *  更新书籍阅读页码信息
 *
 *  @param page   页码
 *  @param bookID 书籍id
 */
- (void)updateReadBookPage:(int)page WithBookID:(NSString *)bookID;
/**
 *  根据书籍id查找上次阅读的页码
 *
 *  @param bookID 书籍id
 *
 *  @return 页码（int型）
 */
- (int)selectReadBookPageWithBookID:(NSString *)bookID;

@end
