//
//  shopcart.m
//  zhubao
//
//  Created by johnson on 14-7-31.
//  Copyright (c) 2014年 SUNYEARS___FULLUSERNAME. All rights reserved.
//

#import "shopcart.h"

@interface shopcart ()

@end

@implementation shopcart

@synthesize goodsview;

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
    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    sqlService *shopcar=[[sqlService alloc] init];
    shoppingcartlist=[shopcar GetBuyproductList:myDelegate.entityl.uId];
}

-(IBAction)closeshopcart:(id)sender
{
    [_mydelegate performSelector:@selector(closesc)];
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
    buyproduct *goods =[shoppingcartlist objectAtIndex:[indexPath row]];
    if ([goods.producttype isEqualToString:@"3"]) {
        if ([goods.diaentiy.Dia_Shape isEqualToString:@"RB"]) {
            cell.modelLable.text=@"圆形";
            cell.showImage.image=[UIImage imageNamed:@"round.jpg"];
        }
        else if ([goods.diaentiy.Dia_Shape isEqualToString:@"PE"]){
            cell.modelLable.text=@"公主方";
            cell.showImage.image=[UIImage imageNamed:@"princess2.jpg"];
        }
        else if ([goods.diaentiy.Dia_Shape isEqualToString:@"EM"]){
            cell.modelLable.text=@"祖母绿";
            cell.showImage.image=[UIImage imageNamed:@"Emerald.jpg"];
        }
        else if ([goods.diaentiy.Dia_Shape isEqualToString:@"RD"]){
            cell.modelLable.text=@"雷蒂恩";
            cell.showImage.image=[UIImage imageNamed:@"radiant.jpg"];
        }
        else if ([goods.diaentiy.Dia_Shape isEqualToString:@"OL"]){
            cell.modelLable.text=@"椭圆形";
            cell.showImage.image=[UIImage imageNamed:@"Oval.jpg"];
        }
        else if ([goods.diaentiy.Dia_Shape isEqualToString:@"MQ"]){
            cell.modelLable.text=@"橄榄形";
            cell.showImage.image=[UIImage imageNamed:@"marquise.jpg"];
        }
        else if ([goods.diaentiy.Dia_Shape isEqualToString:@"CU"]){
            cell.modelLable.text=@"枕形";
            cell.showImage.image=[UIImage imageNamed:@"cushion.jpg"];
        }
        else if ([goods.diaentiy.Dia_Shape isEqualToString:@"PR"]){
            cell.modelLable.text=@"梨形";
            cell.showImage.image=[UIImage imageNamed:@"Pear2.jpg"];
        }
        else if ([goods.diaentiy.Dia_Shape isEqualToString:@"HT"]){
            cell.modelLable.text=@"心形";
            cell.showImage.image=[UIImage imageNamed:@"Heart.jpg"];
        }
        else if ([goods.diaentiy.Dia_Shape isEqualToString:@"ASH"]){
            cell.modelLable.text=@"镭射刑";
            cell.showImage.image=[UIImage imageNamed:@"Asscher2.jpg"];
        }
        if (goods.diaentiy.Dia_Lab) {
            cell.dipLable.text=[@"证书:" stringByAppendingString:goods.diaentiy.Dia_Lab];
        }
        if (goods.diaentiy.Dia_ART) {
            cell.dipLable.text=[cell.dipLable.text stringByAppendingString:[NSString stringWithFormat:@"  编号:%@",goods.diaentiy.Dia_ART]];
        }
        cell.model1Lable.text=[@"形状:" stringByAppendingString:cell.modelLable.text];
        if (goods.pweight) {
            cell.model1Lable.text=[cell.model1Lable.text stringByAppendingString:[NSString stringWithFormat:@"  钻重:%@",goods.pweight]];
        }
        if (goods.pcolor) {
            cell.model1Lable.text=[cell.model1Lable.text stringByAppendingString:[NSString stringWithFormat:@"  颜色:%@",goods.pcolor]];
        }
        if (goods.pvvs) {
            cell.model1Lable.text=[cell.model1Lable.text stringByAppendingString:[NSString stringWithFormat:@"  净度:%@",goods.pvvs]];
        }
        if (goods.diaentiy.Dia_Cut) {
            cell.model1Lable.text=[cell.model1Lable.text stringByAppendingString:[NSString stringWithFormat:@"  切工:%@",goods.diaentiy.Dia_Cut]];
        }
        if (goods.diaentiy.Dia_Pol) {
            cell.model1Lable.text=[cell.model1Lable.text stringByAppendingString:[NSString stringWithFormat:@"  抛光:%@",goods.diaentiy.Dia_Pol]];
        }
        if (goods.diaentiy.Dia_Sym) {
            cell.fluLable.text=[@"对称:" stringByAppendingString:goods.diaentiy.Dia_Sym];
        }else{
            cell.fluLable.text=nil;
        }
        cell.priceLable.text=goods.pcount;
    }else if([goods.producttype isEqualToString:@"1"] || [goods.producttype isEqualToString:@"2"] || [goods.producttype isEqualToString:@"10"]){
        if ([goods.producttype isEqualToString:@"10"]) {
            cell.showImage.image=[[UIImage alloc] initWithContentsOfFile:goods.proentiy.Pro_smallpic];
        }else
        {
            NSURL *imgUrl=[NSURL URLWithString:[NSString stringWithFormat:@"http://seyuu.com%@",goods.proentiy.Pro_smallpic]];
            if (hasCachedImage(imgUrl)) {
                cell.showImage.image=[UIImage imageWithContentsOfFile:pathForURL(imgUrl)];
            }else
            {
                cell.showImage.image=[UIImage imageNamed:@"diamonds"];
                NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:imgUrl,@"url",cell.showImage,@"imageView",nil];
                [NSThread detachNewThreadSelector:@selector(cacheImage:) toTarget:[ImageCacher defaultCacher] withObject:dic];
                
            }
        }
        if (goods.proentiy.Pro_model) {
            cell.dipLable.text=goods.proentiy.Pro_model;
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
        }
        if (goods.pgoldtype) {
            cell.model1Lable.text=[cell.model1Lable.text stringByAppendingString:[NSString stringWithFormat:@"  材质:%@",goods.pgoldtype]];
        }
        if (goods.proentiy.Pro_Z_weight) {
            cell.model1Lable.text=[cell.model1Lable.text stringByAppendingString:[NSString stringWithFormat:@"  钻重:%@",goods.proentiy.Pro_Z_weight]];
        }
        if (goods.proentiy.Pro_f_clarity) {
            cell.model1Lable.text=[cell.model1Lable.text stringByAppendingString:[NSString stringWithFormat:@"  净度:%@",goods.proentiy.Pro_f_clarity]];
        }
        if (goods.proentiy.Pro_Z_color) {
            cell.model1Lable.text=[cell.model1Lable.text stringByAppendingString:[NSString stringWithFormat:@"  颜色:%@",goods.proentiy.Pro_Z_color]];
        }
        if (goods.proentiy.Pro_goldsize) {
            cell.chasing.text=[@"手寸:" stringByAppendingString:goods.proentiy.Pro_goldsize];
        }else{
            cell.chasing.text=nil;
        }
        cell.fluLable.text=nil;
        cell.priceLable.text=goods.pcount;
    }
    else if ([goods.producttype isEqualToString:@"9"])
    {
        NSString *fullpath =goods.photos;
        UIImage *savedImage = [[UIImage alloc] initWithContentsOfFile:fullpath];
        [cell.showImage setImage:savedImage];
        cell.modelLable.text=nil;
        if (goods.pgoldtype) {
            cell.dipLable.text=[@"材质:" stringByAppendingString:goods.pgoldtype];
        }
        if (goods.pweight) {
            cell.dipLable.text=[cell.dipLable.text stringByAppendingString:[NSString stringWithFormat:@"  金重:%@g",goods.pweight]];
        }
        if (goods.Dia_Z_weight) {
            cell.model1Lable.text=[NSString stringWithFormat:@"主石重:%@Ct",goods.Dia_Z_weight];
        }
        if (goods.Dia_Z_count) {
            cell.model1Lable.text=[cell.model1Lable.text stringByAppendingString:[NSString stringWithFormat:@"  主石数:%@",goods.Dia_Z_count]];
        }
        if (goods.Dia_F_weight) {
            cell.model1Lable.text=[cell.model1Lable.text stringByAppendingString:[NSString stringWithFormat:@"  副石重:%@Ct",goods.Dia_F_weight]];
        }
        if (goods.Dia_F_count) {
            cell.model1Lable.text=[cell.model1Lable.text stringByAppendingString:[NSString stringWithFormat:@"  副石数:%@",goods.Dia_F_count]];
        }
        if (goods.psize) {
            cell.model1Lable.text=[cell.model1Lable.text stringByAppendingString:[NSString stringWithFormat:@"  手寸:%@",goods.psize]];
        }
        if (goods.pdetail) {
            cell.fluLable.text=[@"刻字:" stringByAppendingString:goods.pdetail];
        }else{
            cell.fluLable.text=nil;
        }
        cell.chasing.text=nil;
    }
    
    [cell.deleteshopcart addTarget:self action:@selector(deleteshoppingcartgoods:) forControlEvents:UIControlEventTouchUpInside];
    
    
    return cell;
}

