//
//  DataManager.m
//  cosplay
//
//  Created by like on 2014/08/21.
//  Copyright (c) 2014年 like. All rights reserved.
//

#import "DataManager.h"

@implementation DataManager

- (id)init{
	self = [super init];
	
	if (self){
        
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
            // iPhone
            CGRect r = [[UIScreen mainScreen] bounds];
            if (r.size.height == 480) {
                // iPhone4 or iPhone4S
                _isIphone = YES;
            } else {
                _isIphone5 = YES;
            }
        } else if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
            // iPad
            _isIpad = YES;
        }
        
        _downloadCourseList = [[NSMutableArray alloc] init];
        
        netWorkQueue = [[ASINetworkQueue alloc] init];
        netWorkQueue.maxConcurrentOperationCount = MaxQueue;
        [netWorkQueue reset];
        [netWorkQueue setShowAccurateProgress:YES];
        [netWorkQueue go];
        
        dataPackageQueue = [[ASINetworkQueue alloc] init];
        dataPackageQueue.maxConcurrentOperationCount = MaxQueue;
        [dataPackageQueue reset];
        [dataPackageQueue setShowAccurateProgress:NO];
        [dataPackageQueue go];
        
        [ASIHTTPRequest setShouldUpdateNetworkActivityIndicator:NO];
    }
    
    return self;
}

#pragma mark - ~~~~~~~~~~~~~~~~~~~~~~~~文件操作~~~~~~~~~~~~~~~~~~~~~~~~~~

#pragma mark - ~~~~~~~~~~~~~~~~~~~~~~~~网络操作~~~~~~~~~~~~~~~~~~~~~~~~~~
#pragma mark - 数据下载(文件)无状态
- (void)downloadFile:(NSString *)fileurl isIms:(BOOL)isIms withSuccessBlock:(GetBackBoolBlock)block {
    NSString *filename = nil;
    
    [MANAGER_FILE createDirectory:[NSString stringWithFormat:@"course/%@", fileurl]];
    if (isIms) {
        filename = @"imsmanifest.xml";
    }else {
        filename = @"data.zip";
    }
    
    NSString *urlStr = [NSString stringWithFormat:@"url"];
    
    NSLog(@"file urlstr = %@", urlStr);
    
    NSURL *requestURL = [NSURL URLWithString:urlStr];
    ASIHTTPRequest *request = [[ASIHTTPRequest alloc] initWithURL:requestURL];
    // 下载地址
    NSString *savePath = [MANAGER_FILE.CSDownloadPath stringByAppendingPathComponent:[NSString stringWithFormat:@"course/%@/%@", fileurl, filename]];

    [request setDownloadDestinationPath:savePath];
    [request setShouldContinueWhenAppEntersBackground:YES];
    
    __weak ASIHTTPRequest *_request = request;
    [request setCompletionBlock:^{
        
        if([_request responseStatusCode] != 200 && [_request responseStatusCode] != 206) {
            [MANAGER_FILE deleteFolderPath:savePath];
            [MANAGER_SHOW dismiss];
            block(NO);
            return;
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:downloadFinished object:nil];
        
        if (! isIms) {
            //解压文件
            ZipArchive *unzip = [[ZipArchive alloc] init];
            BOOL result;
            
            if ([unzip UnzipOpenFile:savePath]) {
                
                NSString *filepath = [MANAGER_FILE.CSDownloadPath stringByAppendingPathComponent:[NSString stringWithFormat:@"course/%@/data", fileurl]];
                
                result = [unzip UnzipFileTo:filepath overWrite:YES];
                
                if (result){
                    [MANAGER_SHOW dismiss];
                    block(YES);
                }else {
                    [MANAGER_SHOW dismiss];
                    block(NO);
                }
            }else {
                [MANAGER_SHOW dismiss];
                block(NO);
            }
            
            [unzip UnzipCloseFile];
            // 最后不管成功失败,删除压缩文件
            [MANAGER_FILE deleteFolderPath:savePath];
        }else {
            [MANAGER_SHOW dismiss];
            block(YES);
        }
        
    }];
    [request setFailedBlock:^{
        
        block(NO);
        
    }];
    [request startAsynchronous];
}

