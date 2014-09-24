//
//  Index.m
//  zhubao
//
//  Created by johnson on 14-5-27.
//  Copyright (c) 2014年 SUNYEARS___FULLUSERNAME. All rights reserved.
//

#import "Index.h"

@interface Index ()

@end

@implementation Index

@synthesize primaryView;
@synthesize primaryShadeView;
@synthesize thridView;
@synthesize fourthView;
@synthesize fivethview;
@synthesize shopcartcountButton;
@synthesize logoImage;
@synthesize checkpassword;

myindex *_myindex;
product *_product;
NakedDiamond *_NakedDiamond;
ustomtailor *_ustomtailor;
diploma *_diploma;
member *_member;

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
    [self.navigationController setNavigationBarHidden:YES];
     AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    
    sqlService * sql=[[sqlService alloc]init];
    myDelegate.entityl.resultcount=[sql getBuyproductcount:myDelegate.entityl.uId];

    sql=[[sqlService alloc]init];
    myDelegate.myinfol=[sql getMyinfo:myDelegate.entityl.uId];
    
    NSString *goodscount=myDelegate.entityl.resultcount;
    if (goodscount && ![goodscount isEqualToString:@""] && ![goodscount isEqualToString:@"0"]) {
        shopcartcountButton.hidden=NO;
        [shopcartcountButton setTitle:goodscount forState:UIControlStateNormal];
    }else{
        shopcartcountButton.hidden=YES;
    }

    
    _myindex=[[myindex alloc] init];
    [self addChildViewController:_myindex];

    _product=[[product alloc] init];
    [self addChildViewController:_product];
    
    _NakedDiamond=[[NakedDiamond alloc] init];
    [self addChildViewController:_NakedDiamond];
    
    _ustomtailor=[[ustomtailor alloc] init];
    [self addChildViewController:_ustomtailor];
    
    _diploma=[[diploma alloc] init];
    [self addChildViewController:_diploma];
    
    _member=[[member alloc] init];
    [self addChildViewController:_member];
    
    
    [fourthView addSubview:_myindex.view];
    currentViewController=_myindex;
    
    
    //更新ui(如果已经存在的，则不再自动更新)
    //[self loadmyInfo];
    
    NSString *logopathsm = [[Tool getTargetFloderPath] stringByAppendingPathComponent:[NSString stringWithFormat:@"logopathsm.png"]];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:logopathsm]) {
        [logoImage setImage:[[UIImage alloc] initWithContentsOfFile:logopathsm]];
    }
    else {
        [logoImage setImage:[UIImage imageNamed:@"logo"]];
    }
    
}

//更新ui
-(void)loadmyInfo
{
    @try {
        
        NSString *logopathsm = [[Tool getTargetFloderPath] stringByAppendingPathComponent:[NSString stringWithFormat:@"logopathsm.png"]];
        
        if ([[NSFileManager defaultManager] fileExistsAtPath:logopathsm]) {
            [logoImage setImage:[[UIImage alloc] initWithContentsOfFile:logopathsm]];
        }
        else {
            [logoImage setImage:[UIImage imageNamed:@"logo"]];
        }
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            // 耗时的操作（异步操作）
            bool isexists=true;
            if (![[NSFileManager defaultManager] fileExistsAtPath:logopathsm]){
                myApi *myapi=[[myApi alloc]init];
                [myapi getMyInfo];
                isexists=false;
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                // 更新界面（处理结果）

                if (!isexists){
                    
                    sleep(1);//等1秒再执行
                    
                    if ([[NSFileManager defaultManager] fileExistsAtPath:logopathsm]) {
                        [logoImage setImage:[[UIImage alloc] initWithContentsOfFile:logopathsm]];
                    }
                    else {
                        [logoImage setImage:[UIImage imageNamed:@"logo"]];
                    }
                }
            });
        });
        
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
    
}

// 更新ui
-(void)updateIndexUI
{
//    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
//    NSURL *imgUrl=[NSURL URLWithString:[NSString stringWithFormat:@"%@",myDelegate.myinfol.logopathsm]];
//    NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:imgUrl,@"url",logoImage,@"imageView",nil];
//    [NSThread detachNewThreadSelector:@selector(cacheImage:) toTarget:[ImageCacher defaultCacher] withObject:dic];
    
    NSString *logopathsm = [[Tool getTargetFloderPath] stringByAppendingPathComponent:[NSString stringWithFormat:@"logopathsm.png"]];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:logopathsm]) {
        [logoImage setImage:[[UIImage alloc] initWithContentsOfFile:logopathsm]];
    }
    else {
        [logoImage setImage:[UIImage imageNamed:@"logo"]];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)doReg0:(id)sender
{
    if (currentViewController==_myindex) {
        return;
    }
    UIViewController *oldViewController=currentViewController;
    _selectmenu.frame=CGRectMake(0, 110, _selectmenu.frame.size.width, _selectmenu.frame.size.height);
    [self transitionFromViewController:currentViewController toViewController:_myindex duration:1 options:UIViewAnimationOptionTransitionCurlUp animations:^{
    }  completion:^(BOOL finished) {
        if (finished) {
            currentViewController=_myindex;
        }else{
            currentViewController=oldViewController;
        }
    }];
}

