//
//  FileManager.h
//  CloudClassRoom
//
//  Created by xj_love on 15/12/18.
//  Copyright © 2015年 like. All rights reserved.
//

#import <Foundation/Foundation.h>

#define MANAGER_FILE [FileManager sharedManager]

@interface FileManager : NSObject

@property (nonatomic, strong) NSString *CSDownloadPath;

+ (instancetype)sharedManager;

//创建所有文件
- (void)createAllDirectory;

//创建文件
- (void)createDirectory:(NSString *)path;

//复制文件
- (void)copyFileToDocuments:(NSString *)path;

//删除文件
- (void)deleteFolderPath:(NSString *)path;

//删除文件夹下所有内容
- (void)deleteFolderSub:(NSString *)path;

//文件是否存在
- (BOOL)fileExists:(NSString *)path;

//获取文件空间
- (CGFloat)getFreeStorage:(BOOL)isOk FileName:(NSString *)filename;

//获取单个文件大小
- (long long)fileSizeAtPath:(NSString*)filePath;

@end
