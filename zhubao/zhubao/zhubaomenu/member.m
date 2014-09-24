//
//  member.m
//  zhubao
//
//  Created by johnson on 14-5-29.
//  Copyright (c) 2014年 SUNYEARS___FULLUSERNAME. All rights reserved.
//

#import "member.h"
#import "localorder.h"

@interface member ()

@end

@implementation member

@synthesize primaryView;
@synthesize primaryShadeView;
@synthesize fiftharyView;
@synthesize sixthview;
@synthesize shopcartcount;
@synthesize logoImage;
@synthesize checkpassword;
@synthesize submit;

UIWebView *orders;
UIButton* btnBack;

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
    
    checkpassword.secureTextEntry = YES;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)doReg:(id)sender
{
    Index * _Index = [[Index alloc] init];
    
    [self.navigationController pushViewController:_Index animated:NO];
}

-(IBAction)doReg1:(id)sender
{
    product * _product = [[product alloc] init];
    
    [self.navigationController pushViewController:_product animated:NO];
}

-(IBAction)doReg2:(id)sender
{
    NakedDiamond * _NakedDiamond = [[NakedDiamond alloc] init];
    
    [self.navigationController pushViewController:_NakedDiamond animated:NO];
}

-(IBAction)doReg3:(id)sender
{
    ustomtailor * _ustomtailor = [[ustomtailor alloc] init];
    
    [self.navigationController pushViewController:_ustomtailor animated:NO];
}

-(IBAction)doReg4:(id)sender
{
    diploma * _diploma = [[diploma alloc] init];
    
    [self.navigationController pushViewController:_diploma animated:NO];
}


//购物车显示
- (IBAction)goAction:(id)sender
{
    shopcart *samplePopupViewController = [[shopcart alloc] initWithNibName:@"shopcart" bundle:nil];
    samplePopupViewController.mydelegate=self;
    
    [self presentPopupViewController:samplePopupViewController animated:YES completion:^(void) {
        NSLog(@"popup view presented");
    }];
}

-(void)closesc{
    if (self.popupViewController != nil) {
        [self dismissPopupViewControllerAnimated:YES completion:^{
            NSLog(@"popup view dismissed");
        }];
    }
}

//核对密码
-(IBAction)chenckpassword:(id)sender
{
    sixthview.hidden=NO;
    
    
//    if ([[[UIDevice currentDevice]systemVersion]floatValue] < 7.0)
//    {
//        checkpassword.frame = CGRectMake(20, 50, checkpassword.frame.size.width, checkpassword.frame.size.height);
//        
//        _passwordsubmit.frame = CGRectMake(25, 100, _passwordsubmit.frame.size.width, _passwordsubmit.frame.size.height);
//        _passwordexit.frame = CGRectMake(200, 100, _passwordexit.frame.size.width, _passwordexit.frame.size.height);
//    }
}

//关闭核对
-(IBAction)closecheck:(id)sender
{
    checkpassword.text=@"";
    sixthview.hidden=YES;
}

//会员密码修改页面跳转
- (IBAction)goAction1:(id)sender
{
    updatePassword *samplePopupViewController = [[updatePassword alloc] initWithNibName:@"updatePassword" bundle:nil];
    samplePopupViewController.mydelegate=self.parentViewController.self;
    
    [self.parentViewController.self presentPopupViewController:samplePopupViewController animated:YES completion:^(void) {
        NSLog(@"popup view presented");
    }];
}

//会员资料修改页面跳转
- (IBAction)goAction2:(id)sender
{
    memberDetailUpdate *samplePopupViewController = [[memberDetailUpdate alloc] initWithNibName:@"memberDetailUpdate" bundle:nil];
    samplePopupViewController.mydelegate=self.parentViewController.self;
    
    [self.parentViewController.self presentPopupViewController:samplePopupViewController animated:YES completion:^(void) {
        NSLog(@"popup view presented");
    }];
}

//本地商品添加页面跳转页
- (IBAction)addlocalgoods:(id)sender
{
    addlocalgoods *samplePopupViewController = [[addlocalgoods alloc] initWithNibName:@"addlocalgoods" bundle:nil];
    samplePopupViewController.mydelegate=self.parentViewController.self;
    
    [self.parentViewController.self presentPopupViewController:samplePopupViewController animated:YES completion:^(void) {
        NSLog(@"popup view presented");
    }];
}

