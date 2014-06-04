//
//  NakedDiamond.m
//  zhubao
//
//  Created by johnson on 14-5-28.
//  Copyright (c) 2014年 SUNYEARS___FULLUSERNAME. All rights reserved.
//

#import "NakedDiamond.h"

@interface NakedDiamond ()

@end

@implementation NakedDiamond

@synthesize primaryView;
@synthesize secondaryView;
@synthesize primaryShadeView;
@synthesize thridaryView;
@synthesize secondShadeView;
@synthesize fourtharyView;
@synthesize thirdShadeView;

NSArray *shapearray=nil;
NSArray *colorarray=nil;
NSArray *netarray=nil;
NSArray *cutarray=nil;
NSArray *chasingarray=nil;
NSArray *symmetryarray=nil;
NSArray *fluorescencearray=nil;
NSArray *diplomaarray=nil;

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

- (IBAction)goAction:(id)sender
{
    primaryShadeView.alpha=0.5;
    secondaryView.frame = CGRectMake(140, 95, secondaryView.frame.size.width, secondaryView.frame.size.height);
    secondaryView.hidden = NO;
}

- (IBAction)closeAction:(id)sender
{
    secondaryView.hidden = YES;
    primaryShadeView.alpha=0;
}

- (IBAction)goAction1:(id)sender
{
    secondShadeView.alpha=0.5;
    thridaryView.frame = CGRectMake(140, 95, thridaryView.frame.size.width, thridaryView.frame.size.height);
    thridaryView.hidden = NO;
}

- (IBAction)closeAction1:(id)sender
{
    thridaryView.hidden = YES;
    secondShadeView.alpha=0;
}

- (IBAction)goAction2:(id)sender
{
    thirdShadeView.alpha=0.5;
    fourtharyView.frame = CGRectMake(140, 95, fourtharyView.frame.size.width, fourtharyView.frame.size.height);
    fourtharyView.hidden = NO;
}

- (IBAction)closeAction2:(id)sender
{
    fourtharyView.hidden = YES;
    thirdShadeView.alpha=0;
}

//选择形状
-(IBAction)shapeselect:(id)sender
{
    UIButton* btn = (UIButton*)sender;
    NSInteger btntag=[btn tag];
    NSString * shape=nil;
    if (btntag==0) {
        btn.backgroundColor=[UIColor yellowColor];
    }else if (btntag==1){
        shape=@"RB";
        btn.backgroundColor=[UIColor yellowColor];
    }else if (btntag==2){
        shape=@"PE";
        btn.backgroundColor=[UIColor yellowColor];
    }else if (btntag==3){
        shape=@"EM";
        btn.backgroundColor=[UIColor yellowColor];
    }else if (btntag==4){
        shape=@"RD";
        btn.backgroundColor=[UIColor yellowColor];
    }else if (btntag==5){
        shape=@"OL";
        btn.backgroundColor=[UIColor yellowColor];
    }else if (btntag==6){
        shape=@"MQ";
        btn.backgroundColor=[UIColor yellowColor];
    }else if (btntag==7){
        shape=@"CU";
        btn.backgroundColor=[UIColor yellowColor];
    }else if (btntag==8){
        shape=@"PR";
        btn.backgroundColor=[UIColor yellowColor];
    }else if (btntag==9){
        shape=@"HT";
        btn.backgroundColor=[UIColor yellowColor];
    }else if (btntag==10){
        shape=@"ASH";
        btn.backgroundColor=[UIColor yellowColor];
    }
    NSUInteger len=[shapearray count];
    int i;
    BOOL isequal=NO;
    for (i=0; i<len; i++) {
        NSString * value=[shapearray objectAtIndex:i];
        isequal = [shape isEqualToString:value];
        if (isequal) {
            [shapearray removeObjectAtIndex:i];
            btn.backgroundColor=[UIColor whiteColor];
        }
    }
    if (!isequal) {
        [shapearray addObject:shape];
    }
}

