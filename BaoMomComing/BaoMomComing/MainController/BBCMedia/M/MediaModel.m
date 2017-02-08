//
//  MediaModel.m
//  BaoMomComing
//
//  Created by xj_love on 2016/11/9.
//  Copyright © 2016年 Xander. All rights reserved.
//

#import "MediaModel.h"

@implementation MediaModel

- (instancetype)init {
    if (self = [super init]) {
        _imsList = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dict{
    if (self = [super init]) {
        _imsList = [[NSMutableArray alloc] init];
        
        _courseID = [[dict objectForKey:@"id"] intValue];
        _courseNO = [dict objectForKey:@"course_no"];
        _categoryID = [dict objectForKey:@"category"];
        _courseName = [dict objectForKey:@"course_name"];
        if ([[dict objectForKey:@"course_introduction"]  isEqual:[NSNull null]]) {
            _courseIntroduction = @"";
        }else{
            _courseIntroduction = [dict objectForKey:@"course_introduction"];
        }
        _logo = [dict objectForKey:@"logo1"];
        _fileType = [dict objectForKey:@"file_type"];
        _courseType = [[dict objectForKey:@"course_type"] intValue];
        int wareType = [[dict objectForKey:@"courseware_type"] intValue];
        _coursewareType = wareType==6 ? 1 : wareType;
        _lecturer = [dict objectForKey:@"lecturer"];
        _avatar = [dict objectForKey:@"lecturer_avatar"];
        _lecturerIntroduction = [dict objectForKey:@"lecturer_introduction"];
        _elective = [[dict objectForKey:@"elective_count"] intValue];
        _score = [[dict objectForKey:@"comment_score"] intValue];
        _commentCount = [[dict objectForKey:@"comment_count"] intValue];
        _period = [[dict objectForKey:@"period"] intValue];
//        _credit = [[dict objectForKey:@"credit"] intValue];
//        _isTest = [[dict objectForKey:@"is_test"] intValue];
        _createTime = [dict objectForKey:@"create_time"];
        _progress = [[dict objectForKey:@"progress"] floatValue];
        _status = [[dict objectForKey:@"status"] intValue];
        _completeYear = [dict objectForKey:@"complete_year"];
        _deleted = [[dict objectForKey:@"deleted"] intValue];
        _sn = [[dict objectForKey:@"sn"] intValue];
        _electiveTime = [dict objectForKey:@"elective_time"];
        _category = [NSString stringWithFormat:@"%@", [dict objectForKey:@"category"]];
        _definition = [[dict objectForKey:@"definition"] intValue];
        
        _isCheck = NO;
    }
    
    return self;
}

@end
