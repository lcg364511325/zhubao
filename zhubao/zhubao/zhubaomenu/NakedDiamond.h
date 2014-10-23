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
#import "shopcart.h"

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
    NSMutableArray * btnarray1;
    NSMutableArray * btnarray2;
    NSMutableArray * btnarray3;
    NSMutableArray * btnarray4;
    NSMutableArray *shoppingcartlist;
}

@property (retain, nonatomic) IBOutlet UIView *primaryView;

@property (weak, nonatomic) IBOutlet UITextField *weightmin;
@property (weak, nonatomic) IBOutlet UITextField *weightmax;
@property (weak, nonatomic) IBOutlet UITextField *pricemin;
@property (weak, nonatomic) IBOutlet UITextField *pricemax;
@property (weak, nonatomic) IBOutlet UITextField *DiamondNo;
@property (weak, nonatomic) IBOutlet UIButton *modelbtn;
@property (weak, nonatomic) IBOutlet UIButton *colorbtn;
@property (weak, nonatomic) IBOutlet UIButton *netbtn;


- (IBAction)goAction:(id)sender;

-(void)refleshBuycutData;
-(void)closesc;

@end
