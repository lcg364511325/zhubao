//
//  customerApi.m
//  zhubao
//
//  Created by moko on 14-6-4.
//  Copyright (c) 2014年 SUNYEARS___FULLUSERNAME. All rights reserved.
//

#import "customerApi.h"

@implementation customerApi

//更新当前用户的基本信息
-(customer*)updateCustomer:(customer *)entity{
    
    @try {
        
        AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
        
        NSString * uId=myDelegate.entityl.uId;
        NSString * Upt=@"0";//获取上一次的更新时间
        
        getNowTime * time=[[getNowTime alloc] init];
        NSString * Nowt=[time nowTime];
        
//        userTrueName	String	“”	真实姓名/企业名称
//        sfUrl	String	“”	个人身份证扫描件图片地址
//        lxrName	String	“”	企业联系人姓名
//        Sex	Int	0	企业联系人性别/个人用户性别
//        bmName	Int	0	企业联系人所在部门
//        Email	String	“”	邮箱
//        Phone	String	“”	企业联系人电话，个人用户手机号
//        Lxphone	String	“”	企业联系人手机号
//        Sf	String	“”	省份
//        Cs	String	“”	城市
//        Address	String	“”	详细街道地址
        
        NSString * params=[NSString stringWithFormat:@"userTrueName=%@&sfUrl=%@&lxrName=%@&Sex=%@&bmName=%@&Email=%@&Phone=%@&Lxphone=%@&Sf=%@&Cs=%@&Address=%@&",entity.userTrueName,entity.sfUrl,entity.lxrName,entity.Sex,entity.bmName,entity.Email,entity.Phone,entity.Lxphone,entity.Sf,entity.Cs,entity.Address];
        
        //Kstr=md5(uId|type|Upt|Key|Nowt)
        NSString * Kstr=[Commons md5:[NSString stringWithFormat:@"%@|%@|%@|%@|%@",uId,@"502",Upt,apikey,Nowt]];
        
        NSString * surl = [NSString stringWithFormat:@"/app/appinterface.php?uId=%@&type=502&Upt=%@&Nowt=%@&Kstr=%@",uId,Upt,Nowt,Kstr];

        NSString * URL = [NSString stringWithFormat:@"%@%@",domainser,surl];
        
        NSMutableDictionary * dict = [DataService PostDataService:URL postDatas:(NSString*)params];//[DataService GetDataService:URL];
        
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
                        return nil;
                    }
                    
                    return entity;
                    
                }else if ([jsonObject isKindOfClass:[NSArray class]]){
                    
                }
                else {
                    NSLog(@"无法解析的数据结构.");
                }
                
                return nil;
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
    return nil;
    
}

//更新当前用户的密码
-(customer*)updateCustomerPassword:(customer *)entity{
    
    @try {
        
        AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
        
        NSString * uId=myDelegate.entityl.uId;
        NSString * Upt=@"0";//获取上一次的更新时间
        
        getNowTime * time=[[getNowTime alloc] init];
        NSString * Nowt=[time nowTime];
        
        NSString * Password=entity.oldpassword;//已加密码32位md5
        NSString * NewPassword=entity.userPass;//已加密码32位md5

        //Kstr=md5(uId|type|Upt|Key|Nowt|Password|NewPassword)
        NSString * Kstr=[Commons md5:[NSString stringWithFormat:@"%@|%@|%@|%@|%@|%@|%@",uId,@"500",Upt,apikey,Nowt,Password,NewPassword]];
        
        NSString * surl = [NSString stringWithFormat:@"/app/appinterface.php?uId=%@&type=500&Upt=%@&Nowt=%@&Kstr=%@&Password=%@&NewPassword=%@",uId,Upt,Nowt,Kstr,Password,NewPassword];
        
        NSString * URL = [NSString stringWithFormat:@"%@%@",domainser,surl];
        
        NSMutableDictionary * dict = [DataService GetDataService:URL];
        
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
                        return nil;
                    }
                    
                    return entity;
                    
                }else if ([jsonObject isKindOfClass:[NSArray class]]){
                    
                }
                else {
                    NSLog(@"无法解析的数据结构.");
                }
                
                return nil;
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
    return nil;
    
}

@end
