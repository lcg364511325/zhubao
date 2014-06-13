//
//  orderApi.m
//  zhubao
//
//  Created by moko on 14-6-4.
//  Copyright (c) 2014年 SUNYEARS___FULLUSERNAME. All rights reserved.
//

#import "orderApi.h"

@implementation orderApi

//提交订单  CPInfo商品数组  DZInfo高级定制
-(BOOL*)submitOrder:(NSString *)CPInfo DZInfo:(NSString *)DZInfo uploadpath:(NSMutableArray *)uploadpath{
    
    @try {
        
        AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
        
        NSString * uId=myDelegate.entityl.uId;
        NSString * Upt=@"0";//获取上一次的更新时间
        
        getNowTime * time=[[getNowTime alloc] init];
        NSString * Nowt=[time nowTime];
        
        //NSString * params=[NSString stringWithFormat:@"CPInfo=%@&DZInfo=%@",CPInfo,DZInfo];
        
        //Kstr=md5(uId|type|Upt|Key|Nowt)
        NSString * Kstr=[Commons md5:[NSString stringWithFormat:@"%@|%@|%@|%@|%@",uId,@"600",Upt,apikey,Nowt]];
        
        NSString * surl = [NSString stringWithFormat:@"/app/appinterface.php?uId=%@&type=600&Upt=%@&Nowt=%@&Kstr=%@",uId,Upt,Nowt,Kstr];
        
        NSString * URL = [NSString stringWithFormat:@"%@%@",domainser,surl];
        
        //NSMutableDictionary * dict = [DataService PostDataService:URL postDatas:(NSString*)params];//[DataService GetDataService:URL];
        
        ASIFormDataRequest *uploadImageRequest= [ ASIFormDataRequest requestWithURL : [NSURL URLWithString:[URL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] ]];
        
        [uploadImageRequest setStringEncoding:NSUTF8StringEncoding];
        [uploadImageRequest setRequestMethod:@"POST"];
        [uploadImageRequest setPostValue:CPInfo forKey:@"CPInfo"];
        [uploadImageRequest setPostValue:DZInfo forKey:@"DZInfo"];
        [uploadImageRequest setPostFormat:ASIMultipartFormDataPostFormat];
        
        int i=0;
        for (NSString *eImage in uploadpath)
        {
            i++;
            NSData *imageData = [NSData dataWithContentsOfFile:eImage];
            //NSData *imageData=UIImageJPEGRepresentation(eImage,100);
            //NSString *photoName=[NSString stringWithFormat:@"file%d.jpg",i];
            NSString * photoName=[eImage lastPathComponent];//从路径中获得完整的文件名（带后缀）
            //NSString *photoDescribe=@" ";
            //NSLog(@"photoName=%@",photoName);
            //NSLog(@"photoDescribe=%@",photoDescribe);
            NSLog(@"图片大小+++++%d",[imageData length]/1024);
            //照片content
            //[uploadImageRequest setPostValue:photoDescribe forKey:@"photoContent"];
            [uploadImageRequest addData:imageData withFileName:photoName andContentType:@"image/jpeg" forKey:@"photoContent"];
        }
        
        [uploadImageRequest setDelegate : self ];
        [uploadImageRequest setDidFinishSelector : @selector (responseComplete:)];
        [uploadImageRequest setDidFailSelector : @selector (responseFailed:)];
        [uploadImageRequest startAsynchronous];

        
    }@catch (NSException *exception) {
        
    }
    @finally {
        
    }
    return nil;
    
}

//数据提交上传完成
-(void)responseComplete:(ASIHTTPRequest*)request
{
    @try {
        //Use when fetching text data
        NSString *responseString = [request responseString];
        
        //Use when fetching binary data
        NSData *jsonData = [request responseData];
 
        NSError *error = nil;
        if ([jsonData length] > 0 && error == nil){
            error = nil;
            
            id jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:&error];
            
            if (jsonObject != nil && error == nil){
                if ([jsonObject isKindOfClass:[NSDictionary class]])
                {
                    NSDictionary *d = (NSDictionary *)jsonObject;
                    NSString * status=[d objectForKey:@"status"];
                    if ([status isEqualToString:@"false"]) {
                        //提交失败
                        
                    }
                    
                    NSArray * objArray=[d objectForKey:@"result"];
                    NSString * returnstatus=objArray[0];
                    if([returnstatus isEqualToString:@"true"]){
                        //提交成功
                        
                        AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
                        //清空购物车的信息
                        sqlService *sqlser=[[sqlService alloc]init];
                        [sqlser ClearTableDatas:[NSString stringWithFormat:@"buyproduct where customerid=%@",myDelegate.entityl.uId]];
                        
                        [[[UIAlertView alloc] initWithTitle:@"信息提示" message:@"生成订单成功" delegate:myDelegate cancelButtonTitle:@"取消" otherButtonTitles:nil, nil] show];
                        
                        return;
                    }
                    
                }else if ([jsonObject isKindOfClass:[NSArray class]]){
                    
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
        
    }
    @finally {
        
    }
    
    [[[UIAlertView alloc] initWithTitle:@"信息提示" message:@"生成订单失败" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil, nil] show];

}

//提交上传数据失败
-(void)responseFailed:(ASIHTTPRequest *)request
{
    
    NSError *error = [request error];
    
    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    [[[UIAlertView alloc] initWithTitle:@"信息提示" message:@"提交订单数据失败" delegate:myDelegate cancelButtonTitle:@"取消" otherButtonTitles:nil, nil] show];
    
}

//上传例子
- (void) upload{
    
//    NSURL *URL = [NSURL URLWithString:@"http://www.google.com/speech-api/v1/recognize?xjerr=1&client=chromium&lang=zh-CN&maxresults=9"];
//    ASIHTTPRequest *request = [[ASIHTTPRequest alloc]initWithURL:URL];
    
//    [request addRequestHeader:@"User-Agent" value:@"ASIHTTPRequest"];
//    [request addRequestHeader:@"Content-Type" value:@"audio/x-flac; rate=16000"];
//    
//    [request setRequestMethod:@"POST"];
//    //提交的文件
//    NSData *data = [NSData dataWithContentsOfFile:@"/Users/adminadmin/Desktop/hello.flac"];
//    NSLog(@"date:%@",data);
//    [request appendPostData:data];
//    //[request setDidFinishSelector:@selector(didFinishPost:)];
//    //[request setDidFailSelector:@selector(didFailedPost:)];
//    
//    [request setDelegate:self];
//    [request startSynchronous];

    
}

@end
