//
//  productApi.h
//  zhubao
//
//  Created by moko on 14-6-4.
//  Copyright (c) 2014年 SUNYEARS___FULLUSERNAME. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "product.h"
#import "productdia.h"
#import "sqlService.h"

@interface productApi : NSObject

//获取商品的价格
//classId产品类别 goldType材质 goldWeight金重 mDiaWeight主石重 mDiaColor主石颜色 mVVS	主石净度 sDiaWeight副石重 sCount副石数量 proid商品的id
-(NSString *)getPrice:(NSString *)classId goldType:(NSString *)goldType goldWeight:(NSString*)goldWeight mDiaWeight:(NSString *)mDiaWeight mDiaColor:(NSString*)mDiaColor mVVS:(NSString*)mVVS sDiaWeight:(NSString*)sDiaWeight sCount:(NSString*)sCount proid:(NSString*)proid;


@end
