//
//  NakedDiamondDetail.m
//  zhubao
//
//  Created by johnson on 14-7-30.
//  Copyright (c) 2014年 SUNYEARS___FULLUSERNAME. All rights reserved.
//

#import "NakedDiamondDetail.h"

@interface NakedDiamondDetail ()

@end

@implementation NakedDiamondDetail

@synthesize naid;
@synthesize titleLable;
@synthesize modelLable;
@synthesize productNoLable;
@synthesize weightLable;
@synthesize colorLable;
@synthesize netLable;
@synthesize cutLable;
@synthesize chasingLable;
@synthesize symmetryLable;
@synthesize depthLable;
@synthesize tableLable;
@synthesize sizeLable;
@synthesize fluorescenceLable;
@synthesize diplomaLable;
@synthesize priceLable;
@synthesize productimageview;

NSString * nakedno=nil;

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
    [self showNakedDiamondDetail];
}

//裸钻详情显示
-(void)showNakedDiamondDetail
{
        sqlService * sql=[[sqlService alloc] init];
        nakedno=naid;
        productdia *entity=[sql GetProductdiaDetail:naid];
        //_productimageview.image=[UIImage imageNamed:@"10"];
        titleLable.text=[[[[[[[[[[entity.Dia_Lab stringByAppendingString:@"裸钻"] stringByAppendingString:@"    ("] stringByAppendingString:entity.Dia_Carat] stringByAppendingString:@"/"] stringByAppendingString:entity.Dia_Col] stringByAppendingString:@"/"] stringByAppendingString:entity.Dia_Clar] stringByAppendingString:@"/"] stringByAppendingString:entity.Dia_Cut] stringByAppendingString:@")"];
        if ([entity.Dia_Shape isEqualToString:@"RB"]) {
            modelLable.text=@"圆形";
            productimageview.image=[UIImage imageNamed:@"round.jpg"];
        }
        else if ([entity.Dia_Shape isEqualToString:@"PE"]){
            modelLable.text=@"公主方";
            productimageview.image=[UIImage imageNamed:@"princess2.jpg"];
        }
        else if ([entity.Dia_Shape isEqualToString:@"EM"]){
            modelLable.text=@"祖母绿";
            productimageview.image=[UIImage imageNamed:@"Emerald.jpg"];
        }
        else if ([entity.Dia_Shape isEqualToString:@"RD"]){
            modelLable.text=@"雷蒂恩";
            productimageview.image=[UIImage imageNamed:@"radiant.jpg"];
        }
        else if ([entity.Dia_Shape isEqualToString:@"OL"]){
            modelLable.text=@"椭圆形";
            productimageview.image=[UIImage imageNamed:@"Oval.jpg"];
        }
        else if ([entity.Dia_Shape isEqualToString:@"MQ"]){
            modelLable.text=@"橄榄形";
            productimageview.image=[UIImage imageNamed:@"marquise.jpg"];
        }
        else if ([entity.Dia_Shape isEqualToString:@"CU"]){
            modelLable.text=@"枕形";
            productimageview.image=[UIImage imageNamed:@"cushion.jpg"];
        }
        else if ([entity.Dia_Shape isEqualToString:@"PR"]){
            modelLable.text=@"梨形";
            productimageview.image=[UIImage imageNamed:@"Pear2.jpg"];
        }
        else if ([entity.Dia_Shape isEqualToString:@"HT"]){
            modelLable.text=@"心形";
            productimageview.image=[UIImage imageNamed:@"Heart.jpg"];
        }
        else if ([entity.Dia_Shape isEqualToString:@"ASH"]){
            modelLable.text=@"镭射刑";
            productimageview.image=[UIImage imageNamed:@"Asscher2.jpg"];
        }
        productNoLable.text=entity.Dia_CertNo;
        weightLable.text=entity.Dia_Carat;
        colorLable.text=entity.Dia_Col;
        netLable.text=entity.Dia_Clar;
        cutLable.text=entity.Dia_Cut;
        chasingLable.text=entity.Dia_Pol;
        symmetryLable.text=entity.Dia_Sym;
        depthLable.text=entity.Dia_Dep;
        tableLable.text=entity.Dia_Tab;
        sizeLable.text=entity.Dia_Meas;
        fluorescenceLable.text=entity.Dia_Flor;
        diplomaLable.text=entity.Dia_Lab;
        NSArray *price=[entity.Dia_Price componentsSeparatedByString:@"."];
        priceLable.text=[@"¥" stringByAppendingString:[price objectAtIndex:0]];
        
        //Nakeddisplay.hidden=YES;
}

//加入购物车
-(IBAction)addshopcart:(id)sender{
    sqlService * sql=[[sqlService alloc]init];
    productdia * proentity=[sql GetProductdiaDetail:nakedno];
    buyproduct * entity=[[buyproduct alloc]init];
    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    entity.producttype=@"3";
    entity.productid=nakedno;
    entity.pcount=@"1";
    entity.pcolor=proentity.Dia_Col;
    entity.pvvs=proentity.Dia_Clar;
    entity.psize=proentity.Dia_Meas;
    entity.pweight=proentity.Dia_Carat;
    entity.customerid=myDelegate.entityl.uId;
    entity.pprice=proentity.Dia_Price;
    entity.pname=proentity.Dia_CertNo;
    sql=[[sqlService alloc]init];
    buyproduct *successadd=[sql addToBuyproduct:entity];
    if (successadd) {
        [_mydelegate performSelector:@selector(refleshBuycutData)];
        
        NSString *rowString =@"成功加入购物车！";
        UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示" message:rowString delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alter show];
    } else{
        NSString *rowString =@"加入购物车失败！";
        UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示" message:rowString delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alter show];
    }
}

-(IBAction)closenade:(id)sender
{
    [_mydelegate performSelector:@selector(closeAction)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
