//
//  diploma.h
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
#import "member.h"

@interface diploma : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (retain, nonatomic) IBOutlet UIView *primaryView;
@property (retain, nonatomic) IBOutlet UIView *secondaryView;
@property (retain, nonatomic) IBOutlet UIView *primaryShadeView;
@property (retain, nonatomic) IBOutlet UIView *thirdView;
@property (weak, nonatomic) IBOutlet UITableView *DiplomaSelect;
@property (weak, nonatomic) IBOutlet UITextField *selecttext;
@property (strong, nonatomic) NSArray *list;


- (IBAction)goAction:(id)sender;
- (IBAction)closeAction:(id)sender;

@end
