//
//  MediaModel.h
//  BaoMomComing
//
//  Created by xj_love on 2016/11/9.
//  Copyright © 2016年 Xander. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MediaModel : NSObject

@property (nonatomic, strong) NSString *classID; // 班级ID
@property (readwrite) int courseID; // 课程ID
@property (nonatomic, strong) NSString *courseNO; // 课程编号
@property (nonatomic, strong) NSString *categoryID; // 专题ID(多个)
@property (nonatomic, strong) NSString *courseName; // 课程名
@property (nonatomic, strong) NSString *courseIntroduction; // 课程简介
@property (nonatomic, strong) NSString *logo; // 课程图片
@property (nonatomic, strong) NSString *category; //所属专题
@property (nonatomic, strong) NSString *createTime; // 上传时间
@property (nonatomic, strong) NSString *lecturer; // 讲师
@property (nonatomic, strong) NSString *avatar; // 讲师头像
@property (nonatomic, strong) NSString *lecturerIntroduction; // 讲师职务职称
@property (nonatomic, strong) NSString *fileType; // 课程类型
@property (readwrite) int courseType; // 课程类型(0.必修 1.选修)
@property (readwrite) int coursewareType; //课件类型(1.音视频 2.文本 3.三分屏 5.网页 7.新课件(包含视频和音频))
@property (readwrite) int elective; // 选课人次
@property (readwrite) int score; // 课程平均得分
@property (readwrite) int commentCount; // 评价次数
@property (readwrite) int period; // 学时(分钟)
//@property (readwrite) int credit; // 学分
//@property (readwrite) int isTest; // 是否有考试(=0.无考试 !=0.有考试)
@property (readwrite) int definition; // 清晰度区分:0就一个标准清晰度,1是三个清晰度
@property (readwrite) int deleted; // 删除状态(0.已删除 1.未删除)

@property (nonatomic, strong) NSMutableArray *imsList;

// 用户课程
@property (readwrite) int status; // 课程状态(0.未完成 1.已完成)
@property (readwrite) int sn; //排序
@property (readwrite) float progress; // 学习进度
@property (nonatomic, strong) NSString *completeYear; // 完成年份
@property (nonatomic, strong) NSString *electiveTime; //选课时间,排序用

@property (readwrite) BOOL isCheck; //判断cell是否被选择;

//0表示课程,1表示用户课程,2表示学习班课程
- (instancetype)initWithDictionary:(NSDictionary *)dict;

@end
