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
@synthesize fivetharyView;
@synthesize sixview;
@synthesize weightmin;
@synthesize weightmax;
@synthesize pricemin;
@synthesize pricemax;
@synthesize DiamondNo;
@synthesize Nakeddisplay;
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
@synthesize modelbtn;
@synthesize colorbtn;
@synthesize netbtn;
@synthesize goodsview;
@synthesize shopcartcount;
@synthesize logoImage;
@synthesize checkpassword;
@synthesize nakediacount;

NSString * nakedno=nil;
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
    weightmin.keyboardType=UIKeyboardTypeNumberPad;
    weightmax.keyboardType=UIKeyboardTypeNumberPad;
    pricemin.keyboardType=UIKeyboardTypeNumberPad;
    pricemax.keyboardType=UIKeyboardTypeNumberPad;
    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    
    NSString *goodscount=myDelegate.entityl.resultcount;
    if (goodscount && ![goodscount isEqualToString:@""] && ![goodscount isEqualToString:@"0"]) {
        shopcartcount.hidden=NO;
        [shopcartcount setTitle:goodscount forState:UIControlStateNormal];
    }else{
        shopcartcount.hidden=YES;
    }

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
    whichview=0;
    primaryShadeView.alpha=0.5;
    secondaryView.frame = CGRectMake(140, 95, secondaryView.frame.size.width, secondaryView.frame.size.height);
    secondaryView.hidden = NO;
    sqlService *product=[[sqlService alloc] init];
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
    productlist=[product GetProductdiaList:shape type2:weight type3:price type4:color type5:net type6:cut type7:chasing type8:symmetry type9:fluorescence type10:diploma type11:number page:1 pageSize:1500];
    
    [Nakeddisplay reloadData];
    
}

//重置页面
-(IBAction)resetview:(id)sender
{
    NakedDiamond * _NakedDiamond = [[NakedDiamond alloc] init];
    
    [self.navigationController pushViewController:_NakedDiamond animated:NO];
}

- (IBAction)closeAction:(id)sender
{
    secondaryView.hidden = YES;
    nakediacount.text=@"";
    primaryShadeView.alpha=0;
}

- (IBAction)goAction1:(id)sender
{
    secondShadeView.alpha=0.5;
    thridaryView.frame = CGRectMake(140, 95, thridaryView.frame.size.width, thridaryView.frame.size.height);
    thridaryView.hidden = NO;
    titleLable.text=@"string";
    modelLable.text=@"string";
    productNoLable.text=@"string";
    weightLable.text=@"string";
    colorLable.text=@"string";
    netLable.text=@"string";
    cutLable.text=@"string";
    chasingLable.text=@"string";
    symmetryLable.text=@"string";
    depthLable.text=@"string";
    tableLable.text=@"string";
    sizeLable.text=@"string";
    fluorescenceLable.text=@"string";
    diplomaLable.text=@"string";
    priceLable.text=@"string";
}

- (IBAction)closeAction1:(id)sender
{
    thridaryView.hidden = YES;
    secondShadeView.alpha=0;
}

//购物车
- (IBAction)goAction2:(id)sender
{
    whichview=1;
    thirdShadeView.alpha=0.5;
    fourtharyView.frame = CGRectMake(140, 95, fourtharyView.frame.size.width, fourtharyView.frame.size.height);
    fourtharyView.hidden = NO;
    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    sqlService *shopcar=[[sqlService alloc] init];
    shoppingcartlist=[shopcar GetBuyproductList:myDelegate.entityl.uId];
    [goodsview reloadData];
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
        
        [self refleshBuycutData];
        
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

//订单提交
-(IBAction)submitorder:(id)sender
{
    sqlService *sql=[[sqlService alloc]init];
    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    myDelegate.mydelegate=self;
        NSString *orderinfo=[sql saveOrder:myDelegate.entityl.uId];
        if (![orderinfo isEqualToString:@""]) {
            
            [self refleshBuycutData];
            
            NSString *rowString =orderinfo;
            UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示" message:rowString delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alter show];
        }
}

- (IBAction)closeAction2:(id)sender
{
    fourtharyView.hidden = YES;
    thirdShadeView.alpha=0;
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
    fivetharyView.hidden=NO;
    fivetharyView.frame=CGRectMake(750, 70, fivetharyView.frame.size.width, fivetharyView.frame.size.height);
}

//软件更新
-(IBAction)updatesofeware:(id)sender
{
    fivetharyView.hidden=YES;
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
                [getdata getAllZIPPhotos];
                
            });
        });
        fivetharyView.hidden=YES;
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
}

