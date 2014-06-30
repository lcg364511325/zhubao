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
#import "ASIFormDataRequest.h"
#import "ceshi.h"
#import "myinfo.h"
#import "YLProgressBar.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property(retain , nonatomic) LoginEntity * entityl;//保存登录的用户信息

@property(retain , nonatomic) myinfo * myinfol;//保存当前公司的信息

@property(retain , nonatomic) ASINetworkQueue *queue;//下载的队列

@property (strong, nonatomic) UIAlertView *alter;//弹出提示框

@property (nonatomic, strong) YLProgressBar *progressBarRoundedFat;

//是否接着开始下载
-(void)beginRequest:(NSString *)fileurl fileName:(NSString *)fileName version:(NSString *)version;

//提交订单  CPInfo商品数组  DZInfo高级定制
-(BOOL*)submitOrder:(NSString *)CPInfo DZInfo:(NSString *)DZInfo uploadpath:(NSMutableArray *)uploadpath;

//进度条提示
-(void)showProgressBar:(UIView *)view;
//停止进度条
-(void)stopProgressBar;
//取消定时器
-(void)stopTimer;

@end
