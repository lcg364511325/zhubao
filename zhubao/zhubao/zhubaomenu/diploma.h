//
//  diploma.h
//  zhubao
//
//  Created by johnson on 14-5-29.
//  Copyright (c) 2014年 SUNYEARS___FULLUSERNAME. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Index.h"
#import "productEntity.h"
#import "NakedDiamond.h"
#import "ustomtailor.h"
#import "member.h"
#import "shopcart.h"

@interface diploma : UIViewController<UITableViewDelegate, UITableViewDataSource,UIApplicationDelegate>
{
    NSMutableArray *shoppingcartlist;
}

@property (retain, nonatomic) IBOutlet UIView *primaryView;
@property (retain, nonatomic) IBOutlet UIView *thirdView;
@property (retain, nonatomic) IBOutlet UIView *fourthview;
@property (weak, nonatomic) IBOutlet UITableView *DiplomaSelect;
@property (weak, nonatomic) IBOutlet UITextField *selecttext;
@property (strong, nonatomic) NSArray *list;
@property (weak, nonatomic) IBOutlet UITextField *dipomaNoText;
@property (weak, nonatomic) IBOutlet UITextField *diamondWeightText;
@property (weak, nonatomic) IBOutlet UILabel *dipomaIndex;
@property (weak, nonatomic) IBOutlet UILabel *selectText;
@property (weak, nonatomic) IBOutlet UIButton *shopcartcount;
@property (weak, nonatomic) IBOutlet UIImageView *logoImage;
@property (weak, nonatomic) IBOutlet UITextField *checkpassword;
@property (weak, nonatomic) IBOutlet UIButton *settingupdate;
@property (weak, nonatomic) IBOutlet UIButton *settinglogout;
@property (weak, nonatomic) IBOutlet UIButton *settingsoftware;


- (IBAction)goAction:(id)sender;

-(void)closesc;

@end
