//
//  NSArray+XMCommon.m
//  XMCommon
//
//  Created by rgshio on 15/7/28.
//  Copyright (c) 2015年 rgshio. All rights reserved.
//

#import "NSArray+XMCommon.h"
#import <objc/runtime.h>

@implementation NSArray (XMCommon)

+ (void)load {
    [super load];
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method originMethod;
        Method overrideMethod;
        originMethod = class_getInstanceMethod(objc_getClass("__NSArrayI"), @selector(objectAtIndex:));
        overrideMethod = class_getInstanceMethod(objc_getClass("__NSArrayI"), @selector(xm_objectAtIndex_I:));
        method_exchangeImplementations(originMethod, overrideMethod);
        
        originMethod = class_getInstanceMethod(objc_getClass("__NSArrayM"), @selector(objectAtIndex:));
        overrideMethod = class_getInstanceMethod(objc_getClass("__NSArrayM"), @selector(xm_objectAtIndex_M:));
        method_exchangeImplementations(originMethod, overrideMethod);
    });
}

- (instancetype)xm_objectAtIndex_I:(NSInteger)index {
    @try {
        return [self xm_objectAtIndex_I:index];
    }
    @catch (NSException *exception) {
        NSLog(@"-------%s Crash Method Class %s-------", class_getName(self.class), __func__);
    }
    @finally {}
    return nil;
}

- (instancetype)xm_objectAtIndex_M:(NSInteger)index {
    @try {
        return [self xm_objectAtIndex_M:index];
    }
    @catch (NSException *exception) {
        NSLog(@"-------%s Crash Method Class %s-------", class_getName(self.class), __func__);
    }
    @finally {}
    return nil;
}

@end
