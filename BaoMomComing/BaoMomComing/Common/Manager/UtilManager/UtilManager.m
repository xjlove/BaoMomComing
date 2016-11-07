//
//  UtilManager.m
//  CloudClassRoom
//
//  Created by xj_love on 15/12/24.
//  Copyright © 2015年 like. All rights reserved.
//

#import "UtilManager.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>

#define DESKEY @"CCR!@#$%"

static UtilManager *utilManager = nil;
@implementation UtilManager

#pragma mark - Private
+ (instancetype)sharedManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        utilManager = [[UtilManager alloc] init];
    });
    
    return utilManager;
}

+ (instancetype)alloc {
    NSAssert(utilManager == nil, @"Attempted to allocate a second instance of a singleton.");
    return [super alloc];
}

- (instancetype)init {
    if (self = [super init]) {
        
    }
    
    return self;
}

#pragma mark
NSInteger intSort(id num1, id num2, void *context) {
    int v1 = [num1 intValue];
    int v2 = [num2 intValue];
    if (v1 < v2)
        return NSOrderedAscending;
    else if (v1 > v2)
        return NSOrderedDescending;
    else
        return NSOrderedSame;
}

//转换小图
//NSInteger intSortPhoto(id num1, id num2, void *context) {
//    Photo *v1 = (Photo*)num1;
//    Photo *v2 = (Photo*)num2;
//    if (v1.ID < v2.ID)
//        return NSOrderedAscending;
//    else if (v1.ID > v2.ID)
//        return NSOrderedDescending;
//    else
//        return NSOrderedSame;
//}

//NSInteger intSortChat(id num1, id num2, void *context) {
//    Chat *v1 = (Chat*)num1;
//    Chat *v2 = (Chat*)num2;
//    if (v1.ID < v2.ID)
//        return NSOrderedAscending;
//    else if (v1.ID > v2.ID)
//        return NSOrderedDescending;
//    else
//        return NSOrderedSame;
//}

//NSInteger intSortPhotoDesc(id num1, id num2, void *context) {
//    Photo *v1 = (Photo*)num1;
//    Photo *v2 = (Photo*)num2;
//    if (v1.ID > v2.ID)
//        return NSOrderedAscending;
//    else if (v1.ID < v2.ID)
//        return NSOrderedDescending;
//    else
//        return NSOrderedSame;
//}

//NSInteger intSortChatDesc(id num1, id num2, void *context) {
//    Chat *v1 = (Chat*)num1;
//    Chat *v2 = (Chat*)num2;
//    if (v1.ID > v2.ID)
//        return NSOrderedAscending;
//    else if (v1.ID < v2.ID)
//        return NSOrderedDescending;
//    else
//        return NSOrderedSame;
//}

NSInteger intSortCourse(id num1, id num2, void *context) {
    int v1 = [[num1 objectForKey:@"sort"] intValue];
    int v2 = [[num2 objectForKey:@"sort"] intValue];
    if (v1 < v2)
        return NSOrderedAscending;
    else if (v1 > v2)
        return NSOrderedDescending;
    else
        return NSOrderedSame;
}


/**
 * 获取当前屏幕显示的viewcontroller
 */
//- (UITabBarController *)getCurrentShowVC {
//    return [DataManager sharedManager].tabBarController;
//}

- (NSString *)timeToString:(NSString *)time {
    if (time.length > 0) {
        NSArray *array = [time componentsSeparatedByString:@":"];
        int hour = [[array objectAtIndex:0] intValue] * 60;
        int minute = [[array objectAtIndex:1] intValue];
        int num = hour + minute;
        return [NSString stringWithFormat:@"%d分钟", num];
    }
    
    return nil;
}

/*
 * 取当前时间
 */
- (NSString *)getDateTime:(TimeType)type {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    switch (type) {
        case TimeTypeAll:
            [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            break;
        case TimeTypeHalf:
            [dateFormatter setDateFormat:@"yyyy-MM-dd"];
            break;
        case TimeTypeYear:
            [dateFormatter setDateFormat:@"yyyy"];
            break;
        case TimeTypeMonth:
            [dateFormatter setDateFormat:@"MM"];
            break;
        case TimeTypeDay:
            [dateFormatter setDateFormat:@"dd"];
            break;
        case TimeTypeTimeStamp:
            [dateFormatter setDateFormat:@"yyyyMMdd"];
            break;
            
        default:
            break;
    }
    
    return [dateFormatter stringFromDate:[NSDate date]];
}

/**
 * 判断空字符串
 */
- (BOOL)isBlankString:(NSString*)string {
    if (string.length == 0) {
        return YES;
    }
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] == 0) {
        return YES;
    }
    return NO;
}

/*
 *是否可以在相册中选择图片
 */
- (BOOL)canUserPickPhotosFromPhotoLibrary {
//    return [self cameraSupportsMedia:(NSString *)kUTTypeImage sourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    return YES;
}

/*
 *判断是否支持某种多媒体类型：拍照，视频
 */
