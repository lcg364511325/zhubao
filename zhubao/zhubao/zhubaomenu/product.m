//
//  product.m
//  zhubao
//
//  Created by johnson on 14-5-28.
//  Copyright (c) 2014年 SUNYEARS___FULLUSERNAME. All rights reserved.
//

#import "product.h"
#import "DHardGold.h"

@interface product ()

@end

@implementation product

@synthesize primaryView;
@synthesize primaryShadeView;
@synthesize secondShadeView;
@synthesize fourthView;
@synthesize fivethview;
@synthesize mainlist=_mainlist;
@synthesize mainmanlist;
@synthesize netlist=_netlist;
@synthesize colorlist=_colorlist;
@synthesize texturelist=_texturelist;
@synthesize productcollect;
@synthesize countLable;
@synthesize btnstyle;
@synthesize btntexture;
@synthesize btninlay;
@synthesize btnseric;
@synthesize shopcartcount;
@synthesize logoImage;
@synthesize checkpassword;


//查询结果
NSMutableArray *list=nil;

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
    
    [self.productcollect registerClass:[ProductCell class] forCellWithReuseIdentifier:@"ProductCell"];
    stylearray = [[NSMutableArray alloc] init];
    texturearray = [[NSMutableArray alloc] init];
    inlayarray = [[NSMutableArray alloc] init];
    seriearray = [[NSMutableArray alloc] init];
    btnarray1 = [[NSMutableArray alloc] init];
    btnarray2 = [[NSMutableArray alloc] init];
    btnarray3 = [[NSMutableArray alloc] init];
    btnarray4 = [[NSMutableArray alloc] init];
    countLable.text=nil;
    
    //进来时候加载全部数据
//    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    sqlService *sql=[[sqlService alloc]init];
    list=[sql GetProductList:nil type2:nil type3:nil type4:nil page:1 pageSize:1500];
    
//    NSString *goodscount=myDelegate.entityl.resultcount;
//    if (goodscount && ![goodscount isEqualToString:@""] && ![goodscount isEqualToString:@"0"]) {
//        shopcartcount.hidden=NO;
//        [shopcartcount setTitle:goodscount forState:UIControlStateNormal];
//    }else{
//        shopcartcount.hidden=YES;
//    }
//
//    NSString *logopathsm = [[Tool getTargetFloderPath] stringByAppendingPathComponent:[NSString stringWithFormat:@"logopathsm.png"]];
//    if ([[NSFileManager defaultManager] fileExistsAtPath:logopathsm]) {
//        [logoImage setImage:[[UIImage alloc] initWithContentsOfFile:logopathsm]];
//    }
//    else {
//        [logoImage setImage:[UIImage imageNamed:@"logo"]];
//    }
    
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
    NakedDiamond * _NakedDiamond = [[NakedDiamond alloc] init];
    
    [self.navigationController pushViewController:_NakedDiamond animated:NO];
}