//tableview点击操作
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //NSString *rowString = [self.list objectAtIndex:[indexPath row]];
    //Nakeddisplay.hidden=YES;
}

//购物车删除
-(IBAction)deleteshoppingcartgoods:(id)sender
{
    UIButton* btn = (UIButton*)sender;
    UITableViewCell *cell = (UITableViewCell *)[[[btn superview] superview] superview];
    NSIndexPath *indexPath = [goodsview indexPathForCell:cell];
    buyproduct *entity = [shoppingcartlist objectAtIndex:[indexPath row]];
    sqlService * sql=[[sqlService alloc]init];
    NSString *successdelete=[sql deleteBuyproduct:entity.Id];
    if (successdelete) {
        
        [_mydelegate performSelector:@selector(refleshBuycutData)];
        
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

//订单提交
-(IBAction)submitorder:(id)sender
{
    sqlService *sql=[[sqlService alloc]init];
    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    myDelegate.mydelegate=self;
    NSString *orderinfo=[sql saveOrder:myDelegate.entityl.uId];
    if (![orderinfo isEqualToString:@""]) {
        
        [_mydelegate performSelector:@selector(refleshBuycutData)];
        
        NSString *rowString =orderinfo;
        UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示" message:rowString delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alter show];
    }
}

//点击tableview以外的地方触发事件
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}

-(void)refleshBuycutData
{
    [_mydelegate performSelector:@selector(refleshBuycutData)];
    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    sqlService *shopcar=[[sqlService alloc] init];
    shoppingcartlist=[shopcar GetBuyproductList:myDelegate.entityl.uId];
    [goodsview reloadData];
}

-(void)reloadshopcart
{
    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    sqlService *shopcar=[[sqlService alloc] init];
    shoppingcartlist=[shopcar GetBuyproductList:myDelegate.entityl.uId];
    [goodsview reloadData];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
