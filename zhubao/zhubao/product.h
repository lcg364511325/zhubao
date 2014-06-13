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
#import "sqlService.h"
#import "FVImageSequenceDemoViewController.h"
#import "sqlService.h"
#import "ProductCell.h"
#import "ImageCacher.h"
#import "TestViewController.h"
#import "productApi.h"
#import "shoppingcartCell.h"

@interface product : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate>
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
}

@property (retain, nonatomic) IBOutlet UIView *primaryView;
@property (retain, nonatomic) IBOutlet UIView *secondaryView;
@property (retain, nonatomic) IBOutlet UIView *primaryShadeView;
@property (retain, nonatomic) IBOutlet UIView *thridaryView;
@property (retain, nonatomic) IBOutlet UIView *secondShadeView;
@property (retain, nonatomic) IBOutlet UIView *fourthView;
@property (weak, nonatomic) IBOutlet UITableView *mianselect;
@property (weak, nonatomic) IBOutlet UITableView *netselect;
@property (weak, nonatomic) IBOutlet UITableView *colorselect;
@property (weak, nonatomic) IBOutlet UITableView *textureselect;
@property (strong, nonatomic) NSArray *mainlist;
@property (strong, nonatomic) NSArray *netlist;
@property (strong, nonatomic) NSArray *colorlist;
@property (strong, nonatomic) NSArray *texturelist;
@property (weak, nonatomic) IBOutlet UITextField *maintext;
@property (weak, nonatomic) IBOutlet UITextField *nettext;
@property (weak, nonatomic) IBOutlet UITextField *colortext;
@property (weak, nonatomic) IBOutlet UITextField *texturetext;
@property (weak, nonatomic) IBOutlet UITextField *sizeText;
@property (weak, nonatomic) IBOutlet UITextField *fontText;
@property (weak, nonatomic) IBOutlet UITextField *numberText;
@property (weak, nonatomic) IBOutlet UILabel *modellable;
@property (weak, nonatomic) IBOutlet UILabel *weightlable;
@property (weak, nonatomic) IBOutlet UILabel *mainlable;
@property (weak, nonatomic) IBOutlet UILabel *fitNolable;
@property (weak, nonatomic) IBOutlet UILabel *fitweightlable;
@property (weak, nonatomic) IBOutlet UITextField *sizetext;
@property (weak, nonatomic) IBOutlet UITextField *fonttext;
@property (weak, nonatomic) IBOutlet UITextField *numbertext;
@property (weak, nonatomic) IBOutlet UILabel *title1lable;
@property (weak, nonatomic) IBOutlet UILabel *pricelable;
@property (weak, nonatomic) IBOutlet UIImageView *productimageview;
@property (weak, nonatomic) IBOutlet UICollectionView *productcollect;
@property (weak, nonatomic) IBOutlet UILabel *countLable;
@property (weak, nonatomic) IBOutlet UIButton *btnstyle;
@property (weak, nonatomic) IBOutlet UIButton *btntexture;
@property (weak, nonatomic) IBOutlet UIButton *btninlay;
@property (weak, nonatomic) IBOutlet UIButton *btnseric;
@property (weak, nonatomic) IBOutlet UITableView *goodsview;


- (IBAction)closeAction:(id)sender;
- (IBAction)goAction1:(id)sender;
- (IBAction)closeAction1:(id)sender;
- (IBAction)threeddAction:(id)sender;

@end
