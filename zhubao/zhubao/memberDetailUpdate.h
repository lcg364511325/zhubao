//
//  memberDetailUpdate.h
//  zhubao
//
//  Created by johnson on 14-7-31.
//  Copyright (c) 2014年 SUNYEARS___FULLUSERNAME. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "sqlService.h"

@interface memberDetailUpdate : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *selectTableView;
@property (weak, nonatomic) IBOutlet UITextField *provinceText;
@property (weak, nonatomic) IBOutlet UITextField *cityText;
@property (weak, nonatomic) IBOutlet UITextField *divisionText;
@property (weak, nonatomic) IBOutlet UITextField *companyText;
@property (weak, nonatomic) IBOutlet UITextField *cusnameText;
@property (weak, nonatomic) IBOutlet UITextField *mobileText;
@property (weak, nonatomic) IBOutlet UITextField *telText;
@property (weak, nonatomic) IBOutlet UITextField *addressText;


@property (strong,nonatomic) NSArray *provincelist;
@property (strong,nonatomic) NSArray *citylist;
@property (strong,nonatomic) NSArray *Divisionlist;

@property (nonatomic,assign) id <UIApplicationDelegate> mydelegate;

@end
