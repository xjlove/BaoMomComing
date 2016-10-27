//
//  HttpManager.m
//  CloudClassRoom
//
//  Created by xj_love on 15/12/23.
//  Copyright © 2015年 like. All rights reserved.
//

#import "HttpManager.h"

static HttpManager *httpManager = nil;
@implementation HttpManager

#pragma mark - Ptivate
+ (instancetype)sharedManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        httpManager = [[HttpManager alloc] init];
    });
    
    return httpManager;
}

+ (instancetype)alloc {
    NSAssert(httpManager == nil, @"Attempted to allocate a second instance of a singleton.");
    return [super alloc];
}

- (instancetype)init {
    if (self = [super init]) {
        
    }
    
    return self;
}

#pragma mark - Common
- (void)doGetJson:(NSString *)urlstr withCompletionBlock:(GetBackBlock)completionBlock withFailBlock:(GetFailBlock)failBlock {
    if (![MANAGER_UTIL isEnableNetWork]) {
        failBlock(nil);
        return;
    }
    
    ASIHTTPRequest *request = [[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:urlstr]];
    [request startAsynchronous];
    
    __block ASIHTTPRequest *_request = request;
    [request setCompletionBlock:^{
        switch ([_request responseStatusCode]) {//HTTP状态码
            case 404://Not Found 无法找到指定位置的资源
            case 500://Internal Server Error 服务器遇到了意料不到的情况
                failBlock([_request error]);
                break;
            case 200://OK 一切正常
                completionBlock([_request responseData]);
                
                break;
                
            default:
                failBlock([_request error]);
                break;
        }
        [MANAGER_SHOW dismiss];
    }];
    [request setFailedBlock:^{
        failBlock([_request error]);
        [MANAGER_SHOW dismiss];
    }];
}


- (void)doGetJson:(GetModel *)model withSuccessBlock:(GetBackBlock)successBlock withFailBlock:(GetFailBlock)failBlock {
    
    NSLog(@"get urlstr = %@", model.urlStr);
    if (![MANAGER_UTIL isEnableNetWork]) {
        BLOCK_FAILURE(nil);
        return;
    }
    
    if (model.flag) {
        [MANAGER_SHOW showWithInfo:loadingMessage];
    }
    
    ASIHTTPRequest *request = [[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:[model.urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
    [request startAsynchronous];

    __block ASIHTTPRequest *_request = request;
    [request setCompletionBlock:^{
        BLOCK_SUCCESS([_request responseData]);
    }];
    [request setFailedBlock:^{
        [MANAGER_SHOW dismiss];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            BLOCK_FAILURE([_request error]);
        });
    }];
}

- (NSString *)doGetJsonSync:(GetModel *)model {
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:model.urlStr]];
    [request startSynchronous];
    
    return [request responseString];
    return @"";
}

- (void)doPostJson:(PostModel *)model withSuccessBlock:(GetBackBlock)successBlock withFailBlock:(GetFailBlock)failBlock {
    
    NSLog(@"post urlstr = %@", model.urlStr);
    if (model.flag) {
        [MANAGER_SHOW showWithInfo:loadingMessage];
    }
    
    ASIFormDataRequest *request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:[model.urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
    
    [request setRequestMethod:@"POST"];
    for (NSString *key in [model.params allKeys]) {
        [request setPostValue:[model.params objectForKey:key] forKey:key];
    }
    [request buildPostBody];
    [request startAsynchronous];
    
    __block ASIFormDataRequest *_request = request;
    [request setCompletionBlock:^{
        [MANAGER_SHOW dismiss];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            BLOCK_SUCCESS([_request responseData]);
        });
    }];
    [request setFailedBlock:^{
        [MANAGER_SHOW dismiss];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            BLOCK_FAILURE([_request error]);
        });
    }];
}

