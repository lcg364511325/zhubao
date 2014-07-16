//
//  AutoGetData.m
//  zhubao
//
//  Created by moko on 14-6-4.
//  Copyright (c) 2014年 SUNYEARS___FULLUSERNAME. All rights reserved.
//

#import "AutoGetData.h"

@implementation AutoGetData

sqlService *sqlser;
AppDelegate * app;
NSTimer *timer;
NSMutableArray * arraytt;

//同步数据到数据库里面
-(NSString *)getDataInsertTable:(int)tiptable
{
    sqlser= [[sqlService alloc]init];

    getNowTime * time=[[getNowTime alloc] init];
    NSString * nowt=[time nowTime];
    
    if (tiptable==1) {
        [self getProduct:nowt];//同步商品数据
        
    }else if (tiptable==2){
        sqlser= [[sqlService alloc]init];
        [self getProductdia:nowt];//裸钻数据获取
        
    }else if (tiptable==3){
        sqlser= [[sqlService alloc]init];
        [self getproductphotos:nowt];//3D旋转ZIP套图数据获取
        
    }else if (tiptable==4){
        sqlser= [[sqlService alloc]init];
        [self getwithmouth:nowt];//镶口数据获取
        
    }else if (tiptable==0){
        
        [self getProduct:nowt];//同步商品数据
        
        //重新获取时间
        nowt=[time nowTime];
        sqlser= [[sqlService alloc]init];
        [self getProductdia:nowt];//裸钻数据获取
        
        //重新获取时间
        nowt=[time nowTime];
        sqlser= [[sqlService alloc]init];
        [self getproductphotos:nowt];//3D旋转ZIP套图数据获取
        
        //重新获取时间
        nowt=[time nowTime];
        sqlser= [[sqlService alloc]init];
        [self getwithmouth:nowt];//镶口数据获取
    }

    //关闭数据库
    [sqlser closeDB];
    
    return @"";
}


