//
//  NewsAgent.h
//  BaoMomComing
//
//  Created by xj_love on 2016/11/30.
//  Copyright © 2016年 Xander. All rights reserved.
//

#import "BaseAgent.h"

#define AGENT_News [NewsAgent sharedAgent]

@interface NewsAgent : BaseAgent

INTERFACE_SINGLETON_FOR_CLASS

/**
 *  GET请求 资讯Json数据
 *
 *  @param type            页面类型（0.头条，1.其它）
 *  @param Flag            是否缓存 Json是否缓存
 *  @param completionBlock 成功返回数组
 *  @param failBlock       失败返回
 */
- (void)doGetNewsJsonDataWithType:(int)type isCache:(BOOL)Flag WithCompletionBlock:(GetBackArrayBlock)completionBlock withFailBlock:(GetFailBlock)failBlock;

@end
