//
//  menuindex.h
//  zhubao
//
//  Created by moko on 14-9-22.
//  Copyright (c) 2014年 SUNYEARS___FULLUSERNAME. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "sqlService.h"
#import "AppDelegate.h"
#import "orderApi.h"
#import "AutoGetData.h"
#import "UIViewController+CWPopup.h"
#import <QuartzCore/QuartzCore.h>

@interface menuindex : UIViewController<UIWebViewDelegate,UIGestureRecognizerDelegate,UIScrollViewDelegate,UIApplicationDelegate>
{
 
}

@property (retain, nonatomic) IBOutlet UIView *primaryView;
@property (retain, nonatomic) IBOutlet UIView *primaryShadeView;
@property (retain, nonatomic) IBOutlet UIView *fourthView;
@property (weak, nonatomic) IBOutlet UIButton *biglogo;
@property (weak, nonatomic) IBOutlet UIWebView *aboutus;

-(IBAction)openaboutus:(id)sender;

@end
