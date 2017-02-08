//
//  NewsDetailWkWebView.m
//  BaoMomComing
//
//  Created by xj_love on 2016/11/29.
//  Copyright © 2016年 Xander. All rights reserved.
//

#import "NewsDetailWkWebView.h"

@interface NewsDetailWkWebView ()<WKNavigationDelegate,WKUIDelegate>{
    NSString *newsUrlStr;
}

@property (nonatomic, strong) NSURL *newsDetailURl;

@end

@implementation NewsDetailWkWebView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.navigationDelegate = self;
        self.UIDelegate = self;
    }
    return self;
}

- (void)loadNewsDetailWkWebViewWith:(NSString*)newsDetailID andWithType:(int)type{
    [MANAGER_SHOW showWithInfo:loadingMessage inView:self];
    NSString *urlString;
    if (type == 0) {
        urlString = [NSString stringWithFormat:BMC_News_ScrollDetailUrl,Host_news,newsDetailID];
    }else if(type == 1){
        urlString = [NSString stringWithFormat:BMC_News_DetailUrl,Host_news,newsDetailID];
    }
    
    [MANAGER_HTTP doGetJson:urlString withCompletionBlock:^(id obj) {
        
        NSDictionary *dataDict = [MANAGER_PARSE parseJsonToDict:obj];
        newsUrlStr = [dataDict objectForKey:@"url"];
        self.newsDetailURl = [NSURL URLWithString:[dataDict objectForKey:@"url"]];
        [self loadWKWebViewDetail];
        
    } withFailBlock:^(NSError *error) {
        
    }];
    
}

- (void)loadWKWebViewDetail{
    [self loadRequest:[NSURLRequest requestWithURL:self.newsDetailURl]];
}

#pragma mark - **************************** WKNavigationDelegate *************************************
// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    [MANAGER_SHOW dismiss];
    if (self.newsDetailSuccessBlock) {
        self.newsDetailSuccessBlock(newsUrlStr);
    }
}

// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation {
    [MANAGER_SHOW dismiss];
}


-(void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
    //如果是跳转一个新页面
    if (navigationAction.targetFrame == nil) {
        [webView loadRequest:navigationAction.request];
    }
    
    decisionHandler(WKNavigationActionPolicyAllow);
}

#pragma mark - **************************** WKUIDelegate *************************************
//- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler {
//    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];
//    [alert addAction:[UIAlertAction actionWithTitle:@"好" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        completionHandler();
//    }]];
//
//    canGoBack = NO;
//
//    [self presentViewController:alert animated:YES completion:NULL];
//}

//调用逻辑
//NSString *path = [[DataManager sharedManager].CSDownloadPath stringByAppendingPathComponent:@"css"];
//
//if(path){
//    if ([[UIDevice currentDevice].systemVersion floatValue] >= 9.0) {
//        // iOS9. One year later things are OK.
//        NSURL *fileURL = [NSURL fileURLWithPath:[[DataManager sharedManager].CSDownloadPath stringByAppendingPathComponent:[NSString stringWithFormat:@"css/%d.html",_index]]];
//
//        [webView1 loadFileURL:fileURL allowingReadAccessToURL:[NSURL fileURLWithPath:path]];
//
//    } else {
//        // iOS8. Things can be workaround-ed
//
//        NSURL *fileURL = [self fileURLForBuggyWKWebView8:[NSURL fileURLWithPath:path]];
//
//        NSString *htmlString = [NSString stringWithContentsOfFile:[NSTemporaryDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"www/css/%d.html",_index]] encoding:NSUTF8StringEncoding error:nil];
//
//        [webView1 loadHTMLString:htmlString baseURL:fileURL];
//
//    }
//}
//
//}
//}
//
////将文件copy到tmp目录
//- (NSURL *)fileURLForBuggyWKWebView8:(NSURL *)fileURL {
//    NSError *error = nil;
//    if (!fileURL.fileURL || ![fileURL checkResourceIsReachableAndReturnError:&error]) {
//        return nil;
//    }
//    // Create "/temp/www" directory
//    NSFileManager *fileManager= [NSFileManager defaultManager];
//    NSURL *temDirURL = [[NSURL fileURLWithPath:NSTemporaryDirectory()] URLByAppendingPathComponent:@"www"];
//    [fileManager createDirectoryAtURL:temDirURL withIntermediateDirectories:YES attributes:nil error:&error];
//
//    NSURL *dstURL = [temDirURL URLByAppendingPathComponent:fileURL.lastPathComponent];
//    // Now copy given file to the temp directory
//    [fileManager removeItemAtURL:dstURL error:&error];
//    [fileManager copyItemAtURL:fileURL toURL:dstURL error:&error];
//    // Files in "/temp/www" load flawlesly :)
//    return dstURL;
//}

@end
