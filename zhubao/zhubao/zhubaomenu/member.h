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
#import "memberDetailUpdate.h"
#import "updatePassword.h"

@interface member : UIViewController<UIApplicationDelegate>
{
    NSMutableArray *shoppingcartlist;
}

@property (retain, nonatomic) IBOutlet UIView *primaryView;
@property (retain, nonatomic) IBOutlet UIView *primaryShadeView;
@property (retain, nonatomic) IBOutlet UIView *fiftharyView;
@property (retain, nonatomic) IBOutlet UIView *sixthview;
//@property (strong, nonatomic) NSArray *provincelist;
//@property (strong, nonatomic) NSArray *citylist;
//@property (strong, nonatomic) NSArray *Divisionlist;
@property (weak, nonatomic) IBOutlet UIButton *shopcartcount;
@property (weak, nonatomic) IBOutlet UIImageView *logoImage;
@property (weak, nonatomic) IBOutlet UITextField *checkpassword;
@property (weak, nonatomic) IBOutlet UIButton *submit;
@property (weak, nonatomic) IBOutlet UIButton *settingupdate;
@property (weak, nonatomic) IBOutlet UIButton *settinglogout;
@property (weak, nonatomic) IBOutlet UIButton *settingsoftware;
@property (weak, nonatomic) IBOutlet UIButton *passwordsubmit;
@property (weak, nonatomic) IBOutlet UIButton *passwordexit;

- (IBAction)goAction:(id)sender;

-(void)refleshBuycutData;

@end
