//
//  EBookAgent.h
//  CloudClassRoom
//
//  Created by xj_love on 16/5/13.
//  Copyright © 2016年 like. All rights reserved.
//

#import "BaseAgent.h"

#define AGENT_EBook [EBookAgent sharedAgent]

@interface EBookAgent : BaseAgent

INTERFACE_SINGLETON_FOR_CLASS

/**
 *                                          Agent使用示例
 *
 *  @param completionBlock 完成请求回调
 *  @param failBlock       失败回调
 */
- (void)doGetEBookMenuJsonDataWithCompletionBlock:(GetBackArrayBlock)completionBlock withFailBlock:(GetFailBlock)failBlock;

@end