-(IBAction)doReg2:(id)sender
{
    ustomtailor * _ustomtailor = [[ustomtailor alloc] init];
    
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

- (void)closeAction
{
    if (self.popupViewController != nil) {
        [self dismissPopupViewControllerAnimated:YES completion:^{
            NSLog(@"popup view dismissed");
        }];
    }
}

-(void)closesc{
    if (self.popupViewController != nil) {
        [self dismissPopupViewControllerAnimated:YES completion:^{
            NSLog(@"popup view dismissed");
        }];
    }
}

-(void)rotateStart{
    [rImageView setRotate:TRUE];
}

-(void)rotateStop{
    [rImageView setRotate:FALSE];
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
    fourthView.hidden=NO;
    fourthView.frame=CGRectMake(750, 70, fourthView.frame.size.width, fourthView.frame.size.height);
}

//软件更新
-(IBAction)updatesofeware:(id)sender
{
    fourthView.hidden=YES;
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
        fourthView.hidden=YES;
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
}

//下拉按钮执行动作
-(IBAction)mainselect:(id)sender
{
    shopcart *samplePopupViewController = [[shopcart alloc] initWithNibName:@"shopcart" bundle:nil];
    samplePopupViewController.mydelegate=self;
    
    [self presentPopupViewController:samplePopupViewController animated:YES completion:^(void) {
        NSLog(@"popup view presented");
    }];
}

//款式选择
-(IBAction)styleselect:(id)sender
{
    countLable.text=nil;
    UIButton* btn = (UIButton*)sender;
    NSInteger btntag=[btn tag];
    NSString * style=nil;
    if (btntag==0) {
        for (UIButton * btn1 in btnarray1) {
            [btn1 setBackgroundImage:nil forState:UIControlStateNormal];
        }
        [btnarray1 removeAllObjects];
        [stylearray removeAllObjects];
        [btn setBackgroundImage:[UIImage imageNamed:@"options_sedBg"] forState:UIControlStateNormal];
    }else if (btntag==1){
        style=@"1";
        [btn setBackgroundImage:[UIImage imageNamed:@"options_sedBg"] forState:UIControlStateNormal];
    }else if (btntag==2){
        style=@"2";
        [btn setBackgroundImage:[UIImage imageNamed:@"options_sedBg"] forState:UIControlStateNormal];
    }else if (btntag==3){
        style=@"3";
        [btn setBackgroundImage:[UIImage imageNamed:@"options_sedBg"] forState:UIControlStateNormal];
    }else if (btntag==4){
        style=@"4";
        [btn setBackgroundImage:[UIImage imageNamed:@"options_sedBg"] forState:UIControlStateNormal];
    }else if (btntag==5){
        style=@"5";
        [btn setBackgroundImage:[UIImage imageNamed:@"options_sedBg"] forState:UIControlStateNormal];
    }else if (btntag==6){
        style=@"6";
        [btn setBackgroundImage:[UIImage imageNamed:@"options_sedBg"] forState:UIControlStateNormal];
    }else if (btntag==7){
        style=@"7";
        [btn setBackgroundImage:[UIImage imageNamed:@"options_sedBg"] forState:UIControlStateNormal];
    }else if (btntag==8){
        style=@"8";
        [btn setBackgroundImage:[UIImage imageNamed:@"options_sedBg"] forState:UIControlStateNormal];
    }else if (btntag==9){
        style=@"9";
        [btn setBackgroundImage:[UIImage imageNamed:@"options_sedBg"] forState:UIControlStateNormal];
    }else if (btntag==10){
        style=@"10";
        [btn setBackgroundImage:[UIImage imageNamed:@"options_sedBg"] forState:UIControlStateNormal];
    }else if (btntag==11){
        style=@"11";
        [btn setBackgroundImage:[UIImage imageNamed:@"options_sedBg"] forState:UIControlStateNormal];
    }
    if (btntag!=0) {
        [btnstyle setBackgroundImage:nil forState:UIControlStateNormal];
    }
    [btnarray1 addObject:btn];
    if (style) {
        NSUInteger len=[stylearray count];
        NSUInteger i;
        BOOL isequal=NO;
        for (i=0; i<len; i++) {
            NSString * value=[stylearray objectAtIndex:i];
            isequal = [style isEqualToString:value];
            if (isequal) {
                [stylearray removeObjectAtIndex:i];
                [btn setBackgroundImage:nil forState:UIControlStateNormal];
                i=len;
            }
        }
        if (!isequal) {
            [stylearray addObject:style];
        }
    }
    if ([stylearray count]==0) {
        [btnstyle setBackgroundImage:[UIImage imageNamed:@"options_sedBg"] forState:UIControlStateNormal];
    }
    //款式
    NSMutableString *styleindex=[[NSMutableString alloc] init];
    for (NSString *index in stylearray) {
        if (styleindex.length!=0) {
            [styleindex appendString:@","];
            [styleindex appendString:index];
        }else{
            [styleindex appendString:index];
        }
    }
    //材质
    NSMutableString *textrueindex=[[NSMutableString alloc] init];
    for (NSString *index in texturearray) {
        if (textrueindex.length!=0) {
            [textrueindex appendString:@","];
            [textrueindex appendString:index];
        }else{
            [textrueindex appendString:index];
        }
    }
    //镶口
    NSMutableString *inlayindex=[[NSMutableString alloc] init];
    for (NSString *index in inlayarray) {
        if (inlayindex.length!=0) {
            [inlayindex appendString:@","];
            [inlayindex appendString:index];
        }else{
            [inlayindex appendString:index];
        }
    }
    //系列
    NSMutableString *serieindex=[[NSMutableString alloc] init];
    for (NSString *index in seriearray) {
        if (serieindex.length!=0) {
            [serieindex appendString:@" or "];
            [serieindex appendString:index];
        }else{
            [serieindex appendString:index];
        }
    }
    
    NSString * serieindexs=serieindex;
    if([seriearray count]>1)serieindexs=[NSString stringWithFormat:@"(%@)",serieindex];
    
    list = [NSMutableArray arrayWithCapacity:10];
    [productcollect reloadData];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 耗时的操作（异步操作）
        sqlService *sql=[[sqlService alloc]init];
        list=[sql GetProductList:styleindex type2:textrueindex type3:inlayindex type4:serieindexs page:1 pageSize:1500];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [productcollect reloadData];
        });
    });
    
}


