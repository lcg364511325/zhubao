//
//  NakedDiamond.m
//  zhubao
//
//  Created by johnson on 14-5-28.
//  Copyright (c) 2014年 SUNYEARS___FULLUSERNAME. All rights reserved.
//

#import "NakedDiamond.h"
#import "NakedDiamondResult.h"

@interface NakedDiamond ()

@end

@implementation NakedDiamond

@synthesize primaryView;
@synthesize weightmin;
@synthesize weightmax;
@synthesize pricemin;
@synthesize pricemax;
@synthesize DiamondNo;
@synthesize modelbtn;
@synthesize colorbtn;
@synthesize netbtn;

NSInteger whichview=0;

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
    shapearray = [[NSMutableArray alloc] init];
    colorarray = [[NSMutableArray alloc] init];
    netarray = [[NSMutableArray alloc] init];
    cutarray = [[NSMutableArray alloc] init];
    chasingarray = [[NSMutableArray alloc] init];
    symmetryarray = [[NSMutableArray alloc] init];
    fluorescencearray = [[NSMutableArray alloc] init];
    diplomaarray = [[NSMutableArray alloc] init];
    btnarray1 = [[NSMutableArray alloc] init];
    btnarray2 = [[NSMutableArray alloc] init];
    btnarray3 = [[NSMutableArray alloc] init];
    btnarray4 = [[NSMutableArray alloc] init];
    weightmin.keyboardType=UIKeyboardTypeNumberPad;
    weightmax.keyboardType=UIKeyboardTypeNumberPad;
    pricemin.keyboardType=UIKeyboardTypeNumberPad;
    pricemax.keyboardType=UIKeyboardTypeNumberPad;
 //   AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    
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
    
    if ([[[UIDevice currentDevice]systemVersion]floatValue]>=7.0) {
        self.edgesForExtendedLayout=UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars=NO;
        self.modalPresentationCapturesStatusBarAppearance=NO;
        self.navigationController.navigationBar.translucent=NO;
    }
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

