//
//  orderdetail.h
//  zhubao
//
//  Created by johnson on 14-9-23.
//  Copyright (c) 2014年 SUNYEARS___FULLUSERNAME. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface orderdetail : NSObject


@property (nonatomic, retain) NSString * Id;
@property (nonatomic, retain) NSString * orderid;//订单id
@property (nonatomic, retain) NSString * cid;//商品id
@property (nonatomic, retain) NSString * name;//商品名称
@property (nonatomic, retain) NSString * goldType;//商品款式
@property (nonatomic, retain) NSString * size;//手寸
@property (nonatomic, retain) NSString * nums;//数量
@property (nonatomic, retain) NSString * Pro_model;//型号
@property (nonatomic, retain) NSString * diaColor;//材质
@property (nonatomic, retain) NSString * goldWeight;//金重
@property (nonatomic, retain) NSString * Dia_Z_weight;//主石重
@property (nonatomic, retain) NSString * Dia_Z_count;//主石数量
@property (nonatomic, retain) NSString * Dia_F_weight;//副石重
@property (nonatomic, retain) NSString * Dia_F_count;//副石数量
@property (nonatomic, retain) NSString * goldPrice;//金价
@property (nonatomic, retain) NSString * Pro_price;//商品价格
@property (nonatomic, retain) NSString * logopic;//商品图片
@end
