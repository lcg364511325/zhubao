//
//  member.h
//  zhubao
//
//  Created by johnson on 14-5-29.
//  Copyright (c) 2014年 SUNYEARS___FULLUSERNAME. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Index.h"
#import "product.h"
#import "NakedDiamond.h"
#import "ustomtailor.h"
#import "diploma.h"
#import "sqlService.h"
#import "getNowTime.h"

@interface member : UIViewController
{
    NSMutableArray *shoppingcartlist;
}

@property (retain, nonatomic) IBOutlet UIView *primaryView;
@property (retain, nonatomic) IBOutlet UIView *secondaryView;
@property (retain, nonatomic) IBOutlet UIView *primaryShadeView;
@property (retain, nonatomic) IBOutlet UIView *thridaryView;
@property (retain, nonatomic) IBOutlet UIView *fourtharyView;
@property (retain, nonatomic) IBOutlet UIView *fiftharyView;
@property (retain, nonatomic) IBOutlet UIView *sixthview;
@property (weak, nonatomic) IBOutlet UITableView *selectTableView;
//@property (strong, nonatomic) NSArray *provincelist;
//@property (strong, nonatomic) NSArray *citylist;
//@property (strong, nonatomic) NSArray *Divisionlist;
@property (strong,nonatomic) NSArray *provincelist;
@property (strong,nonatomic) NSArray *citylist;
@property (strong,nonatomic) NSArray *Divisionlist;
@property (weak, nonatomic) IBOutlet UITextField *provinceText;
@property (weak, nonatomic) IBOutlet UITextField *cityText;
@property (weak, nonatomic) IBOutlet UITextField *divisionText;
@property (weak, nonatomic) IBOutlet UITextField *companyText;
@property (weak, nonatomic) IBOutlet UITextField *cusnameText;
@property (weak, nonatomic) IBOutlet UITextField *mobileText;
@property (weak, nonatomic) IBOutlet UITextField *telText;
@property (weak, nonatomic) IBOutlet UITextField *addressText;
@property (weak, nonatomic) IBOutlet UITextField *oldpassword;
@property (weak, nonatomic) IBOutlet UITextField *newpassword;
@property (weak, nonatomic) IBOutlet UITextField *affirmpassword;
@property (weak, nonatomic) IBOutlet UITableView *goodsview;
@property (weak, nonatomic) IBOutlet UIButton *shopcartcount;
@property (weak, nonatomic) IBOutlet UIImageView *logoImage;
@property (weak, nonatomic) IBOutlet UITextField *checkpassword;
@property (weak, nonatomic) IBOutlet UIButton *submit;
@property (weak, nonatomic) IBOutlet UIButton *settingupdate;
@property (weak, nonatomic) IBOutlet UIButton *settinglogout;
@property (weak, nonatomic) IBOutlet UIButton *settingsoftware;

- (IBAction)goAction:(id)sender;
- (IBAction)closeAction:(id)sender;

-(void)refleshBuycutData;

@end
