//
//  LocalGoodslist.h
//  zhubao
//
//  Created by johnson on 14-7-16.
//  Copyright (c) 2014年 SUNYEARS___FULLUSERNAME. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "sqlService.h"
#import "ProductCell.h"

@interface LocalGoodslist : UIViewController
{
    NSMutableArray *btnarray1;
    NSMutableArray *btnarray2;
    NSMutableArray *btnarray3;
    NSMutableArray *btnarray4;
    NSMutableArray *stylearray;
    NSMutableArray *texturearray;
    NSMutableArray *inlayarray;
    NSMutableArray *seriearray;
}

@property (weak, nonatomic) IBOutlet UICollectionView *productcollect;
@property (weak, nonatomic) IBOutlet UILabel *countLable;
@property (weak, nonatomic) IBOutlet UIButton *btnstyle;
@property (weak, nonatomic) IBOutlet UIButton *btntexture;
@property (weak, nonatomic) IBOutlet UIButton *btninlay;
@property (weak, nonatomic) IBOutlet UIButton *btnseric;

@end
