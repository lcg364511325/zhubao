//
//  AutoGetData.h
//  zhubao
//
//  Created by moko on 14-6-4.
//  Copyright (c) 2014年 SUNYEARS___FULLUSERNAME. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"
#import "DataService.h"
#import "Commons.h"
#import "getNowTime.h"
#import "sqlService.h"
#import "ASIHTTPRequest.h"
#import "ASINetworkQueue.h"
#import "Tool.h"
#import "ZipArchive.h"

@interface AutoGetData : NSObject

//同步所有要插入表的数据
-(NSString *)getDataInsertTable:(int)tiptable;

//查询所有的商品的3d图片，并且下载压缩文件里面的图片
-(BOOL *)getAllZIPPhotos;

//查询所有的商品的图片，并且下载图片(非3d图片)
-(BOOL *)getAllProductPhotos;

@end
