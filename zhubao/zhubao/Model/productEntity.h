//
//  product.h
//  zhubao
//
//  Created by moko on 14-6-4.
//  Copyright (c) 2014年 SUNYEARS___FULLUSERNAME. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface productEntity : NSObject

@property (nonatomic, retain) NSString * Id;//商品id
@property (nonatomic, retain) NSString * Pro_model;
@property (nonatomic, retain) NSString * Pro_number;
@property (nonatomic, retain) NSString * Pro_name;
@property (nonatomic, retain) NSString * Pro_State;
@property (nonatomic, retain) NSString * Pro_Class;
@property (nonatomic, retain) NSString * Pro_Type;
@property (nonatomic, retain) NSString * Pro_smallpic;
@property (nonatomic, retain) NSString * Pro_bigpic;
@property (nonatomic, retain) NSString * Pro_typeWenProId;
@property (nonatomic, retain) NSString * Pro_info;
@property (nonatomic, retain) NSString * Pro_lock;
@property (nonatomic, retain) NSString * Pro_IsDel;
@property (nonatomic, retain) NSString * Pro_author;
@property (nonatomic, retain) NSString * Pro_Order;
@property (nonatomic, retain) NSString * Pro_addtime;
@property (nonatomic, retain) NSString * Pro_goldType;
@property (nonatomic, retain) NSString * Pro_goldWeight;
@property (nonatomic, retain) NSString * Pro_goldsize;
@property (nonatomic, retain) NSString * Pro_goldset;
@property (nonatomic, retain) NSString * Pro_FingerSize;
@property (nonatomic, retain) NSString * Pro_gongfei;
@property (nonatomic, retain) NSString * Pro_MarketPrice;
@property (nonatomic, retain) NSString * Pro_price;
@property (nonatomic, retain) NSString * Pro_OKdays;
@property (nonatomic, retain) NSString * Pro_Salenums;
@property (nonatomic, retain) NSString * Pro_hotA;
@property (nonatomic, retain) NSString * Pro_hotB;
@property (nonatomic, retain) NSString * Pro_hotC;
@property (nonatomic, retain) NSString * Pro_hotD;
@property (nonatomic, retain) NSString * Pro_hotE;
@property (nonatomic, retain) NSString * Pro_Z_count;
@property (nonatomic, retain) NSString * Pro_Z_GIA;
@property (nonatomic, retain) NSString * Pro_Z_number;
@property (nonatomic, retain) NSString * Pro_Z_weight;
@property (nonatomic, retain) NSString * Pro_Z_color;
@property (nonatomic, retain) NSString * Pro_Z_cut;
@property (nonatomic, retain) NSString * Pro_Z_clarity;
@property (nonatomic, retain) NSString * Pro_Z_polish;
@property (nonatomic, retain) NSString * Pro_Z_pair;
@property (nonatomic, retain) NSString * Pro_Z_price;
@property (nonatomic, retain) NSString * Pro_f_count;
@property (nonatomic, retain) NSString * Pro_F_GIA;
@property (nonatomic, retain) NSString * Pro_f_number;
@property (nonatomic, retain) NSString * Pro_f_weight;
@property (nonatomic, retain) NSString * Pro_f_color;
@property (nonatomic, retain) NSString * Pro_f_cut;
@property (nonatomic, retain) NSString * Pro_f_clarity;
@property (nonatomic, retain) NSString * Pro_f_polish;
@property (nonatomic, retain) NSString * Pro_f_pair;
@property (nonatomic, retain) NSString * Pro_f_price;
@property (nonatomic, retain) NSString * Pro_D_Hand;
@property (nonatomic, retain) NSString * Pro_D_Width;
@property (nonatomic, retain) NSString * Pro_D_Dia;
@property (nonatomic, retain) NSString * Pro_D_Bangle;
@property (nonatomic, retain) NSString * Pro_D_Ear;
@property (nonatomic, retain) NSString * Pro_D_Height;
@property (nonatomic, retain) NSString * Pro_SmallClass;
@property (nonatomic, retain) NSString * IsCaijin;
@property (nonatomic, retain) NSString * Di_DiaShape;
@property (nonatomic, retain) NSString * Pro_GroupSerial;
@property (nonatomic, retain) NSString * Pro_FactoryNumber;
@property (nonatomic, retain) NSString * Pro_domondB;
@property (nonatomic, retain) NSString * Pro_domondE;
@property (nonatomic, retain) NSString * Pro_ChiCun;
@property (nonatomic, retain) NSString * Pro_goldWeightB;
@property (nonatomic, retain) NSString * Pro_gongfeiB;
@property (nonatomic, retain) NSString * Pro_zhuanti;
@property (nonatomic, retain) NSString * location;
@property (nonatomic, retain) NSString * zWeight;
@property (nonatomic, retain) NSString * AuWeight;
@property (nonatomic, retain) NSString * ptWeight;

@property (nonatomic, retain) NSString * producttype;//0是服务器商品，1是自已新加的商品

@end
