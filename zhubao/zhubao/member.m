//
//  member.m
//  zhubao
//
//  Created by johnson on 14-5-29.
//  Copyright (c) 2014年 SUNYEARS___FULLUSERNAME. All rights reserved.
//

#import "member.h"

@interface member ()

@end

@implementation member

@synthesize primaryView;
@synthesize secondaryView;
@synthesize primaryShadeView;
@synthesize thridaryView;
@synthesize fourtharyView;
@synthesize fiftharyView;
@synthesize selectTableView;
@synthesize provincelist=_provincelist;
@synthesize citylist=_citylist;
@synthesize Divisionlist=_Divisionlist;
@synthesize provinceText;
@synthesize cityText;
@synthesize divisionText;
@synthesize companyText;
@synthesize cusnameText;
@synthesize mobileText;
@synthesize telText;
@synthesize addressText;
@synthesize oldpassword;
@synthesize newpassword;
@synthesize affirmpassword;
@synthesize goodsview;
@synthesize shopcartcount;
@synthesize logoImage;


//判定点击来哪个tableview
NSInteger selecttable=0;


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
    NSArray *Divisionarray = [[NSArray alloc] initWithObjects:@"办公室", @"市场部",
                         @"采购部", @"技术部",@"人力资源",@"其他", nil];
    //NSArray *province=[[NSArray alloc] initWithObjects:@"广东",@"广西",@"河北", nil];
    NSArray *province = [[NSArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"city" ofType:@"plist"]];
    
    
    self.provincelist=province;
    self.Divisionlist=Divisionarray;
    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    NSURL *imgUrl=[NSURL URLWithString:myDelegate.myinfol.logopathsm];
    if (hasCachedImage(imgUrl)) {
        [logoImage setImage:[UIImage imageWithContentsOfFile:pathForURL(imgUrl)]];
    }else
    {
        [logoImage setImage:[UIImage imageNamed:@"logo"]];
        NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:imgUrl,@"url",logoImage,@"imageView",nil];
        [NSThread detachNewThreadSelector:@selector(cacheImage:) toTarget:[ImageCacher defaultCacher] withObject:dic];
        
    }
    
    NSString *goodscount=myDelegate.entityl.resultcount;
    if (goodscount && ![goodscount isEqualToString:@""] && ![goodscount isEqualToString:@"0"]) {
        shopcartcount.hidden=NO;
        [shopcartcount setTitle:goodscount forState:UIControlStateNormal];
    }else{
        shopcartcount.hidden=YES;
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
    NakedDiamond * _NakedDiamond = [[NakedDiamond alloc] init];
    
    [self.navigationController pushViewController:_NakedDiamond animated:NO];
}

-(IBAction)doReg3:(id)sender
{
    ustomtailor * _ustomtailor = [[ustomtailor alloc] init];
    
    [self.navigationController pushViewController:_ustomtailor animated:NO];
}

-(IBAction)doReg4:(id)sender
{
    diploma * _diploma = [[diploma alloc] init];
    
    [self.navigationController pushViewController:_diploma animated:NO];
}