//商品数据获取
-(BOOL *)getProduct:(NSString *)Nowt
{
    @try {
        //NSString * adminss=[Commons md5:[NSString stringWithFormat:@"%@%@%@%@%@%@",@"0",@"100",@"0",apikey,@"1402023598",@"0"]];
    
    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    
    NSString * timecode=@"producttime";
    
    NSString * uId=myDelegate.entityl.uId;
    NSString * Upt=[sqlser getUpdateTime:timecode];//获取上一次的更新时间
    
    //Kstr=md5(uId|type|Upt|Key|Nowt|cid)
    NSString * Kstr=[Commons md5:[NSString stringWithFormat:@"%@|%@|%@|%@|%@|%@",uId,@"100",Upt,apikey,Nowt,@"0"]];
    
    NSString * surl = [NSString stringWithFormat:@"/app/aiface.php?uId=%@&type=100&Upt=%@&Nowt=%@&Kstr=%@&cid=0",uId,Upt,Nowt,Kstr];
    
    
    NSString * URL = [NSString stringWithFormat:@"%@%@",domainser,surl];
    
    NSMutableDictionary * dict = [DataService GetDataService:URL];
  //{"status":"true","uptime":1401886947,"result":[["36530","S000001W","C20454992","18K\u94bb\u77f3\u5973\u6212","0","1","1","/files/3DNewa/1/3C0158E/3C0158E_thumb_1.jpg","/files/3DNewa/1/3C0158E/3C0158E.jpg","0","","0","0","3C0158E","0","2014 \u4e00\u6708 23 17:56","2","0.0","0","0","0","60","0.0","0.0","0","0","0","0","0","0","0","1","","1","0.385","I-J","","SI",""," ","0.0","0","","0","0.0",""," ",""," ","","0.0",""," ",""," ",""," ","0","0",""," ","2","0.0","0.0","{14}","0.0","60.0000","0",null,"0.22","1.92","2.52"]]}
    
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    
    if ([jsonData length] > 0 && error == nil){
        error = nil;
        
        id jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:&error];
        
        if (jsonObject != nil && error == nil){
            if ([jsonObject isKindOfClass:[NSDictionary class]]){
                NSDictionary *d = (NSDictionary *)jsonObject;
                NSString * status=[d objectForKey:@"status"];
                if ([status isEqualToString:@"false"]) {
                    return FALSE;
                }
                
                //查询出所有的商品，然后判断时间是否需要删除当前的记录
                NSMutableArray * arrayp=[sqlser GetProductList:nil type2:nil type3:nil type4:nil page:1 pageSize:1500];
                sqlser= [[sqlService alloc]init];
                
                NSArray * objArray=[d objectForKey:@"result"];
                for(int i = 0 ; i < objArray.count ; i++){
                    
                    NSArray * valuearray = objArray[i];
                    //NSString *values = [objArray[i] componentsJoinedByString:@","];
                    NSString *proid=@"";//当前商品的id
                    NSString *proaddtime=@"";//当前商品的新加时间
                    NSMutableString *values=[[NSMutableString alloc] init];
                    for (int j = 0 ; j < valuearray.count ; j++) {
                        if(j>0)[values appendString:[NSString stringWithFormat:@","]];
                        [values appendString:[NSString stringWithFormat:@"'%@'",valuearray[j]]];
                        
                        if(j==0){
                            proid=valuearray[0];
                        }else if(j==15){
                            proaddtime=valuearray[15];
                        }
                    }
                    
                    //判断时间是否需要删除当前的记录
                    bool isupdate=true;
                    for (id key in arrayp){
                        productEntity * entity=(productEntity *)key;
                        
                        NSString * addtime=entity.Pro_addtime;
                        if([entity.Id isEqualToString:proid]){
                            
                            if(![addtime isEqualToString:proaddtime]){
                                //删除这条记录
                                [sqlser execSql:[NSString stringWithFormat:@"delete from product where Id=%@",entity.Id]];
                                //删除压缩图片和压缩文件还有大小图片
                                [self deleteFile:entity.Pro_author smallpic:entity.Pro_smallpic Pro_bigpic:entity.Pro_bigpic];
                            }else{
                                isupdate=false;
                            }
                            
                            break;
                        }
                    }
                    
                    if(!isupdate)continue;
                    
                    NSString *tablekey=@"Id,Pro_model,Pro_number,Pro_name,Pro_State,Pro_Class,Pro_Type,Pro_smallpic,Pro_bigpic,Pro_typeWenProId,Pro_info,Pro_lock,Pro_IsDel,Pro_author,Pro_Order,Pro_addtime,Pro_goldType,Pro_goldWeight,Pro_goldsize,Pro_goldset,Pro_FingerSize,Pro_gongfei,Pro_MarketPrice,Pro_price,Pro_OKdays,Pro_Salenums,Pro_hotA,Pro_hotB,Pro_hotC,Pro_hotD,Pro_hotE,Pro_Z_count,Pro_Z_GIA,Pro_Z_number,Pro_Z_weight,Pro_Z_color,Pro_Z_cut,Pro_Z_clarity,Pro_Z_polish,Pro_Z_pair,Pro_Z_price,Pro_f_count,Pro_F_GIA,Pro_f_number,Pro_f_weight,Pro_f_color,Pro_f_cut,Pro_f_clarity,Pro_f_polish,Pro_f_pair,Pro_f_price,Pro_D_Hand,Pro_D_Width,Pro_D_Dia,Pro_D_Bangle,Pro_D_Ear,Pro_D_Height,Pro_SmallClass,IsCaijin,Di_DiaShape,Pro_GroupSerial,Pro_FactoryNumber,Pro_domondB,Pro_domondE,Pro_ChiCun,Pro_goldWeightB,Pro_gongfeiB,Pro_zhuanti,location,zWeight,AuWeight,ptWeight";
                    
                    NSString * sql=[NSString stringWithFormat:@"insert into product(%@)values(%@)",tablekey,(NSString *)values];
                    
                    NSLog(@"--------------:%@",sql);
                    
                    [sqlser execSql:sql];

                }
                //先删除之前的更新时间
                //[sqlser execSql:[NSString stringWithFormat:@"delete from updatetime where updateCode='%@'",timecode]];
                
                NSString * uptime=[d objectForKey:@"uptime"];
                //更新时间表记录
                NSString * sql1=[NSString stringWithFormat:@"insert into updatetime(updateCode,updatetimevalue)values('%@','%@')",timecode,uptime];
                
                //判断此值是否已经有了，如果已经有了，则不再插入
                int count=[sqlser getcount:[NSString stringWithFormat:@"select updatetimevalue from updatetime where updateCode='%@'",timecode]];
                if(count>0){
                    sql1=[NSString stringWithFormat:@"update updatetime set updatetimevalue='%@' where updateCode='%@'",uptime,timecode];
                }
                
                NSLog(@"--------------:%@",sql1);
                
                [sqlser execSql:sql1];
                
            }else if ([jsonObject isKindOfClass:[NSArray class]]){
//                NSArray * objArray = (NSArray *)jsonObject;
//                
//                for(int i = 0 ; i < objArray.count ; i++)
//                {
//                    
//                }
                
            }
            else {
                NSLog(@"无法解析的数据结构.");
            }
            
            return TRUE;
        }
        else if (error != nil){
            NSLog(@"%@",error);
        }
    }
    else if ([jsonData length] == 0 &&error == nil){
        NSLog(@"空的数据集.");
    }
    else if (error != nil){
        NSLog(@"发生致命错误：%@", error);
    }
    
    }@catch (NSException *exception) {
            
    }
    @finally {
            
    }
    return FALSE;
}