/**
 *  下载文件
 *  @param urlStr 文件路径
 *  @param block  回调
 */
- (void)downloadFile:(NSString *)urlStr withType:(int)type finishCallbackBlock:(void (^)(BOOL result))block {
    [MANAGER_SHOW dismiss];
    
    if (![MANAGER_UTIL isEnableNetWork]) {
        block(NO);
        return;
    }
    
    ASIHTTPRequest *request = [[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:urlStr]];
    
    NSString *filename = [urlStr lastPathComponent];
    
    NSString *savePath = [MANAGER_FILE.CSDownloadPath stringByAppendingPathComponent:[NSString stringWithFormat:@"file/%@", filename]];
    NSString *tempPath = [MANAGER_FILE.CSDownloadPath stringByAppendingPathComponent:[NSString stringWithFormat:@"temp/%@", filename]];
    [request setDownloadDestinationPath:savePath];
    [request setTemporaryFileDownloadPath:tempPath];
    [request setShouldContinueWhenAppEntersBackground:YES];
    [request setDownloadProgressDelegate:self];
    
    [MANAGER_SHOW showProgressWithInfo:@"下载中..."];
    
    [request setCompletionBlock:^{
        [MANAGER_SHOW setProgress:1.0];
        if ([MANAGER_FILE fileExists:savePath]) {
            
//            NSString *key = [NSString stringWithFormat:@"filename_%d", type];
//            NSString *oldname = [[NSUserDefaults standardUserDefaults] objectForKey:key];
//            NSString *filepath = [MANAGER_FILE.CSDownloadPath stringByAppendingPathComponent:[NSString stringWithFormat:@"file/%@", oldname]];
//            if ([MANAGER_FILE fileExists:filepath]) {
//                [MANAGER_FILE deleteFolderPath:filepath];
//            }
            
//            [[NSUserDefaults standardUserDefaults] setObject:filename forKey:key];
//            [[NSUserDefaults standardUserDefaults] synchronize];
            
            block(YES);
            
        }else {
            
            block(NO);
            
        }
    }];
    
    [request setFailedBlock:^{
        [MANAGER_SHOW setProgress:1.0];
        block(NO);
    }];
    
    [request startAsynchronous];
}

#pragma mark - 数据下载(文件)
- (void)downloadDataPackage:(Download *)dl {
    
    if (![MANAGER_UTIL isEnableNetWork]) {
        [MANAGER_SHOW showInfo:netWorkError];
        return;
    }
    
    //初始化加载状态，转圈加载
//    dl.imsmanifest.status = Init;
//    if ([dl.ID isEqualToString:dl.cpv.ID]) {
//        [dl.cpv changProgressStatus:Init];
//        [dl.cpv setProgress:0];
//        [dl.cpv showProgressView:YES];
//        [MANAGER_SQLITE executeUpdateWithSql:sql_update_download(dl.type, (int)Init, 0.0, dl.ID)];
//    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"startDownload" object:nil];
    
//    [MANAGER_FILE createDirectory:[NSString stringWithFormat:@"temporary/%@/%@", dl.courseNO, [[dl.imsmanifest.resource componentsSeparatedByString:@"/"] firstObject]]];
//    
//    [MANAGER_FILE createDirectory:[NSString stringWithFormat:@"course/%@/%@/data", dl.courseNO, [[dl.imsmanifest.resource componentsSeparatedByString:@"/"] firstObject]]];
    
//    [[NSUserDefaults standardUserDefaults] setObject:@1 forKey:[NSString stringWithFormat:@"download_%@", _login.ID]];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    NSURL* requestURL = [NSURL URLWithString:dl.dataurl];
    ASIHTTPRequest *request = [[ASIHTTPRequest alloc] initWithURL:requestURL];
    // 下载地址
    NSString *savePath = dl.datapath;
    // 缓存地址
//    NSString *tempPath = [MANAGER_FILE.CSDownloadPath stringByAppendingPathComponent:[NSString stringWithFormat:@"temporary/%@/%@/data.zip", dl.courseNO, [[dl.imsmanifest.resource componentsSeparatedByString:@"/"] firstObject]]];
    
    [request setUserInfo:[NSDictionary dictionaryWithObjectsAndKeys:dl,@"dl",nil]];
    [request setDownloadDestinationPath:savePath];
    [request setShouldContinueWhenAppEntersBackground:YES];
    [request setAllowResumeForFileDownloads:YES];
//    [request setTemporaryFileDownloadPath:tempPath];
    request.tag = 10;
    request.delegate = self;
    [dataPackageQueue addOperation:request];
}