//搜索
- (IBAction)goAction:(id)sender
{
    //形状参数
    NSMutableString *shape=[[NSMutableString alloc] init];
    for (NSString *index in shapearray) {
        if (shape.length!=0) {
            [shape appendString:@",'"];
            [shape appendString:index];
            [shape appendString:@"'"];
        }else{
            [shape appendString:@"'"];
            [shape appendString:index];
            [shape appendString:@"'"];
        }
    }
    //颜色参数
    NSMutableString *color=[[NSMutableString alloc] init];
    for (NSString *index in colorarray) {
        if (color.length!=0) {
            
            [color appendString:@",'"];
            [color appendString:index];
            [color appendString:@"'"];
        }else{
            [color appendString:@"'"];
            [color appendString:index];
            [color appendString:@"'"];
        }
    }
    //净度参数
    NSMutableString *net=[[NSMutableString alloc] init];
    for (NSString *index in netarray) {
        if (net.length!=0) {
            [net appendString:@",'"];
            [net appendString:index];
            [net appendString:@"'"];
        }else{
            [net appendString:@"'"];
            [net appendString:index];
            [net appendString:@"'"];
        }
    }
    //切工参数
    NSMutableString *cut=[[NSMutableString alloc] init];
    for (NSString *index in cutarray) {
        if (cut.length!=0) {
            [cut appendString:@",'"];
            [cut appendString:index];
            [cut appendString:@"'"];
        }else{
            [cut appendString:@"'"];
            [cut appendString:index];
            [cut appendString:@"'"];
        }
    }
    //抛光参数
    NSMutableString *chasing=[[NSMutableString alloc] init];
    for (NSString *index in chasingarray) {
        if (chasing.length!=0) {
            [chasing appendString:@",'"];
            [chasing appendString:index];
            [chasing appendString:@"'"];
        }else{
            [chasing appendString:@"'"];
            [chasing appendString:index];
            [chasing appendString:@"'"];
        }
    }
    //对称参数
    NSMutableString *symmetry=[[NSMutableString alloc] init];
    for (NSString *index in symmetryarray) {
        if (symmetry.length!=0) {
            [symmetry appendString:@",'"];
            [symmetry appendString:index];
            [symmetry appendString:@"'"];
        }else{
            [symmetry appendString:@"'"];
            [symmetry appendString:index];
            [symmetry appendString:@"'"];
        }
    }
    //荧光参数
    NSMutableString *fluorescence=[[NSMutableString alloc] init];
    for (NSString *index in fluorescencearray) {
        if (fluorescence.length!=0) {
            [fluorescence appendString:@",'"];
            [fluorescence appendString:index];
            [fluorescence appendString:@"'"];
        }else{
            [fluorescence appendString:@"'"];
            [fluorescence appendString:index];
            [fluorescence appendString:@"'"];
        }
    }
    //证书参数
    NSMutableString *diploma=[[NSMutableString alloc] init];
    for (NSString *index in diplomaarray) {
        if (diploma.length!=0) {
            [diploma appendString:@",'"];
            [diploma appendString:index];
            [diploma appendString:@"'"];
        }else{
            [diploma appendString:@"'"];
            [diploma appendString:index];
            [diploma appendString:@"'"];
        }
    }
    //钻重参数
    NSString *weight=nil;
    if (![weightmax.text isEqualToString:@""]) {
        if ([weightmin.text isEqualToString:@""]) {
            weight=[[@"0" stringByAppendingString:@","] stringByAppendingString:weightmax.text];
        }else{
            weight=[[weightmin.text stringByAppendingString:@","] stringByAppendingString:weightmax.text];
        }
    }else{
        weight=weightmin.text;
    }
    //价钱参数
    NSString *price=nil;
    if (![pricemax.text isEqualToString:@""]) {
        if ([pricemin.text isEqualToString:@""]) {
            
            price=[[@"0" stringByAppendingString:@","] stringByAppendingString:pricemax.text];
        }else{
            price=[[pricemin.text stringByAppendingString:@","] stringByAppendingString:pricemax.text];
        }
    }else{
        price=pricemin.text;
    }
    //编号参数
    NSString *number=DiamondNo.text;
    
    NakedDiamondResult *samplePopupViewController = [[NakedDiamondResult alloc] initWithNibName:@"NakedDiamondResult" bundle:nil];
    
    samplePopupViewController.mydelegate=self.parentViewController.self;
    
    samplePopupViewController.shape=shape;
    samplePopupViewController.weight=weight;
    samplePopupViewController.price=price;
    samplePopupViewController.color=color;
    samplePopupViewController.net=net;
    samplePopupViewController.cut=cut;
    samplePopupViewController.chasing=chasing;
    samplePopupViewController.symmetry=symmetry;
    samplePopupViewController.fluorescence=fluorescence;
    samplePopupViewController.diploma=diploma;
    samplePopupViewController.number=number;
    
    [self.parentViewController.self presentPopupViewController:samplePopupViewController animated:YES completion:^(void) {
        NSLog(@"popup view presented");
    }];
 
}

//重置页面
-(IBAction)resetview:(id)sender
{
    [self shapeselect:modelbtn];
    [self colorselect:colorbtn];
    [self netselect:netbtn];
    [cutarray removeAllObjects];
    [chasingarray removeAllObjects];
    [symmetryarray removeAllObjects];
    [fluorescencearray removeAllObjects];
    [diplomaarray removeAllObjects];
    if ([btnarray4 count]!=0) {
        for (UIButton* btn1 in btnarray4) {
            [btn1 setBackgroundImage:nil forState:UIControlStateNormal];
        }
    }
    weightmin.text=@"";
    weightmax.text=@"";
    pricemin.text=@"";
    pricemax.text=@"";
    DiamondNo.text=@"";
    
}

//购物车
- (IBAction)goAction2:(id)sender
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


////核对密码
//-(IBAction)chenckpassword:(id)sender
//{
//    sixview.hidden=NO;
//}
//
////关闭核对
//-(IBAction)closecheck:(id)sender
//{
//    checkpassword.text=@"";
//    sixview.hidden=YES;
//}