//材质选择
-(IBAction)textureselect:(id)sender
{
    countLable.text=nil;
    UIButton* btn = (UIButton*)sender;
    NSInteger btntag=[btn tag];
    NSString *texture=nil;
    if (btntag==0) {
        for (UIButton * btn2 in btnarray2) {
            [btn2 setBackgroundImage:nil forState:UIControlStateNormal];
        }
        [btnarray2 removeAllObjects];
        [texturearray removeAllObjects];
        [btn setBackgroundImage:[UIImage imageNamed:@"options_sedBg"] forState:UIControlStateNormal];
    }else if (btntag==1){
        texture=@"1";
        [btn setBackgroundImage:[UIImage imageNamed:@"options_sedBg"] forState:UIControlStateNormal];
    }else if (btntag==2){
        texture=@"2";
        [btn setBackgroundImage:[UIImage imageNamed:@"options_sedBg"] forState:UIControlStateNormal];
    }else if (btntag==3){
        texture=@"3";
        [btn setBackgroundImage:[UIImage imageNamed:@"options_sedBg"] forState:UIControlStateNormal];
    }else if (btntag==4){
        texture=@"4";
        [btn setBackgroundImage:[UIImage imageNamed:@"options_sedBg"] forState:UIControlStateNormal];
    }else if (btntag==5){
        texture=@"5";
        [btn setBackgroundImage:[UIImage imageNamed:@"options_sedBg"] forState:UIControlStateNormal];
    }else if (btntag==6){
        texture=@"6";
        [btn setBackgroundImage:[UIImage imageNamed:@"options_sedBg"] forState:UIControlStateNormal];
    }else if (btntag==7){
        texture=@"7";
        [btn setBackgroundImage:[UIImage imageNamed:@"options_sedBg"] forState:UIControlStateNormal];
    }
    [btnarray2 addObject:btn];
    if (btntag!=0) {
        [btntexture setBackgroundImage:nil forState:UIControlStateNormal];
    }
    if (texture) {
        NSUInteger len=[texturearray count];
        NSUInteger i;
        BOOL isequal=NO;
        for (i=0; i<len; i++) {
            NSString * value=[texturearray objectAtIndex:i];
            isequal = [texture isEqualToString:value];
            if (isequal) {
                [texturearray removeObjectAtIndex:i];
                [btn setBackgroundImage:nil forState:UIControlStateNormal];
                i=len;
            }
        }
        if (!isequal) {
            [texturearray addObject:texture];
        }
    }
    if ([texturearray count]==0) {
        [btntexture setBackgroundImage:[UIImage imageNamed:@"options_sedBg"] forState:UIControlStateNormal];
    }
    //款式
    NSMutableString *styleindex=[[NSMutableString alloc] init];
    for (NSString *index in stylearray) {
        if (styleindex.length!=0) {
            [styleindex appendString:@","];
            [styleindex appendString:index];
        }else{
            [styleindex appendString:index];
        }
    }
    //材质
    NSMutableString *textrueindex=[[NSMutableString alloc] init];
    for (NSString *index in texturearray) {
        if (textrueindex.length!=0) {
            [textrueindex appendString:@","];
            [textrueindex appendString:index];
        }else{
            [textrueindex appendString:index];
        }
    }
    //镶口
    NSMutableString *inlayindex=[[NSMutableString alloc] init];
    for (NSString *index in inlayarray) {
        if (inlayindex.length!=0) {
            [inlayindex appendString:@","];
            [inlayindex appendString:index];
        }else{
            [inlayindex appendString:index];
        }
    }
    //系列
    NSMutableString *serieindex=[[NSMutableString alloc] init];
    for (NSString *index in seriearray) {
        if (serieindex.length!=0) {
            [serieindex appendString:@" or "];
            [serieindex appendString:index];
        }else{
            [serieindex appendString:index];
        }
    }
    
    NSString * serieindexs=serieindex;
    if([seriearray count]>1)serieindexs=[NSString stringWithFormat:@"(%@)",serieindex];
    
    list = [NSMutableArray arrayWithCapacity:10];
    [productcollect reloadData];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 耗时的操作（异步操作）
        sqlService *sql=[[sqlService alloc]init];
        list=[sql GetProductList:styleindex type2:textrueindex type3:inlayindex type4:serieindexs page:1 pageSize:1500];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [productcollect reloadData];
        });
    });
}