/**
 * 下载资源文件
 * @param Download 下载对象
 */
- (void)downloadResource:(Download *)dl {
    if (![MANAGER_UTIL isEnableNetWork]) {
        [MANAGER_SHOW showInfo:netWorkError];
        return;
    }
    
    NSString *filename = nil;
//    switch (dl.type) {
//        case DownloadTypeCourse:
//        {
//            [MANAGER_FILE createDirectory:[NSString stringWithFormat:@"temporary/%@/%@", dl.courseNO, [[dl.imsmanifest.resource componentsSeparatedByString:@"/"] firstObject]]];
//            [MANAGER_FILE createDirectory:[NSString stringWithFormat:@"course/%@/%@", dl.courseNO, [[dl.imsmanifest.resource componentsSeparatedByString:@"/"] firstObject]]];
//            filename = [NSString stringWithFormat:@"%@/%@/%@", dl.courseNO, [[dl.imsmanifest.resource componentsSeparatedByString:@"/"] firstObject], dl.filename];          
//        }
//            break;
//        case DownloadTypeResource:
//            filename = dl.filename;
//            break;
//            
//        default:
//            break;
//    }

//    if ([dl.ID isEqualToString:dl.cpv.ID]) {
//        [dl.cpv changProgressStatus:Downloading];
//        [dl.cpv setProgress:dl.progressdl];
//        [dl.cpv showProgressView:YES];
//        [MANAGER_SQLITE executeUpdateWithSql:sql_update_download(dl.type, (int)Downloading, dl.progressdl, dl.ID)];
//    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"startDownload" object:nil];
    
//    [[NSUserDefaults standardUserDefaults] setObject:@2 forKey:[NSString stringWithFormat:@"download_%@", _login.ID]];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    NSURL *requestURL = [NSURL URLWithString:dl.resourceurl];
    ASIHTTPRequest *request = [[ASIHTTPRequest alloc] initWithURL:requestURL];
    // 下载地址
    NSString *savePath = dl.resourcepath;
    // 缓存地址
    NSString *tempPath = [MANAGER_FILE.CSDownloadPath stringByAppendingPathComponent:[NSString stringWithFormat:@"temporary/%@", filename]];
    
    [request setUserInfo:[NSDictionary dictionaryWithObjectsAndKeys:dl,@"dl",nil]];
    [request setDownloadDestinationPath:savePath];
    [request setShouldContinueWhenAppEntersBackground:YES];
    [request setDownloadProgressDelegate:dl];
    [request setAllowResumeForFileDownloads:YES];
    [request setTemporaryFileDownloadPath:tempPath];
    request.tag = 11;
    request.delegate = self;
    [netWorkQueue addOperation:request];
}

#pragma mark -
/*
 *下载成功时调用
 */
