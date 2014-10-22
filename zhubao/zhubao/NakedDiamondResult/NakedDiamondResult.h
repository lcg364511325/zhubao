//
//  NakedDiamondResult.h
//  zhubao
//
//  Created by johnson on 14-10-20.
//  Copyright (c) 2014年 SUNYEARS___FULLUSERNAME. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NakedDiamondResult : UIViewController<UIApplicationDelegate>
{
    NSMutableArray * productlist;
    NSMutableArray *shoppingcartlist;
}
@property (nonatomic,assign) id <UIApplicationDelegate> mydelegate;//当前请求过来的对象

@property (weak, nonatomic) IBOutlet UILabel *nakediacount;

@property(retain , nonatomic) NSString * shape;
@property(retain , nonatomic) NSString * weight;
@property(retain , nonatomic) NSString * price;
@property(retain , nonatomic) NSString * color;
@property(retain , nonatomic) NSString * net;
@property(retain , nonatomic) NSString * cut;
@property(retain , nonatomic) NSString * chasing;
@property(retain , nonatomic) NSString * symmetry;
@property(retain , nonatomic) NSString * fluorescence;
@property(retain , nonatomic) NSString * diploma;
@property(retain , nonatomic) NSString * number;

- (void)closeAction;

-(void)refleshBuycutData;


@end
