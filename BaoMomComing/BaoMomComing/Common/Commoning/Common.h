//
//  Common.h
//  BaoMomComing
//
//  Created by xj_love on 16/8/1.
//  Copyright © 2016年 Xander. All rights reserved.
//

#import <Foundation/Foundation.h>

#define BLOCK_SUCCESS(block) if (successBlock) { \
successBlock(block); \
}

#define BLOCK_FAILURE(block) if (failBlock) { \
failBlock(block); \
}

#define BLOCK_END if (endBlock) { \
endBlock(); \
}

#define INTERFACE_SINGLETON_FOR_CLASS \
+ (instancetype)sharedAgent;

#define SYNTHESIZE_SINGLETON_FOR_CLASS(classname) \
static classname *shared##classname = nil; \
+ (instancetype)sharedAgent { \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
shared##classname = [[self alloc] init]; \
}); \
\
return shared##classname; \
} \
\
+ (instancetype)alloc { \
NSAssert(shared##classname == nil, @"Attempted to allocate a second instance of a singleton."); \
return [super alloc]; \
}

typedef enum : NSUInteger {
    CASE_1, // 显示文本和菊花,延时3秒后消失
    CASE_2, // 仅仅显示文本,延时3秒后消失
    CASE_3, // 加载自定义view,3秒后消失
} E_CASE;

typedef NS_ENUM(NSInteger, TimeType) {
    TimeTypeAll,
    TimeTypeHalf,
    TimeTypeYear,
    TimeTypeMonth,
    TimeTypeDay,
    TimeTypeTimeStamp
};

//解析json数据
typedef NS_ENUM (NSInteger, ParseJsonType) {
    ParseJsonTypeLogin,
    ParseJsonTypeBookMenu,
    ParseJsonTypeBMCMedia
};

//删除下载列表时的个数
typedef NS_ENUM (NSInteger, DeleteCountType) {
    DeleteCountTypeSingle = 0,
    DeleteCountTypeAll
};

@interface Common : NSObject

//常用的block
typedef void (^GetBackBlock)(id obj);
typedef void (^GetBackBoolBlock)(BOOL result);
typedef void (^GetBackStringBlock)(NSString *result);
typedef void (^GetBackArrayBlock)(NSMutableArray *result);
typedef void (^GetBackDictionaryBlock)(NSDictionary *result);
typedef void (^GetBackNSUIntegerBlock)(NSUInteger result);
typedef void (^GetFailBlock)(NSError *error);
typedef void (^GetEndBlock)();

@end