- (IBAction)closeAction2:(id)sender
{
    if (self.popupViewController != nil) {
        [self dismissPopupViewControllerAnimated:YES completion:^{
            NSLog(@"popup view dismissed");
        }];
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


//选择形状
-(IBAction)shapeselect:(id)sender
{
    UIButton* btn = (UIButton*)sender;
    NSInteger btntag=[btn tag];
    NSString * shape=nil;
    if (btntag==0) {
        for (UIButton* btn1 in btnarray1) {
            if ([btn1 tag]!=10) {
                [btn1 setImage:[UIImage imageNamed:[NSString stringWithFormat:@"diamond0%ld",(long)[btn1 tag]]] forState:UIControlStateNormal];
            }else{
                [btn1 setImage:[UIImage imageNamed:@"diamond10"] forState:UIControlStateNormal];
            }
        }
        [btn setBackgroundImage:[UIImage imageNamed:@"yellowcolor"] forState:UIControlStateNormal];
        [btnarray1 removeAllObjects];
        [shapearray removeAllObjects];
    }else if (btntag==1){
        shape=@"RB";
        [btn setImage:[UIImage imageNamed:@"diamond_ring01"] forState:UIControlStateNormal];
    }else if (btntag==2){
        shape=@"PE";
        [btn setImage:[UIImage imageNamed:@"diamond_ring02"] forState:UIControlStateNormal];
    }else if (btntag==3){
        shape=@"EM";
        [btn setImage:[UIImage imageNamed:@"diamond_ring03"] forState:UIControlStateNormal];
    }else if (btntag==4){
        shape=@"RD";
        [btn setImage:[UIImage imageNamed:@"diamond_ring04"] forState:UIControlStateNormal];
    }else if (btntag==5){
        shape=@"OL";
        [btn setImage:[UIImage imageNamed:@"diamond_ring05"] forState:UIControlStateNormal];
    }else if (btntag==6){
        shape=@"MQ";
        [btn setImage:[UIImage imageNamed:@"diamond_ring06"] forState:UIControlStateNormal];
    }else if (btntag==7){
        shape=@"CU";
        [btn setImage:[UIImage imageNamed:@"diamond_ring07"] forState:UIControlStateNormal];
    }else if (btntag==8){
        shape=@"PR";
        [btn setImage:[UIImage imageNamed:@"diamond_ring08"] forState:UIControlStateNormal];
    }else if (btntag==9){
        shape=@"HT";
        [btn setImage:[UIImage imageNamed:@"diamond_ring09"] forState:UIControlStateNormal];
    }else if (btntag==10){
        shape=@"ASH";
        [btn setImage:[UIImage imageNamed:@"diamond_ring10"] forState:UIControlStateNormal];
    }
    [btnarray1 addObject:btn];
    if (btntag!=0) {
        [modelbtn setBackgroundImage:nil forState:UIControlStateNormal];
    }
    if (shape) {
        NSUInteger len=[shapearray count];
        NSUInteger i;
        BOOL isequal=NO;
        for (i=0; i<len; i++) {
            NSString * value=[shapearray objectAtIndex:i];
            isequal = [shape isEqualToString:value];
            if (isequal) {
                [shapearray removeObjectAtIndex:i];
                if (btntag!=10) {
                    [btn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"diamond0%ld",(long)btntag]] forState:UIControlStateNormal];
                }else{
                    [btn setImage:[UIImage imageNamed:@"diamond10"] forState:UIControlStateNormal];
                }
                i=len;
            }
        }
        if (!isequal) {
            [shapearray addObject:shape];
        }
    }
}