-(IBAction)doReg:(id)sender
{
    if (currentViewController==_product) {
        return;
    }
    UIViewController *oldViewController=currentViewController;
    _selectmenu.frame=CGRectMake(0, 179, _selectmenu.frame.size.width, _selectmenu.frame.size.height);
    
    [self transitionFromViewController:currentViewController toViewController:_product duration:1 options:UIViewAnimationOptionAllowUserInteraction animations:^{
    }  completion:^(BOOL finished) {
        if (finished) {
            currentViewController=_product;
        }else{
            currentViewController=oldViewController;
        }
    }];
    
//    product * _product = [[product alloc] init];
//    
//    [self.navigationController pushViewController:_product animated:NO];
}

-(IBAction)doReg1:(id)sender
{
    if (currentViewController==_NakedDiamond) {
        return;
    }
    UIViewController *oldViewController=currentViewController;
    _selectmenu.frame=CGRectMake(0, 248, _selectmenu.frame.size.width, _selectmenu.frame.size.height);
    [self transitionFromViewController:currentViewController toViewController:_NakedDiamond duration:1 options:UIViewAnimationOptionTransitionCurlUp animations:^{
    }  completion:^(BOOL finished) {
        if (finished) {
            currentViewController=_NakedDiamond;
        }else{
            currentViewController=oldViewController;
        }
    }];
    
//    NakedDiamond * _NakedDiamond = [[NakedDiamond alloc] init];
//    
//    [self.navigationController pushViewController:_NakedDiamond animated:NO];
}

-(IBAction)doReg2:(id)sender
{
    if (currentViewController==_ustomtailor) {
        return;
    }
    UIViewController *oldViewController=currentViewController;
     _selectmenu.frame=CGRectMake(0, 317, _selectmenu.frame.size.width, _selectmenu.frame.size.height);
    
    [self transitionFromViewController:currentViewController toViewController:_ustomtailor duration:1 options:UIViewAnimationOptionTransitionCurlUp animations:^{
    }  completion:^(BOOL finished) {
        if (finished) {
            currentViewController=_ustomtailor;
        }else{
            currentViewController=oldViewController;
        }
    }];
    
//    ustomtailor * _ustomtailor=[[ustomtailor alloc] init];
//    
//    [self.navigationController pushViewController:_ustomtailor animated:NO];
}

-(IBAction)doReg3:(id)sender
{
    if (currentViewController==_diploma) {
        return;
    }
    UIViewController *oldViewController=currentViewController;
    _selectmenu.frame=CGRectMake(0, 386, _selectmenu.frame.size.width, _selectmenu.frame.size.height);
    [self transitionFromViewController:currentViewController toViewController:_diploma duration:1 options:UIViewAnimationOptionTransitionCurlUp animations:^{
    }  completion:^(BOOL finished) {
        if (finished) {
            currentViewController=_diploma;
        }else{
            currentViewController=oldViewController;
        }
    }];
    
//    diploma * _diploma = [[diploma alloc] init];
//    
//    [self.navigationController pushViewController:_diploma animated:NO];
}