- (void)requestFinished:(ASIHTTPRequest *)request {
    NSLog(@"url = %@", request.url);
    
    Download *dl =[request.userInfo objectForKey:@"dl"];

    if (request.tag == 10) {
        //文件不存在时删除已创建文件
        if([request responseStatusCode]!=200 && [request responseStatusCode]!= 206) {
            [MANAGER_FILE deleteFolderPath:dl.datapath];
            return;
        }
        
        //解压文件
        ZipArchive *unzip = [[ZipArchive alloc] init];
//        BOOL result;
        
        if ([unzip UnzipOpenFile:dl.datapath]) {
            
//            NSString *filepath = [MANAGER_FILE.CSDownloadPath stringByAppendingPathComponent:[NSString stringWithFormat:@"course/%@/%@/data", dl.courseNO, [[dl.imsmanifest.resource componentsSeparatedByString:@"/"] firstObject]]];
            
//            result = [unzip UnzipFileTo:filepath overWrite:YES];
//            if (result){
//                [MANAGER_FILE deleteFolderPath:dl.datapath];
//            }
        }
        [unzip UnzipCloseFile];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:downloadFinished object:nil];
        
//        if (dl.imsmanifest.status != 0) {
//            [self downloadResource:dl];
//        }
        
    }else if (request.tag == 11) {
        
//        if (dl.type == DownloadTypeCourse) {
//            dl.imsmanifest.status = Finished;
//            dl.imsmanifest.progress = 1;
//        }else {
//            dl.resource.status = Finished;
//            dl.resource.progress = 1;
//        }
        
//        if ([dl.ID isEqualToString:dl.cpv.ID]) {
//            [dl.cpv changProgressStatus:Finished];
//        }
        
//        [MANAGER_SQLITE executeUpdateWithSql:sql_update_download(dl.type, (int)Finished, 1.0, dl.ID)];

        [_downloadCourseList removeObject:dl];
        [[NSNotificationCenter defaultCenter] postNotificationName:downloadFinished object:nil];
        
        [self startDownloadFromWaiting];
    }
    
}


/*
 *下载失败时调用
 */
- (void)requestFailed:(ASIHTTPRequest *)request {
    Download *dl =[request.userInfo objectForKey:@"dl"];
    NSLog(@"download failed, error = %@", request.error);
    
    if (request.tag == 11) {
        
//        if (dl.type == DownloadTypeCourse) {
//            dl.imsmanifest.status = Pause;
//        }else {
//            dl.resource.status = Pause;
//        }
        
//        if ([dl.ID isEqualToString:dl.cpv.ID]) {
//            [dl.cpv changProgressStatus:Pause];
//            [dl.cpv setProgress:dl.progressdl];
//        }
        
//        [MANAGER_SQLITE executeUpdateWithSql:sql_update_download(dl.type, (int)Pause, dl.progressdl, dl.ID)];

        [_downloadCourseList removeObject:dl];

        [self startDownloadFromWaiting];

    }else if (request.tag == 10) {
        
//        dl.imsmanifest.status = Pause;
//        dl.imsmanifest.progress = 0;
//        
//        if ([dl.ID isEqualToString:dl.cpv.ID]) {
//            [dl.cpv changProgressStatus:Pause];
//        }
        
//        [MANAGER_SQLITE executeUpdateWithSql:sql_update_download(dl.type, (int)Pause, 0.0, dl.ID)];

        [_downloadCourseList removeObject:dl];

        [self startDownloadFromWaiting];

    }
    [[NSNotificationCenter defaultCenter] postNotificationName:downloadFinished object:nil];
}

#pragma mark -
/**
 * 停止下载资源文件
 * @param courseID 资源文件ID
 */