- (void)doPostJsonSync:(PostModel *)model {
    
    NSLog(@"post urlstr = %@", model.urlStr);
    if (model.flag) {
        [MANAGER_SHOW showWithInfo:loadingMessage];
    }
    
    ASIFormDataRequest *request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:model.urlStr]];
    
    [request setRequestMethod:@"POST"];
    for (NSString *key in [model.params allKeys]) {
        [request setPostValue:[model.params objectForKey:key] forKey:key];
    }
    [request buildPostBody];
    [request startSynchronous];
    
    [MANAGER_SHOW dismiss];
}

- (void)doUploadImage:(PostModel *)model withSuccessBlock:(GetBackBlock)successBlock withFailBlock:(GetFailBlock)failBlock {
    
    NSLog(@"post image urlstr = %@", model.urlStr);
    if (![MANAGER_UTIL isEnableNetWork]) {
        BLOCK_FAILURE(nil);
        return;
    }
    
    ASIFormDataRequest *request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:model.urlStr]];
    
    [request setRequestMethod:@"POST"];
    for (NSString *key in [model.params allKeys]) {
        [request setPostValue:[model.params objectForKey:key] forKey:key];
    }
    for (NSString *key in [model.imageDict allKeys]) {
        [request setFile:[model.imageDict objectForKey:key] forKey:key];
    }
    
    [request setUploadProgressDelegate:self];
    [request buildPostBody];
    [request startAsynchronous];
    
    [MANAGER_SHOW showProgressWithInfo:@"上传中..."];
    __block ASIFormDataRequest *_request = request;
    [request setCompletionBlock:^{
        BLOCK_SUCCESS([_request responseData]);
    }];
    [request setFailedBlock:^{
        BLOCK_FAILURE([_request error]);
    }];
}

- (void)downloadJSONData:(NSString *)URLStr FileName:(NSString *)fileName ShowLoadingMessage:(BOOL)flag finishCallbackBlock:(void (^)(BOOL))block {
    if (! [MANAGER_UTIL isEnableNetWork]) {
        
        block(NO);
        return;
        
    }
    
    if (flag) {
        [MANAGER_SHOW showWithInfo:loadingMessage];
    }
    
    NSURL* requestURL = [NSURL URLWithString:[URLStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:requestURL];
    __weak ASIHTTPRequest *_request = request;
    [request setAllowCompressedResponse:YES];
    [request setShouldContinueWhenAppEntersBackground:YES];
    [request setTimeOutSeconds:60];
    [request setCompletionBlock:^{
        BOOL dataWasCompressed = [_request isResponseCompressed];
        if (dataWasCompressed) {
            
            NSData *uncompressedData = [_request responseData];
            if (uncompressedData) {
                [uncompressedData writeToFile:[MANAGER_FILE.CSDownloadPath stringByAppendingPathComponent:[NSString stringWithFormat:@"json/%@",fileName]] atomically:YES];
            }
            
            block(YES);
        }
        [MANAGER_SHOW dismiss];
    }];
    [request setFailedBlock:^{
        block(NO);
        [MANAGER_SHOW dismiss];
    }];
    [request startAsynchronous];
    
}

/**
 * 下载json数据文件
 * @param requestURL 访问链接
 * @param fileName 下载的json文件名字
 * @param block 下载完成后的回调函数
 * @param flag 是否显示加载中对话框
 */
- (void)parseJsonData:(NSString *)URLStr FileName:(NSString *)fileName ShowLoadingMessage:(BOOL)flag JsonType:(ParseJsonType)type finishCallbackBlock:(void (^)(NSMutableArray *result))block {
    NSLog(@"url = %@", URLStr);
    [self downloadJSONData:URLStr FileName:fileName ShowLoadingMessage:flag finishCallbackBlock:^(BOOL result) {
        
        NSFileManager *fm = [NSFileManager defaultManager];
        NSData *fileData = [fm contentsAtPath:[MANAGER_FILE.CSDownloadPath stringByAppendingPathComponent:[NSString stringWithFormat:@"json/%@", fileName]]];
        
        if(fileData) {
            
            NSError *error;
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:fileData options:kNilOptions error:&error];
            if (json == nil) {
                NSLog(@"json parse failed \r\n");
                block(nil);
                return;
            }
            
            NSMutableArray *dataArray = [[NSMutableArray alloc] init];
            
            if (type == ParseJsonTypeBookMenu) {
                NSString *success = [json objectForKey:@"success"];
                if ([success isEqualToString:@"success"]) {
                    dataArray = [self getDownloadArray:json JsonType:type];
                    block(dataArray);
                }
                else{
                    block(nil);
                }
            }
            else {
                NSString *status = [json objectForKey:@"status"];
                if ([status intValue] == 1) {
                    dataArray = [self getDownloadArray:json JsonType:type];
                    block(dataArray);
                }else {
                    block(nil);
                }
            }
            
        }
        else {
            block(nil);
            NSLog(@"file %@ read failed", fileName);
        }
        
    }];
    
}