//购物车页面跳转
- (IBAction)goAction:(id)sender
{
    selecttable=3;
    primaryShadeView.alpha=0.5;
    secondaryView.frame = CGRectMake(145, 90, secondaryView.frame.size.width, secondaryView.frame.size.height);
    secondaryView.hidden = NO;
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
        AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
        sql=[[sqlService alloc]init];
        myDelegate.entityl.resultcount=[sql getBuyproductcount:myDelegate.entityl.uId];
        NSString *goodscount=myDelegate.entityl.resultcount;
        if (goodscount && ![goodscount isEqualToString:@""] && ![goodscount isEqualToString:@"0"]) {
            shopcartcount.hidden=NO;
            [shopcartcount setTitle:goodscount forState:UIControlStateNormal];
        }else{
            shopcartcount.hidden=YES;
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

//订单提交
-(IBAction)submitorder:(id)sender
{
    sqlService *sql=[[sqlService alloc]init];
    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    if (![myDelegate.entityl.userPass isEqualToString:@""] && myDelegate.entityl.userPass!=nil ) {
        NSString *orderinfo=[sql saveOrder:myDelegate.entityl.uId];
        if (![orderinfo isEqualToString:@""]) {
            NSString *rowString =orderinfo;
            UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示" message:rowString delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alter show];
        }
    }
}

- (IBAction)closeAction:(id)sender
{
    primaryShadeView.alpha=0;
    secondaryView.hidden = YES;
}

//会员密码修改页面跳转
- (IBAction)goAction1:(id)sender
{
    thridaryView.frame = CGRectMake(195, 90, thridaryView.frame.size.width, thridaryView.frame.size.height);
    thridaryView.hidden = NO;
}

- (IBAction)closeAction1:(id)sender
{
    thridaryView.hidden = YES;
}

//会员资料修改页面跳转
- (IBAction)goAction2:(id)sender
{
    fourtharyView.frame = CGRectMake(195, 90, fourtharyView.frame.size.width, fourtharyView.frame.size.height);
    fourtharyView.hidden = NO;
    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    companyText.text=myDelegate.entityl.userTrueName;
    cusnameText.text=myDelegate.entityl.lxrName;
    mobileText.text=myDelegate.entityl.Phone;
    telText.text=myDelegate.entityl.Lxphone;
    provinceText.text=myDelegate.entityl.Sf;
    cityText.text=myDelegate.entityl.Cs;
    addressText.text=myDelegate.entityl.Address;
    NSString *division=nil;
    if ([ myDelegate.entityl.bmName isEqualToString:@"1"]) {
        division=@"办公室";
    }else if ([ myDelegate.entityl.bmName isEqualToString:@"2"]){
        division=@"市场部";
    }else if ([ myDelegate.entityl.bmName isEqualToString:@"3"]){
        division=@"采购部";
    }else if ([ myDelegate.entityl.bmName isEqualToString:@"4"]){
        division=@"技术部";
    }else if ([ myDelegate.entityl.bmName isEqualToString:@"5"]){
        division=@"人力资源";
    }else if ([ myDelegate.entityl.bmName isEqualToString:@"6"]){
        division=@"其他";
    }
    divisionText.text=division;
}

- (IBAction)closeAction2:(id)sender
{
    fourtharyView.hidden = YES;
}

//设置页面跳转
-(IBAction)setup:(id)sender
{
     fiftharyView.hidden=NO;
    fiftharyView.frame=CGRectMake(750, 70, fiftharyView.frame.size.width, fiftharyView.frame.size.height);
}

//软件更新
-(IBAction)updatesofeware:(id)sender
{
    fiftharyView.hidden=YES;
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
                myDelegate.thridView=fiftharyView;
                
                //同步完数据了，则再去下载图片组
                [getdata getAllZIPPhotos];
                
            });
        });
        fiftharyView.hidden=YES;
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
}

//下拉框
-(IBAction)selecttableview:(id)sender
{
    UIButton* btn = (UIButton*)sender;
    NSInteger btntag=[btn tag];
    selecttable=btntag;
    selectTableView.hidden=NO;
    if (btntag==0) {
        selectTableView.frame=CGRectMake(297, 267, 93, 100);
    }else if (btntag==1){
        selectTableView.frame=CGRectMake(403, 267, 90, 100);
    }else if (btntag==2){
        selectTableView.frame=CGRectMake(293, 348, 97, 100);
        
    }
    [selectTableView reloadData];
}

//初始化tableview数据
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray * list=nil;
    if (selecttable==0) {
        list=self.provincelist;
    }else if (selecttable==1){
        list=self.citylist;
    }else if (selecttable==2){
        list=self.Divisionlist;
    }else if (selecttable==3){
        list=shoppingcartlist;
    }
    return [list count];
    //只有一组，数组数即为行数。
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (selecttable==3) {
        static NSString *TableSampleIdentifier = @"shoppingcartCell";
        
        shoppingcartCell *cell = [tableView dequeueReusableCellWithIdentifier:TableSampleIdentifier];
        if (cell == nil) {
            NSArray * nib=[[NSBundle mainBundle]loadNibNamed:@"shoppingcartCell" owner:self options:nil];
            cell=[nib objectAtIndex:0];
        }
        buyproduct *goods =[shoppingcartlist objectAtIndex:[indexPath row]];
        if ([goods.producttype isEqualToString:@"3"]) {
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
        }else if([goods.producttype isEqualToString:@"1"] || [goods.producttype isEqualToString:@"2"]){
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
    }else{
        static NSString *TableSampleIdentifier = @"TableSampleIdentifier";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                                 TableSampleIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]
                    initWithStyle:UITableViewCellStyleDefault
                    reuseIdentifier:TableSampleIdentifier];
        }
        
        NSUInteger row = [indexPath row];
        if (selecttable==0) {
            NSDictionary *rowString = [self.provincelist objectAtIndex:[indexPath row]];
            cell.textLabel.text = [rowString objectForKey:@"state"];
            
        }else if (selecttable==1){
            cell.textLabel.text = [self.citylist objectAtIndex:row];
        }else if (selecttable==2){
            cell.textLabel.text = [self.Divisionlist objectAtIndex:row];
        }
        return cell;
    }
    
}

//tableview点击操作
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (selecttable==0) {
         NSDictionary *rowString = [self.provincelist objectAtIndex:[indexPath row]];
        NSString * proname=[rowString objectForKey:@"state"];
        NSArray * cities=[rowString objectForKey:@"cities"];
        
        provinceText.text=proname;
        self.citylist=cities;
        cityText.text=nil;
        
    }else if (selecttable==1){
        NSString *rowString = [self.citylist objectAtIndex:[indexPath row]];
        cityText.text=rowString;
        
    }else if (selecttable==2){
        NSString *rowString = [self.Divisionlist objectAtIndex:[indexPath row]];
        divisionText.text=rowString;
    }
    selectTableView.hidden=YES;
}

