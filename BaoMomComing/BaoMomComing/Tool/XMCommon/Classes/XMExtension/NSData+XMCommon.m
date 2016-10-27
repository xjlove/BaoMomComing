//
//  NSData+XMCommon.m
//  XMCommon
//
//  Created by rgshio on 15/7/28.
//  Copyright (c) 2015年 rgshio. All rights reserved.
//

#import "NSData+XMCommon.h"

@implementation NSData (XMCommon)

- (id)jsonObject {
    id obj;
    
    if (self) {
        
        NSError *error;
        obj = [NSJSONSerialization JSONObjectWithData:self options:NSJSONReadingMutableContainers error:&error];
        
        if (error) {
            obj = nil;
            NSLog(@"error : %@", error.description);
        }
        
    }
    
    return obj;
}

@end
