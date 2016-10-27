//
//  Download.h
//  CloudClassRoom
//
//  Created by rgshio on 15/3/31.
//  Copyright (c) 2015年 like. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Download : NSObject

@property (strong, nonatomic) NSString *ID;
//@property (strong, nonatomic) Resource *resource;
//@property (strong, nonatomic) ImsmanifestXML *imsmanifest;
//@property (strong, nonatomic) CircularProgressView *cpv;
@property (strong, nonatomic) UIImageView *imageView;

//@property (readwrite) DownloadType type; //判断是课程还是资源文件
@property (readwrite, nonatomic) int status;
@property (readwrite) float progressdl;

@property (nonatomic, strong) NSString *courseNO; //记录课程编号
@property (readwrite) int courseID; //记录课程ID
@property (readwrite) int ware_type; //记录课程类型
@property (readwrite) int definition; //记录课程清晰度

@property (strong, nonatomic) NSString *filename; //文件名

//文件下载地址
@property (strong, nonatomic) NSString *dataurl; //data包地址
@property (strong, nonatomic) NSString *resourceurl; //资源地址

//文件存放地址
@property (strong, nonatomic) NSString *datapath;
@property (strong, nonatomic) NSString *resourcepath;

- (instancetype)initWithDictionary:(NSDictionary *)dict;

@end
