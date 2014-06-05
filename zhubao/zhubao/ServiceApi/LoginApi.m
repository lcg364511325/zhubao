////
////  LoginApi.m
////  zhubao
////
////  Created by moko on 14-6-2.
////  Copyright (c) 2014年 SUNYEARS___FULLUSERNAME. All rights reserved.
////
//
//#import "LoginApi.h"
//
//@implementation LoginApi
//
////登录接口
//-(LoginEntity *)login:(NSString *)username password:(NSString *)password verlity:(NSString*)verlity
//{
//    
//    NSString * surl = [NSString stringWithFormat:@"Application/checkLogin.ashx?Action=checklogin&UserName=%@&UserPWD=%@&Lcode=%@",username,password,verlity];
//    
//    
//    NSString * URL = [NSString stringWithFormat:@"%@%@",domainser,surl];
//    
//    NSMutableDictionary * dict = [DataService GetDataService:URL];
//    
//    
//    NSError *error = nil;
//    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
//    
//    if ([jsonData length] > 0 && error == nil){
//        error = nil;
//        
//        id jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:&error];
//        
//        if (jsonObject != nil && error == nil){
//            if ([jsonObject isKindOfClass:[NSDictionary class]]){
//                NSDictionary *d = (NSDictionary *)jsonObject;
//                //单个对象
//                LoginEntity * n = [[LoginEntity alloc] init];
//                n.result = [d objectForKey:@"result"];
//                n.info = [d objectForKey:@"info"];
//                //n.webcode = [d objectForKey:@"webcode"];
//                
//                return n;
//            }
//            else {
//                NSLog(@"无法解析的数据结构.");
//            }
//        }
//        else if (error != nil){
//            NSLog(@"%@",error);
//        }
//    }
//    else if ([jsonData length] == 0 &&error == nil){
//        NSLog(@"空的数据集.");
//    }
//    else if (error != nil){
//        NSLog(@"发生致命错误：%@", error);
//    }
//    
//    return nil;
//}
//
//
//
//-(NSMutableArray*)GetNews_yejhd:(int)Page typeid:(int)typeid
//{
//    NSMutableArray * m = [[NSMutableArray alloc] initWithCapacity:20];
//    
//    NSString *urlps=@"sdfds";
//    
//    
//    NSString * URL = [NSString stringWithFormat:@"%@%@",domainser,urlps];
//    
//    NSMutableDictionary * dict = [DataService GetDataService:URL forPage:Page forPageSize:[PSize intValue]];
//    
//    NSError *error = nil;
//    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
//    
//    if ([jsonData length] > 0 && error == nil){
//        error = nil;
//        
//        id jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:&error];
//        
//        if (jsonObject != nil && error == nil){
//            if ([jsonObject isKindOfClass:[NSDictionary class]]){
//                //NSDictionary *deserializedDictionary = (NSDictionary *)jsonObject;
//                //单个对象
//            }
//            else if ([jsonObject isKindOfClass:[NSArray class]]){
//                NSArray * objArray = (NSArray *)jsonObject;
//                
//                for(int i = 0 ; i < objArray.count ; i++)
//                {
//                    NSDictionary * d = (NSDictionary *)objArray[i];
//                    
//                    //                    NewsEntity * n = [[NewsEntity alloc] init];
//                    //                    n.peta_rn = [d objectForKey:@"peta_rn"];
//                    //                    n.ID = [d objectForKey:@"ID"];
//                    //                    n.ArticleTitle = [d objectForKey:@"ArticleTitle"];
//                    //                    n.ArticleType = [d objectForKey:@"ArticleType"];
//                    //                    n.OperatorDate = [d objectForKey:@"OperatorDate"];
//                    //
//                    //                    [m addObject:n];
//                }
//                
//            } else {
//                NSLog(@"无法解析的数据结构.");
//            }
//        }
//        else if (error != nil){
//            NSLog(@"%@",error);
//        }
//    }
//    else if ([jsonData length] == 0 &&error == nil){
//        NSLog(@"空的数据集.");
//    }
//    else if (error != nil){
//        NSLog(@"发生致命错误：%@", error);
//    }
//    
//    return m;
//}
//
//-(id)GetNews_content:(NSString *)newid
//{
//    
//    NSString * surl = [NSString stringWithFormat:@"%@&ID=%@",@"url",newid];
//    
//    
//    NSString * URL = [NSString stringWithFormat:@"%@%@",domainser,surl];
//    
//    NSMutableDictionary * dict = [DataService GetDataService:URL forPage:1 forPageSize:[PSize intValue]];
//    
//    NSError *error = nil;
//    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
//    
//    if ([jsonData length] > 0 && error == nil){
//        error = nil;
//        
//        id jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:&error];
//        
//        if (jsonObject != nil && error == nil){
//            if ([jsonObject isKindOfClass:[NSDictionary class]]){
//                NSDictionary *d = (NSDictionary *)jsonObject;
//                //单个对象
//                //                NewsEntity * n = [[NewsEntity alloc] init];
//                //                n.peta_rn = [d objectForKey:@"peta_rn"];
//                //                n.ID = [d objectForKey:@"ID"];
//                //                n.ArticleTitle = [d objectForKey:@"ArticleTitle"];
//                //                n.ArticleType = [d objectForKey:@"ArticleType"];
//                //                n.OperatorDate = [d objectForKey:@"OperatorDate"];
//                //
//                //                n.ArticleContent = [d objectForKey:@"ArticleContent"];
//                //                n.ReadCount = [d objectForKey:@"ReadCount"];
//                //                n.IsHot = [d objectForKey:@"IsHot"];
//                //
//                //                return n;
//            }
//            else {
//                NSLog(@"无法解析的数据结构.");
//            }
//        }
//        else if (error != nil){
//            NSLog(@"%@",error);
//        }
//    }
//    else if ([jsonData length] == 0 &&error == nil){
//        NSLog(@"空的数据集.");
//    }
//    else if (error != nil){
//        NSLog(@"发生致命错误：%@", error);
//    }
//    
//    return nil;
//}
//
//
//
////查询个人资料
//-(id)schoolPersonnel:(NSString *)username
//{
//    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
//    
//    NSString * surl = [NSString stringWithFormat:@"Application/myInformation.ashx?Action=schoolPersonnel&UserName=%@&webcode=%@",username,@"webcode"];
//    
//    
//    NSString * URL = [NSString stringWithFormat:@"%@%@",domainser,surl];
//    
//    NSMutableDictionary * dict = [DataService GetDataService:URL forPage:1 forPageSize:[PSize intValue]];
//    
//    NSError *error = nil;
//    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
//    
//    if ([jsonData length] > 0 && error == nil){
//        error = nil;
//        
//        id jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:&error];
//        
//        if (jsonObject != nil && error == nil){
//            if ([jsonObject isKindOfClass:[NSDictionary class]]){
//                NSDictionary *dd = (NSDictionary *)jsonObject;
//                
//                NSDictionary *d = (NSDictionary *)[dd objectForKey:@"userInfo"];
//                
//                //单个对象
//                //                ProfileEntity * n = [[ProfileEntity alloc] init];
//                //                n.ID = [d objectForKey:@"ID"];
//                //                n.RealName = [d objectForKey:@"RealName"];
//                //                n.PetName = [d objectForKey:@"PetName"];
//                //                n.Birthday = [d objectForKey:@"Birthday"];
//                //
//                //                n.Sexual = [d objectForKey:@"Sexual"];
//                //                n.BloodType = [d objectForKey:@"BloodType"];
//                //                n.Telphone = [d objectForKey:@"Telphone"];
//                //
//                //                n.Address = [d objectForKey:@"Address"];
//                //                n.Email = [d objectForKey:@"Email"];
//                //                n.HomeTel = [d objectForKey:@"HomeTel"];
//                //                n.PortraitPath = [d objectForKey:@"PortraitPath"];
//                //                n.PersonCode = [d objectForKey:@"PersonCode"];
//                //                n.JoinDate = [d objectForKey:@"JoinDate"];
//                //                n.UserDescribe = [d objectForKey:@"UserDescribe"];
//                //                n.Constellation = [d objectForKey:@"Constellation"];
//                //
//                //                n.contactInfo = [dd objectForKey:@"contactInfo"];
//                //
//                //                return n;
//            }
//            else {
//                NSLog(@"无法解析的数据结构.");
//            }
//        }
//        else if (error != nil){
//            NSLog(@"%@",error);
//        }
//    }
//    else if ([jsonData length] == 0 &&error == nil){
//        NSLog(@"空的数据集.");
//    }
//    else if (error != nil){
//        NSLog(@"发生致命错误：%@", error);
//    }
//    
//    return nil;
//}
//
//
////查询个人资料
//-(id)newDesire:(NSString *)username
//{
//    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
//    
//    NSString * surl = [NSString stringWithFormat:@"Application/myDesire.ashx?Action=newDesire&UserName=%@&webcode=%@",username,@"webcode"];
//    
//    
//    NSString * URL = [NSString stringWithFormat:@"%@%@",domainser,surl];
//    
//    NSMutableDictionary * dict = [DataService GetDataService:URL forPage:1 forPageSize:[PSize intValue]];
//    
//    NSError *error = nil;
//    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
//    
//    if ([jsonData length] > 0 && error == nil){
//        error = nil;
//        
//        id jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:&error];
//        
//        if (jsonObject != nil && error == nil){
//            if ([jsonObject isKindOfClass:[NSDictionary class]]){
//                NSDictionary *d = (NSDictionary *)jsonObject;
//                //单个对象
//                //                DesireEntity * n = [[DesireEntity alloc] init];
//                //                n.ID = [d objectForKey:@"ID"];
//                //                n.DesireContent = [d objectForKey:@"DesireContent"];
//                //                n.ReleaseDate = [d objectForKey:@"ReleaseDate"];
//                //                n.PraiseNumber = [d objectForKey:@"PraiseNumber"];
//                //                
//                //                return n;
//            }
//            else {
//                NSLog(@"无法解析的数据结构.");
//            }
//        }
//        else if (error != nil){
//            NSLog(@"%@",error);
//        }
//    }
//    else if ([jsonData length] == 0 &&error == nil){
//        NSLog(@"空的数据集.");
//    }
//    else if (error != nil){
//        NSLog(@"发生致命错误：%@", error);
//    }
//    
//    return nil;
//}
//
//@end