//点击tableview以外得地方关闭
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint pt = [touch locationInView:self.view];
    //点击其他地方消失
    if (!CGRectContainsPoint([selectTableView frame], pt)) {
        //to-do
        selectTableView.hidden=YES;
    }
}


//会员资料修改保存操作
-(IBAction)updatemember:(id)sender
{
    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    sqlService *sql=[[sqlService alloc]init];
    customer *man=[sql getCustomer:myDelegate.entityl.uId];
    man.userTrueName=companyText.text;
    man.lxrName=cusnameText.text;
    man.Phone=mobileText.text;
    man.Lxphone=telText.text;
    man.Sf=provinceText.text;
    man.Cs=cityText.text;
    man.Address=addressText.text;
    if ([divisionText.text isEqualToString:@"办公室"]) {
        man.bmName=@"1";
    }else if ([divisionText.text isEqualToString:@"市场部"]){
        man.bmName=@"2";
    }else if ([divisionText.text isEqualToString:@"采购部"]){
        man.bmName=@"3";
    }else if ([divisionText.text isEqualToString:@"技术部"]){
        man.bmName=@"4";
    }else if ([divisionText.text isEqualToString:@"人力资源"]){
        man.bmName=@"5";
    }else if ([divisionText.text isEqualToString:@"其他"]){
        man.bmName=@"6";
    }
    customer *updateman=[sql updateCustomer:man];
    if (updateman) {
        myDelegate.entityl.userTrueName=companyText.text;
        myDelegate.entityl.lxrName=cusnameText.text;
        myDelegate.entityl.Phone=mobileText.text;
        myDelegate.entityl.Lxphone=telText.text;
        myDelegate.entityl.Sf=provinceText.text;
        myDelegate.entityl.Cs=cityText.text;
        myDelegate.entityl.Address=addressText.text;
        if ([divisionText.text isEqualToString:@"办公室"]) {
            myDelegate.entityl.bmName=@"1";
        }else if ([divisionText.text isEqualToString:@"市场部"]){
            myDelegate.entityl.bmName=@"2";
        }else if ([divisionText.text isEqualToString:@"采购部"]){
            myDelegate.entityl.bmName=@"3";
        }else if ([divisionText.text isEqualToString:@"技术部"]){
            myDelegate.entityl.bmName=@"4";
        }else if ([divisionText.text isEqualToString:@"人力资源"]){
            myDelegate.entityl.bmName=@"5";
        }else if ([divisionText.text isEqualToString:@"其他"]){
            myDelegate.entityl.bmName=@"6";
        }
        NSString *rowString =@"修改成功！";
        UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示" message:rowString delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alter show];
    }else{
        NSString *rowString =@"修改失败！";
        UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示" message:rowString delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alter show];
    }
}

//密码修改
-(IBAction)updatepassword:(id)sender
{
    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    sqlService *sql=[[sqlService alloc]init];
    customer *newnam=[sql getCustomer:myDelegate.entityl.uId];
    if ([[Commons md5:[NSString stringWithFormat:@"%@",oldpassword.text]]  isEqualToString:myDelegate.entityl.userPass]) {
        newnam.userPass=[Commons md5:[NSString stringWithFormat:@"%@",newpassword.text]];
        newnam.oldpassword=[Commons md5:[NSString stringWithFormat:@"%@",oldpassword.text]];
        customer *updatesuccess=[sql updateCustomerPasswrod:newnam];
        if (updatesuccess) {
            NSString *rowString =@"修改成功！";
            UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示" message:rowString delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alter show];
             myDelegate.entityl.userPass=[Commons md5:[NSString stringWithFormat:@"%@",newpassword.text]];
        }else{
            NSString *rowString =@"修改失败！";
            UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示" message:rowString delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alter show];
        }
    }else{
        NSString *rowString =@"请输入正确的原密码！";
        UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示" message:rowString delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alter show];
    }
}

//订单页面打开
-(IBAction)openorder:(id)sender
{
    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    //当前时间
    getNowTime * time=[[getNowTime alloc] init];
    NSString * Nowt=[time nowTime];
    //上次更新时间
    NSString *Upt=@"0";
    //订单号
    NSString *orderid=@"0";
    NSString * Kstr=[Commons md5:[NSString stringWithFormat:@"%@|%@|%@|%@|%@|%@",myDelegate.entityl.uId,@"601",Upt,apikey,Nowt,orderid]];
    NSString * surl = [NSString stringWithFormat:@"http://www.seyuu.com/order/myorder.asp?uId=%@&type=601&Upt=%@&Nowt=%@&Kstr=%@&ordid=%@",myDelegate.entityl.uId,Upt,Nowt,Kstr,orderid];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:surl]];
}

@end