//镶口选择
-(IBAction)inlayselect:(id)sender
{
    countLable.text=nil;
    UIButton* btn = (UIButton*)sender;
    NSInteger btntag=[btn tag];
    NSString *inlay=nil;
    if (btntag==0) {
        for (UIButton * btn3 in btnarray3) {
            [btn3 setBackgroundImage:nil forState:UIControlStateNormal];
        }
        [btnarray3 removeAllObjects];
        [inlayarray removeAllObjects];
        [btn setBackgroundImage:[UIImage imageNamed:@"options_sedBg"] forState:UIControlStateNormal];
    }else if (btntag==1){
        inlay=@"0.00-0.02";
        [btn setBackgroundImage:[UIImage imageNamed:@"options_sedBg"] forState:UIControlStateNormal];
    }else if (btntag==2){
        inlay=@"0.03-0.07";
        [btn setBackgroundImage:[UIImage imageNamed:@"options_sedBg"] forState:UIControlStateNormal];
    }else if (btntag==3){
        inlay=@"0.08-0.12";
        [btn setBackgroundImage:[UIImage imageNamed:@"options_sedBg"] forState:UIControlStateNormal];
    }else if (btntag==4){
        inlay=@"0.13-0.17";
        [btn setBackgroundImage:[UIImage imageNamed:@"options_sedBg"] forState:UIControlStateNormal];
    }else if (btntag==5){
        inlay=@"0.18-0.22";
        [btn setBackgroundImage:[UIImage imageNamed:@"options_sedBg"] forState:UIControlStateNormal];
    }else if (btntag==6){
        inlay=@"0.23-0.28";
        [btn setBackgroundImage:[UIImage imageNamed:@"options_sedBg"] forState:UIControlStateNormal];
    }else if (btntag==7){
        inlay=@"0.29-0.39";
        [btn setBackgroundImage:[UIImage imageNamed:@"options_sedBg"] forState:UIControlStateNormal];
    }else if (btntag==8){
        inlay=@"0.40-0.49";
        [btn setBackgroundImage:[UIImage imageNamed:@"options_sedBg"] forState:UIControlStateNormal];
    }else if (btntag==9){
        inlay=@"0.50-0.59";
        [btn setBackgroundImage:[UIImage imageNamed:@"options_sedBg"] forState:UIControlStateNormal];
    }else if (btntag==10){
        inlay=@"0.60-0.69";
        [btn setBackgroundImage:[UIImage imageNamed:@"options_sedBg"] forState:UIControlStateNormal];
    }else if (btntag==11){
        inlay=@"0.70-0.69";
        [btn setBackgroundImage:[UIImage imageNamed:@"options_sedBg"] forState:UIControlStateNormal];
    }else if (btntag==12){
        inlay=@"0.80-0.69";
        [btn setBackgroundImage:[UIImage imageNamed:@"options_sedBg"] forState:UIControlStateNormal];
    }else if (btntag==13){
        inlay=@"0.90-0.69";
        [btn setBackgroundImage:[UIImage imageNamed:@"options_sedBg"] forState:UIControlStateNormal];
    }else if (btntag==14){
        inlay=@"1-100000";
        [btn setBackgroundImage:[UIImage imageNamed:@"options_sedBg"] forState:UIControlStateNormal];
    }
    [btnarray3 addObject:btn];
    if (btntag!=0) {
        [btninlay setBackgroundImage:nil forState:UIControlStateNormal];
    }
    if (inlay) {
        NSUInteger len=[inlayarray count];
        NSUInteger i;
        BOOL isequal=NO;
        for (i=0; i<len; i++) {
            NSString * value=[inlayarray objectAtIndex:i];
            isequal = [inlay isEqualToString:value];
            if (isequal) {
                [inlayarray removeObjectAtIndex:i];
                [btn setBackgroundImage:nil forState:UIControlStateNormal];
                i=len;
            }
        }
        if (!isequal) {
            [inlayarray addObject:inlay];
        }
    }
    if ([inlayarray count]==0) {
        [btninlay setBackgroundImage:[UIImage imageNamed:@"options_sedBg"] forState:UIControlStateNormal];
    }
    //款式
    NSMutableString *styleindex=[[NSMutableString alloc] init];
    for (NSString *index in stylearray) {
        if (styleindex.length!=0) {
            [styleindex appendString:@","];
            [styleindex appendString:index];
        }else{
            [styleindex appendString:index];
        }
    }
    //材质
    NSMutableString *textrueindex=[[NSMutableString alloc] init];
    for (NSString *index in texturearray) {
        if (textrueindex.length!=0) {
            [textrueindex appendString:@","];
            [textrueindex appendString:index];
        }else{
            [textrueindex appendString:index];
        }
    }
    //镶口
    NSMutableString *inlayindex=[[NSMutableString alloc] init];
    for (NSString *index in inlayarray) {
        if (inlayindex.length!=0) {
            [inlayindex appendString:@","];
            [inlayindex appendString:index];
        }else{
            [inlayindex appendString:index];
        }
    }
    //系列
    NSMutableString *serieindex=[[NSMutableString alloc] init];
    for (NSString *index in seriearray) {
        if (serieindex.length!=0) {
            [serieindex appendString:@" or "];
            [serieindex appendString:index];
        }else{
            [serieindex appendString:index];
        }
    }
    
    NSString * serieindexs=serieindex;
    if([seriearray count]>1)serieindexs=[NSString stringWithFormat:@"(%@)",serieindex];
    
    list = [NSMutableArray arrayWithCapacity:10];
    [productcollect reloadData];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 耗时的操作（异步操作）
        sqlService *sql=[[sqlService alloc]init];
        list=[sql GetProductList:styleindex type2:textrueindex type3:inlayindex type4:serieindexs page:1 pageSize:1500];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [productcollect reloadData];
        });
    });
}

