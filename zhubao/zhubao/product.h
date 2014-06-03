//
//  product.h
//  zhubao
//
//  Created by johnson on 14-5-28.
//  Copyright (c) 2014年 SUNYEARS___FULLUSERNAME. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Index.h"
#import "NakedDiamond.h"
#import "ustomtailor.h"
#import "diploma.h"
#import "member.h"

@interface product : UIViewController

@property (retain, nonatomic) IBOutlet UIView *primaryView;
@property (retain, nonatomic) IBOutlet UIView *secondaryView;
@property (retain, nonatomic) IBOutlet UIView *primaryShadeView;
@property (retain, nonatomic) IBOutlet UIView *thridaryView;
@property (retain, nonatomic) IBOutlet UIView *secondShadeView;

- (IBAction)goAction:(id)sender;
- (IBAction)closeAction:(id)sender;
- (IBAction)goAction1:(id)sender;
- (IBAction)closeAction1:(id)sender;

@end
