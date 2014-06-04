//
//  common.m
//  dzqz_6
//
//  Created by xing on 13-10-26.
//  Copyright (c) 2013年 moko. All rights reserved.
//

#import "Commons.h"

@implementation Commons

//设备唯一码 每次安装时都将重新生成
-(NSString*) UUID {
    CFUUIDRef puuid = CFUUIDCreate( nil );
    CFStringRef uuidString = CFUUIDCreateString( nil, puuid );
    NSString * result = (NSString *)CFBridgingRelease(CFStringCreateCopy(NULL, uuidString));
    CFRelease(puuid);
    CFRelease(uuidString);
    
    return result;
}
//MD5加密
+ (NSString *)md5:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, strlen(cStr), result); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

//判断返回数据状态
-(BOOL) IsSuccess:(NSString *) result{
    //NSLog(@"ret:%@",result);
    
//    NSDictionary * dictResult = [result objectFromJSONStringWithParseOptions:JKParseOptionLooseUnicode];
//    
//    NSString * ret = [dictResult objectForKey:@"result"] ;
//    
//    if ([ret intValue]  == 0 ) {
//        return false;
//    }
//    else
//    {
//        return true;
//    }
    return true;
}

@end
