//
//  shopcart.h
//  zhubao
//
//  Created by johnson on 14-7-31.
//  Copyright (c) 2014年 SUNYEARS___FULLUSERNAME. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "shoppingcartCell.h"
#import "buyproduct.h"
#import "FileHelpers.h"
#import "ImageCacher.h"
#import "sqlService.h"
#import "AppDelegate.h"
#import "Index.h"
#import "CustomIOS7AlertView.h"

@interface shopcart : UIViewController<UIApplicationDelegate,CustomIOS7AlertViewDelegate>
{
    NSMutableArray *shoppingcartlist;
    UITextField *goodsno;
    NSString *goodnumber;
    UIView *demoView;
    UIView *hiview;
    buyproduct *selectgoods;
}

@property (weak, nonatomic) IBOutlet UITableView *goodsview;

@property (nonatomic,assign) id <UIApplicationDelegate> mydelegate;

-(void)reloadshopcart;

@end
