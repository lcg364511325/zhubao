//
//  orderApi.m
//  zhubao
//
//  Created by moko on 14-6-4.
//  Copyright (c) 2014年 SUNYEARS___FULLUSERNAME. All rights reserved.
//

#import "orderApi.h"

@implementation orderApi

//提交订单
-(buyproduct*)submitOrder:(buyproduct *)entity{
    
    @try {
        
        AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
        
        NSString * uId=myDelegate.entityl.uId;
        NSString * Upt=@"0";//获取上一次的更新时间
        
        getNowTime * time=[[getNowTime alloc] init];
        NSString * Nowt=[time nowTime];

        //NSString * params=[NSString stringWithFormat:@"userTrueName=%@&sfUrl=%@&lxrName=%@&Sex=%@&bmName=%@&Email=%@&Phone=%@&Lxphone=%@&Sf=%@&Cs=%@&Address=%@&",entity.userTrueName,entity.sfUrl,entity.lxrName,entity.Sex,entity.bmName,entity.Email,entity.Phone,entity.Lxphone,entity.Sf,entity.Cs,entity.Address];
        
        NSString * params=@"";
        
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

//上传例子
- (void) upload{
    
    NSURL *URL = [NSURL URLWithString:@"http://www.google.com/speech-api/v1/recognize?xjerr=1&client=chromium&lang=zh-CN&maxresults=9"];
    ASIHTTPRequest *request = [[ASIHTTPRequest alloc]initWithURL:URL];
    
    [request addRequestHeader:@"User-Agent" value:@"ASIHTTPRequest"];
    [request addRequestHeader:@"Content-Type" value:@"audio/x-flac; rate=16000"];
    
    [request setRequestMethod:@"POST"];
    
    NSData *data = [NSData dataWithContentsOfFile:@"/Users/adminadmin/Desktop/hello.flac"];
    NSLog(@"date:%@",data);
    [request appendPostData:data];
    //[request setDidFinishSelector:@selector(didFinishPost:)];
    //[request setDidFailSelector:@selector(didFailedPost:)];
    
    [request setDelegate:self];
    [request startSynchronous];
    
}

@end