// 选择颜色
-(IBAction)colorselect:(id)sender
{
    UIButton* btn = (UIButton*)sender;
    NSInteger btntag=[btn tag];
    NSString * color=nil;
    if (btntag==0) {
        for (UIButton * btn2 in btnarray2) {
            [btn2 setBackgroundImage:nil forState:UIControlStateNormal];
        }
        [btnarray2 removeAllObjects];
        [colorarray removeAllObjects];
        [btn setBackgroundImage:[UIImage imageNamed:@"yellowcolor"] forState:UIControlStateNormal];
    }else if (btntag==1){
        color=@"D";
        [btn setBackgroundImage:[UIImage imageNamed:@"yellowcolor"] forState:UIControlStateNormal];
    }else if (btntag==2){
        color=@"E";
        [btn setBackgroundImage:[UIImage imageNamed:@"yellowcolor"] forState:UIControlStateNormal];
    }else if (btntag==3){
        color=@"F";
        [btn setBackgroundImage:[UIImage imageNamed:@"yellowcolor"] forState:UIControlStateNormal];
    }else if (btntag==4){
        color=@"G";
        [btn setBackgroundImage:[UIImage imageNamed:@"yellowcolor"] forState:UIControlStateNormal];
    }else if (btntag==5){
        color=@"H";
        [btn setBackgroundImage:[UIImage imageNamed:@"yellowcolor"] forState:UIControlStateNormal];
    }else if (btntag==6){
        color=@"I";
        [btn setBackgroundImage:[UIImage imageNamed:@"yellowcolor"] forState:UIControlStateNormal];
    }else if (btntag==7){
        color=@"J";
        [btn setBackgroundImage:[UIImage imageNamed:@"yellowcolor"] forState:UIControlStateNormal];
    }else if (btntag==8){
        color=@"K";
        [btn setBackgroundImage:[UIImage imageNamed:@"yellowcolor"] forState:UIControlStateNormal];
    }else if (btntag==9){
        color=@"L";
        [btn setBackgroundImage:[UIImage imageNamed:@"yellowcolor"] forState:UIControlStateNormal];
    }else if (btntag==10){
        color=@"M";
        [btn setBackgroundImage:[UIImage imageNamed:@"yellowcolor"] forState:UIControlStateNormal];
    }
    [btnarray2 addObject:btn];
    if (btntag!=0) {
        [colorbtn setBackgroundImage:nil forState:UIControlStateNormal];
    }
    if (color) {
        NSUInteger len=[colorarray count];
        NSUInteger i;
        BOOL isequal=NO;
        for (i=0; i<len; i++) {
            NSString * value=[colorarray objectAtIndex:i];
            isequal = [color isEqualToString:value];
            if (isequal) {
                [colorarray removeObjectAtIndex:i];
                [btn setBackgroundImage:nil forState:UIControlStateNormal];
                i=len;
            }
        }
        if (!isequal) {
            [colorarray addObject:color];
        }
    }
}
// 选择净度
-(IBAction)netselect:(id)sender
{
    UIButton* btn = (UIButton*)sender;
    NSInteger btntag=[btn tag];
    NSString * net=nil;
    if (btntag==0) {
        for (UIButton * btn3 in btnarray3) {
            [btn3 setBackgroundImage:nil forState:UIControlStateNormal];
        }
        [btnarray3 removeAllObjects];
        [netarray removeAllObjects];
        [btn setBackgroundImage:[UIImage imageNamed:@"yellowcolor"] forState:UIControlStateNormal];
    }else if (btntag==1){
        net=@"FL";
        [btn setBackgroundImage:[UIImage imageNamed:@"yellowcolor"] forState:UIControlStateNormal];
    }else if (btntag==2){
        net=@"IF";
        [btn setBackgroundImage:[UIImage imageNamed:@"yellowcolor"] forState:UIControlStateNormal];
    }else if (btntag==3){
        net=@"VVS1";
        [btn setBackgroundImage:[UIImage imageNamed:@"yellowcolor"] forState:UIControlStateNormal];
    }else if (btntag==4){
        net=@"VVS2";
        [btn setBackgroundImage:[UIImage imageNamed:@"yellowcolor"] forState:UIControlStateNormal];
    }else if (btntag==5){
        net=@"VS1";
        [btn setBackgroundImage:[UIImage imageNamed:@"yellowcolor"] forState:UIControlStateNormal];
    }else if (btntag==6){
        net=@"VS2";
        [btn setBackgroundImage:[UIImage imageNamed:@"yellowcolor"] forState:UIControlStateNormal];
    }else if (btntag==7){
        net=@"SI1";
        [btn setBackgroundImage:[UIImage imageNamed:@"yellowcolor"] forState:UIControlStateNormal];
    }else if (btntag==8){
        net=@"SI2";
        [btn setBackgroundImage:[UIImage imageNamed:@"yellowcolor"] forState:UIControlStateNormal];
    }else if (btntag==9){
        net=@"I1";
        [btn setBackgroundImage:[UIImage imageNamed:@"yellowcolor"] forState:UIControlStateNormal];
    }else if (btntag==10){
        net=@"I2";
        [btn setBackgroundImage:[UIImage imageNamed:@"yellowcolor"] forState:UIControlStateNormal];
    }
    [btnarray3 addObject:btn];
    if (btntag!=0) {
        [netbtn setBackgroundImage:nil forState:UIControlStateNormal];
    }
    if (net) {
        NSUInteger len=[netarray count];
        NSUInteger i;
        BOOL isequal=NO;
        for (i=0; i<len; i++) {
            NSString * value=[netarray objectAtIndex:i];
            isequal = [net isEqualToString:value];
            if (isequal) {
                [netarray removeObjectAtIndex:i];
                [btn setBackgroundImage:nil forState:UIControlStateNormal];
                i=len;
            }
        }
        if (!isequal) {
            [netarray addObject:net];
        }
    }
}

