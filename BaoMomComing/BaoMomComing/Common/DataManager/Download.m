//
//  Download.m
//  CloudClassRoom
//
//  Created by rgshio on 15/3/31.
//  Copyright (c) 2015年 like. All rights reserved.
//

#import "Download.h"

@implementation Download

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    if (self = [super init]) {
        _ID = [dict objectWithKey:@"course_sco_id"];
        _courseNO = [dict objectWithKey:@"course_no"];
        _courseID = [[dict objectWithKey:@"course_id"] intValue];
        _ware_type = [[dict objectWithKey:@"courseware_type"] intValue];
        _definition = [[dict objectWithKey:@"definition"] intValue];
    }
    
    return self;
}

/*
 *下载进度
 */
//- (void)setProgress:(float)newProgress {
//    if(isnan(newProgress)) {
//        return;
//    }

//    if (newProgress != 0) {
//        if ([_ID isEqualToString:_cpv.ID]) {
//            
//            if (_type == DownloadTypeCourse) {
//                _imsmanifest.progress = newProgress;
//                _imsmanifest.status = Downloading;
//            }else {
//                _resource.progress = newProgress;
//                _resource.status = Downloading;
//            }
    
//            _progressdl = newProgress;
//            [_cpv changProgressStatus:Downloading];
//            [_cpv setProgress:newProgress];
//            
//            [MANAGER_SQLITE executeUpdateWithSql:sql_update_download(_type, (int)Downloading, newProgress, _ID)];
//        }
//    }
//}

//- (void)setImsmanifest:(ImsmanifestXML *)imsmanifest {
//    _imsmanifest = imsmanifest;
//    _type = DownloadTypeCourse;
//    _status = imsmanifest.status;
//    _progressdl = imsmanifest.progress;
//        
//    if (_ware_type == 1) {
//        _filename = imsmanifest.filename;
//    }else if (_ware_type == 2) {
//        _filename = @"1.pdf";
//    }else if (_ware_type == 3) {
//        _filename = @"1.mp3";
//    }
//    
//    NSString *file = [[imsmanifest.resource componentsSeparatedByString:@"/"] firstObject];
//    
//    //data包
//    _dataurl = [NSString stringWithFormat:@"%@/%@/%@/data.zip", Resource_Host, _courseNO, file];
//    _datapath = [MANAGER_FILE.CSDownloadPath stringByAppendingPathComponent:[NSString stringWithFormat:@"course/%@/%@/data.zip", _courseNO, file]];
//    
//    //音视频
//    _resourceurl = [NSString stringWithFormat:@"%@/%@/%@/%@", Resource_Host, _courseNO, file, _filename];
//    _resourcepath = [MANAGER_FILE.CSDownloadPath stringByAppendingPathComponent:[NSString stringWithFormat:@"course/%@/%@/%@", _courseNO, file, _filename]];
//}

//- (void)setResource:(Resource *)resource {
//    _resource = resource;
//    _filename = [resource.url lastPathComponent];
//    _type = DownloadTypeResource;
//    _status = resource.status;
//    _progressdl = resource.progress;
//    
//    
//    //资源
//    _resourceurl = [NSString stringWithFormat:@"%@%@", Host, resource.url];
//    _resourcepath = [MANAGER_FILE.CSDownloadPath stringByAppendingPathComponent:[NSString stringWithFormat:@"resource/%@", _filename]];
//}

@end
