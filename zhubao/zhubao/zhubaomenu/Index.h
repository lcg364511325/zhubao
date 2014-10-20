//
//  Index.h
//  zhubao
//
//  Created by johnson on 14-5-27.
//  Copyright (c) 2014年 SUNYEARS___FULLUSERNAME. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "myindex.h"
#import "product.h"
#import "NakedDiamond.h"
#import "ustomtailor.h"
#import "diploma.h"
#import "member.h"
#import "sqlService.h"
#import "AppDelegate.h"
#import "login.h"
#import "orderApi.h"
#import "AutoGetData.h"
#import "UIViewController+CWPopup.h"
#import "shopcart.h"
#import "test.h"
#import <QuartzCore/QuartzCore.h>
#import "localorderlist.h"
#import "LoginApi.h"

@interface Index : UIViewController<UIWebViewDelegate,UIGestureRecognizerDelegate,UIScrollViewDelegate,UIApplicationDelegate>
{
    NSMutableArray *shoppingcartlist;
    UIView *moveView;
    
    UIViewController *currentViewController;
    NSString *url;
    NSInteger isverson;
}

@property (retain, nonatomic) IBOutlet UIView *primaryView;
@property (retain, nonatomic) IBOutlet UIView *primaryShadeView;
@property (retain, nonatomic) IBOutlet UIView *thridView;
@property (retain, nonatomic) IBOutlet UIView *fourthView;
@property (retain, nonatomic) IBOutlet UIView *fivethview;
@property (weak, nonatomic) IBOutlet UIButton *shopcartcountButton;
@property (weak, nonatomic) IBOutlet UIImageView *logoImage;
@property (weak, nonatomic) IBOutlet UITextField *checkpassword;
@property (weak, nonatomic) IBOutlet UIButton *settingupdate;
@property (weak, nonatomic) IBOutlet UIButton *settinglogout;
@property (weak, nonatomic) IBOutlet UIButton *settingsoftware;
@property (weak, nonatomic) IBOutlet UIImageView *selectmenu;

- (IBAction)goAction:(id)sender;

-(void)refleshBuycutData;

-(void)closesc;

// 更新ui
-(void)updateIndexUI;

@end
