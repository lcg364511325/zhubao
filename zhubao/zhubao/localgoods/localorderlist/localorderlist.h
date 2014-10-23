//
//  localorderlist.h
//  zhubao
//
//  Created by johnson on 14-9-25.
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
#import "ImageCacher.h"
#import "TestViewController.h"
#import "RotateImageView.h"
#import "productApi.h"
#import "MWPhotoBrowser.h"
#import "prodeuctDetail.h"
#import "shopcart.h"

@interface localorderlist : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate,UIApplicationDelegate>
{
    NSMutableArray *stylearray;
    NSMutableArray *texturearray;
    NSMutableArray *inlayarray;
    NSMutableArray *seriearray;
    NSMutableArray *btnarray1;
    NSMutableArray *btnarray2;
    NSMutableArray *btnarray3;
    NSMutableArray *btnarray4;
    NSMutableArray *addobject;
    NSMutableArray *shoppingcartlist;
    
    NSMutableArray *_selections;
    
    RotateImageView *rImageView;
    UIButton* btnBack;
    UIButton *btnstyle;
}

@property (nonatomic, strong) NSMutableArray *photos;
@property (nonatomic, strong) NSMutableArray *thumbs;

@property (retain, nonatomic) IBOutlet UIView *primaryView;

@property (strong, nonatomic) NSArray *mainlist;
@property (strong, nonatomic) NSArray *mainmanlist;
@property (strong, nonatomic) NSArray *netlist;
@property (strong, nonatomic) NSArray *colorlist;
@property (strong, nonatomic) NSArray *texturelist;
@property (weak, nonatomic) IBOutlet UICollectionView *productcollect;
@property (weak, nonatomic) IBOutlet UILabel *countLable;
@property (weak, nonatomic) IBOutlet UIButton *btntexture;
@property (weak, nonatomic) IBOutlet UIButton *btninlay;
@property (weak, nonatomic) IBOutlet UIButton *btnseric;

-(void)reloaddata;

-(void)refleshBuycutData;

-(void)closeAction;

-(void)closesc;


@end
