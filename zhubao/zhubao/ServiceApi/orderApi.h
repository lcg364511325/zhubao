//
//  orderApi.h
//  zhubao
//
//  Created by moko on 14-6-4.
//  Copyright (c) 2014年 SUNYEARS___FULLUSERNAME. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "buyproduct.h"
#import "AppDelegate.h"
#import "DataService.h"
#import "Commons.h"
#import "getNowTime.h"
#import "sqlService.h"
#import "ASIHTTPRequest.h"
#import "ASINetworkQueue.h"
#import "ASIFormDataRequest.h"

@interface orderApi : NSObject

//提交订单  CPInfo商品数组  DZInfo高级定制
-(BOOL*)submitOrder:(NSString *)CPInfo DZInfo:(NSString *)DZInfo uploadpath:(NSMutableArray *)uploadpath;

@end