- (NSMutableArray *)getDownloadArray:(NSDictionary *)dict JsonType:(ParseJsonType)type {
    NSMutableArray *dataArray = [[NSMutableArray alloc] init];
    //    NSArray *array = [[NSArray alloc] init];
    //    switch (type) {
    //
    //        case ParseJsonTypeCategory:
    //        {
    //            NSArray *group = [dict objectForKey:@"category_group"];
    //            NSDictionary *first = [group firstObject];
    //
    //            array = [first objectForKey:@"category"];
    //            for (NSDictionary *subDict in array) {
    //                CourseCategory *category = [[CourseCategory alloc] initWithDictionary:subDict];
    //                [dataArray addObject:category];
    //            }
    //        }
    //            break;
    //
    //        default:
    //            break;
    //    }
    
    return dataArray;
}

- (void)setProgress:(float)newProgress {
    [MANAGER_SHOW setProgress:newProgress];
}

@end

#pragma mark - GET MODEL
@implementation GetModel

- (instancetype)init {
    if (self = [super init]) {
        _flag = NO;
    }
    
    return self;
}

@end

#pragma mark - POST MODEL
@implementation PostModel

- (instancetype)initWithType:(NSString*)type {
    if (self = [super init]) {
//        _imageDict = [[NSMutableDictionary alloc] init];
//        _type = type;
//        _flag = NO;
    }
//
    return self;
}

- (void)setImageArray:(NSArray *)imageArray {
//    switch (_type) {
//        case PostImageTypeAvatar:
//        {
//            UIImage *image = imageArray[0];
//            NSData *imageData = UIImageJPEGRepresentation(image, 0.1);//图片压缩
//            
//            // 将图片写入文件
//            NSString *filepath = [MANAGER_FILE.CSDownloadPath stringByAppendingPathComponent:@"upload/image.jpg"];
//            if ([imageData writeToFile:filepath atomically:YES]) {
//                [_imageDict setObject:filepath forKey:@"image"];
//            }
//        }
//            break;
//        case PostImageTypePhotoSingle:
//        {
//            UIImage *image = imageArray[0];
//            NSData *imageData = UIImageJPEGRepresentation(image, 0.1);//图片压缩
//            
//            // 将图片写入文件
//            NSString *filepath = [MANAGER_FILE.CSDownloadPath stringByAppendingPathComponent:@"upload/image0.jpg"];
//            if ([imageData writeToFile:filepath atomically:YES]) {
//                [_imageDict setObject:filepath forKey:@"image0"];
//            }
//        }
//            break;
//        case PostImageTypePhotoMutil:
//            for (int i=0; i<imageArray.count; i++) {
//                UIImage *image = imageArray[i];
//                NSData *imageData = UIImageJPEGRepresentation(image, 0.1);//图片压缩
//                
//                // 将图片写入文件
//                NSString *filepath = [MANAGER_FILE.CSDownloadPath stringByAppendingPathComponent:[NSString stringWithFormat:@"upload/image%d.jpg", i]];
//                if ([imageData writeToFile:filepath atomically:YES]) {
//                    [_imageDict setObject:filepath forKey:[NSString stringWithFormat:@"image%d", i]];
//                }
//            }
//            break;
//            
//        default:
//            break;
//    }
}

@end