- (BOOL)cameraSupportsMedia:(NSString *)paramMediaType sourceType:(UIImagePickerControllerSourceType)paramSourceType{
    __block BOOL result = NO;
    if ([paramMediaType length] == 0){
        NSLog(@"Media type is empty.");
        return NO;
    }
    NSArray *availableMediaTypes =[UIImagePickerController availableMediaTypesForSourceType:paramSourceType];
    [availableMediaTypes enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL*stop) {
        NSString *mediaType = (NSString *)obj;
        if ([mediaType isEqualToString:paramMediaType]){
            result = YES;
            *stop= YES;
        }
        
    }];
    return result;
}

/**
 * 获取MD5字符串
 */
- (NSString *)MD5String:(NSString *)str {
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5( cStr, (unsigned int) strlen(cStr), result);
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

/**
 * DES加密
 */
- (NSString *)encryptWithText:(NSString *)sText {
    //kCCEncrypt 加密
    return [self encrypt:sText encryptOrDecrypt:kCCEncrypt];
}

/**
 * DES解密
 */
- (NSString *)decryptWithText:(NSString *)sText {
    //kCCDecrypt 解密
    return [self encrypt:sText encryptOrDecrypt:kCCDecrypt];
}

- (NSString *)encrypt:(NSString *)sText encryptOrDecrypt:(CCOperation)encryptOperation {
    const void *dataIn;
    size_t dataInLength;
    
    if (encryptOperation == kCCDecrypt)//传递过来的是decrypt 解码
    {
        //解码 base64
        //NSData *decryptData = [GTMBase64 decodeData:[sText dataUsingEncoding:NSUTF8StringEncoding]];//转成utf-8并decode
        // NSData from the Base64 encoded str
        NSData *decryptData = [[NSData alloc]
                               initWithBase64EncodedString:sText options:0];
        
        dataInLength = [decryptData length];
        dataIn = [decryptData bytes];
    }
    else  //encrypt
    {
        NSData* encryptData = [sText dataUsingEncoding:NSUTF8StringEncoding];
        dataInLength = [encryptData length];
        dataIn = (const void *)[encryptData bytes];
    }
    
    /*
     DES加密 ：用CCCrypt函数加密一下，然后用base64编码下，传过去
     DES解密 ：把收到的数据根据base64，decode一下，然后再用CCCrypt函数解密，得到原本的数据
     */
    CCCryptorStatus ccStatus;
    uint8_t *dataOut = NULL; //可以理解位type/typedef 的缩写（有效的维护了代码，比如：一个人用int，一个人用long。最好用typedef来定义）
    size_t dataOutAvailable = 0; //size_t  是操作符sizeof返回的结果类型
    size_t dataOutMoved = 0;
    
    dataOutAvailable = (dataInLength + kCCBlockSizeDES) & ~(kCCBlockSizeDES - 1);
    dataOut = malloc( dataOutAvailable * sizeof(uint8_t));
    memset((void *)dataOut, 0x0, dataOutAvailable);//将已开辟内存空间buffer的首 1 个字节的值设为值 0
    
    // NSString *initIv = @"12345678";
    const void *vkey = (const void *) [DESKEY UTF8String];
    // const void *iv = (const void *) [initIv UTF8String];
    
    //CCCrypt函数 加密/解密kCCAlgorithmDES,
    //kCCOptionPKCS7Padding| kCCOptionECBMode,
    ccStatus = CCCrypt(encryptOperation,//  加密/解密
                       kCCAlgorithmDES,//  加密根据哪个标准（des，3des，aes。。。。）
                       kCCOptionPKCS7Padding| kCCOptionECBMode,//  选项分组密码算法(des:对每块分组加一次密  3DES：对每块分组加三个不同的密)
                       vkey,  //密钥    加密和解密的密钥必须一致
                       kCCKeySizeDES,//   DES 密钥的大小（kCCKeySizeDES=8）
                       NULL, //  可选的初始矢量
                       dataIn, // 数据的存储单元
                       dataInLength,// 数据的大小
                       (void *)dataOut,// 用于返回数据
                       dataOutAvailable,
                       &dataOutMoved);
    
    NSString *result = nil;
    
    if (encryptOperation == kCCDecrypt) {//encryptOperation==1  解码
        //得到解密出来的data数据，改变为utf-8的字符串
        result = [[NSString alloc] initWithData:[NSData dataWithBytes:(const void *)dataOut length:(NSUInteger)dataOutMoved] encoding:NSUTF8StringEncoding];
    }else {//encryptOperation==0  （加密过程中，把加好密的数据转成base64的）
        //编码 base64
        NSData *data = [NSData dataWithBytes:(const void *)dataOut length:(NSUInteger)dataOutMoved];
        result = [data base64EncodedStringWithOptions:0];
    }
    
    return result;
}

- (NSString *)intToString:(int)num {
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = kCFNumberFormatterRoundHalfDown;
    formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"ZH"];
    NSString *string = [formatter stringFromNumber:[NSNumber numberWithInt:num]];
        
    return string;
}


@end
