//
//  myApi.m
//  zhubao
//
//  Created by moko on 14-6-4.
//  Copyright (c) 2014年 SUNYEARS___FULLUSERNAME. All rights reserved.
//

#import "myApi.h"

@implementation myApi

//获取当前公司的信息，并且更新
-(NSString *)getMyInfo
{
    @try {
        AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
        
        NSString * uId=myDelegate.entityl.uId;//@"68";
        
        getNowTime * time=[[getNowTime alloc] init];
        NSString * nowt=[time nowTime];
        
        NSString * Upt=@"0";//获取上一次的更新时间
        
        //Kstr=md5(uId|type|Upt|Key|Nowt)
        NSString * Kstr=[Commons md5:[NSString stringWithFormat:@"%@|%@|%@|%@|%@",uId,@"503",Upt,apikey,nowt]];
        
        NSString * surl = [NSString stringWithFormat:@"/app/aiface.php?uId=%@&type=503&Upt=%@&Nowt=%@&Kstr=%@",uId,Upt,nowt,Kstr];
        
        
        NSString * URL = [NSString stringWithFormat:@"%@%@",domainser,surl];
        
        NSLog(@"url------------------:%@",URL);
        
        NSMutableDictionary * dict = [DataService GetDataService:URL];
        
        
        NSError *error = nil;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
        
        if ([jsonData length] > 0 && error == nil){
            error = nil;
            
            id jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:&error];
            
            if (jsonObject != nil && error == nil){
                if ([jsonObject isKindOfClass:[NSDictionary class]]){
                    NSDictionary *d = (NSDictionary *)jsonObject;
                    NSArray * objArray=[d objectForKey:@"result"];
                    myinfo * n = [[myinfo alloc] init];
                    //if([(NSString *)objArray[0] isEqualToString:@"true"]){
                        //单个对象
                        
                        n.uId = uId;
                        n.logopath = (NSString *)objArray[1];
                        n.logopathsm = (NSString *)objArray[0];
                        n.details = (NSString *)objArray[2];
                    
                        n.companycode = uId;
                        myDelegate.myinfol=n;
                        
                        sqlService *sqlser= [[sqlService alloc]init];
                        
                        [sqlser HandleSql:[NSString stringWithFormat:@"delete from myinfo where uId=%@",uId]];
                        
                        //uId,logopath,details,name,logopathsm,companycode
                        NSString * sql1=[NSString stringWithFormat:@"insert into myinfo(uId,logopath,details,name,logopathsm,companycode)values('%@','%@','%@','%@','%@','%@')",uId,n.logopath,n.details,n.name,n.logopathsm,n.companycode];
                        
                        NSLog(@"--------------:%@",sql1);
                        sqlser= [[sqlService alloc]init];
                        [sqlser HandleSql:sql1];
                    
                    //同时去下载文件回来
                    NSString * surl = [NSString stringWithFormat:@"%@",n.details];
                    NSString * fileName=@"about.webarchive";//[entity.zipUrl lastPathComponent];//从路径中获得完整的文件名（带后缀）
                    [myDelegate beginRequest:surl fileName:fileName version:@"1"];
                    
                    surl = [NSString stringWithFormat:@"%@",n.logopath];
                    fileName=@"logopath.png";//[entity.zipUrl lastPathComponent];//从路径中获得完整的文件名（带后缀）
                    [myDelegate beginRequest:surl fileName:fileName version:@"1"];
                    
                    surl = [NSString stringWithFormat:@"%@",n.logopathsm];
                    fileName=@"logopathsm.png";//[entity.zipUrl lastPathComponent];//从路径中获得完整的文件名（带后缀）
                    [myDelegate beginRequest:surl fileName:fileName version:@"1"];
                    
                    //}
                    
                    return @"更新成功！";
                }
                else {
                    NSLog(@"无法解析的数据结构.");
                }
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
        
    }
    @catch (NSException *exception) {
        return nil;
    }
    @finally {
        
    }
    
    return nil;
}

@end