//裸钻数据获取
-(BOOL *)getProductdia:(NSString *)Nowt
{
    @try {
    
    //sqlService *sqlser= [[sqlService alloc]init];
    
    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    
    NSString * timecode=@"productdiatime";
    
    NSString * uId=myDelegate.entityl.uId;
    NSString * Upt=[sqlser getUpdateTime:timecode];//获取上一次的更新时间
    
    //Kstr=md5(uId|type|Upt|Key|Nowt)
    NSString * Kstr=[Commons md5:[NSString stringWithFormat:@"%@|%@|%@|%@|%@",uId,@"101",Upt,apikey,Nowt]];
    
    NSString * surl = [NSString stringWithFormat:@"/app/aiface.php?uId=%@&type=101&Upt=%@&Nowt=%@&Kstr=%@",uId,Upt,Nowt,Kstr];
    
    
    NSString * URL = [NSString stringWithFormat:@"%@%@",domainser,surl];
    
    NSMutableDictionary * dict = [DataService GetDataService:URL];
    //{"status":"true","uptime":1401886947,"result":[["36530","S000001W","C20454992","18K\u94bb\u77f3\u5973\u6212","0","1","1","/files/3DNewa/1/3C0158E/3C0158E_thumb_1.jpg","/files/3DNewa/1/3C0158E/3C0158E.jpg","0","","0","0","3C0158E","0","2014 \u4e00\u6708 23 17:56","2","0.0","0","0","0","60","0.0","0.0","0","0","0","0","0","0","0","1","","1","0.385","I-J","","SI",""," ","0.0","0","","0","0.0",""," ",""," ","","0.0",""," ",""," ",""," ","0","0",""," ","2","0.0","0.0","{14}","0.0","60.0000","0",null,"0.22","1.92","2.52"]]}
    
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    
    if ([jsonData length] > 0 && error == nil){
        error = nil;
        
        id jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:&error];
        
        if (jsonObject != nil && error == nil){
            if ([jsonObject isKindOfClass:[NSDictionary class]]){
                NSDictionary *d = (NSDictionary *)jsonObject;
                NSString * status=[d objectForKey:@"status"];
                if ([status isEqualToString:@"false"]) {
                    return FALSE;
                }
                
                //查询出所有的裸钻
                NSMutableArray * arrayp=[sqlser GetProductdiaList:nil type2:nil type3:nil type4:nil type5:nil type6:nil type7:nil type8:nil type9:nil type10:nil type11:nil page:1 pageSize:65000];
                sqlser= [[sqlService alloc]init];
                
                NSArray * objArray=[d objectForKey:@"result"];
                for(int i = 0 ; i < objArray.count ; i++){
                    
                    NSArray * valuearray = objArray[i];
                    //NSString *values = [objArray[i] componentsJoinedByString:@","];
                    NSString *proid=@"";//当前裸钻的id
                    NSString *proaddtime=@"";//当前裸钻的新加时间
                    NSMutableString *values=[[NSMutableString alloc] init];
                    for (int j = 0 ; j < valuearray.count ; j++) {
                        if(j>0)[values appendString:[NSString stringWithFormat:@","]];
                        [values appendString:[NSString stringWithFormat:@"'%@'",valuearray[j]]];
                        
                        if(j==0){
                            proid=valuearray[0];
                        }else if(j==21){
                            proaddtime=valuearray[21];
                        }
                    }
                    
                    //判断时间是否需要删除当前的记录
                    bool isupdate=true;
                    for (id key in arrayp){
                        productdia * entity=(productdia *)key;
                        //NSLog(@"-----------:%@==%@",entity.Id,proid);
                        NSString * addtime=entity.Dia_Addtime;
                        if([entity.Id isEqualToString:proid]){
                            
                            if(![addtime isEqualToString:proaddtime]){
                                //删除这条记录
                                [sqlser execSql:[NSString stringWithFormat:@"delete from productdia where Id=%@",entity.Id]];
                            }else{
                                isupdate=false;
                            }
                            
                            break;
                        }
                    }
                    
                    if(!isupdate)continue;
                    
                    NSString *tablekey=@"Id,Dia_Lab,Dia_CertNo,Dia_Carat,Dia_Clar,Dia_Col,Dia_Cut,Dia_Pol,Dia_Sym,Dia_Shape,Dia_Dep,Dia_Tab,Dia_Meas,Dia_Flor,Dia_Price,Dia_Cost,Dia_ART,Dia_Corp,Dia_Theonly,Dia_Out,Dia_Tj,Dia_Addtime,Dia_XH,ColStep,ColCream,BackFlaw,TabFlaw,location,colordesc";
                    
                    NSString * sql=[NSString stringWithFormat:@"insert into productdia(%@)values(%@)",tablekey,(NSString *)values];
                    
                    NSLog(@"--------------:%@",sql);
                    
                    [sqlser execSql:sql];
                    
                }
                //先删除之前的更新时间
                //[sqlser execSql:[NSString stringWithFormat:@"delete from updatetime where updateCode='%@'",timecode]];
                
                NSString * uptime=[d objectForKey:@"uptime"];
                //更新时间表记录
                NSString * sql1=[NSString stringWithFormat:@"insert into updatetime(updateCode,updatetimevalue)values('%@','%@')",timecode,uptime];
                
                //判断此值是否已经有了，如果已经有了，则不再插入
                int count=[sqlser getcount:[NSString stringWithFormat:@"select updatetimevalue from updatetime where updateCode='%@'",timecode]];
                if(count>0){
                    sql1=[NSString stringWithFormat:@"update updatetime set updatetimevalue='%@' where updateCode='%@'",uptime,timecode];
                }
                
                NSLog(@"--------------:%@",sql1);
                
                [sqlser execSql:sql1];
                
            }else if ([jsonObject isKindOfClass:[NSArray class]]){
                //                NSArray * objArray = (NSArray *)jsonObject;
                //
                //                for(int i = 0 ; i < objArray.count ; i++)
                //                {
                //
                //                }
                
            }
            else {
                NSLog(@"无法解析的数据结构.");
            }
            
            return TRUE;
        }
        else if (error != nil){
            NSLog(@"%@",error);
        }
    }
    else if ([jsonData length] == 0 &&error == nil){
        NSLog(@"空的数据集.");
    }
    else if (error != nil){
        NSLog(@"发生致命错误：%@", error);
    }
        
    }@catch (NSException *exception) {
        
    }
    @finally {
        
    }
    return FALSE;
}

