//
//  Index.h
//  zhubao
//
//  Created by johnson on 14-5-27.
//  Copyright (c) 2014年 SUNYEARS___FULLUSERNAME. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "product.h"
#import "NakedDiamond.h"
#import "ustomtailor.h"
#import "diploma.h"
#import "member.h"
#import "test.h"
#import "sqlService.h"
#import "shoppingcartCell.h"
#import "AppDelegate.h"
#import "login.h"
#import "orderApi.h"
#import "AutoGetData.h"

@interface Index : UIViewController
{
    NSMutableArray *shoppingcartlist;
}

@property (retain, nonatomic) IBOutlet UIView *primaryView;
@property (retain, nonatomic) IBOutlet UIView *secondaryView;
@property (retain, nonatomic) IBOutlet UIView *primaryShadeView;
@property (retain, nonatomic) IBOutlet UIView *thridView;
@property (retain, nonatomic) IBOutlet UIView *fourthView;
@property (weak, nonatomic) IBOutlet UITableView *goodsview;
@property (weak, nonatomic) IBOutlet UIButton *shopcartcountButton;
@property (weak, nonatomic) IBOutlet UIImageView *logoImage;
@property (weak, nonatomic) IBOutlet UIImageView *biglogo;
@property (weak, nonatomic) IBOutlet UIWebView *aboutus;

- (IBAction)goAction:(id)sender;
- (IBAction)closeAction:(id)sender;

@end
