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
@synthesize fourthView;
@synthesize fivethview;
@synthesize shopcartcountButton;
@synthesize logoImage;
@synthesize biglogo;
@synthesize aboutus;
@synthesize checkpassword;


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
    NSURL *imgUrl=[NSURL URLWithString:myDelegate.myinfol.logopathsm];
    if (hasCachedImage(imgUrl)) {
        [logoImage setImage:[UIImage imageWithContentsOfFile:pathForURL(imgUrl)]];
    }else
    {
        [logoImage setImage:[UIImage imageNamed:@"logo"]];
        NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:imgUrl,@"url",logoImage,@"imageView",nil];
        [NSThread detachNewThreadSelector:@selector(cacheImage:) toTarget:[ImageCacher defaultCacher] withObject:dic];
        
    }
    NSURL *imgUrl1=[NSURL URLWithString:myDelegate.myinfol.logopath];
    if (hasCachedImage(imgUrl1)) {
        [biglogo setImage:[UIImage imageWithContentsOfFile:pathForURL(imgUrl1)]];
    }else
    {
        [biglogo setImage:[UIImage imageNamed:@"logoshengyu"]];
        NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:imgUrl1,@"url",biglogo,@"imageView",nil];
        [NSThread detachNewThreadSelector:@selector(cacheImage:) toTarget:[ImageCacher defaultCacher] withObject:dic];
        
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
//关于我们
-(IBAction)aboutus:(id)sender
{
    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    fourthView.hidden=NO;
    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:myDelegate.myinfol.details]];
    [aboutus loadRequest:request];
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
        }else if([goods.producttype isEqualToString:@"1"] || [goods.producttype isEqualToString:@"2"]){
            NSURL *imgUrl=[NSURL URLWithString:[NSString stringWithFormat:@"http://seyuu.com%@",goods.proentiy.Pro_smallpic]];
            if (hasCachedImage(imgUrl)) {
                cell.showImage.image=[UIImage imageWithContentsOfFile:pathForURL(imgUrl)];
            }else
            {
                cell.showImage.image=[UIImage imageNamed:@"diamonds"];
                NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:imgUrl,@"url",cell.showImage,@"imageView",nil];
                [NSThread detachNewThreadSelector:@selector(cacheImage:) toTarget:[ImageCacher defaultCacher] withObject:dic];
                
            }
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
    else if ([goods.producttype isEqualToString:@"9"])
    {
        NSString *fullpath =goods.photos;
        UIImage *savedImage = [[UIImage alloc] initWithContentsOfFile:fullpath];
        [cell.showImage setImage:savedImage];
        if (goods.pgoldtype) {
            cell.dipLable.text=[@"材质:" stringByAppendingString:goods.pgoldtype];
        }else{
            cell.dipLable.text=nil;
        }
        if (goods.pweight) {
            cell.numberLable.text=[NSString stringWithFormat:@"金重:%@g",goods.pweight];
        }else{
            cell.numberLable.text=nil;
        }
        if (goods.Dia_Z_weight) {
            cell.model1Lable.text=[NSString stringWithFormat:@"主石重:%@Ct",goods.Dia_Z_count];
        }else{
            cell.model1Lable.text=nil;
        }
        if (goods.Dia_Z_count) {
            cell.weightLable.text=[@"主石数:" stringByAppendingString:goods.Dia_Z_count];
        }else{
            cell.weightLable.text=nil;
        }
        if (goods.Dia_F_weight) {
            cell.netLable.text=[NSString stringWithFormat:@"副石重:%@Ct",goods.Dia_F_weight];
        }else{
            cell.netLable.text=nil;
        }
        if (goods.Dia_F_count) {
            cell.colorLable.text=[@"副石数:" stringByAppendingString:goods.Dia_F_count];
        }else{
            cell.colorLable.text=nil;
        }
        if (goods.psize) {
            cell.cutLable.text=[@"手寸:" stringByAppendingString:goods.psize];
        }else{
            cell.cutLable.text=nil;
        }
        if (goods.pdetail) {
            cell.fluLable.text=[@"刻字:" stringByAppendingString:goods.pdetail];
        }else{
            cell.fluLable.text=nil;
        }
        cell.chasing.text=nil;
    }
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
        AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
        sql=[[sqlService alloc]init];
        myDelegate.entityl.resultcount=[sql getBuyproductcount:myDelegate.entityl.uId];
        NSString *goodscount=myDelegate.entityl.resultcount;
        if (goodscount && ![goodscount isEqualToString:@""] && ![goodscount isEqualToString:@"0"]) {
            shopcartcountButton.hidden=NO;
            [shopcartcountButton setTitle:goodscount forState:UIControlStateNormal];
        }else{
            shopcartcountButton.hidden=YES;
        }
        
        NSString *rowString =@"删除成功！";
        UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示" message:rowString delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alter show];

        sqlService *shopcar=[[sqlService alloc] init];
        shoppingcartlist=[shopcar GetBuyproductList:myDelegate.entityl.uId];
        [goodsview reloadData];
        
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
        NSString *orderinfo=[sql saveOrder:myDelegate.entityl.uId];
        if (![orderinfo isEqualToString:@""]) {
            
            sql=[[sqlService alloc]init];
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
            [goodsview reloadData];
            
            NSString *rowString =orderinfo;
            UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示" message:rowString delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alter show];
        }
}

//更新数据
-(IBAction)updateProductDate:(id)sender
{
    @try {
        //可以在此加代码提示用户说正在加载数据中
        NSString *rowString =@"正在更新数据。。。。";
        UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示" message:rowString delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
        [alter show];
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            // 耗时的操作（异步操作）
            
            AutoGetData * getdata=[[AutoGetData alloc] init];
            [getdata getDataInsertTable:nil];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //可以在此加代码提示用户，数据已经加载完毕
                [alter dismissWithClickedButtonIndex:0 animated:YES];
                
                //NSString *rowString =@"更新成功！";
//                UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示" message:rowString delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//                [alter show];
                AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
                UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示" message:@"数据更新完，开始下载3d图片集。。。" delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
                [alter show];
                
                myDelegate.alter=alter;
                myDelegate.thridView=thridView;
                
                //同步完数据了，则再去下载图片组
                [getdata getAllZIPPhotos];
                
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

@end