//本地商品订单列表页面跳转
- (IBAction)localorder:(id)sender
{
    localorder *samplePopupViewController = [[localorder alloc] initWithNibName:@"localorder" bundle:nil];
    samplePopupViewController.mydelegate=self.parentViewController.self;
    
    [self.parentViewController.self presentPopupViewController:samplePopupViewController animated:YES completion:^(void) {
        NSLog(@"popup view presented");
    }];
}

- (void)closeAction2
{
    if (self.popupViewController != nil) {
        [self dismissPopupViewControllerAnimated:YES completion:^{
            NSLog(@"popup view dismissed");
        }];
    }
}

//设置页面跳转
-(IBAction)setup:(id)sender
{
    if ([[[UIDevice currentDevice]systemVersion]floatValue] >= 7.0)
    {
        _settingupdate.frame = CGRectMake(10, 55, _settingupdate.frame.size.width, _settingupdate.frame.size.height);
        _settinglogout.frame = CGRectMake(10, 90, _settinglogout.frame.size.width, _settinglogout.frame.size.height);
        _settingsoftware.frame = CGRectMake(10, 20, _settingsoftware.frame.size.width, _settingsoftware.frame.size.height);
    }
     fiftharyView.hidden=NO;
    fiftharyView.frame=CGRectMake(750, 70, fiftharyView.frame.size.width, fiftharyView.frame.size.height);
}

//软件更新
-(IBAction)updatesofeware:(id)sender
{
    fiftharyView.hidden=YES;
    NSString *rowString =@"当前没有最新版本！";
    UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示" message:rowString delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alter show];
}

//退出登录
-(IBAction)logout:(id)sender
{
    login * _login=[[login alloc] init];
    
    [self.navigationController pushViewController:_login animated:NO];
    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    myDelegate.entityl=[[LoginEntity alloc]init];
}

//更新数据
-(IBAction)updateProductDate:(id)sender
{
    @try {
        //可以在此加代码提示用户说正在加载数据中
//        NSString *rowString =@"正在更新数据。。。。";
//        UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示" message:rowString delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
//        [alter show];
        AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
        [myDelegate showProgressBar:self.view];
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            // 耗时的操作（异步操作）
            
            AutoGetData * getdata=[[AutoGetData alloc] init];
            [getdata getDataInsertTable:0];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //可以在此加代码提示用户，数据已经加载完毕
                [myDelegate stopTimer];
                
                //同步完数据了，则再去下载图片组
                //[getdata getAllZIPPhotos];
                [getdata getAllProductPhotos];
            });
        });
        fiftharyView.hidden=YES;
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
}


//订单页面打开
-(IBAction)openorder:(id)sender
{
    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    //当前时间
    getNowTime * time=[[getNowTime alloc] init];
    NSString * Nowt=[time nowTime];
    //上次更新时间
    NSString *Upt=@"0";
    //订单号
    NSString *orderid=@"0";
    if ([[Commons md5:[NSString stringWithFormat:@"%@",checkpassword.text]] isEqualToString:myDelegate.entityl.userPass]) {
        sixthview.hidden=YES;
        checkpassword.text=@"";
        NSString * Kstr=[Commons md5:[NSString stringWithFormat:@"%@|%@|%@|%@|%@|%@",myDelegate.entityl.uId,@"601",Upt,apikey,Nowt,orderid]];
        NSString * surl = [NSString stringWithFormat:@"%@/app/aiface.php?uId=%@&type=601&Upt=%@&Nowt=%@&Kstr=%@&ordid=%@",domainser,myDelegate.entityl.uId,Upt,Nowt,Kstr,orderid];

        //在新的view里面打开
        CGRect frame_0= CGRectMake(20, 20, self.view.frame.size.width-40, self.view.frame.size.height-40);
        orders =[[UIWebView alloc]initWithFrame:frame_0];
        NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:surl]];
        [orders loadRequest:request];
        [self.parentViewController.self.view addSubview:orders];
        
        UIImage* image= [UIImage imageNamed:@"close"];
        CGRect frame_1= CGRectMake(self.view.frame.size.width-50, 5, 48, 48);
        btnBack= [[UIButton alloc] initWithFrame:frame_1];
        [btnBack setBackgroundImage:image forState:UIControlStateNormal];
        [btnBack addTarget:self action:@selector(goActionback:) forControlEvents:UIControlEventTouchUpInside];
        [self.parentViewController.self.view addSubview:btnBack];
        
        //[[UIApplication sharedApplication] openURL:[NSURL URLWithString:surl]];
    }else{
        checkpassword.text=nil;
        NSString *rowString =@"请输入正确密码！";
        UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示" message:rowString delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alter show];
    }
}

