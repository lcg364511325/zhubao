//
//  localgoodsmanager.h
//  zhubao
//
//  Created by johnson on 14-10-21.
//  Copyright (c) 2014年 SUNYEARS___FULLUSERNAME. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RotateImageView.h"

@interface localgoodsmanager : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate,UIApplicationDelegate>
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
    UIButton *btnstyle;
    //查询结果
    NSMutableArray *resultlist;
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

@property (nonatomic,assign) id <UIApplicationDelegate> mydelegate;//当前请求过来的对象

-(void)reloaddata;

-(void)refleshBuycutData;

-(void)closeAction;

-(void)closesc;



@end
