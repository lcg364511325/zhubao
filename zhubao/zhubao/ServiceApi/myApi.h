//
//  myApi.h
//  zhubao
//
//  Created by moko on 14-6-4.
//  Copyright (c) 2014年 SUNYEARS___FULLUSERNAME. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"
#import "DataService.h"
#import "Commons.h"
#import "sqlService.h"
#import "Tool.h"

@interface myApi : NSObject

//获取当前公司的信息，并且更新
-(NSString *)getMyInfo;

@end
