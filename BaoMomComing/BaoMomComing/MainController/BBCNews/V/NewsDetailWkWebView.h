//
//  NewsDetailWkWebView.h
//  BaoMomComing
//
//  Created by xj_love on 2016/11/29.
//  Copyright © 2016年 Xander. All rights reserved.
//

#import <WebKit/WebKit.h>

@interface NewsDetailWkWebView : WKWebView
/**
 *  加载资讯网页
 *
 *  @param newsDetailID 资讯id
 *  @param type         资讯类型 0.头条 1.其它
 */
- (void)loadNewsDetailWkWebViewWith:(NSString*)newsDetailID andWithType:(int)type;

@property (nonatomic, copy)void (^newsDetailSuccessBlock)(NSString *url);

@end