-(IBAction)doReg4:(id)sender
{
    if (currentViewController==_member) {
        return;
    }
    UIViewController *oldViewController=currentViewController;
    _selectmenu.frame=CGRectMake(0, 455, _selectmenu.frame.size.width, _selectmenu.frame.size.height);
    
    [self transitionFromViewController:currentViewController toViewController:_member duration:1 options:UIViewAnimationOptionTransitionCurlUp animations:^{
    }  completion:^(BOOL finished) {
        if (finished) {
            currentViewController=_member;
        }else{
            currentViewController=oldViewController;
        }
    }];
    
//    member * _member = [[member alloc] init];
//    
//    [self.navigationController pushViewController:_member animated:NO];
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

-(IBAction)setup:(id)sender
{
    if ([[[UIDevice currentDevice]systemVersion]floatValue] >= 7.0)
    {
        _settingupdate.frame = CGRectMake(10, 55, _settingupdate.frame.size.width, _settingupdate.frame.size.height);
        _settinglogout.frame = CGRectMake(10, 90, _settinglogout.frame.size.width, _settinglogout.frame.size.height);
         _settingsoftware.frame = CGRectMake(10, 20, _settingsoftware.frame.size.width, _settingsoftware.frame.size.height);
    }
    
    thridView.hidden=NO;
    thridView.frame=CGRectMake(750, 70, thridView.frame.size.width, thridView.frame.size.height);
}


//软件更新
-(IBAction)updatesofeware:(id)sender
{
    isverson=1;
    thridView.hidden=YES;
    getNowTime * time=[[getNowTime alloc] init];
    NSString * nowt=[time nowTime];
    
    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    
    NSString * uId=myDelegate.entityl.uId;
    NSString * Upt=@"0";//获取上一次的更新时间
    //Kstr=md5(uId|type|Upt|Key|Nowt|cid)
    NSString * Kstr=[Commons md5:[NSString stringWithFormat:@"%@|%@|%@|%@|%@",uId,@"9997",Upt,apikey,nowt]];
    
    NSString * surl = [NSString stringWithFormat:@"/app/aifacen.php?uId=%@&type=9997&Upt=%@&Nowt=%@&Kstr=%@",uId,Upt,nowt,Kstr];
    
    
    NSString * URL = [NSString stringWithFormat:@"%@%@",domainser,surl];
    NSMutableDictionary * dict = [DataService GetDataService:URL];
    NSString *status=[NSString stringWithFormat:@"%@",[dict objectForKey:@"status"]];
    if ([status isEqualToString:@"true"]) {
        NSArray *versoninfo=[[dict objectForKey:@"result"] objectAtIndex:0];
        url=[NSString stringWithFormat:@"%@",[versoninfo objectAtIndex:0]];
        NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
        NSString *oldappVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
        NSString *newappVersion=[NSString stringWithFormat:@"%@",[versoninfo objectAtIndex:2]];
        if (![oldappVersion isEqualToString:newappVersion]) {
            NSString *rowString =[NSString stringWithFormat:@"更新内容：%@",[versoninfo objectAtIndex:1]];
            UIAlertView * alter = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"发现新版本%@,是否升级？",newappVersion] message:rowString delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            [alter show];
        }else
        {
            NSString *rowString =@"当前版本已是最新版本";
            UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示" message:rowString delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alter show];
        }
    }else
    {
        NSString *rowString =@"未知错误";
        UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示" message:rowString delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alter show];
    }
}

//退出登录
-(IBAction)logout:(id)sender
{
    login * _login=[[login alloc] init];
    
    [self.navigationController pushViewController:_login animated:NO];
    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    myDelegate.entityl=[[LoginEntity alloc]init];
}


//alertview响应事件
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (isverson==1) {
        if (buttonIndex==1) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
        }
        isverson=0;
    }else{
        AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
        sqlService *shopcar=[[sqlService alloc] init];
        shoppingcartlist=[shopcar GetBuyproductList:myDelegate.entityl.uId];
        shopcart *scg=[[shopcart alloc]init];
        [scg reloadshopcart];
    }
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
            //[getdata getDataInsertTable:0];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //可以在此加代码提示用户，数据已经加载完毕
                //[alter dismissWithClickedButtonIndex:0 animated:YES];
                
                [myDelegate stopTimer];

                //同步完数据了，则再去下载图片组
                //[getdata getAllZIPPhotos];
                [getdata getAllProductPhotos];
                
            });
        });
        //thridView.hidden=YES;
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
}

//点击tableview以外的地方触发事件
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint pt = [touch locationInView:self.view];
    if (!CGRectContainsPoint([thridView frame], pt)) {
        //to-do
        thridView.hidden=YES;
    }
}

-(void)refleshBuycutData
{
    sqlService * sql=[[sqlService alloc]init];
    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    myDelegate.entityl.resultcount=[sql getBuyproductcount:myDelegate.entityl.uId];
    NSString *goodscount=myDelegate.entityl.resultcount;
    if (goodscount && ![goodscount isEqualToString:@""] && ![goodscount isEqualToString:@"0"]) {
        shopcartcountButton.hidden=NO;
        [shopcartcountButton setTitle:goodscount forState:UIControlStateNormal];
    }else{
        shopcartcountButton.hidden=YES;
    }
    
    sqlService *shopcar=[[sqlService alloc] init];
    shoppingcartlist=[shopcar GetBuyproductList:myDelegate.entityl.uId];
    shopcart *scg=[[shopcart alloc]init];
    [scg reloadshopcart];
    
}

- (void)closeAction
{
    if (self.popupViewController != nil) {
        [self dismissPopupViewControllerAnimated:YES completion:^{
            NSLog(@"popup view dismissed");
        }];
    }
}

@end
