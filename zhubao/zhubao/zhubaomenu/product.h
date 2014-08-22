//
//  product.h
//  zhubao
//
//  Created by johnson on 14-5-28.
//  Copyright (c) 2014年 SUNYEARS___FULLUSERNAME. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "Index.h"
#import "NakedDiamond.h"
#import "ustomtailor.h"
#import "diploma.h"
#import "member.h"
#import "sqlService.h"
#import "FVImageSequenceDemoViewController.h"
#import "sqlService.h"
#import "ProductCell.h"
#import "ImageCacher.h"
#import "TestViewController.h"
#import "RotateImageView.h"
#import "productApi.h"
#import "MWPhotoBrowser.h"
#import "prodeuctDetail.h"
#import "shopcart.h"

@interface product : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate,UIApplicationDelegate>
{
    NSMutableArray *stylearray;
    NSMutableArray *texturearray;
    NSMutableArray *inlayarray;
    NSMutableArray *seriearray;
    NSMutableArray *btnarray1;
    NSMutableArray *btnarray2;
    NSMutableArray *btnarray3;
    NSMutableArray *btnarray4;
    NSMutableArray *shoppingcartlist;
    
    NSMutableArray *_selections;
    
    RotateImageView *rImageView;
    UIButton* btnBack;
}

@property (nonatomic, strong) NSMutableArray *photos;
@property (nonatomic, strong) NSMutableArray *thumbs;

@property (retain, nonatomic) IBOutlet UIView *primaryView;
@property (retain, nonatomic) IBOutlet UIView *primaryShadeView;
@property (retain, nonatomic) IBOutlet UIView *secondShadeView;
@property (retain, nonatomic) IBOutlet UIView *fourthView;
@property (retain, nonatomic) IBOutlet UIView *fivethview;

@property (strong, nonatomic) NSArray *mainlist;
@property (strong, nonatomic) NSArray *mainmanlist;
@property (strong, nonatomic) NSArray *netlist;
@property (strong, nonatomic) NSArray *colorlist;
@property (strong, nonatomic) NSArray *texturelist;
@property (weak, nonatomic) IBOutlet UICollectionView *productcollect;
@property (weak, nonatomic) IBOutlet UILabel *countLable;
@property (weak, nonatomic) IBOutlet UIButton *btnstyle;
@property (weak, nonatomic) IBOutlet UIButton *btntexture;
@property (weak, nonatomic) IBOutlet UIButton *btninlay;
@property (weak, nonatomic) IBOutlet UIButton *btnseric;
@property (weak, nonatomic) IBOutlet UIButton *shopcartcount;
@property (weak, nonatomic) IBOutlet UIImageView *logoImage;
@property (weak, nonatomic) IBOutlet UITextField *checkpassword;

@property (weak, nonatomic) IBOutlet UIButton *settingupdate;
@property (weak, nonatomic) IBOutlet UIButton *settinglogout;
@property (weak, nonatomic) IBOutlet UIButton *settingsoftware;

-(void)refleshBuycutData;

@end
