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

@interface NakedDiamond : UIViewController
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
}

@property (retain, nonatomic) IBOutlet UIView *primaryView;
@property (retain, nonatomic) IBOutlet UIView *secondaryView;
@property (retain, nonatomic) IBOutlet UIView *primaryShadeView;
@property (retain, nonatomic) IBOutlet UIView *thridaryView;
@property (retain, nonatomic) IBOutlet UIView *secondShadeView;
@property (retain, nonatomic) IBOutlet UIView *fourtharyView;
@property (retain, nonatomic) IBOutlet UIView *thirdShadeView;
@property (retain, nonatomic) IBOutlet UIView *fivetharyView;
@property (weak, nonatomic) IBOutlet UITextField *weightmin;
@property (weak, nonatomic) IBOutlet UITextField *weightmax;
@property (weak, nonatomic) IBOutlet UITextField *pricemin;
@property (weak, nonatomic) IBOutlet UITextField *pricemax;
@property (weak, nonatomic) IBOutlet UITextField *DiamondNo;
@property (weak, nonatomic) IBOutlet UITableView *Nakeddisplay;
@property (weak, nonatomic) IBOutlet UIImageView *productimageview;
@property (weak, nonatomic) IBOutlet UILabel *titleLable;
@property (weak, nonatomic) IBOutlet UILabel *modelLable;
@property (weak, nonatomic) IBOutlet UILabel *productNoLable;
@property (weak, nonatomic) IBOutlet UILabel *weightLable;
@property (weak, nonatomic) IBOutlet UILabel *colorLable;
@property (weak, nonatomic) IBOutlet UILabel *netLable;
@property (weak, nonatomic) IBOutlet UILabel *cutLable;
@property (weak, nonatomic) IBOutlet UILabel *chasingLable;
@property (weak, nonatomic) IBOutlet UILabel *symmetryLable;
@property (weak, nonatomic) IBOutlet UILabel *depthLable;
@property (weak, nonatomic) IBOutlet UILabel *tableLable;
@property (weak, nonatomic) IBOutlet UILabel *sizeLable;
@property (weak, nonatomic) IBOutlet UILabel *fluorescenceLable;
@property (weak, nonatomic) IBOutlet UILabel *diplomaLable;
@property (weak, nonatomic) IBOutlet UILabel *priceLable;
@property (weak, nonatomic) IBOutlet UIButton *modelbtn;
@property (weak, nonatomic) IBOutlet UIButton *colorbtn;
@property (weak, nonatomic) IBOutlet UIButton *netbtn;


- (IBAction)goAction:(id)sender;
- (IBAction)closeAction:(id)sender;
- (IBAction)goAction1:(id)sender;
- (IBAction)closeAction1:(id)sender;
- (IBAction)goAction2:(id)sender;
- (IBAction)closeAction2:(id)sender;

@end
