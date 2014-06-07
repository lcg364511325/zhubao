//
//  buyproduct.h
//  zhubao
//
//  Created by moko on 14-6-5.
//  Copyright (c) 2014年 SUNYEARS___FULLUSERNAME. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "productEntity.h"
#import "productdia.h"

@interface buyproduct : NSObject

@property (nonatomic, retain) NSString * Id;
@property (nonatomic, retain) NSString * productid;//产品的id
@property (nonatomic, retain) NSString * pcolor;//颜色
@property (nonatomic, retain) NSString * pcount;//数量
@property (nonatomic, retain) NSString * pdetail;//详情说明
@property (nonatomic, retain) NSString * psize;//尺寸
@property (nonatomic, retain) NSString * pprice;//价格
@property (nonatomic, retain) NSString * customerid;//用户id
@property (nonatomic, retain) NSString * producttype;//类型（0代表是商品，1是钻）
@property (nonatomic, retain) NSString * pvvs;//主石净度
@property (nonatomic, retain) NSString * pweight;//重量
@property (nonatomic, retain) NSString * pgoldtype;//材质

@property (nonatomic, retain) productEntity * proentiy;//商品的对象数据（在购物车列表显示的时候才用到）
@property (nonatomic, retain) productdia * diaentiy;//钻的对象数据（在购物车列表显示的时候才用到）



@end
