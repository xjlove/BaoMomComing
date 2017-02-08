//
//  DataManager.h
//  cosplay
//
//  Created by like on 2014/08/21.
//  Copyright (c) 2014年 like. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Download.h"

#define MANAGER_Data [DataManager sharedManager]

@interface DataManager : NSObject <ASIHTTPRequestDelegate> {
    ASINetworkQueue *netWorkQueue;
    ASINetworkQueue *dataPackageQueue;
}

@property (strong, nonatomic) NSMutableArray *downloadCourseList;
@property (strong, nonatomic) NSString *updateMessage;

@property (readwrite) BOOL isIphone5;
@property (readwrite) BOOL isIphone;
@property (readwrite) BOOL isIpad;

@property (readwrite) BOOL isNotLogin;

@property (strong, nonatomic) UITabBarController *tabBarController;

+ (DataManager *)sharedManager;

#pragma mark - ~~~~~~~~~~~~~~~~~~~~~~~~网络操作~~~~~~~~~~~~~~~~~~~~~~~~~~
#pragma mark - 数据下载(文件)无状态
/**
 * 下载json数据文件
 * @param requestURL 访问链接
 * @param fileName 下载的json文件名字
 * @param block 下载完成后的回调函数
 * @param flag 是否显示加载中对话框
 */
- (void)parseJsonData:(NSString *)URLStr FileName:(NSString *)fileName ShowLoadingMessage:(BOOL)flag JsonType:(ParseJsonType)type finishCallbackBlock:(GetBackArrayBlock)block;
/**
 * 下载不显示状态的文件
 * @param isIms 下载清单文件(YES)还是data包(NO)
 */
- (void)downloadFile:(NSString *)fileurl isIms:(BOOL)isIms withSuccessBlock:(GetBackBoolBlock)block;

#pragma mark - 数据下载(文件)
/**
 *  下载文件
 *
 *  @param urlStr 文件路径
 *  @param block  回调
 */
- (void)downloadFile:(NSString *)urlStr withType:(int)type finishCallbackBlock:(void (^)(BOOL result))block;

/**
 * 下载data包
 * @param Download 下载对象
 */
- (void)downloadDataPackage:(Download *)dl;

/**
 * 下载资源文件
 * @param Download 下载对象
 */
- (void)downloadResource:(Download *)dl;

/**
 * 停止下载资源文件
 * @param scormID 资源文件ID
 */
- (void)stopDownload:(DeleteCountType)type ScormID:(NSString *)scormID;

/**
 * 返回下载队列个数
 * @param course 资源文件ID
 */
- (int)getCurrentOperationCount;

/*
 *从等待队列加载下载资源
 */
- (void)startDownloadFromWaiting;
/**
 * 验证用户权限
 */
- (void)verifyUserPermissions:(void (^)(BOOL result))block;

/**
 * 登录
 * @param username 用户名
 * @param password 密码
 */
- (BOOL)doLogin:(NSString *)username Password:(NSString *)password ShowInfo:(BOOL)flag;

/**
 * 推出系统时调用
 */
- (void)doLogOut;


@end