//选择切工
-(IBAction)cutselect:(id)sender
{
    UIButton* btn = (UIButton*)sender;
    NSInteger btntag=[btn tag];
    NSString * cut=nil;
    if (btntag==0) {
        cut=@"EX";
        [btn setBackgroundImage:[UIImage imageNamed:@"yellowcolor"] forState:UIControlStateNormal];
    }else if (btntag==1){
        cut=@"VG";
        [btn setBackgroundImage:[UIImage imageNamed:@"yellowcolor"] forState:UIControlStateNormal];
    }else if (btntag==2){
        cut=@"GD";
        [btn setBackgroundImage:[UIImage imageNamed:@"yellowcolor"] forState:UIControlStateNormal];
    }else if (btntag==3){
        cut=@"Fair";
        [btn setBackgroundImage:[UIImage imageNamed:@"yellowcolor"] forState:UIControlStateNormal];
    }
    [btnarray4 addObject:btn];
    NSUInteger len=[cutarray count];
    NSUInteger i;
    BOOL isequal=NO;
    for (i=0; i<len; i++) {
        NSString * value=[cutarray objectAtIndex:i];
        isequal = [cut isEqualToString:value];
        if (isequal) {
            [cutarray removeObjectAtIndex:i];
            [btn setBackgroundImage:nil forState:UIControlStateNormal];
            i=len;
        }
    }
    if (!isequal) {
        [cutarray addObject:cut];
    }
}

//选择抛光
-(IBAction)chasingselect:(id)sender
{
    UIButton* btn = (UIButton*)sender;
    NSInteger btntag=[btn tag];
    NSString * chasing=nil;
    if (btntag==0) {
        chasing=@"EX";
        [btn setBackgroundImage:[UIImage imageNamed:@"yellowcolor"] forState:UIControlStateNormal];
    }else if (btntag==1){
        chasing=@"VG";
        [btn setBackgroundImage:[UIImage imageNamed:@"yellowcolor"] forState:UIControlStateNormal];
    }else if (btntag==2){
        chasing=@"GD";
        [btn setBackgroundImage:[UIImage imageNamed:@"yellowcolor"] forState:UIControlStateNormal];
    }else if (btntag==3){
        chasing=@"Fair";
        [btn setBackgroundImage:[UIImage imageNamed:@"yellowcolor"] forState:UIControlStateNormal];
    }
    [btnarray4 addObject:btn];
    NSUInteger len=[chasingarray count];
    NSUInteger i;
    BOOL isequal=NO;
    for (i=0; i<len; i++) {
        NSString * value=[chasingarray objectAtIndex:i];
        isequal = [chasing isEqualToString:value];
        if (isequal) {
            [chasingarray removeObjectAtIndex:i];
            [btn setBackgroundImage:nil forState:UIControlStateNormal];
            i=len;
        }
    }
    if (!isequal) {
        [chasingarray addObject:chasing];
    }
}

//选择对称
-(IBAction)symmetryselect:(id)sender
{
    UIButton* btn = (UIButton*)sender;
    NSInteger btntag=[btn tag];
    NSString * symmetry=nil;
    if (btntag==0) {
        symmetry=@"EX";
        [btn setBackgroundImage:[UIImage imageNamed:@"yellowcolor"] forState:UIControlStateNormal];
    }else if (btntag==1){
        symmetry=@"VG";
        [btn setBackgroundImage:[UIImage imageNamed:@"yellowcolor"] forState:UIControlStateNormal];
    }else if (btntag==2){
        symmetry=@"GD";
        [btn setBackgroundImage:[UIImage imageNamed:@"yellowcolor"] forState:UIControlStateNormal];
    }else if (btntag==3){
        symmetry=@"Fair";
        [btn setBackgroundImage:[UIImage imageNamed:@"yellowcolor"] forState:UIControlStateNormal];
    }
    [btnarray4 addObject:btn];
    NSUInteger len=[symmetryarray count];
    NSUInteger i;
    BOOL isequal=NO;
    for (i=0; i<len; i++) {
        NSString * value=[symmetryarray objectAtIndex:i];
        isequal = [symmetry isEqualToString:value];
        if (isequal) {
            [symmetryarray removeObjectAtIndex:i];
            [btn setBackgroundImage:nil forState:UIControlStateNormal];
            i=len;
        }
    }
    if (!isequal) {
        [symmetryarray addObject:symmetry];
    }
}