- (void)stopDownload:(DeleteCountType)type ScormID:(NSString *)scormID {
    switch (type) {
        case DeleteCountTypeSingle:
        {
//            for (ASIHTTPRequest *request in [dataPackageQueue operations]) {
//                Download *dl =[request.userInfo objectForKey:@"dl"];
//                if ([scormID isEqualToString:dl.imsmanifest.identifierref]) {
//                    [request clearDelegatesAndCancel];
//                }
//            }
            
            for (ASIHTTPRequest *request in [netWorkQueue operations]) {
//                Download *dl =[request.userInfo objectForKey:@"dl"];
                NSString *resourceID = nil;
//                if (dl.type == DownloadTypeCourse) {
//                    resourceID = dl.imsmanifest.identifierref;
//                }else {
//                    resourceID = dl.resource.ID;
//                }
                if ([scormID isEqualToString:resourceID]) {
                    [request clearDelegatesAndCancel];
                }
            }
            break;
        }
        case DeleteCountTypeAll:
        {
            NSArray *tmp = [NSArray arrayWithArray:_downloadCourseList];
            for (Download *dl in tmp) {
                if (dl.courseID == [scormID intValue]) {
                    [_downloadCourseList removeObject:dl];
                }
            }
            
            for (ASIHTTPRequest *request in [dataPackageQueue operations]) {
                Download *dl =[request.userInfo objectForKey:@"dl"];
                if (dl.courseID == [scormID intValue]) {
                    [request clearDelegatesAndCancel];
                }
            }
            
            for (ASIHTTPRequest *request in [netWorkQueue operations]) {
                Download *dl =[request.userInfo objectForKey:@"dl"];
                if (dl.courseID == [scormID intValue]) {
                    [request clearDelegatesAndCancel];
                }
            }
            break;
        }
            
        default:
            break;
    }
}


/*
 *返回下载队列个数
 *@param resource 资源文件ID
 */
- (int)getCurrentOperationCount {
    return (int)netWorkQueue.operationCount;
}


/*
 *从等待队列加载下载资源
 */
- (void)startDownloadFromWaiting {
    if ([self getCurrentOperationCount] == 0 && dataPackageQueue.operationCount == 0) {
//        for (Download *dl in _downloadCourseList) {
//            if (dl.status == Wait) {
//                
//                if (dl.type == DownloadTypeCourse) {
//                    
//                    if (dl.ware_type == 1) {
//                        [self downloadResource:dl];
//                    }else if (dl.ware_type == 3) {
//                        [self downloadDataPackage:dl];
//                    }
//                    
//                }else {
//                    [self downloadResource:dl];
//                }
            
//                break;
//            }
//        }
    }
}


/*
 *上传进度
 */
- (void)setProgress:(float)newProgress {
    [MANAGER_SHOW setProgress:newProgress];
}


/**
 * 验证用户权限
 */
- (void)verifyUserPermissions:(void (^)(BOOL result))block {
    if (![[[NSUserDefaults standardUserDefaults] objectForKey:@"host"] isEqualToString:@""]) {
        block(NO);
        [MANAGER_SHOW showInfo:@"登陆错误, 请重试! "];
        return;
    }

    NSString *userID = [[NSUserDefaults standardUserDefaults] objectForKey:@"userID"];
    MANAGER_FILE.CSDownloadPath = [NSString stringWithFormat:@"%@/%@",DownloadPath, userID];
    
//    NSDictionary *dict = [[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"user_%@", userID]];
//    _login = [[Login alloc] initWithDictionary:dict];
    
    if ([MANAGER_UTIL isEnableNetWork]) {
        [self verifyUserPermissionsWith:userID FinishBlock:^(BOOL result) {
            block(result);
        }];
    }else {
//        if ([_login.status intValue] == 1) {
//            block(YES);
//        }else {
//            block(NO);
//            [MANAGER_SHOW showInfo:@"该账号无权限, 请更换账号! "];
//        }
    }
    
}

- (void)verifyUserPermissionsWith:(NSString *)userID FinishBlock:(void(^)(BOOL result))block {
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:@"url"]];
    [request setAllowCompressedResponse:YES];
    
    __weak ASIHTTPRequest *_request = request;
    [request setCompletionBlock:^{

        if ([[_request responseString] intValue] == 1) {
            
            block(YES);
            
        }else {
            
            block(NO);
            [MANAGER_SHOW showInfo:@"该账号无权限, 请更换账号! "];

        }
        
    }];
    
    [request setFailedBlock:^{
        block(YES);
    }];
    
    [request startAsynchronous];
}

