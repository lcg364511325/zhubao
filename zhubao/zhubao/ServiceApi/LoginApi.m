//
//  LoginApi.m
//  zhubao
//
//  Created by moko on 14-6-2.
//  Copyright (c) 2014年 SUNYEARS___FULLUSERNAME. All rights reserved.
//

#import "LoginApi.h"

@implementation LoginApi

//登录接口
-(LoginEntity *)login:(NSString *)username password:(NSString *)password verlity:(NSString*)verlity
{
    @try {

    getNowTime * time=[[getNowTime alloc] init];
    NSString * nowt=[time nowTime];
    
    NSString * uId=@"0";
    NSString * Upt=@"0";//获取上一次的更新时间
    password=[Commons md5:[NSString stringWithFormat:@"%@",password]];
    
    //Kstr=md5(uId|type|Upt|Key|Nowt|Mobile|Password|machineNO)
    NSString * Kstr=[Commons md5:[NSString stringWithFormat:@"%@|%@|%@|%@|%@|%@|%@|%@",uId,@"501",Upt,apikey,nowt,username,password,verlity]];
    
    NSString * surl = [NSString stringWithFormat:@"/app/aiface.php?uId=%@&type=501&Upt=%@&Nowt=%@&Kstr=%@&Mobile=%@&Password=%@&machineNO=%@",uId,Upt,nowt,Kstr,username,password,verlity];
    
    
    NSString * URL = [NSString stringWithFormat:@"%@%@",domainser,surl];
    
    NSLog(@"url------------------:%@",URL);
    
    NSMutableDictionary * dict = [DataService GetDataService:URL];
    
    
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    
    if ([jsonData length] > 0 && error == nil){
        error = nil;
        
        id jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:&error];
        //{"status":"true","uptime":1372994916,"result":["true",0,0, "李生","21232f297a57a5a743894a0e4a801fc3","2013-12-30","http://app.feicuiwuyu.com/backImg.jpg","http://app.feicuiwuyu.com/logoImg.png","13554791111"]}
        
        if (jsonObject != nil && error == nil){
            if ([jsonObject isKindOfClass:[NSDictionary class]]){
                NSDictionary *d = (NSDictionary *)jsonObject;
                NSArray * objArray=[d objectForKey:@"result"];
                LoginEntity * n = [[LoginEntity alloc] init];
                if([(NSString *)objArray[0] isEqualToString:@"true"]){
                    //单个对象
                    
                    n.uId = (NSString *)objArray[1];
                    n.userType = (NSString *)objArray[2];
                    n.userName = (NSString *)objArray[3];
                    n.userPass = (NSString *)objArray[4];
                    n.userDueDate = (NSString *)objArray[5];
                    n.userTrueName = (NSString *)objArray[6];
                    n.sfUrl = (NSString *)objArray[7];
                    n.lxrName = (NSString *)objArray[8];
                    n.Sex = (NSString *)objArray[9];
                    n.bmName = (NSString *)objArray[10];
                    n.Email = (NSString *)objArray[11];
                    n.Phone = (NSString *)objArray[12];
                    n.Lxphone = (NSString *)objArray[13];
                    n.Sf = (NSString *)objArray[14];
                    n.Cs = (NSString *)objArray[15];
                    n.Address = (NSString *)objArray[16];
                    
                    return n;
                }
                
                return nil;
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
