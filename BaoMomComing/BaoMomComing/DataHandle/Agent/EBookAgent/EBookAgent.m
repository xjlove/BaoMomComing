//
//  EBookAgent.m
//  CloudClassRoom
//
//  Created by xj_love on 16/5/13.
//  Copyright © 2016年 like. All rights reserved.
//

#import "EBookAgent.h"

@implementation EBookAgent

SYNTHESIZE_SINGLETON_FOR_CLASS(EBookAgent)

- (void)doGetEBookMenuJsonDataWithCompletionBlock:(GetBackArrayBlock)completionBlock withFailBlock:(GetFailBlock)failBlock{
    
    NSString *urlStr = [NSString stringWithFormat:@""];
    
//    NSLog(@"bookMenuUrl:%@",urlStr);
    
    [MANAGER_SHOW showWithInfo:loadingMessage];
    
    [MANAGER_HTTP doGetJson:urlStr withCompletionBlock:^(id obj) {
        
        NSDictionary *dict = [MANAGER_PARSE parseJsonToDict:obj];
        
        if ([[dict objectWithKey:@"message"] isEqualToString:@"success"]) {
            
            NSMutableArray *bookMenuArrM = [NSMutableArray array];
            
//            NSArray *booksArr = [dict objectForKey:@"categorys"];
//            for (NSDictionary *tempDic  in booksArr) {
//                
//                BookMenuEntity *menu = [[BookMenuEntity alloc] initWithDictionary:tempDic];
//                
//                [bookMenuArrM addObject:menu];
//            }
//            
//            BookMenuDataEntity *menuData = [[BookMenuDataEntity alloc] initWithArrayM:bookMenuArrM];
//            
//            [bookMenuArrM removeAllObjects];
//            [bookMenuArrM addObject:menuData];
            
            completionBlock(bookMenuArrM);
            
        }
        
    } withFailBlock:^(NSError *error) {
        
    }];
}

@end