//系列
-(IBAction)serie:(id)sender
{
    countLable.text=nil;
    UIButton* btn = (UIButton*)sender;
    NSInteger btntag=[btn tag];
    NSString * serie=nil;
    if (btntag==1) {
        serie=@"Pro_f_pair='true'";
        [btn setBackgroundImage:[UIImage imageNamed:@"options_sedBg"] forState:UIControlStateNormal];
    }else if(btntag==2){
        serie=@"Pro_hotE=1";//豪华系列 ： Pro_hotE=1
        [btn setBackgroundImage:[UIImage imageNamed:@"options_sedBg"] forState:UIControlStateNormal];
    }else if (btntag==0){
        for (UIButton * btn4 in btnarray4) {
            [btn4 setBackgroundImage:nil forState:UIControlStateNormal];
        }
        [btnarray4 removeAllObjects];
        [seriearray removeAllObjects];
        [btn setBackgroundImage:[UIImage imageNamed:@"options_sedBg"] forState:UIControlStateNormal];
    }
    [btnarray4 addObject:btn];
    if (btntag!=0) {
        [btnseric setBackgroundImage:nil forState:UIControlStateNormal];
    }
    if (serie) {
        NSUInteger len=[seriearray count];
        NSUInteger i;
        BOOL isequal=NO;
        for (i=0; i<len; i++) {
            NSString * value=[seriearray objectAtIndex:i];
            isequal = [serie isEqualToString:value];
            if (isequal) {
                [seriearray removeObjectAtIndex:i];
                [btn setBackgroundImage:nil forState:UIControlStateNormal];
                i=len;
            }
        }
        if (!isequal) {
            [seriearray addObject:serie];
        }
    }
    if ([seriearray count]==0) {
        [btnseric setBackgroundImage:[UIImage imageNamed:@"options_sedBg"] forState:UIControlStateNormal];
    }
    //款式
    NSMutableString *styleindex=[[NSMutableString alloc] init];
    for (NSString *index in stylearray) {
        if (styleindex.length!=0) {
            [styleindex appendString:@","];
            [styleindex appendString:index];
        }else{
            [styleindex appendString:index];
        }
    }
    //材质
    NSMutableString *textrueindex=[[NSMutableString alloc] init];
    for (NSString *index in texturearray) {
        if (textrueindex.length!=0) {
            [textrueindex appendString:@","];
            [textrueindex appendString:index];
        }else{
            [textrueindex appendString:index];
        }
    }
    //镶口
    NSMutableString *inlayindex=[[NSMutableString alloc] init];
    for (NSString *index in inlayarray) {
        if (inlayindex.length!=0) {
            [inlayindex appendString:@","];
            [inlayindex appendString:index];
        }else{
            [inlayindex appendString:index];
        }
    }
    //系列
    NSMutableString *serieindex=[[NSMutableString alloc] init];
    for (NSString *index in seriearray) {
        if (serieindex.length!=0) {
            [serieindex appendString:@" or "];
            [serieindex appendString:index];
        }else{
            [serieindex appendString:index];
        }
    }
    NSString * serieindexs=serieindex;
    if([seriearray count]>1)serieindexs=[NSString stringWithFormat:@"(%@)",serieindex];
    
    list = [NSMutableArray arrayWithCapacity:10];
    [productcollect reloadData];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 耗时的操作（异步操作）
        sqlService *sql=[[sqlService alloc]init];
        list=[sql GetProductList:styleindex type2:textrueindex type3:inlayindex type4:serieindexs page:1 pageSize:1500];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [productcollect reloadData];
        });
    });
}

