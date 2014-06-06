//
//  LoginApi.h
//  zhubao
//
//  Created by moko on 14-6-2.
//  Copyright (c) 2014年 SUNYEARS___FULLUSERNAME. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LoginEntity.h"
#import "AppDelegate.h"
#import "DataService.h"
#import "getNowTime.h"
#import "Commons.h"

@interface LoginApi : NSObject

-(LoginEntity*)login:(NSString *)username password:(NSString *)password verlity:(NSString*)verlity;

 
@end