// 选择颜色
-(IBAction)colorselect:(id)sender
{
    UIButton* btn = (UIButton*)sender;
    NSInteger btntag=[btn tag];
    NSString * color=nil;
    if (btntag==0) {
        btn.backgroundColor=[UIColor yellowColor];
    }else if (btntag==1){
        color=@"D";
        btn.backgroundColor=[UIColor yellowColor];
    }else if (btntag==2){
        color=@"E";
        btn.backgroundColor=[UIColor yellowColor];
    }else if (btntag==3){
        color=@"F";
        btn.backgroundColor=[UIColor yellowColor];
    }else if (btntag==4){
        color=@"G";
        btn.backgroundColor=[UIColor yellowColor];
    }else if (btntag==5){
        color=@"H";
        btn.backgroundColor=[UIColor yellowColor];
    }else if (btntag==6){
        color=@"I";
        btn.backgroundColor=[UIColor yellowColor];
    }else if (btntag==7){
        color=@"J";
        btn.backgroundColor=[UIColor yellowColor];
    }else if (btntag==8){
        color=@"K";
        btn.backgroundColor=[UIColor yellowColor];
    }else if (btntag==9){
        color=@"L";
        btn.backgroundColor=[UIColor yellowColor];
    }else if (btntag==10){
        color=@"M";
        btn.backgroundColor=[UIColor yellowColor];
    }
    NSUInteger len=[colorarray count];
    int i;
    BOOL isequal=NO;
    for (i=0; i<len; i++) {
        NSString * value=[colorarray objectAtIndex:i];
        isequal = [color isEqualToString:value];
        if (isequal) {
            [colorarray removeObjectAtIndex:i];
            btn.backgroundColor=[UIColor whiteColor];
        }
    }
    if (!isequal) {
        [colorarray addObject:color];
    }
}
// 选择净度
-(IBAction)netselect:(id)sender
{
    UIButton* btn = (UIButton*)sender;
    NSInteger btntag=[btn tag];
    NSString * net=nil;
    if (btntag==0) {
        btn.backgroundColor=[UIColor yellowColor];
    }else if (btntag==1){
        net=@"FL";
        btn.backgroundColor=[UIColor yellowColor];
    }else if (btntag==2){
        net=@"IF";
        btn.backgroundColor=[UIColor yellowColor];
    }else if (btntag==3){
        net=@"VVS1";
        btn.backgroundColor=[UIColor yellowColor];
    }else if (btntag==4){
        net=@"VVS2";
        btn.backgroundColor=[UIColor yellowColor];
    }else if (btntag==5){
        net=@"VS1";
        btn.backgroundColor=[UIColor yellowColor];
    }else if (btntag==6){
        net=@"VS2";
        btn.backgroundColor=[UIColor yellowColor];
    }else if (btntag==7){
        net=@"SI1";
        btn.backgroundColor=[UIColor yellowColor];
    }else if (btntag==8){
        net=@"SI2";
        btn.backgroundColor=[UIColor yellowColor];
    }else if (btntag==9){
        net=@"I1";
        btn.backgroundColor=[UIColor yellowColor];
    }else if (btntag==10){
        net=@"I2";
        btn.backgroundColor=[UIColor yellowColor];
    }
    NSUInteger len=[netarray count];
    int i;
    BOOL isequal=NO;
    for (i=0; i<len; i++) {
        NSString * value=[netarray objectAtIndex:i];
        isequal = [net isEqualToString:value];
        if (isequal) {
            [netarray removeObjectAtIndex:i];
            btn.backgroundColor=[UIColor whiteColor];
        }
    }
    if (!isequal) {
        [netarray addObject:net];
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
        btn.backgroundColor=[UIColor yellowColor];
    }else if (btntag==1){
        cut=@"VG";
        btn.backgroundColor=[UIColor yellowColor];
    }else if (btntag==2){
        cut=@"GD";
        btn.backgroundColor=[UIColor yellowColor];
    }else if (btntag==3){
        cut=@"Fair";
        btn.backgroundColor=[UIColor yellowColor];
    }
    NSUInteger len=[cutarray count];
    int i;
    BOOL isequal=NO;
    for (i=0; i<len; i++) {
        NSString * value=[cutarray objectAtIndex:i];
        isequal = [cut isEqualToString:value];
        if (isequal) {
            [cutarray removeObjectAtIndex:i];
            btn.backgroundColor=[UIColor whiteColor];
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
        btn.backgroundColor=[UIColor yellowColor];
    }else if (btntag==1){
        chasing=@"VG";
        btn.backgroundColor=[UIColor yellowColor];
    }else if (btntag==2){
        chasing=@"GD";
        btn.backgroundColor=[UIColor yellowColor];
    }else if (btntag==3){
        chasing=@"Fair";
        btn.backgroundColor=[UIColor yellowColor];
    }
    NSUInteger len=[chasingarray count];
    int i;
    BOOL isequal=NO;
    for (i=0; i<len; i++) {
        NSString * value=[chasingarray objectAtIndex:i];
        isequal = [chasing isEqualToString:value];
        if (isequal) {
            [chasingarray removeObjectAtIndex:i];
            btn.backgroundColor=[UIColor whiteColor];
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
        btn.backgroundColor=[UIColor yellowColor];
    }else if (btntag==1){
        symmetry=@"VG";
        btn.backgroundColor=[UIColor yellowColor];
    }else if (btntag==2){
        symmetry=@"GD";
        btn.backgroundColor=[UIColor yellowColor];
    }else if (btntag==3){
        symmetry=@"Fair";
        btn.backgroundColor=[UIColor yellowColor];
    }
    NSUInteger len=[symmetryarray count];
    int i;
    BOOL isequal=NO;
    for (i=0; i<len; i++) {
        NSString * value=[symmetryarray objectAtIndex:i];
        isequal = [symmetry isEqualToString:value];
        if (isequal) {
            [symmetryarray removeObjectAtIndex:i];
            btn.backgroundColor=[UIColor whiteColor];
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
        fluorescence=@"N";
        btn.backgroundColor=[UIColor yellowColor];
    }else if (btntag==1){
        fluorescence=@"F";
        btn.backgroundColor=[UIColor yellowColor];
    }else if (btntag==2){
        fluorescence=@"M";
        btn.backgroundColor=[UIColor yellowColor];
    }else if (btntag==3){
        fluorescence=@"S";
        btn.backgroundColor=[UIColor yellowColor];
    }else if (btntag==4){
        fluorescence=@"VS";
        btn.backgroundColor=[UIColor yellowColor];
    }
    NSUInteger len=[fluorescencearray count];
    int i;
    BOOL isequal=NO;
    for (i=0; i<len; i++) {
        NSString * value=[fluorescencearray objectAtIndex:i];
        isequal = [fluorescence isEqualToString:value];
        if (isequal) {
            [fluorescencearray removeObjectAtIndex:i];
            btn.backgroundColor=[UIColor whiteColor];
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
        btn.backgroundColor=[UIColor yellowColor];
        //[btn setBackgroundImage:[UIImage imageNamed:@"bg_1"] forState:UIControlStateSelected];
    }else if (btntag==1){
        diploma=@"IGI";
        [btn setBackgroundImage:[UIImage imageNamed:@"bg_1"] forState:UIControlStateSelected];
    }else if (btntag==2){
        diploma=@"NGTC";
        [btn setBackgroundImage:[UIImage imageNamed:@"bg_1"] forState:UIControlStateSelected];
    }else if (btntag==3){
        diploma=@"HRD";
        [btn setBackgroundImage:[UIImage imageNamed:@"bg_1"] forState:UIControlStateSelected];
    }else if (btntag==4){
        diploma=@"EGL";
        [btn setBackgroundImage:[UIImage imageNamed:@"bg_1"] forState:UIControlStateSelected];
    }else if (btntag==5){
        diploma=@"Other";
        [btn setBackgroundImage:[UIImage imageNamed:@"bg_1"] forState:UIControlStateSelected];
    }
    NSUInteger len=[diplomaarray count];
    int i;
    BOOL isequal=NO;
    for (i=0; i<len; i++) {
        NSString * value=[diplomaarray objectAtIndex:i];
        isequal = [diploma isEqualToString:value];
        if (isequal) {
            [diplomaarray removeObjectAtIndex:i];
            btn.backgroundColor=[UIColor whiteColor];
        }
    }
    if (!isequal) {
        [diplomaarray addObject:diploma];
    }
}

@end
