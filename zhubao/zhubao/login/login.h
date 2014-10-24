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
#import "myApi.h"

@interface login : UIViewController<UITextFieldDelegate>
{
    UIView *hiview;
    UIView *getmoneyview;
}


@property (weak, nonatomic) IBOutlet UITextField *account;

@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UITextField *xymText;

@property (weak, nonatomic) IBOutlet UIButton *submitlogin;
@property (weak, nonatomic) IBOutlet UILabel *tipLable;
@property (weak, nonatomic) IBOutlet UIButton *passwordbtn;
@property (weak, nonatomic) IBOutlet UIImageView *logoshengyu;
@property (weak, nonatomic) IBOutlet UIImageView *loginbgimg;
@property (weak, nonatomic) IBOutlet UITextField *anoText;
@property (weak, nonatomic) IBOutlet UIImageView *anopic;
@property (weak, nonatomic) IBOutlet UILabel *anolable;

- (IBAction)loginAction:(id)sender;

@end
