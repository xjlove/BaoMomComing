//
//  FileManager.m
//  CloudClassRoom
//
//  Created by xj_love on 15/12/18.
//  Copyright © 2015年 like. All rights reserved.
//

#import "FileManager.h"

static FileManager *fileManager = nil;
@implementation FileManager

#pragma mark - Private
+ (instancetype)sharedManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        fileManager = [[FileManager alloc] init];
    });
    
    return fileManager;
}

+ (instancetype)alloc {
    NSAssert(fileManager == nil, @"Attempted to allocate a second instance of a singleton.");
    return [super alloc];
}

- (instancetype)init {
    if (self = [super init]) {
        NSLog(@"filepath = %@", DownloadPath);
    }
    
    return self;
}

#pragma mark - Common
- (void)createAllDirectory {
    _CSDownloadPath = [NSString stringWithFormat:@"%@/%@", DownloadPath,@"BMC"];
    
    if (![[NSUserDefaults standardUserDefaults] valueForKey:@"DownDefinition"]) {
        [[NSUserDefaults standardUserDefaults] setValue:@1 forKey:@"DownDefinition"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    if (![[NSUserDefaults standardUserDefaults] valueForKey:@"ChangeDefinition"]) {
        [[NSUserDefaults standardUserDefaults] setValue:@1 forKey:@"ChangeDefinition"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    [self createDirectory:@"db"];
    [self createDirectory:@"json/subject"];
    [self createDirectory:@"resource"];
    [self createDirectory:@"temporary"];
}

- (void)createDirectory:(NSString *)path {
    NSString *filepath = _CSDownloadPath;
    
    NSString *folderPath = [filepath stringByAppendingPathComponent:path];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if (![self fileExists:folderPath]) {
        [fileManager createDirectoryAtPath:folderPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
}

- (void)copyFileToDocuments:(NSString *)path {
    [self createDirectory:path];
    
    NSString *filepath = [AppPath stringByAppendingPathComponent:path];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *lists = [fileManager contentsOfDirectoryAtPath:filepath error:nil];
    
    NSString *filepath1 = _CSDownloadPath;
    for (NSString *file in lists) {
        NSString *fromPath = [[AppPath stringByAppendingPathComponent:path] stringByAppendingPathComponent:file];
        NSString *toPath = [[filepath1 stringByAppendingPathComponent:path] stringByAppendingPathComponent:file];
        if (![self fileExists:toPath]) {
            [fileManager copyItemAtPath:fromPath toPath:toPath error:nil];
        }
    }
    
}

- (BOOL)fileExists:(NSString *)path {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    return [fileManager fileExistsAtPath:path];
}

- (void)deleteFolderPath:(NSString *)path {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path]) {
        [fileManager removeItemAtPath:path error:nil];
    }
}

- (void)deleteFolderSub:(NSString *)path {
    NSFileManager* manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:path])
        return;
    NSEnumerator *enumerator = [[manager subpathsAtPath:path] objectEnumerator];
    NSString* fileName;
    while ((fileName = [enumerator nextObject]) != nil){
        [manager removeItemAtPath:[path stringByAppendingPathComponent:fileName] error:nil];
    }
}

- (CGFloat)getFreeStorage:(BOOL)isOk FileName:(NSString *)filename {
    if (isOk) {
        NSDictionary *fattributes = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:nil];
        NSNumber *num = [fattributes objectForKey:NSFileSystemFreeSize];
        return [num longLongValue]/1024.0/1024.0/1024.0;
    }else {
        NSString *filePath = [_CSDownloadPath stringByAppendingPathComponent:[NSString stringWithFormat:@"course/%@", filename]];
        NSFileManager* manager = [NSFileManager defaultManager];
        if (![manager fileExistsAtPath:filePath])
            return 0;
        NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:filePath] objectEnumerator];
        NSString *fileName;
        long long folderSize = 0;
        
        while ((fileName = [childFilesEnumerator nextObject]) != nil){
            NSString *fileAbsolutePath = [filePath stringByAppendingPathComponent:fileName];
            folderSize += [self fileSizeAtPath:fileAbsolutePath];
        }
        return folderSize/(1024.0*1024.0);
    }
}

- (long long)fileSizeAtPath:(NSString *)filePath {
    NSFileManager *manager = [NSFileManager defaultManager];
    if ([self fileExists:filePath]){
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
}

@end