//选择荧光
-(IBAction)fluorescenceselect:(id)sender
{
    UIButton* btn = (UIButton*)sender;
    NSInteger btntag=[btn tag];
    NSString * fluorescence=nil;
    if (btntag==0) {
        fluorescence=@"Non','None";
        [btn setBackgroundImage:[UIImage imageNamed:@"yellowcolor"] forState:UIControlStateNormal];
    }else if (btntag==1){
        fluorescence=@"Fnt";
        [btn setBackgroundImage:[UIImage imageNamed:@"yellowcolor"] forState:UIControlStateNormal];
    }else if (btntag==2){
        fluorescence=@"Med";
        [btn setBackgroundImage:[UIImage imageNamed:@"yellowcolor"] forState:UIControlStateNormal];
    }else if (btntag==3){
        fluorescence=@"SI','Stg";
        [btn setBackgroundImage:[UIImage imageNamed:@"yellowcolor"] forState:UIControlStateNormal];
    }else if (btntag==4){
        fluorescence=@"Vsl','Vst";
        [btn setBackgroundImage:[UIImage imageNamed:@"yellowcolor"] forState:UIControlStateNormal];
    }
    [btnarray4 addObject:btn];
    NSUInteger len=[fluorescencearray count];
    NSUInteger i;
    BOOL isequal=NO;
    for (i=0; i<len; i++) {
        NSString * value=[fluorescencearray objectAtIndex:i];
        isequal = [fluorescence isEqualToString:value];
        if (isequal) {
            [fluorescencearray removeObjectAtIndex:i];
            [btn setBackgroundImage:nil forState:UIControlStateNormal];
            i=len;
        }
    }
    if (!isequal) {
        [fluorescencearray addObject:fluorescence];
    }
}

//选择证书
-(IBAction)diplomaselect:(id)sender
{
    UIButton* btn = (UIButton*)sender;
    NSInteger btntag=[btn tag];
    NSString * diploma=nil;
    if (btntag==0) {
        diploma=@"GIA";
        [btn setBackgroundImage:[UIImage imageNamed:@"yellowcolor"] forState:UIControlStateNormal];
    }else if (btntag==1){
        diploma=@"IGI";
        [btn setBackgroundImage:[UIImage imageNamed:@"yellowcolor"] forState:UIControlStateNormal];
    }else if (btntag==2){
        diploma=@"NGTC";
        [btn setBackgroundImage:[UIImage imageNamed:@"yellowcolor"] forState:UIControlStateNormal];
    }else if (btntag==3){
        diploma=@"HRD";
        [btn setBackgroundImage:[UIImage imageNamed:@"yellowcolor"] forState:UIControlStateNormal];
    }else if (btntag==4){
        diploma=@"EGL";
        [btn setBackgroundImage:[UIImage imageNamed:@"yellowcolor"] forState:UIControlStateNormal];
    }else if (btntag==5){
        diploma=@"Other";
        [btn setBackgroundImage:[UIImage imageNamed:@"yellowcolor"] forState:UIControlStateNormal];
    }
    [btnarray4 addObject:btn];
    NSUInteger len=[diplomaarray count];
    NSUInteger i;
    BOOL isequal=NO;
    for (i=0; i<len; i++) {
        NSString * value=[diplomaarray objectAtIndex:i];
        isequal = [diploma isEqualToString:value];
        if (isequal) {
            [diplomaarray removeObjectAtIndex:i];
            [btn setBackgroundImage:nil forState:UIControlStateNormal];
            i=len;
        }
    }
    if (!isequal) {
        [diplomaarray addObject:diploma];
    }
}

-(void)refleshBuycutData
{
    
    sqlService *sql=[[sqlService alloc]init];
    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    myDelegate.entityl.resultcount=[sql getBuyproductcount:myDelegate.entityl.uId];

    sqlService *shopcar=[[sqlService alloc] init];
    shoppingcartlist=[shopcar GetBuyproductList:myDelegate.entityl.uId];
    shopcart *scg=[[shopcart alloc]init];
    [scg reloadshopcart];
    
}

-(void)closeAction1
{
    if (self.popupViewController != nil) {
        [self dismissPopupViewControllerAnimated:YES completion:^{
            NSLog(@"popup view dismissed");
        }];
    }
}

@end