//3D旋转ZIP套图数据获取
-(BOOL *)getproductphotos:(NSString *)Nowt
{
    @try {
    //sqlService *sqlser= [[sqlService alloc]init];
    
    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    
    NSString * timecode=@"productphotos";
    
    NSString * uId=myDelegate.entityl.uId;
    NSString * Upt=[sqlser getUpdateTime:timecode];//获取上一次的更新时间
    
    //Kstr=md5(uId|type|Upt|Key|Nowt)
    NSString * Kstr=[Commons md5:[NSString stringWithFormat:@"%@|%@|%@|%@|%@",uId,@"103",Upt,apikey,Nowt]];
    
    NSString * surl = [NSString stringWithFormat:@"/app/aiface.php?uId=%@&type=103&Upt=%@&Nowt=%@&Kstr=%@",uId,Upt,Nowt,Kstr];
    
    
    NSString * URL = [NSString stringWithFormat:@"%@%@",domainser,surl];
    
    NSMutableDictionary * dict = [DataService GetDataService:URL];
    //{"status":"true","uptime":1401886947,"result":[["36530","S000001W","C20454992","18K\u94bb\u77f3\u5973\u6212","0","1","1","/files/3DNewa/1/3C0158E/3C0158E_thumb_1.jpg","/files/3DNewa/1/3C0158E/3C0158E.jpg","0","","0","0","3C0158E","0","2014 \u4e00\u6708 23 17:56","2","0.0","0","0","0","60","0.0","0.0","0","0","0","0","0","0","0","1","","1","0.385","I-J","","SI",""," ","0.0","0","","0","0.0",""," ",""," ","","0.0",""," ",""," ",""," ","0","0",""," ","2","0.0","0.0","{14}","0.0","60.0000","0",null,"0.22","1.92","2.52"]]}
    
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    
    if ([jsonData length] > 0 && error == nil){
        error = nil;
        
        id jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:&error];
        
        if (jsonObject != nil && error == nil){
            if ([jsonObject isKindOfClass:[NSDictionary class]]){
                NSDictionary *d = (NSDictionary *)jsonObject;
                NSString * status=[d objectForKey:@"status"];
                if ([status isEqualToString:@"false"]) {
                    return FALSE;
                }
                NSArray * objArray=[d objectForKey:@"result"];
                for(int i = 0 ; i < objArray.count ; i++){
                    
                    NSArray * valuearray = objArray[i];
                    //NSString *values = [objArray[i] componentsJoinedByString:@","];
                    NSMutableString *values=[[NSMutableString alloc] init];
                    for (int j = 0 ; j < valuearray.count ; j++) {
                        if(j>0)[values appendString:[NSString stringWithFormat:@","]];
                        [values appendString:[NSString stringWithFormat:@"'%@'",valuearray[j]]];
                    }
                    
                    NSString *tablekey=@"Id,zipUrl";
                    
                    NSString * sql=[NSString stringWithFormat:@"insert into productphotos(%@)values(%@)",tablekey,(NSString *)values];
                    
                    NSLog(@"--------------:%@",sql);
                    
                    [sqlser execSql:sql];
                    
                }
                //先删除之前的更新时间
                //[sqlser execSql:[NSString stringWithFormat:@"delete from updatetime where updateCode='%@'",timecode]];
                
                NSString * uptime=[d objectForKey:@"uptime"];
                //更新时间表记录
                NSString * sql1=[NSString stringWithFormat:@"insert into updatetime(updateCode,updatetimevalue)values('%@','%@')",timecode,uptime];
                
                //判断此值是否已经有了，如果已经有了，则不再插入
                int count=[sqlser getcount:[NSString stringWithFormat:@"select updatetimevalue from updatetime where updateCode='%@'",timecode]];
                if(count>0){
                    sql1=[NSString stringWithFormat:@"update updatetime set updatetimevalue='%@' where updateCode='%@'",uptime,timecode];
                }
                
                NSLog(@"--------------:%@",sql1);
                
                [sqlser execSql:sql1];
                
            }else if ([jsonObject isKindOfClass:[NSArray class]]){
                //                NSArray * objArray = (NSArray *)jsonObject;
                //
                //                for(int i = 0 ; i < objArray.count ; i++)
                //                {
                //
                //                }
                
            }
            else {
                NSLog(@"无法解析的数据结构.");
            }
            
            return TRUE;
        }
        else if (error != nil){
            NSLog(@"%@",error);
        }
    }
    else if ([jsonData length] == 0 &&error == nil){
        NSLog(@"空的数据集.");
    }
    else if (error != nil){
        NSLog(@"发生致命错误：%@", error);
    }
    
    }@catch (NSException *exception) {
    
    }
    @finally {
    
    }

    return FALSE;
}

