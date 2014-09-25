//
//  localorder.h
//  zhubao
//
//  Created by johnson on 14-9-23.
//  Copyright (c) 2014年 SUNYEARS___FULLUSERNAME. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "orderbill.h"

@interface localorder : UIViewController<UIApplicationDelegate>
{
    NSArray *list;
    orderbill *selectedentity;
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

@end