//搜索结果数目
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [list count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ProductCell *cell = (ProductCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"ProductCell" forIndexPath:indexPath];
    productEntity *entity=[list objectAtIndex:[indexPath row]];
    NSString *count=[NSString stringWithFormat:@"%lu",(unsigned long)[list count]];
    countLable.text=[[@"共有首饰" stringByAppendingString:count] stringByAppendingString:@"件"];
    
//    NSString *url1=pathInDocumentDirectory([NSString stringWithFormat:@"images/%@%@",entity.Pro_author,@"_001.jpg"]);
//    if ([[NSFileManager defaultManager] fileExistsAtPath:url1]) {
//        cell.productImage.image=[UIImage imageWithContentsOfFile:url1];
//    }else{
    if ([entity.producttype isEqualToString:@"1"]) {
        cell.productImage.image=[[UIImage alloc] initWithContentsOfFile:entity.Pro_smallpic];
    }else{
        NSURL *imgUrl=[NSURL URLWithString:[NSString stringWithFormat:@"http://seyuu.com%@",entity.Pro_smallpic]];
        if (hasCachedImage(imgUrl)) {
            cell.productImage.image=[UIImage imageWithContentsOfFile:pathForURL(imgUrl)];
        }else
        {
            cell.productImage.image=[UIImage imageNamed:@""];
            NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:imgUrl,@"url",cell.productImage,@"imageView",nil];
            [NSThread detachNewThreadSelector:@selector(cacheImage:) toTarget:[ImageCacher defaultCacher] withObject:dic];
            
        }
    }
    
//    }
    cell.show3dImage.hidden=NO;
    if (![self isexistsfile:entity.Pro_author]) {
        cell.show3dImage.hidden=YES;
    }

    cell.productLable.text = entity.Pro_model;
    return cell;
}

//点击tableview以外的地方触发事件
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint pt = [touch locationInView:self.view];
    if (!CGRectContainsPoint([fourthView frame], pt)) {
        //to-do
        fourthView.hidden=YES;
    }
}

