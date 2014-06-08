//
//  customerApi.h
//  zhubao
//
//  Created by moko on 14-6-4.
//  Copyright (c) 2014年 SUNYEARS___FULLUSERNAME. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "customer.h"
#import "AppDelegate.h"
#import "DataService.h"
#import "Commons.h"
#import "getNowTime.h"
#import "sqlService.h"

@interface customerApi : NSObject

//更新当前用户的基本信息
-(customer*)updateCustomer:(customer *)entity;

//更新当前用户的密码
-(customer*)updateCustomerPassword:(customer *)entity;

@end
