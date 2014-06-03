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

@interface NakedDiamond : UIViewController

@property (retain, nonatomic) IBOutlet UIView *primaryView;
@property (retain, nonatomic) IBOutlet UIView *secondaryView;
@property (retain, nonatomic) IBOutlet UIView *primaryShadeView;
@property (retain, nonatomic) IBOutlet UIView *thridaryView;
@property (retain, nonatomic) IBOutlet UIView *secondShadeView;
@property (retain, nonatomic) IBOutlet UIView *fourtharyView;
@property (retain, nonatomic) IBOutlet UIView *thirdShadeView;

- (IBAction)goAction:(id)sender;
- (IBAction)closeAction:(id)sender;
- (IBAction)goAction1:(id)sender;
- (IBAction)closeAction1:(id)sender;
- (IBAction)goAction2:(id)sender;
- (IBAction)closeAction2:(id)sender;

@end
