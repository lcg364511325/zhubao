//
//  localorderdetail.h
//  zhubao
//
//  Created by johnson on 14-9-23.
//  Copyright (c) 2014年 SUNYEARS___FULLUSERNAME. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "orderbill.h"

@interface localorderdetail : UIViewController
{
    NSArray *list;
}

@property (nonatomic,assign) id <UIApplicationDelegate> mydelegate;
@property(retain , nonatomic) orderbill * order;//订单
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *mobileLabel;
@property (weak, nonatomic) IBOutlet UILabel *telLabel;
@property (weak, nonatomic) IBOutlet UILabel *addrLabel;
@property (weak, nonatomic) IBOutlet UILabel *comtentsLabel;
@property (weak, nonatomic) IBOutlet UILabel *ordernoLabel;
@property (weak, nonatomic) IBOutlet UILabel *createtimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *allmoneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *getpriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *stateLbel;
@property (weak, nonatomic) IBOutlet UITableView *dTView;

@end
