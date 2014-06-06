//
//  getNowTime.m
//  zhubao
//
//  Created by moko on 14-6-4.
//  Copyright (c) 2014年 SUNYEARS___FULLUSERNAME. All rights reserved.
//

#import "getNowTime.h"

@implementation getNowTime

//Nowt当前时间戳在线获取
-(NSString *)nowTime
{
    NSString * surl = [NSString stringWithFormat:@"/app/NowT.php"];

    NSString * URL = [NSString stringWithFormat:@"%@%@",domainser,surl];
    
    NSString * dict = [DataService GetDataServiceToNsstring:URL];
    
    return dict;
}

@end
