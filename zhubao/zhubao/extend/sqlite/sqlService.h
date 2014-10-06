//
//  sqlService.h
//  ACS
//
//  Created by 陈 星 on 13-5-2.
//
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "productEntity.h"
#import "productdia.h"
#import "buyproduct.h"
#import "productphotos.h"
#import "customer.h"
#import "productEntity.h"
#import "productdia.h"
#import "customerApi.h"
#import "myinfo.h"
#import "withmouth.h"
#import "orderApi.h"
#import "orderbill.h"
#import "orderdetail.h"
#import "proclassEntity.h"

@interface sqlService : NSObject
{
    sqlite3 *_database;
}

@property (nonatomic) sqlite3 *_database;

-(BOOL) initializeDb;
-(BOOL) openDB;
-(BOOL) HandleSql:(NSString*)sql;
-(BOOL) execSql:(NSString*)sql;
//执行sql
-(BOOL) execSqlandClose:(NSString *)sql;
//关闭数据库连接
-(BOOL) closeDB;
//查询记录的条数
- (int)getcount:(NSString *)sqls;
//清空数据
- (BOOL)ClearTableDatas:(NSString *)tableName;

//清空数据
- (BOOL)ClearAllTableDatas;

//查询商品列表
-(NSMutableArray*)GetProductList:(NSString *)type1 type2:(NSString *)type2 type3:(NSString *)type3 type4:(NSString *)type4 page:(int)page pageSize:(int)pageSize;

//查询商品明细
-(productEntity*)GetProductDetail:(NSString *)pid;

//查询商品明细
-(productEntity*)GetProductBoyDetail:(NSString *)girlid;

//新加商品
-(productEntity*)saveProduct:(productEntity *)entity;

//修改商品
-(productEntity*)updateProduct:(productEntity *)entity;

//删除商品信息
-(NSString*)deleteProduct:(NSString *)pid;

//查询裸钻列表
-(NSMutableArray*)GetProductdiaList:(NSString *)type1 type2:(NSString *)type2 type3:(NSString *)type3 type4:(NSString *)type4 type5:(NSString *)type5 type6:(NSString *)type6 type7:(NSString *)type7 type8:(NSString *)type8 type9:(NSString *)type9 type10:(NSString *)type10 type11:(NSString *)type11 page:(int)page pageSize:(int)pageSize;

//查询裸钻明细
-(productdia*)GetProductdiaDetail:(NSString *)pid;

//查询用户的购物车信息
-(NSMutableArray*)GetBuyproductList:(NSString *)customerid;

//新加到购物车信息
-(buyproduct*)addToBuyproduct:(buyproduct *)entity;

//删除购物车信息
-(NSString*)deleteBuyproduct:(NSString *)pid;

//根据用户的id查询购物车的数量
-(NSString*)getBuyproductcount:(NSString*)uid;

//修改购物车商品数量
-(NSString *)updateBuyproduct:(buyproduct *)entity;

//查询商品的3d图片
-(NSMutableArray*)getProductRAR:(NSString *)pid;

//查询所有的商品的3d图片
-(NSMutableArray*)getAllProductRAR;

//更新当前用户的基本信息(不调用接口更新服务器的信息)
-(customer*)updateCustomerNoApi:(customer *)entity;

//查询当前用户的基本信息
-(customer*)getCustomer:(NSString *)uid;

//更新当前用户的基本信息
-(customer*)updateCustomer:(customer *)entity;

//更新当前用户的密码
-(customer*)updateCustomerPasswrod:(customer *)entity;

//根据编号查询上次更新数据的时间
-(NSString*)getUpdateTime:(NSString *)code;


//查询当前公司的资料
-(myinfo*)getMyinfo:(NSString *)code;

//更新当前当前公司的资料
-(myinfo*)updateMyinfo:(myinfo *)entity;


//查询镶口数据
-(NSMutableArray*)getwithmouths:(NSString *)pid;

//提交当前用户的订单
-(NSString*)saveOrder:(NSString *)customerid;

//查询本地商品订单列表
- (NSMutableArray*)GetLocalOrderList:(NSString *)uId page:(int)page pageSize:(int)pageSize;

//查询本地订单详情列表
- (NSMutableArray*)GetLocalOrderDetailList:(NSString *)orderid page:(int)page pageSize:(int)pageSize;

//删除本地订单信息
-(NSString*)deletelocalorder:(NSString *)oid;

//修改本地订单
-(NSString *)updatelocalorder:(NSString *)key value:(NSString *)value oid:(NSString *)oid;

//查询本地商品列表
- (NSMutableArray*)GetLocalProductList:(NSString *)type1 type2:(NSString *)type2 type3:(NSString *)type3 type4:(NSString *)type4 page:(int)page pageSize:(int)pageSize;


//查询商品类别列表
- (NSMutableArray*)GetProclassList:(NSString *)uId page:(int)page pageSize:(int)pageSize;

//删除商品类别信息
-(NSString*)deleteProclass:(NSString *)oid;

//修改商品类别
-(NSString *)updateProclass:(NSString *)key value:(NSString *)value oid:(NSString *)oid;

//新加商品类别
-(proclassEntity*)addProclass:(proclassEntity *)entity;

@end
