//
//  productApi.m
//  zhubao
//
//  Created by moko on 14-6-4.
//  Copyright (c) 2014年 SUNYEARS___FULLUSERNAME. All rights reserved.
//

#import "productApi.h"

@implementation productApi


//获取商品的价格
//classId产品类别 goldType材质 goldWeight金重 mDiaWeight主石重 mDiaColor主石颜色 mVVS	主石净度 sDiaWeight副石重 sCount副石数量 proid商品的id
-(NSString *)getPrice:(NSString *)classId goldType:(NSString *)goldType goldWeight:(NSString*)goldWeight mDiaWeight:(NSString *)mDiaWeight mDiaColor:(NSString*)mDiaColor mVVS:(NSString*)mVVS sDiaWeight:(NSString*)sDiaWeight sCount:(NSString*)sCount proid:(NSString*)proid{
    
    @try {
        
        AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
        
        NSString * uId=myDelegate.entityl.uId;
        NSString * Upt=@"0";//获取上一次的更新时间
        
        getNowTime * time=[[getNowTime alloc] init];
        NSString * Nowt=[time nowTime];
        
        NSString * params=[NSString stringWithFormat:@"classId=%@&goldType=%@&goldWeight=%@&mDiaWeight=%@&mDiaColor=%@&mVVS=%@&sDiaWeight=%@&sCount=%@",classId,goldType,goldWeight,mDiaWeight,mDiaColor,mVVS,sDiaWeight,sCount];
        
        //Kstr=md5(uId|type|Upt|Key|Nowt)
        NSString * Kstr=[Commons md5:[NSString stringWithFormat:@"%@|%@|%@|%@|%@",uId,@"104",Upt,apikey,Nowt]];
        
        NSString * surl = [NSString stringWithFormat:@"/app/appinterface.php?uId=%@&type=104&Upt=%@&Nowt=%@&Kstr=%@",uId,Upt,Nowt,Kstr];
        
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
                        return 0;
                    }
                    
                    NSArray * objArray=[d objectForKey:@"result"];
                    for(int i = 0 ; i < objArray.count ; i++){
                        
                        NSArray * valuearray = objArray[i];
                        if ([valuearray[0] isEqualToString:proid]) {
                            return valuearray[1];
                        }

                    }

                    return 0;
                    
                }else if ([jsonObject isKindOfClass:[NSArray class]]){
                    
                }
                else {
                    NSLog(@"无法解析的数据结构.");
                }
                
                return 0;
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
    return 0;
    
}

@end
