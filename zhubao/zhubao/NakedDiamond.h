//
//  NakedDiamond.h
//  zhubao
//
//  Created by johnson on 14-5-28.
//  Copyright (c) 2014年 SUNYEARS___FULLUSERNAME. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Index.h"
#import "product.h"
#import "ustomtailor.h"
#import "diploma.h"
#import "member.h"
#import "NoticeReportCell.h"
#import "sqlService.h"
#import "shoppingcartCell.h"
#import "NakedDiamondDetail.h"

@interface NakedDiamond : UIViewController<UIApplicationDelegate>
{
    NSMutableArray *shapearray;
    NSMutableArray *colorarray;
    NSMutableArray *netarray;
    NSMutableArray *cutarray;
    NSMutableArray *chasingarray;
    NSMutableArray *symmetryarray;
    NSMutableArray *fluorescencearray;
    NSMutableArray *diplomaarray;
    NSMutableArray * productlist;
    NSMutableArray * btnarray1;
    NSMutableArray * btnarray2;
    NSMutableArray * btnarray3;
    NSMutableArray *shoppingcartlist;
}

@property (retain, nonatomic) IBOutlet UIView *primaryView;
@property (retain, nonatomic) IBOutlet UIView *secondaryView;
@property (retain, nonatomic) IBOutlet UIView *primaryShadeView;
@property (retain, nonatomic) IBOutlet UIView *secondShadeView;
@property (retain, nonatomic) IBOutlet UIView *fourtharyView;
@property (retain, nonatomic) IBOutlet UIView *thirdShadeView;
@property (retain, nonatomic) IBOutlet UIView *fivetharyView;
@property (retain, nonatomic) IBOutlet UIView *sixview;
@property (weak, nonatomic) IBOutlet UITextField *weightmin;
@property (weak, nonatomic) IBOutlet UITextField *weightmax;
@property (weak, nonatomic) IBOutlet UITextField *pricemin;
@property (weak, nonatomic) IBOutlet UITextField *pricemax;
@property (weak, nonatomic) IBOutlet UITextField *DiamondNo;
@property (weak, nonatomic) IBOutlet UITableView *Nakeddisplay;
@property (weak, nonatomic) IBOutlet UIButton *modelbtn;
@property (weak, nonatomic) IBOutlet UIButton *colorbtn;
@property (weak, nonatomic) IBOutlet UIButton *netbtn;
@property (weak, nonatomic) IBOutlet UITableView *goodsview;
@property (weak, nonatomic) IBOutlet UIButton *shopcartcount;
@property (weak, nonatomic) IBOutlet UIImageView *logoImage;
@property (weak, nonatomic) IBOutlet UITextField *checkpassword;
@property (weak, nonatomic) IBOutlet UILabel *nakediacount;
@property (weak, nonatomic) IBOutlet UIButton *settingupdate;
@property (weak, nonatomic) IBOutlet UIButton *settinglogout;
@property (weak, nonatomic) IBOutlet UIButton *settingsoftware;

- (IBAction)goAction:(id)sender;
- (IBAction)closeAction:(id)sender;
- (IBAction)goAction1:(id)sender;
- (IBAction)closeAction1:(id)sender;
- (IBAction)goAction2:(id)sender;
- (IBAction)closeAction2:(id)sender;

-(void)refleshBuycutData;

@end
