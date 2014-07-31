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
@synthesize biglogo;
@synthesize aboutus;
@synthesize checkpassword;
UISwipeGestureRecognizer *recognizer;

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
    //web标签背景色透明
    aboutus.backgroundColor = [UIColor clearColor];
    aboutus.opaque = NO;
    //[aboutus setUserInteractionEnabled: YES ];	 //是否支持交互
    [aboutus setDelegate:self];				 //委托document.body.style.webkitTouchCallout='none'
    [aboutus stringByEvaluatingJavaScriptFromString:@"document.body.style.webkitUserSelect='none';"];
    // Disable callout
    [aboutus stringByEvaluatingJavaScriptFromString:@"document.body.style.webkitTouchCallout='none';"];
    
    //更新ui(如果已经存在的，则不再自动更新)
    [self loadmyInfo];
    
    
    //设置了左右滑动
//    UISwipeGestureRecognizer *recognizer;
//    
//    recognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom:)];
//    [recognizer setDirection:(UISwipeGestureRecognizerDirectionRight)];
//    aboutus.delegate = self;
//    [[self view] addGestureRecognizer:recognizer];
//    [aboutus addGestureRecognizer:recognizer];
    
     recognizer= [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom:)];
    recognizer.delegate=self;
    [recognizer setDirection:(UISwipeGestureRecognizerDirectionRight)];
    recognizer.cancelsTouchesInView=NO;
    [[self view] addGestureRecognizer:recognizer];
    
//    recognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom:)];
//    [recognizer setDirection:(UISwipeGestureRecognizerDirectionLeft)];
//    [[self view] addGestureRecognizer:recognizer];
    
//    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeLeftAction)];
//    swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
//    swipeLeft.delegate = self;
//    [webView addGestureRecognizer:swipeLeft];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    return YES;
}
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    return YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    // Disable user selection
    [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitUserSelect='none';"];
    // Disable callout
    [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitTouchCallout='none';"];
}

-(void)handleSwipeFrom:(UISwipeGestureRecognizer *)recognizer{
    
    if(recognizer.direction==UISwipeGestureRecognizerDirectionLeft) {
        
        NSLog(@"swipe left");
        //执行程序
        
    }
    
    if(recognizer.direction==UISwipeGestureRecognizerDirectionRight) {
        
        NSLog(@"swipe right");
        //执行程序
        [fourthView setHidden:YES];
        [biglogo setHidden:NO];
    }
    
}

//更新ui
-(void)loadmyInfo
{
    @try {
        
        NSString *logopathsm = [[Tool getTargetFloderPath] stringByAppendingPathComponent:[NSString stringWithFormat:@"logopathsm.png"]];
        NSString *logopath = [[Tool getTargetFloderPath] stringByAppendingPathComponent:[NSString stringWithFormat:@"logopath.png"]];
        
        if ([[NSFileManager defaultManager] fileExistsAtPath:logopathsm]) {
            [logoImage setImage:[[UIImage alloc] initWithContentsOfFile:logopathsm]];
        }
        else {
            [logoImage setImage:[UIImage imageNamed:@"logo"]];
        }

        if ([[NSFileManager defaultManager] fileExistsAtPath:logopath]) {
            [biglogo setImage:[[UIImage alloc] initWithContentsOfFile:logopath] forState:UIControlStateNormal];
        }
        else {
            [biglogo setImage:[UIImage imageNamed:@"logoshengyu"] forState:UIControlStateNormal];
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
                
                
                    if ([[NSFileManager defaultManager] fileExistsAtPath:logopath]) {
                        [biglogo setImage:[[UIImage alloc] initWithContentsOfFile:logopath] forState:UIControlStateNormal];
                    }
                    else {
                        [biglogo setImage:[UIImage imageNamed:@"logoshengyu"] forState:UIControlStateNormal];
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)doReg:(id)sender
{
    product * _product = [[product alloc] init];
    
    [self.navigationController pushViewController:_product animated:NO];
}

-(IBAction)doReg1:(id)sender
{
    NakedDiamond * _NakedDiamond = [[NakedDiamond alloc] init];
    
    [self.navigationController pushViewController:_NakedDiamond animated:NO];
}

-(IBAction)doReg2:(id)sender
{
    ustomtailor * _ustomtailor=[[ustomtailor alloc] init];
    
    [self.navigationController pushViewController:_ustomtailor animated:NO];
}

-(IBAction)doReg3:(id)sender
{
    diploma * _diploma = [[diploma alloc] init];
    
    [self.navigationController pushViewController:_diploma animated:NO];
}

-(IBAction)doReg4:(id)sender
{
    member * _member = [[member alloc] init];
    
    [self.navigationController pushViewController:_member animated:NO];
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
//关于我们
-(IBAction)openaboutus:(id)sender
{
    NSString *filePath = [[Tool getTargetFloderPath] stringByAppendingPathComponent:[NSString stringWithFormat:@"about.webarchive"]];
    NSURL *aURL = [NSURL fileURLWithPath:filePath];
    NSURLRequest *request = [NSURLRequest requestWithURL:aURL];
    //AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    fourthView.hidden=NO;
    //NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:myDelegate.myinfol.details]];
    [aboutus loadRequest:request];
    aboutus.scrollView.delegate=self;
    [aboutus.scrollView setShowsHorizontalScrollIndicator:NO];
    
    [fourthView setHidden:NO];
    [biglogo setHidden:YES];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.x > 0)
        scrollView.contentOffset=CGPointMake(0, scrollView.contentOffset.y);
}

-(IBAction)closeaboutus:(id)sender
{
    fourthView.hidden=YES;
}

//软件更新
-(IBAction)updatesofeware:(id)sender
{
    thridView.hidden=YES;
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


//alertview响应事件
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    sqlService *shopcar=[[sqlService alloc] init];
    shoppingcartlist=[shopcar GetBuyproductList:myDelegate.entityl.uId];
    shopcart *scg=[[shopcart alloc]init];
    [scg reloadshopcart];
}


////核对密码
//-(IBAction)chenckpassword:(id)sender
//{
//    fivethview.hidden=NO;
//}
//
////关闭核对
//-(IBAction)closecheck:(id)sender
//{
//    checkpassword.text=@"";
//    fivethview.hidden=YES;
//}


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

@end
