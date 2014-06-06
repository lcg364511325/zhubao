//
//  login.m
//  zhubao
//
//  Created by moko on 14-6-4.
//  Copyright (c) 2014年 SUNYEARS___FULLUSERNAME. All rights reserved.
//

#import "login.h"

@interface login ()

@end

@implementation login

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //shengyu    222222
    _account.text=@"shengyu";
    _password.text=@"222222";
    
    NSDate *  senddate=[NSDate date];
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"YYYYMMdd"];
    NSString *  locationString=[dateformatter stringFromDate:senddate];
    
    //判断当前天是否已经有更新过数据了
    if (![locationString isEqualToString:(NSString *)[[NSUserDefaults standardUserDefaults]objectForKey:@"autodata"]]) {
        
        [self autogetData];
    }
}

-(id)autogetData{
    @try {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            // 耗时的操作（异步操作）
        
            AutoGetData * getdata=[[AutoGetData alloc] init];
            [getdata getDataInsertTable];
        
            dispatch_async(dispatch_get_main_queue(), ^{
                // 更新界面（处理结果）
                NSDate *  senddate=[NSDate date];
                NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
                [dateformatter setDateFormat:@"YYYYMMdd"];
                NSString *  locationString=[dateformatter stringFromDate:senddate];
                
                //标识今天已经更新过数据了
                [[NSUserDefaults standardUserDefaults]setObject:locationString forKey:@"autodata"];

            });
        });
    }
    @catch (NSException *exception) {
    
    }
    @finally {
    
    }

}

-(IBAction)loginAction:(id)sender
{
    @try {
        
        UIButton *resultButton = (UIButton *)sender;
        
        [resultButton setTitle:@"正努力登录中..." forState:UIControlStateNormal];
        [resultButton setTag:1];
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            // 耗时的操作（异步操作）
            
            NSString * code = @"";
            NSString * account = _account.text;
            NSString * password = _password.text;
            
            LoginApi * service = [[LoginApi alloc] init];
            LoginEntity * result = [service login:account password:password verlity:code];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                // 更新界面（处理结果）
                if(result){
                    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
                    
                    myDelegate.entityl=result;
                    
                    //登录成功，进入系统首页
                    NSLog(@"登录成功，进入系统首页");
                    //Index *sysmenu=[[Index alloc] init];
                    FVImageSequenceDemoViewController *sysmenu=[[FVImageSequenceDemoViewController alloc] init];
                    [self.navigationController pushViewController:sysmenu animated:NO];
                    
                    
                }else{
                    //测试中，进入系统首页
                    
                    NSString *info=@"登录失败！";
                    // NSLog(@"登录失败------:%@",info);
                    [[[UIAlertView alloc] initWithTitle:@"信息提示" message:info delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil, nil] show];
                }
                
                [resultButton setTitle:@"登录" forState:UIControlStateNormal];
                [resultButton setTag:0];
            });
        });
        
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
