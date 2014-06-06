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
@property (nonatomic, retain) NSString * productid;
@property (nonatomic, retain) NSString * pcolor;
@property (nonatomic, retain) NSString * pcount;
@property (nonatomic, retain) NSString * pdetail;
@property (nonatomic, retain) NSString * psize;
@property (nonatomic, retain) NSString * pprice;
@property (nonatomic, retain) NSString * customerid;
@property (nonatomic, retain) NSString * producttype;
@property (nonatomic, retain) NSString * pvvs;
@property (nonatomic, retain) NSString * pweight;
@property (nonatomic, retain) NSString * pgoldtype;

@property (nonatomic, retain) productEntity * proentiy;
@property (nonatomic, retain) productdia * diaentiy;



@end
