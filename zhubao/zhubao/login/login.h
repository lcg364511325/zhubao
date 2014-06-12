//
//  login.h
//  zhubao
//
//  Created by moko on 14-6-4.
//  Copyright (c) 2014年 SUNYEARS___FULLUSERNAME. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Index.h"
#import "LoginApi.h"
#import "AutoGetData.h"
#import "FVImageSequenceDemoViewController.h"
#import "sqlService.h"
#import "customer.h"

@interface login : UIViewController




@property (weak, nonatomic) IBOutlet UITextField *account;

@property (weak, nonatomic) IBOutlet UITextField *password;

@property (weak, nonatomic) IBOutlet UIButton *submitlogin;
@property (weak, nonatomic) IBOutlet UILabel *tipLable;

- (IBAction)loginAction:(id)sender;

@end
