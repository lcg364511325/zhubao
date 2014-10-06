//
//  proclass.h
//  zhubao
//
//  Created by moko on 14-9-30.
//  Copyright (c) 2014年 SUNYEARS___FULLUSERNAME. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "proclassEntity.h"
#import "proclasslistCell.h"
#import "sqlService.h"

@interface proclass : UIViewController<UIApplicationDelegate>
{
    NSArray *list;
    proclassEntity *selectedentity;
    UIView *demoView;
    UIView *hiview;
    NSArray *btnlist;
    NSString *statevalue;
    UIView *getmoneyview;
    UITextField *moneyText;
}

@property (nonatomic,assign) id <UIApplicationDelegate> mydelegate;
@property (weak, nonatomic) IBOutlet UITableView *orderTView;

-(void)closed;

-(IBAction)closeaddlocalg:(id)sender;

@end
