//
//  HttpManager.h
//  CloudClassRoom
//
//  Created by xj_love on 15/12/23.
//  Copyright © 2015年 like. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetModel : NSObject

@property (nonatomic, strong) NSString *urlStr;
@property (nonatomic, strong) NSString *filename;

//@property (nonatomic, assign) ParseJsonType jsonType;
@property (nonatomic, assign) BOOL flag;

@end

@interface PostModel : NSObject

@property (nonatomic, assign) BOOL flag;
//@property (nonatomic, assign) PostImageType type;
@property (nonatomic, strong) NSString *urlStr;//主机
@property (nonatomic, strong) NSMutableDictionary *params;//参数

@property (nonatomic, strong) NSMutableDictionary *imageDict;
@property (nonatomic, strong) NSArray *imageArray;//上传头像

- (instancetype)initWithType:(NSString*)type;

@end

#define MANAGER_HTTP [HttpManager sharedManager]

@interface HttpManager: NSObject <ASIProgressDelegate>

+ (instancetype)sharedManager;

#pragma mark - ASIHttpRequest
/**
 *  GET Async
 *
 *  @param urlstr          请求接口
 *  @param completionBlock 完成网络请求回调
 *  @param failBlock       请求失败回调
 */
- (void)doGetJson:(NSString *)urlstr withCompletionBlock:(GetBackBlock)completionBlock withFailBlock:(GetFailBlock)failBlock;

/**
 * GET json
 */
- (void)doGetJson:(GetModel *)model withSuccessBlock:(GetBackBlock)successBlock withFailBlock:(GetFailBlock)failBlock;

/**
 * GET json sync
 */
- (NSString *)doGetJsonSync:(GetModel *)model;

/**
 * POST json
 */
- (void)doPostJson:(PostModel *)model withSuccessBlock:(GetBackBlock)successBlock withFailBlock:(GetFailBlock)failBlock;

/**
 * POST json sync
 */
- (void)doPostJsonSync:(PostModel *)model;

/**
 * POST upload image
 */
- (void)doUploadImage:(PostModel *)model withSuccessBlock:(GetBackBlock)successBlock withFailBlock:(GetFailBlock)failBlock;

@end