//镶口数据获取
-(BOOL *)getwithmouth:(NSString *)Nowt
{
    @try {
    
    //sqlService *sqlser= [[sqlService alloc]init];
    
    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    
    NSString * timecode=@"withmouth";
    
    NSString * uId=myDelegate.entityl.uId;
    NSString * Upt=[sqlser getUpdateTime:timecode];//获取上一次的更新时间
    
    //Kstr=md5(uId|type|Upt|Key|Nowt)
    NSString * Kstr=[Commons md5:[NSString stringWithFormat:@"%@|%@|%@|%@|%@",uId,@"102",Upt,apikey,Nowt]];
    
    NSString * surl = [NSString stringWithFormat:@"/app/aiface.php?uId=%@&type=102&Upt=%@&Nowt=%@&Kstr=%@",uId,Upt,Nowt,Kstr];
    
    
    NSString * URL = [NSString stringWithFormat:@"%@%@",domainser,surl];
    
    NSMutableDictionary * dict = [DataService GetDataService:URL];
    //{"status":"true","uptime":1401886947,"result":[["36530","S000001W","C20454992","18K\u94bb\u77f3\u5973\u6212","0","1","1","/files/3DNewa/1/3C0158E/3C0158E_thumb_1.jpg","/files/3DNewa/1/3C0158E/3C0158E.jpg","0","","0","0","3C0158E","0","2014 \u4e00\u6708 23 17:56","2","0.0","0","0","0","60","0.0","0.0","0","0","0","0","0","0","0","1","","1","0.385","I-J","","SI",""," ","0.0","0","","0","0.0",""," ",""," ","","0.0",""," ",""," ",""," ","0","0",""," ","2","0.0","0.0","{14}","0.0","60.0000","0",null,"0.22","1.92","2.52"]]}
    
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    
    if ([jsonData length] > 0 && error == nil){
        error = nil;
        
        id jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:&error];
        
        if (jsonObject != nil && error == nil){
            if ([jsonObject isKindOfClass:[NSDictionary class]]){
                NSDictionary *d = (NSDictionary *)jsonObject;
                NSString * status=[d objectForKey:@"status"];
                if ([status isEqualToString:@"false"]) {
                    return FALSE;
                }
                NSArray * objArray=[d objectForKey:@"result"];
                for(int i = 0 ; i < objArray.count ; i++){
                    
                    NSArray * valuearray = objArray[i];
                    //NSString *values = [objArray[i] componentsJoinedByString:@","];
                    NSMutableString *values=[[NSMutableString alloc] init];
                    for (int j = 0 ; j < valuearray.count ; j++) {
                        if(j>0)[values appendString:[NSString stringWithFormat:@","]];
                        [values appendString:[NSString stringWithFormat:@"'%@'",valuearray[j]]];
                    }
                    
                    NSString *tablekey=@"Id,Proid,zWeight,AuWeight,ptWeight,IsComm,Pro_number";
                    
                    NSString * sql=[NSString stringWithFormat:@"insert into withmouth(%@)values(%@)",tablekey,(NSString *)values];
                    
                    NSLog(@"--------------:%@",sql);
                    
                    [sqlser execSql:sql];
                    
                }
                //先删除之前的更新时间
                //[sqlser execSql:[NSString stringWithFormat:@"delete from updatetime where updateCode='%@'",timecode]];
                
                NSString * uptime=[d objectForKey:@"uptime"];
                //更新时间表记录
                NSString * sql1=[NSString stringWithFormat:@"insert into updatetime(updateCode,updatetimevalue)values('%@','%@')",timecode,uptime];
                
                //判断此值是否已经有了，如果已经有了，则不再插入
                int count=[sqlser getcount:[NSString stringWithFormat:@"select updatetimevalue from updatetime where updateCode='%@'",timecode]];
                if(count>0){
                    sql1=[NSString stringWithFormat:@"update updatetime set updatetimevalue='%@' where updateCode='%@'",uptime,timecode];
                }
                
                NSLog(@"--------------:%@",sql1);
                
                [sqlser execSql:sql1];
                
            }else if ([jsonObject isKindOfClass:[NSArray class]]){
                //                NSArray * objArray = (NSArray *)jsonObject;
                //
                //                for(int i = 0 ; i < objArray.count ; i++)
                //                {
                //
                //                }
                
            }
            else {
                NSLog(@"无法解析的数据结构.");
            }
            
            return TRUE;
        }
        else if (error != nil){
            NSLog(@"%@",error);
        }
    }
    else if ([jsonData length] == 0 &&error == nil){
        NSLog(@"空的数据集.");
    }
    else if (error != nil){
        NSLog(@"发生致命错误：%@", error);
    }
    
    }@catch (NSException *exception) {
        
    }
    @finally {
        
    }
        
    return FALSE;
}

