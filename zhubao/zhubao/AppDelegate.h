//
//  AppDelegate.h
//  zhubao
//
//  Created by johnson on 14-5-27.
//  Copyright (c) 2014年 SUNYEARS___FULLUSERNAME. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Index.h"
#import "login.h"
#import "sqlService.h"
#import "FileHelpers.h"
#import "LoginEntity.h"
#import "ASINetworkQueue.h"
#import "ceshi.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property(retain , nonatomic) LoginEntity * entityl;//保存登录的用户信息

@property(retain , nonatomic) ASINetworkQueue *queue;//下载的队列

//是否接着开始下载
-(void)beginRequest:(NSString *)fileurl fileName:(NSString *)fileName version:(NSString *)version;

@end