//初始化tableview数据
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger value=0;
    if (whichview==1) {
        value=[shoppingcartlist count];
    }else{
        value=[productlist count];
        nakediacount.text=[NSString stringWithFormat:@"共有钻石%lu颗",(unsigned long)[productlist count]];
    }
    return value;
    //只有一组，数组数即为行数。
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (whichview==1) {
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
        return cell;
    }else{
        static NSString *TableSampleIdentifier = @"NoticeReportCell";
        
        NoticeReportCell *cell = [tableView dequeueReusableCellWithIdentifier:TableSampleIdentifier];
        if (cell == nil) {
            NSArray * nib=[[NSBundle mainBundle]loadNibNamed:@"NoticeReportCell" owner:self options:nil];
            cell=[nib objectAtIndex:0];
        }
        productdia *entity =[productlist objectAtIndex:[indexPath row]];
        if ([entity.Dia_Shape isEqualToString:@"RB"]) {
            cell.notice.text=@"圆形";
            cell.showimage.image=[UIImage imageNamed:@"round.jpg"];
        }
        else if ([entity.Dia_Shape isEqualToString:@"PE"]){
            cell.notice.text=@"公主方";
            cell.showimage.image=[UIImage imageNamed:@"princess2.jpg"];
        }
        else if ([entity.Dia_Shape isEqualToString:@"EM"]){
            cell.notice.text=@"祖母绿";
            cell.showimage.image=[UIImage imageNamed:@"Emerald.jpg"];
        }
        else if ([entity.Dia_Shape isEqualToString:@"RD"]){
            cell.notice.text=@"雷蒂恩";
            cell.showimage.image=[UIImage imageNamed:@"radiant.jpg"];
        }
        else if ([entity.Dia_Shape isEqualToString:@"OL"]){
            cell.notice.text=@"椭圆形";
            cell.showimage.image=[UIImage imageNamed:@"Oval.jpg"];
        }
        else if ([entity.Dia_Shape isEqualToString:@"MQ"]){
            cell.notice.text=@"橄榄形";
            cell.showimage.image=[UIImage imageNamed:@"marquise.jpg"];
        }
        else if ([entity.Dia_Shape isEqualToString:@"CU"]){
            cell.notice.text=@"枕形";
            cell.showimage.image=[UIImage imageNamed:@"cushion.jpg"];
        }
        else if ([entity.Dia_Shape isEqualToString:@"PR"]){
            cell.notice.text=@"梨形";
            cell.showimage.image=[UIImage imageNamed:@"Pear2.jpg"];
        }
        else if ([entity.Dia_Shape isEqualToString:@"HT"]){
            cell.notice.text=@"心形";
            cell.showimage.image=[UIImage imageNamed:@"Heart.jpg"];
        }
        else if ([entity.Dia_Shape isEqualToString:@"ASH"]){
            cell.notice.text=@"镭射刑";
            cell.showimage.image=[UIImage imageNamed:@"Asscher2.jpg"];
        }
        cell.noticeDate.text=entity.Dia_CertNo;
        cell.tuDate.text=entity.Dia_Carat;
        cell.Dia_Col.text=entity.Dia_Col;
        cell.Dia_Clar.text=entity.Dia_Clar;
        cell.Dia_Cut.text=entity.Dia_Cut;
        NSArray *price=[entity.Dia_Price componentsSeparatedByString:@"."];
        cell.chasinglable.text=[@"¥" stringByAppendingString:[price objectAtIndex:0]];
        cell.Dia_Sym.text=entity.Dia_Lab;
        cell.Dia_Lab.text=entity.Dia_Pol;
        cell.Dia_Price.text=entity.Dia_Sym;
        cell.teslable.text=@"查看";
        
        return cell;
    }
}

//tableview点击操作，裸钻详情页面显示
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (whichview==1) {
        
    }else{
        productdia *entity = [productlist objectAtIndex:[indexPath row]];
        nakedno=entity.Id;
        //    NSString *rowString =[NSString stringWithFormat:@"你点击了：%@",entity.Dia_CertNo];
        //    UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示" message:rowString delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        //    [alter show];
        secondShadeView.alpha=0.5;
        thridaryView.frame = CGRectMake(140, 95, thridaryView.frame.size.width, thridaryView.frame.size.height);
        thridaryView.hidden = NO;
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
        sql=[[sqlService alloc]init];
        myDelegate.entityl.resultcount=[sql getBuyproductcount:myDelegate.entityl.uId];
        shopcartcount.hidden=NO;
        [shopcartcount setTitle:myDelegate.entityl.resultcount forState:UIControlStateNormal];
        
        NSString *rowString =@"成功加入购物车！";
        UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示" message:rowString delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alter show];
    } else{
        NSString *rowString =@"加入购物车失败！";
        UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示" message:rowString delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alter show];
    }
}

//点击tableview以外得地方关闭
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint pt = [touch locationInView:self.view];
    //点击其他地方消失
    if (!CGRectContainsPoint([fivetharyView frame], pt)) {
        //to-do
        fivetharyView.hidden=YES;
    }
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
    [goodsview reloadData];
    
}

@end