//查询所有的商品的3d图片，并且下载压缩文件里面的图片
-(BOOL *)getAllZIPPhotos
{
    @try {
        app=(AppDelegate *)[[UIApplication sharedApplication]delegate];
        sqlser= [[sqlService alloc]init];
        //查询图片的压缩文件
        NSMutableArray * array=[sqlser getAllProductRAR];
        int i=0;
        for (id key in array){
            productphotos * entity=(productphotos *)key;
            
            NSString * surl = [NSString stringWithFormat:@"%@",entity.zipUrl];
            NSString * fileName=[entity.zipUrl lastPathComponent];//从路径中获得完整的文件名（带后缀）
            
            //初始化Documents路径
            NSString *downloadPath = [[Tool getTargetFloderPath] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",fileName]];
            
            //NSLog(@"压缩文件存放的路径------%@",downloadPath);
            
            if ([[NSFileManager defaultManager] fileExistsAtPath:downloadPath]) {
                //NSLog(@"------有了，不再下载");
                
            }else {
                NSLog(@"------没有，所以要下载");
                i++;
                //去下载
                [app beginRequest:surl fileName:fileName version:entity.Id];
            }
            
            //[self getZIPPhotosData:entity.zipUrl];
            
            //if(i==10)break;
        }
        
        if(array.count<=0 || i==0){
            [app stopProgressBar];
        }
        
        //同步下载商品图片
        //[self getAllProductPhotos];

    }@catch (NSException *exception) {
        
    }
    @finally {
        
    }
    
    return FALSE;
}

//计算下载的数量，然后提示出来，并且显示进度条
-(void)forAllProductDowlon
{
    int queuecount=0;
    int allcount=0;
    @try {
        for (id key in arraytt){
            productEntity * entity=(productEntity *)key;
            
            NSURL *imgUrl=[NSURL URLWithString:[NSString stringWithFormat:@"http://seyuu.com%@",entity.Pro_smallpic]];
            if (hasCachedImage(imgUrl)) {
                queuecount++;
            }
            allcount++;
            
            //下载大图
            NSArray  * array= [entity.Pro_bigpic componentsSeparatedByString:@","];
            int count = [array count];
            //遍历这个数组
            for (int i = 0; i < count; i++) {
                NSURL *imgUrl=[NSURL URLWithString:[NSString stringWithFormat:@"http://seyuu.com%@",[array objectAtIndex: i]]];
                if (hasCachedImage(imgUrl)) {
                    queuecount++;
                }
                allcount++;
            }
        }
        
        float dd=(queuecount*0.1)/(allcount*0.1);
        //重新设置进度条
        [app showProgressBarprocess:[NSString stringWithFormat:@"商品大小图片下载：%d/%d",queuecount,allcount] countt:dd];
    }
    @catch (NSException *exception) {
        
    }
}

//查询所有的商品的图片，并且下载图片(非3d图片)
-(BOOL *)getAllProductPhotos
{
    @try {
        app=(AppDelegate *)[[UIApplication sharedApplication]delegate];
        sqlser= [[sqlService alloc]init];
        //查询商品的图片
        arraytt=[sqlser GetProductList:nil type2:nil type3:nil type4:nil page:1 pageSize:1500];
        
        timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(forAllProductDowlon) userInfo:nil repeats:YES];
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            // 耗时的操作（异步操作）
            int t=0;
            for (id key in arraytt){
                productEntity * entity=(productEntity *)key;
                
                NSLog(@"getAllProductPhotos------:%@",entity.Pro_smallpic);
                
                NSURL *imgUrl=[NSURL URLWithString:[NSString stringWithFormat:@"http://seyuu.com%@",entity.Pro_smallpic]];
                if (hasCachedImage(imgUrl)) {
                    
                }else
                {
                    NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:imgUrl,@"url",nil,@"imageView",nil];
                    [NSThread detachNewThreadSelector:@selector(cacheImage:) toTarget:[ImageCacher defaultCacher] withObject:dic];
                    //[[ImageCacher defaultCacher] cacheImage:dic];
                    t++;
                    sleep(1);//等待多长时间
                }
                
                //下载大图
                NSArray  * array= [entity.Pro_bigpic componentsSeparatedByString:@","];
                int count = [array count];
                //遍历这个数组
                for (int i = 0; i < count; i++) {
                    NSURL *imgUrl=[NSURL URLWithString:[NSString stringWithFormat:@"http://seyuu.com%@",[array objectAtIndex: i]]];
                    if (hasCachedImage(imgUrl)) {
                        
                    }else
                    {
                        NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:imgUrl,@"url",nil,@"imageView",nil];
                        [NSThread detachNewThreadSelector:@selector(cacheImage:) toTarget:[ImageCacher defaultCacher] withObject:dic];
                        //[[ImageCacher defaultCacher] cacheImage:dic];
                        t++;
                        sleep(2);//等待多长时间
                        //[NSThread sleepForTimeInterval:0.5];
                    }
                }
                
                //if(t>=10)break;
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //可以在此加代码提示用户，数据已经加载完毕
                //取消定时器
                @try {
                    [timer invalidate];
                    timer = nil;
                    arraytt=nil;//清空数据
                    [app showProgressBarprocess:[NSString stringWithFormat:@"商品大小图片下载：%d/%d",arraytt.count,arraytt.count] countt:1.0];
                }
                @catch (NSException *exception) {
                    
                }
                
                //更新3d图片下载
                [self getAllZIPPhotos];
                
            });
        });
        
    }@catch (NSException *exception) {
        
    }
    @finally {
        
    }
    
    return FALSE;
}