/**
 * 登录
 * @param username 用户名
 * @param password 密码
 */
- (BOOL)doLogin:(NSString *)username Password:(NSString *)password ShowInfo:(BOOL)flag {
//    NSString *urlStr = @"url";

//    if ([MANAGER_UTIL isEnableNetWork]) {
    
//        ASIFormDataRequest *request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
//        [request setRequestMethod:@"POST"];
//        [request setPostValue:username forKey:@"username"];
//        [request setPostValue:[MANAGER_UTIL encryptWithText:password] forKey:@"password"];
//        [request buildPostBody];
//        
//        [request startSynchronous];
        
//        NSError *error = [request error];
//        if(!error) {
//            NSData *response = [request responseData];
//            
//            if (response == nil) {
//                NSLog(@"return json data is nil");
//                return NO;
//            }
//            
//            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:response options:kNilOptions error:&error];
//            
//            if (json == nil) {
//                NSLog(@"json parse failed \r\n");
//                return NO;
//            }
//            
//            NSString *status = [json objectForKey:@"status"];
//            if ([status intValue] == 1) {
//                
//                NSDictionary *user = [json objectForKey:@"user"];
//                if ([[user objectForKey:@"status"] intValue] == 1) {
//                    _login = [[Login alloc] initWithDictionary:user];
//                    
//                    [[NSUserDefaults standardUserDefaults] setObject:user forKey:[NSString stringWithFormat:@"user_%@", _login.ID]];
//                    //系统ID和教师身份保存到本地
//                    [[NSUserDefaults standardUserDefaults] setObject:[json objectForKey:@"system_uuid"] forKey:@"system_uuid"];
//                    [[NSUserDefaults standardUserDefaults] setObject:[json objectForKey:@"is_class_teacher"] forKey:@"is_class_teacher"];
//                    [[NSUserDefaults standardUserDefaults] setObject:Host forKey:@"host"];
//                    [[NSUserDefaults standardUserDefaults] synchronize];
//                    
//                    [MANAGER_FILE createAllDirectory];
//                    
//                    [response writeToFile:[MANAGER_FILE.CSDownloadPath stringByAppendingPathComponent:@"json/login.json"] atomically:YES];
//                    
//                    return  YES;
//                }else {
//                    [self showLoginInfo:@"该账号无权限, 请更换账号! " Flag:flag];
//                    return NO;
//                }
//                
//            }else {
//                [self showLoginInfo:@"账户或密码错误, 请重试!" Flag:flag];
//                return NO;
//            }
//        }else {
//            NSLog(@"error = %@", error);
//            [self showLoginInfo:@"登录错误, 请重试!" Flag:flag];
//            return NO;
//        }
//    }else {
//        
//        if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"username"] isEqualToString:username]) {
//            return YES;
//        }else {
//            [self showLoginInfo:netWorkError Flag:flag];
//            return NO;
//        }
//        
//    }
    
    return NO;
}

- (void)showLoginInfo:(NSString *)info Flag:(BOOL)flag {
    if (flag) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [MANAGER_SHOW showInfo:info];
        });
    }
}

/**
 * 推出系统时调用
 */
- (void)doLogOut {
    for (ASIHTTPRequest *request in [dataPackageQueue operations]) {
        [request clearDelegatesAndCancel];
    }
    for (ASIHTTPRequest *request in [netWorkQueue operations]) {
        [request clearDelegatesAndCancel];
    }
    
    [_downloadCourseList removeAllObjects];
}

#pragma mark -
static DataManager *sharedDataManager = nil;

+ (DataManager *) sharedManager {
    @synchronized(self)
	{
        if (sharedDataManager == nil)
		{
            return [[self alloc] init];
        }
    }
	
    return sharedDataManager;
}

+(id)alloc {
	@synchronized(self)
	{
		NSAssert(sharedDataManager == nil, @"Attempted to allocate a second instance of a singleton.");
		sharedDataManager = [super alloc];
		return sharedDataManager;
	}
	return nil;
}

@end