-(void)goActionback:(id)sender
{
    [orders removeFromSuperview];
    [btnBack removeFromSuperview];
    orders=nil;
    btnBack=nil;
}

//点击tableview以外的地方触发事件
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint pt = [touch locationInView:self.view];
    if (!CGRectContainsPoint([fiftharyView frame], pt)) {
        //to-do
        fiftharyView.hidden=YES;
    }
}

// 更新ui
-(IBAction)updateUI:(id)sender
{
    NSString *rowString =@"正在更新数据。。。。";
    UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示" message:rowString delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
    [alter show];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 耗时的操作（异步操作）
        
        myApi *sql=[[myApi alloc]init];
        NSString *info=[sql getMyInfo];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [alter dismissWithClickedButtonIndex:0 animated:YES];
            if (info) {
                
                 [self.parentViewController.self performSelector:@selector(updateIndexUI)];
                
                UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示" message:info delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alter show];
            }else{
                NSString *rowString =@"更新失败";
                UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示" message:rowString delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alter show];
            }
            
        });
    });

}
//
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSLog(@" button index=%d is clicked.....", buttonIndex);
    if (buttonIndex==1) {
        [self docleargoodsdata];
    }else{
        return;
    }
    return;
}

//清除商品数据
-(IBAction)cleargoodsdate:(id)sender
{
    
    NSString *rowString =@"是否清除商品数据？";
    UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示" message:rowString delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alter show];

}
//清除商品数据
-(void)docleargoodsdata
{
    NSString *rowString =@"正在清除商品数据。。。。";
    UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示" message:rowString delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
    [alter show];
    sqlService *sql=[[sqlService alloc]init];
    BOOL state=[sql ClearTableDatas:@"product"];
    [alter dismissWithClickedButtonIndex:0 animated:YES];
    if (state) {
        //删除压缩文件
        NSString *extension = @"zip";
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        
        NSArray *contents = [fileManager contentsOfDirectoryAtPath:documentsDirectory error:NULL];
        NSEnumerator *e = [contents objectEnumerator];
        NSString *filename;
        while ((filename = [e nextObject])) {
            
            if ([[filename pathExtension] isEqualToString:extension]) {
                
                [fileManager removeItemAtPath:[documentsDirectory stringByAppendingPathComponent:filename] error:NULL];
            }
        }
        //删除3d图片
        NSString *documentsDirectoryt =[documentsDirectory stringByAppendingString:@"/images"];
        NSArray *contentst = [fileManager contentsOfDirectoryAtPath:documentsDirectoryt error:NULL];
        NSEnumerator *et = [contentst objectEnumerator];
        NSString *filenamet;
        while ((filenamet = [et nextObject])) {
            
            if ([[filenamet pathExtension] isEqualToString:@"jpg"]) {
                
                [fileManager removeItemAtPath:[documentsDirectoryt stringByAppendingPathComponent:filenamet] error:NULL];
            }
        }
        
        //删除大小图
        //获取沙盒中缓存文件目录
        NSString *cacheDirectory = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
        cacheDirectory =[cacheDirectory stringByAppendingString:@"/com.xmly"];
        NSArray *contentcacheDirectory = [fileManager contentsOfDirectoryAtPath:cacheDirectory error:NULL];
        NSEnumerator *ett = [contentcacheDirectory objectEnumerator];
        NSString *filenamett;
        while ((filenamett = [ett nextObject])) {
            
            if ([[filenamett pathExtension] isEqualToString:@"jpg"]) {
                
                [fileManager removeItemAtPath:[cacheDirectory stringByAppendingPathComponent:filenamett] error:NULL];
            }
        }
        
        NSString *rowString =@"清除成功";
        UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示" message:rowString delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alter show];
    }else{
        NSString *rowString =@"清除失败";
        UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示" message:rowString delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alter show];
    }
}

-(void)refleshBuycutData
{
    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    sqlService *sql=[[sqlService alloc]init];
    myDelegate.entityl.resultcount=[sql getBuyproductcount:myDelegate.entityl.uId];
    NSString *goodscount=myDelegate.entityl.resultcount;
    if (goodscount && ![goodscount isEqualToString:@""] && ![goodscount isEqualToString:@"0"]) {
        shopcartcount.hidden=NO;
        [shopcartcount setTitle:goodscount forState:UIControlStateNormal];
    }else{
        shopcartcount.hidden=YES;
    }
    sqlService *shopcar=[[sqlService alloc] init];
    shoppingcartlist=[shopcar GetBuyproductList:myDelegate.entityl.uId];
    shopcart *scg=[[shopcart alloc]init];
    [scg reloadshopcart];
    
}

@end