//上载压缩文件里面的图片
-(BOOL *)getZIPPhotosData:(NSString *)zippath
{
    @try {
        
        NSString * surl = [NSString stringWithFormat:@"%@",zippath];
        NSString * fileName=[zippath lastPathComponent];//从路径中获得完整的文件名（带后缀）
        
        //初始化Documents路径
        NSString *downloadPath = [[Tool getTargetFloderPath] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",fileName]];
        
        //NSLog(@"压缩文件存放的路径------%@",downloadPath);
        
        if ([[NSFileManager defaultManager] fileExistsAtPath:downloadPath]) {
            //NSLog(@"------有了，不再下载");
        }else {
            NSLog(@"------没有，所以要下载");
            //去下载
            [app beginRequest:surl fileName:fileName version:@"1"];
        }

    }@catch (NSException *exception) {
        
    }
    @finally {
        
    }
    
    return FALSE;
}

//清掉商品对应的文件
-(void)deleteFile:(NSString *)authcode smallpic:(NSString *) smallpic Pro_bigpic:(NSString *)Pro_bigpic
{
    @try {
        
        NSString * fileName=[NSString stringWithFormat:@"%@.zip",authcode];
        
        //初始化Documents路径
        NSString *downloadPath = [[Tool getTargetFloderPath] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",fileName]];
        
        NSFileManager *defaultManager = [NSFileManager defaultManager];
        [defaultManager removeItemAtPath: downloadPath error: nil];
        
        NSURL *imgUrl=[NSURL URLWithString:[NSString stringWithFormat:@"http://seyuu.com%@",smallpic]];
        deleteCachedImage(imgUrl);
        
        //下载大图
        NSArray  * array= [Pro_bigpic componentsSeparatedByString:@","];
        int count = [array count];
        //遍历这个数组
        for (int i = 0; i < count; i++) {
            NSURL *imgUrl=[NSURL URLWithString:[NSString stringWithFormat:@"http://seyuu.com%@",[array objectAtIndex: i]]];
            deleteCachedImage(imgUrl);
        }
    }
    @catch (NSException *exception) {
        
    }
    

}

@end
