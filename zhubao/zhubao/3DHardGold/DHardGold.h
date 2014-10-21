//
//  3DHardGold.h
//  zhubao
//
//  Created by johnson on 14-10-21.
//  Copyright (c) 2014年 SUNYEARS___FULLUSERNAME. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MWPhotoBrowser.h"
#import "RotateImageView.h"
#import "productEntity.h"

@interface DHardGold : UIViewController<MWPhotoBrowserDelegate,UIApplicationDelegate>
{
    UIButton* btnBack;
    RotateImageView *rImageView;
    UIButton *deletebtn;
    UIButton *updatebtn;
    
    //产品id
    NSString * productnumber;
    //默认商品
    productEntity *goods;
    //对戒男戒
    productEntity *goodsman;
    //商品类型
    NSString * Pro_type;
    //主石约重
    NSMutableArray *inlayarry;
    //男主石约重
    NSMutableArray *inlayarryman;
    //女戒价格
    NSString *womanprice;
    //男戒价格
    NSString *manprice;
    //判定点击来哪个tableview
    NSInteger selecttype;
}


@property(retain , nonatomic) NSString * proid;//产品id
@property (weak, nonatomic) IBOutlet UIImageView *productpic;//产品图片
@property (weak, nonatomic) IBOutlet UIButton *addtoshopcart;//加入购物车按钮
@property (weak, nonatomic) IBOutlet UIButton *show3D;//3D展示按钮（非对戒）
@property (weak, nonatomic) IBOutlet UIButton *watchmorepic;//查看更多图片
@property (weak, nonatomic) IBOutlet UILabel *modellable;//型号
@property (weak, nonatomic) IBOutlet UILabel *weighlable;//约重
@property (weak, nonatomic) IBOutlet UILabel *titlelable;//产品标题
@property (weak, nonatomic) IBOutlet UILabel *pricelable;//产品价格
@property (weak, nonatomic) IBOutlet UIButton *closebutton;

@property (strong, nonatomic) NSArray *mainlist;
@property (strong, nonatomic) NSArray *dmainlist;
@property (strong, nonatomic) NSArray *netlist;
@property (strong, nonatomic) NSArray *colorlist;
@property (strong, nonatomic) NSArray *texturelist;

@property (weak, nonatomic) IBOutlet UIView *childview;

@property (nonatomic, strong) NSMutableArray *photos;

@property (nonatomic,assign) id <UIApplicationDelegate> mydelegate;//当前请求过来的对象
@property (nonatomic,assign) id <UIApplicationDelegate> mypdelegate;//当前请求过来的对象

-(void)closesc;

-(void)showproductDetai;



@end