//点击事件
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    productEntity *entity = [list objectAtIndex:[indexPath row]];
    if ([entity.Pro_Type isEqualToString:@"2"]) {
        DHardGold *prodeuctDetailcontroller = [[DHardGold alloc] initWithNibName:@"DHardGold" bundle:nil];
        prodeuctDetailcontroller.mydelegate=self.parentViewController.self;
        prodeuctDetailcontroller.proid=entity.Id;
        
        [self.parentViewController.self presentPopupViewController:prodeuctDetailcontroller animated:YES completion:^(void) {
            NSLog(@"popup view presented");
        }];
    }else{
        prodeuctDetail *prodeuctDetailcontroller = [[prodeuctDetail alloc] initWithNibName:@"prodeuctDetail" bundle:nil];
        prodeuctDetailcontroller.mydelegate=self.parentViewController.self;
        prodeuctDetailcontroller.proid=entity.Id;
        
        [self.parentViewController.self presentPopupViewController:prodeuctDetailcontroller animated:YES completion:^(void) {
            NSLog(@"popup view presented");
        }];
    }
}

//保留小数位数
-(NSString *)notRounding:(float)price afterPoint:(int)position{
    NSDecimalNumberHandler* roundingBehavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundDown scale:position raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
    NSDecimalNumber *ouncesDecimal;
    NSDecimalNumber *roundedOunces;
    
    ouncesDecimal = [[NSDecimalNumber alloc] initWithFloat:price];
    roundedOunces = [ouncesDecimal decimalNumberByRoundingAccordingToBehavior:roundingBehavior];
    return [NSString stringWithFormat:@"%@",roundedOunces];
}

-(BOOL)isexistsfile:(NSString *)Pro_author
{
    BOOL isshow=FALSE;
    for(int i=1;i<60;i++){
        NSString *strApend;
        if(i<9)
            strApend=@"00";
        else
            strApend=@"0";
        
        NSString *path = [NSString stringWithFormat:@"%@_%@%d.jpg",Pro_author, strApend,i];
        NSLog(@"%@", path);
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *dcoumentpath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
        // 解压缩文件夹路径
        NSString* unzipPath = [dcoumentpath stringByAppendingString:@"/images"];
        if ([[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"%@/%@",unzipPath,path]]) {
            isshow=TRUE;
            break;
        }
    }
        
    return isshow;
}

-(void)reloaddata
{
    //款式
    NSMutableString *styleindex=[[NSMutableString alloc] init];
    for (NSString *index in stylearray) {
        if (styleindex.length!=0) {
            [styleindex appendString:@","];
            [styleindex appendString:index];
        }else{
            [styleindex appendString:index];
        }
    }
    //材质
    NSMutableString *textrueindex=[[NSMutableString alloc] init];
    for (NSString *index in texturearray) {
        if (textrueindex.length!=0) {
            [textrueindex appendString:@","];
            [textrueindex appendString:index];
        }else{
            [textrueindex appendString:index];
        }
    }
    //镶口
    NSMutableString *inlayindex=[[NSMutableString alloc] init];
    for (NSString *index in inlayarray) {
        if (inlayindex.length!=0) {
            [inlayindex appendString:@","];
            [inlayindex appendString:index];
        }else{
            [inlayindex appendString:index];
        }
    }
    //系列
    NSMutableString *serieindex=[[NSMutableString alloc] init];
    for (NSString *index in seriearray) {
        if (serieindex.length!=0) {
            [serieindex appendString:@" or "];
            [serieindex appendString:index];
        }else{
            [serieindex appendString:index];
        }
    }
    NSString * serieindexs=serieindex;
    if([seriearray count]>1)serieindexs=[NSString stringWithFormat:@"(%@)",serieindex];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 耗时的操作（异步操作）
        sqlService *sql=[[sqlService alloc]init];
        list=[sql GetProductList:styleindex type2:textrueindex type3:inlayindex type4:serieindexs page:1 pageSize:1500];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [productcollect reloadData];
        });
    });
}

-(void)refleshBuycutData
{
    
    sqlService *sql=[[sqlService alloc]init];
    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
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
