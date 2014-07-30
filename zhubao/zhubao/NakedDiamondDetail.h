//
//  NakedDiamondDetail.h
//  zhubao
//
//  Created by johnson on 14-7-30.
//  Copyright (c) 2014年 SUNYEARS___FULLUSERNAME. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "sqlService.h"

@interface NakedDiamondDetail : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *productimageview;
@property (weak, nonatomic) IBOutlet UILabel *titleLable;
@property (weak, nonatomic) IBOutlet UILabel *modelLable;
@property (weak, nonatomic) IBOutlet UILabel *productNoLable;
@property (weak, nonatomic) IBOutlet UILabel *weightLable;
@property (weak, nonatomic) IBOutlet UILabel *colorLable;
@property (weak, nonatomic) IBOutlet UILabel *netLable;
@property (weak, nonatomic) IBOutlet UILabel *cutLable;
@property (weak, nonatomic) IBOutlet UILabel *chasingLable;
@property (weak, nonatomic) IBOutlet UILabel *symmetryLable;
@property (weak, nonatomic) IBOutlet UILabel *depthLable;
@property (weak, nonatomic) IBOutlet UILabel *tableLable;
@property (weak, nonatomic) IBOutlet UILabel *sizeLable;
@property (weak, nonatomic) IBOutlet UILabel *fluorescenceLable;
@property (weak, nonatomic) IBOutlet UILabel *diplomaLable;
@property (weak, nonatomic) IBOutlet UILabel *priceLable;

@property(retain , nonatomic) NSString * naid;//裸钻id

@property (nonatomic,assign) id <UIApplicationDelegate> mydelegate;//当前请求过来的对象

@end
