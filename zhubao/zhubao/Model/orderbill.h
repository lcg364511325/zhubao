//
//  orderbill.h
//  zhubao
//
//  Created by johnson on 14-9-23.
//  Copyright (c) 2014年 SUNYEARS___FULLUSERNAME. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface orderbill : NSObject


@property (nonatomic, retain) NSString * Id;
@property (nonatomic, retain) NSString * uId;//买家id
@property (nonatomic, retain) NSString * username;//买家名称
@property (nonatomic, retain) NSString * mobile;//买家手机
@property (nonatomic, retain) NSString * phone;//买家固话
@property (nonatomic, retain) NSString * addr;//买家送货地址
@property (nonatomic, retain) NSString * comtents;//备注
@property (nonatomic, retain) NSString * createdate;//下单时间
@property (nonatomic, retain) NSString * allprice;//总价
@property (nonatomic, retain) NSString * getprice;//已付款
@end
