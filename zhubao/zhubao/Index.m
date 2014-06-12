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
@synthesize secondaryView;
@synthesize primaryShadeView;
@synthesize thridView;
@synthesize goodsview;

NSInteger tim=0;

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

- (IBAction)goAction:(id)sender
{
    primaryShadeView.alpha=0.5;
    secondaryView.frame = CGRectMake(140, 95, secondaryView.frame.size.width, secondaryView.frame.size.width);
    secondaryView.hidden = NO;
    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    sqlService *shopcar=[[sqlService alloc] init];
    shoppingcartlist=[shopcar GetBuyproductList:myDelegate.entityl.uId];
    [goodsview reloadData];
}

- (IBAction)closeAction:(id)sender
{
    secondaryView.hidden = YES;
    primaryShadeView.alpha=0;
}

-(IBAction)setup:(id)sender
{
    thridView.hidden=NO;
    thridView.frame=CGRectMake(750, 70, thridView.frame.size.width, thridView.frame.size.height);
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
}
//初始化tableview数据
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [shoppingcartlist count];
    //只有一组，数组数即为行数。
}

// 购物车数据显示
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *TableSampleIdentifier = @"shoppingcartCell";
    
    shoppingcartCell *cell = [tableView dequeueReusableCellWithIdentifier:TableSampleIdentifier];
    if (cell == nil) {
        NSArray * nib=[[NSBundle mainBundle]loadNibNamed:@"shoppingcartCell" owner:self options:nil];
        cell=[nib objectAtIndex:0];
    }
    if (tim>=[shoppingcartlist count]) {
        tim=0;
    }
    buyproduct *goods =[shoppingcartlist objectAtIndex:tim];
        BOOL iseuqal=[goods.producttype isEqualToString:@"1"];
        if (iseuqal) {
            cell.showImage.image=[UIImage imageNamed:@"diamond01"];
            cell.modelLable.text=goods.diaentiy.Dia_Shape;
            if (goods.diaentiy.Dia_Lab) {
                cell.dipLable.text=[@"证书:" stringByAppendingString:goods.diaentiy.Dia_Lab];
            }else{
                cell.dipLable.text=nil;
            }
            if (goods.diaentiy.Dia_ART) {
                cell.numberLable.text=[@"编号:" stringByAppendingString:goods.diaentiy.Dia_ART];
            }else{
                cell.numberLable.text=nil;
            }
            cell.model1Lable.text=[@"形状:" stringByAppendingString:goods.diaentiy.Dia_Shape];
            if (goods.pweight) {
                cell.weightLable.text=[@"钻重:" stringByAppendingString:goods.pweight];
            }else{
                cell.weightLable.text=nil;
            }
            if (goods.pcolor) {
                cell.netLable.text=[@"颜色:" stringByAppendingString:goods.pcolor];
            }else{
                cell.netLable.text=nil;
            }
            if (goods.pvvs) {
                cell.colorLable.text=[@"净度:" stringByAppendingString:goods.pvvs];
            }else{
                cell.colorLable.text=nil;
            }
            if (goods.diaentiy.Dia_Cut) {
                cell.cutLable.text=[@"切工:" stringByAppendingString:goods.diaentiy.Dia_Cut];
            }else{
                cell.cutLable.text=nil;
            }
            if (goods.diaentiy.Dia_Pol) {
                cell.chasing.text=[@"抛光:" stringByAppendingString:goods.diaentiy.Dia_Pol];
            }else{
                cell.chasing.text=nil;
            }
            if (goods.diaentiy.Dia_Sym) {
                cell.fluLable.text=[@"对称:" stringByAppendingString:goods.diaentiy.Dia_Sym];
            }else{
                cell.fluLable.text=nil;
            }
            cell.priceLable.text=goods.pcount;
        }else{
            cell.showImage.image=[UIImage imageNamed:@"diamond01"];
            if (goods.proentiy.Pro_number) {
                cell.dipLable.text=goods.proentiy.Pro_number;
            }else{
                cell.dipLable.text=nil;
            }
            if (goods.proentiy.Pro_number) {
                cell.modelLable.text=goods.proentiy.Pro_number;
            }else{
                cell.modelLable.text=nil;
            }
            if (goods.diaentiy.Dia_ART) {
                cell.numberLable.text=goods.diaentiy.Dia_ART;
            }else{
                cell.numberLable.text=nil;
            }
            if (goods.proentiy.Pro_goldWeight) {
                cell.model1Lable.text=[@"金重:" stringByAppendingString:goods.proentiy.Pro_goldWeight];
            }else{
                cell.model1Lable.text=nil;
            }
            if (goods.pgoldtype) {
                cell.weightLable.text=[@"材质:" stringByAppendingString:goods.pgoldtype];
            }else{
                cell.weightLable.text=nil;
            }
            if (goods.proentiy.Pro_Z_weight) {
                cell.colorLable.text=[@"钻重:" stringByAppendingString:goods.proentiy.Pro_Z_weight];
            }else{
                cell.colorLable.text=nil;
            }
            if (goods.proentiy.Pro_f_clarity) {
                cell.netLable.text=[@"净度:" stringByAppendingString:goods.proentiy.Pro_f_clarity];
            }else{
                cell.netLable.text=nil;
            }
            if (goods.proentiy.Pro_Z_color) {
                cell.cutLable.text=[@"颜色:" stringByAppendingString:goods.proentiy.Pro_Z_color];
            }else{
                cell.cutLable.text=nil;
            }
            if (goods.proentiy.Pro_goldsize) {
                cell.chasing.text=[@"尺寸:" stringByAppendingString:goods.proentiy.Pro_goldsize];
            }else{
                cell.chasing.text=nil;
            }
            cell.fluLable.text=nil;
            cell.priceLable.text=goods.pcount;
        }
    tim++;
    return cell;
}

//tableview点击操作
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //NSString *rowString = [self.list objectAtIndex:[indexPath row]];
    //Nakeddisplay.hidden=YES;
}

//购物车删除
-(IBAction)deleteshoppingcart:(id)sender
{
    UIButton* btn = (UIButton*)sender;
    UITableViewCell *cell = (UITableViewCell *)[[[btn superview] superview] superview];
    NSIndexPath *indexPath = [goodsview indexPathForCell:cell];
    buyproduct *entity = [shoppingcartlist objectAtIndex:[indexPath row]];
    sqlService * sql=[[sqlService alloc]init];
    NSString *successdelete=[sql deleteBuyproduct:entity.Id];
    if (successdelete) {
        NSString *rowString =@"删除成功！";
        UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示" message:rowString delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alter show];
    }else{
        NSString *rowString =@"删除失败！";
        UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示" message:rowString delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alter show];
    }
    //[goodsview reloadData];
}

//alertview响应事件
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    sqlService *shopcar=[[sqlService alloc] init];
    shoppingcartlist=[shopcar GetBuyproductList:myDelegate.entityl.uId];
    [goodsview reloadData];
}

@end
