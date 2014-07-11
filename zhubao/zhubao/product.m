//
//  product.m
//  zhubao
//
//  Created by johnson on 14-5-28.
//  Copyright (c) 2014年 SUNYEARS___FULLUSERNAME. All rights reserved.
//

#import "product.h"

@interface product ()

@end

@implementation product

@synthesize primaryView;
@synthesize secondaryView;
@synthesize primaryShadeView;
@synthesize thridaryView;
@synthesize secondShadeView;
@synthesize fourthView;
@synthesize fivethview;
@synthesize mianselect;
@synthesize netselect;
@synthesize colorselect;
@synthesize textureselect;
@synthesize mainlist=_mainlist;
@synthesize mainmanlist;
@synthesize netlist=_netlist;
@synthesize colorlist=_colorlist;
@synthesize texturelist=_texturelist;
@synthesize maintext;
@synthesize nettext;
@synthesize colortext;
@synthesize texturetext;
@synthesize sizeText;
@synthesize fontText;
@synthesize numberText;
@synthesize modellable;
@synthesize weightlable;
@synthesize mainlable;
@synthesize fitNolable;
@synthesize fitweightlable;
@synthesize sizetext;
@synthesize fonttext;
@synthesize numbertext;
@synthesize title1lable;
@synthesize pricelable;
@synthesize productimageview;
@synthesize productcollect;
@synthesize countLable;
@synthesize btnstyle;
@synthesize btntexture;
@synthesize btninlay;
@synthesize btnseric;
@synthesize goodsview;
@synthesize shopcartcount;
@synthesize logoImage;
@synthesize mamMainText;
@synthesize manNetText;
@synthesize mamColorText;
@synthesize manTextureText;
@synthesize manSizeText;
@synthesize manFontText;
@synthesize button3D;
@synthesize button3dwoman;
@synthesize button3dman;
@synthesize checkpassword;

//判定点击来哪个tableview
NSInteger selecttype=0;
//产品id
NSString * productnumber=nil;
//查询结果
NSMutableArray *list=nil;
//默认商品
productEntity *goods;
//对戒男戒
productEntity *goodsman;
//商品类型
NSString * Pro_type;
//女戒价格
NSString *womanprice=nil;
//男戒价格
NSString *manprice=nil;
//主石约重
NSMutableArray *inlayarry;
//男主石约重
NSMutableArray *inlayarryman;

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
    //主石重量
    //净度
    NSArray *netarray = [[NSArray alloc]initWithObjects:@"VVS",@"VS",@"SI",@"P", nil];
    //颜色
    NSArray *colorarray = [[NSArray alloc]initWithObjects:@"F-G",@"H",@"I-J",@"K-L",@"M-N", nil];
    //材质
    NSArray *texture1array = [[NSArray alloc]initWithObjects:@"18K黄",@"18K白",@"18K双色",@"18K玫瑰金",@"PT900",@"PT950",@"PD950", nil];
    self.netlist=netarray;
    self.colorlist=colorarray;
    self.texturelist=texture1array;
    maintext.userInteractionEnabled=NO;
    nettext.userInteractionEnabled=NO;
    colortext.userInteractionEnabled=NO;
    texturetext.userInteractionEnabled=NO;
    mamMainText.userInteractionEnabled=NO;
    manNetText.userInteractionEnabled=NO;
    mamColorText.userInteractionEnabled=NO;
    manTextureText.userInteractionEnabled=NO;
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
    fonttext.placeholder=@"        8到12个字符";
    //进来时候加载全部数据
    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    sqlService *sql=[[sqlService alloc]init];
    list=[sql GetProductList:nil type2:nil type3:nil type4:nil page:1 pageSize:1500];
    pricelable.text=@"获取价格中。。。";
    
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
    
    //定义图片标签的点击事件
    productimageview.userInteractionEnabled=YES;
    UITapGestureRecognizer *singleTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showPhotoBrowser)];
    [productimageview addGestureRecognizer:singleTap];
    
    [_showPhotos addTarget:self action:@selector(showPhotoBrowser) forControlEvents:UIControlEventTouchUpInside];
    
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

- (IBAction)closeAction:(id)sender
{
    primaryShadeView.alpha=0;
    mianselect.hidden=YES;
    colorselect.hidden=YES;
    netselect.hidden=YES;
    textureselect.hidden=YES;
    secondaryView.hidden = YES;
    pricelable.text=@"获取价格中。。。";
}

//购物车
- (IBAction)goAction1:(id)sender
{
    //    secondShadeView.alpha=0.5;
    //    thridaryView.frame = CGRectMake(140, 95, thridaryView.frame.size.width, thridaryView.frame.size.height);
    //    thridaryView.hidden = NO;
}

- (IBAction)closeAction1:(id)sender
{
    thridaryView.hidden = YES;
    secondShadeView.alpha=0;
    primaryShadeView.alpha=0;
}

- (IBAction)threeddAction:(id)sender
{
    
    //FVImageSequenceDemoViewController *sysmenu=[[FVImageSequenceDemoViewController alloc] init];
    UIButton *btn=(UIButton*)sender;
    NSInteger btntag=btn.tag;
    //TestViewController *sysmenu=[[TestViewController alloc] init];
    NSString * code=@"";
    if (btntag==1) {
        code=goodsman.Pro_author;//@"3Y0012";//工厂款号
        //sysmenu.code=goodsman.Pro_author;//@"3Y0012";//工厂款号
        //[self.navigationController pushViewController:sysmenu animated:NO];
    }else{
        code=goods.Pro_author;//@"3Y0012";//工厂款号
        //sysmenu.code=goods.Pro_author;//@"3Y0012";//工厂款号
        //[self.navigationController pushViewController:sysmenu animated:NO];
    }
    
    NSMutableArray *imgArray=[[NSMutableArray alloc]init];
    for(int i=1;i<60;i++){
        NSString *strApend;
        if(i<9)
            strApend=@"00";
        else
            strApend=@"0";
        
        NSString *path = [NSString stringWithFormat:@"%@_%@%d.jpg", code, strApend,i];
        //NSLog(@"%@", path);
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *dcoumentpath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
        // 解压缩文件夹路径
        NSString* unzipPath = [dcoumentpath stringByAppendingString:@"/images"];
        
        //NSLog(@"---------------本地的图片:%@", [NSString stringWithFormat:@"%@/%@",unzipPath,path]);
        
        UIImage *img =  [[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/%@",unzipPath,path]];//[[UIImage alloc] initWithContentsOfFile:path];
        if(img)[imgArray addObject:img];
    }

    rImageView=[[RotateImageView alloc]initWithFrame:self.view.frame];
    rImageView.animationImages=imgArray;
    [rImageView setUserInteractionEnabled:YES];
    [self.view addSubview:rImageView];
    
    //旋转初使化
    rImageView.numberOfImages=[imgArray count]-1;
    [rImageView initTimer];
    
    UIImage* image= [UIImage imageNamed:@"close"];
    CGRect frame_1= CGRectMake(self.view.frame.size.width-80, 30, 48, 48);
    btnBack= [[UIButton alloc] initWithFrame:frame_1];
    [btnBack setBackgroundImage:image forState:UIControlStateNormal];
    [btnBack addTarget:self action:@selector(closeImageView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnBack];
}

-(void)rotateStart{
    [rImageView setRotate:TRUE];
}

-(void)rotateStop{
    [rImageView setRotate:FALSE];
}

-(void)closeImageView
{
    [rImageView removeFromSuperview];
    [btnBack removeFromSuperview];
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
                [getdata getAllZIPPhotos];
                
            });
        });
        fourthView.hidden=YES;
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
}


//tableview行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger value=0;
    if(selecttype==0){
        value=[_mainlist count];
    }else if(selecttype==1 || selecttype==6){
        value=[_netlist count];
    }else if(selecttype==2 || selecttype==7){
        value=[_colorlist count];
    }else if (selecttype==3 || selecttype==8){
        value=[_texturelist count];
    }else if (selecttype==4)
    {
        value=[shoppingcartlist count];
    }else if(selecttype==5)
    {
        value=[mainmanlist count];
    }
    return value;
    //只有一组，数组数即为行数。
}

//tableview值
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (selecttype==4) {
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
        static NSString *TableSampleIdentifier = @"TableSampleIdentifier";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                                 TableSampleIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]
                    initWithStyle:UITableViewCellStyleDefault
                    reuseIdentifier:TableSampleIdentifier];
        }
        
        NSUInteger row = [indexPath row];
        if(selecttype==0){
            cell.textLabel.text = [self.mainlist objectAtIndex:row];
        }else if(selecttype==1 || selecttype==6){
            cell.textLabel.text = [self.netlist objectAtIndex:row];
        }else if(selecttype==2 || selecttype==7){
            cell.textLabel.text = [self.colorlist objectAtIndex:row];
        }else if (selecttype==3 || selecttype==8){
            cell.textLabel.text = [self.texturelist objectAtIndex:row];
        }else if (selecttype==5)
        {
            cell.textLabel.text=[self.mainmanlist objectAtIndex:row];
        }
        return cell;
    }
}


//点击tableview触发事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *rowString=nil;
    if(selecttype==0){
        rowString = [self.mainlist objectAtIndex:[indexPath row]];
        maintext.text=rowString;
        mianselect.hidden=YES;
        colorselect.hidden=YES;
        netselect.hidden=YES;
        textureselect.hidden=YES;
        
    }else if(selecttype==1){
        rowString = [self.netlist objectAtIndex:[indexPath row]];
        nettext.text=rowString;
        mianselect.hidden=YES;
        colorselect.hidden=YES;
        netselect.hidden=YES;
        textureselect.hidden=YES;
    }else if(selecttype==2){
        rowString = [self.colorlist objectAtIndex:[indexPath row]];
        colortext.text=rowString;
        mianselect.hidden=YES;
        colorselect.hidden=YES;
        netselect.hidden=YES;
        textureselect.hidden=YES;
    }else if (selecttype==3){
        rowString = [self.texturelist objectAtIndex:[indexPath row]];
        texturetext.text=rowString;
        mianselect.hidden=YES;
        colorselect.hidden=YES;
        netselect.hidden=YES;
        textureselect.hidden=YES;
    }else if(selecttype==5){
        rowString = [self.mainmanlist objectAtIndex:[indexPath row]];
        mamMainText.text=rowString;
        mianselect.hidden=YES;
        colorselect.hidden=YES;
        netselect.hidden=YES;
        textureselect.hidden=YES;
        
    }else if(selecttype==6){
        rowString = [self.netlist objectAtIndex:[indexPath row]];
        manNetText.text=rowString;
        mianselect.hidden=YES;
        colorselect.hidden=YES;
        netselect.hidden=YES;
        textureselect.hidden=YES;
    }else if(selecttype==7){
        rowString = [self.colorlist objectAtIndex:[indexPath row]];
        mamColorText.text=rowString;
        mianselect.hidden=YES;
        colorselect.hidden=YES;
        netselect.hidden=YES;
        textureselect.hidden=YES;
    }else if (selecttype==8){
        rowString = [self.texturelist objectAtIndex:[indexPath row]];
        manTextureText.text=rowString;
        mianselect.hidden=YES;
        colorselect.hidden=YES;
        netselect.hidden=YES;
        textureselect.hidden=YES;
    }
    //获取商品价格
    sqlService * sql=[[sqlService alloc] init];
    productEntity *goods=[sql GetProductDetail:productnumber];
    NSString *textvalue=nil;
    Commons * common=[[Commons alloc]init];
    textvalue=[common getGoldtypevalue:texturetext.text];
    
    NSString * weightg=[self getweightg:rowString];
    NSString * weightman=[self getweightman:rowString];
    
    @try {
        //可以在此加代码提示用户说正在加载数据中
        pricelable.text=@"获取价格中。。。";
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            // 耗时的操作（异步操作）
            
            pricelable.text=@"获取价格中。。。";
            NSString *proprice=nil;
            productApi *priceApi=[[productApi alloc]init];
            womanprice=[priceApi getPrice:goods.Pro_Class goldType:texturetext.text goldWeight:weightg mDiaWeight:maintext.text mDiaColor:colortext.text mVVS:nettext.text sDiaWeight:goods.Pro_f_weight sCount:goods.Pro_f_count proid:goods.Id];
            if ([goods.Pro_Class isEqualToString:@"3"] && [goods.Pro_typeWenProId isEqualToString:@"0"]) {
                priceApi=[[productApi alloc]init];
                manprice=[priceApi getPrice:goodsman.Pro_Class goldType:manTextureText.text goldWeight:weightman mDiaWeight:mamMainText.text mDiaColor:mamColorText.text mVVS:manNetText.text sDiaWeight:goodsman.Pro_f_weight sCount:goodsman.Pro_f_count proid:goodsman.Id];
                proprice=[NSString stringWithFormat:@"%d",womanprice.intValue+manprice.intValue];
            }else{
                proprice=womanprice;
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                if (proprice) {
                    //pricelable.text=[@"¥" stringByAppendingString:proprice];
                    NSArray *price=[[NSString stringWithFormat:@"%@",proprice] componentsSeparatedByString:@"."];
                    pricelable.text=[NSString stringWithFormat:@"¥ %@",[price objectAtIndex:0]];
                }else{
                    pricelable.text=@"暂无价格信息";
                }
                
            });
        });
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
    
    if (!CGRectContainsPoint([fourthView frame], pt)) {
        //to-do
        fourthView.hidden=YES;
    }
    //点击其他地方消失
    if(selecttype==0 || selecttype==5){
        if (!CGRectContainsPoint([mianselect frame], pt)) {
            //to-do
            mianselect.hidden=YES;
            colorselect.hidden=YES;
            netselect.hidden=YES;
            textureselect.hidden=YES;
        }
    }else if(selecttype==1 || selecttype==6){
        if (!CGRectContainsPoint([netselect frame], pt)) {
            //to-do
            mianselect.hidden=YES;
            colorselect.hidden=YES;
            netselect.hidden=YES;
            textureselect.hidden=YES;
        }
    }else if(selecttype==2 || selecttype==7){
        if (!CGRectContainsPoint([colorselect frame], pt)) {
            //to-do
            mianselect.hidden=YES;
            colorselect.hidden=YES;
            netselect.hidden=YES;
            textureselect.hidden=YES;
        }
    }else if (selecttype==3 || selecttype==8){
        if (!CGRectContainsPoint([textureselect frame], pt)) {
            //to-do
            mianselect.hidden=YES;
            colorselect.hidden=YES;
            netselect.hidden=YES;
            textureselect.hidden=YES;
        }
    }
}

//下拉按钮执行动作
-(IBAction)mainselect:(id)sender
{
    UIButton* btn = (UIButton*)sender;
    NSInteger btntag=[btn tag];
    selecttype=btntag;
    if(btntag==0){
        mianselect.hidden=NO;
        colorselect.hidden=YES;
        netselect.hidden=YES;
        textureselect.hidden=YES;
        mianselect.frame=CGRectMake(544, mianselect.frame.origin.y, mianselect.frame.size.width, mianselect.frame.size.height);
        [mianselect reloadData];
    }else if(btntag==1){
        netselect.hidden=NO;
        mianselect.hidden=YES;
        colorselect.hidden=YES;
        textureselect.hidden=YES;
        netselect.frame=CGRectMake(544, netselect.frame.origin.y, netselect.frame.size.width, netselect.frame.size.height);
        [netselect reloadData];
    }else if (btntag==2){
        colorselect.hidden=NO;
        mianselect.hidden=YES;
        netselect.hidden=YES;
        textureselect.hidden=YES;
        colorselect.frame=CGRectMake(544, colorselect.frame.origin.y, colorselect.frame.size.width, colorselect.frame.size.height);
        [colorselect reloadData];
    }else if (btntag==3){
        textureselect.hidden=NO;
        mianselect.hidden=YES;
        colorselect.hidden=YES;
        netselect.hidden=YES;
        textureselect.frame=CGRectMake(544, textureselect.frame.origin.y, textureselect.frame.size.width, textureselect.frame.size.height);
        [textureselect reloadData];
    }else if (btntag==4)
    {
        secondShadeView.alpha=0.5;
        primaryShadeView.alpha=0.5;
        thridaryView.frame = CGRectMake(140, 95, thridaryView.frame.size.width, thridaryView.frame.size.width);
        thridaryView.hidden = NO;

        AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
        sqlService *shopcar=[[sqlService alloc] init];
        shoppingcartlist=[shopcar GetBuyproductList:myDelegate.entityl.uId];
        [goodsview reloadData];
    }else if(btntag==5){
        mianselect.hidden=NO;
        colorselect.hidden=YES;
        netselect.hidden=YES;
        textureselect.hidden=YES;
        mianselect.frame=CGRectMake(544+135, mianselect.frame.origin.y, mianselect.frame.size.width, mianselect.frame.size.height);
        [mianselect reloadData];
    }else if(btntag==6){
        netselect.hidden=NO;
        mianselect.hidden=YES;
        colorselect.hidden=YES;
        textureselect.hidden=YES;
        netselect.frame=CGRectMake(544+135, netselect.frame.origin.y, netselect.frame.size.width, netselect.frame.size.height);
        [netselect reloadData];
    }else if (btntag==7){
        colorselect.hidden=NO;
        mianselect.hidden=YES;
        netselect.hidden=YES;
        textureselect.hidden=YES;
        colorselect.frame=CGRectMake(544+135, colorselect.frame.origin.y, colorselect.frame.size.width, colorselect.frame.size.height);
        [colorselect reloadData];
    }else if (btntag==8){
        textureselect.hidden=NO;
        mianselect.hidden=YES;
        colorselect.hidden=YES;
        netselect.hidden=YES;
        textureselect.frame=CGRectMake(544+135, textureselect.frame.origin.y, textureselect.frame.size.width, textureselect.frame.size.height);
        [textureselect reloadData];
    }
    
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
        [btn setBackgroundImage:[UIImage imageNamed:@"yellowcolor"] forState:UIControlStateNormal];
    }else if (btntag==1){
        style=@"1";
        [btn setBackgroundImage:[UIImage imageNamed:@"yellowcolor"] forState:UIControlStateNormal];
    }else if (btntag==2){
        style=@"2";
        [btn setBackgroundImage:[UIImage imageNamed:@"yellowcolor"] forState:UIControlStateNormal];
    }else if (btntag==3){
        style=@"3";
        [btn setBackgroundImage:[UIImage imageNamed:@"yellowcolor"] forState:UIControlStateNormal];
    }else if (btntag==4){
        style=@"4";
        [btn setBackgroundImage:[UIImage imageNamed:@"yellowcolor"] forState:UIControlStateNormal];
    }else if (btntag==5){
        style=@"5";
        [btn setBackgroundImage:[UIImage imageNamed:@"yellowcolor"] forState:UIControlStateNormal];
    }else if (btntag==6){
        style=@"6";
        [btn setBackgroundImage:[UIImage imageNamed:@"yellowcolor"] forState:UIControlStateNormal];
    }else if (btntag==7){
        style=@"7";
        [btn setBackgroundImage:[UIImage imageNamed:@"yellowcolor"] forState:UIControlStateNormal];
    }else if (btntag==8){
        style=@"8";
        [btn setBackgroundImage:[UIImage imageNamed:@"yellowcolor"] forState:UIControlStateNormal];
    }else if (btntag==9){
        style=@"9";
        [btn setBackgroundImage:[UIImage imageNamed:@"yellowcolor"] forState:UIControlStateNormal];
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
            [serieindex appendString:@","];
            [serieindex appendString:index];
        }else{
            [serieindex appendString:index];
        }
    }
    
    list = [NSMutableArray arrayWithCapacity:10];
    [productcollect reloadData];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 耗时的操作（异步操作）
        sqlService *sql=[[sqlService alloc]init];
        list=[sql GetProductList:styleindex type2:textrueindex type3:inlayindex type4:serieindex page:1 pageSize:1500];
        
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
        [btn setBackgroundImage:[UIImage imageNamed:@"yellowcolor"] forState:UIControlStateNormal];
    }else if (btntag==1){
        texture=@"1";
        [btn setBackgroundImage:[UIImage imageNamed:@"yellowcolor"] forState:UIControlStateNormal];
    }else if (btntag==2){
        texture=@"2";
        [btn setBackgroundImage:[UIImage imageNamed:@"yellowcolor"] forState:UIControlStateNormal];
    }else if (btntag==3){
        texture=@"3";
        [btn setBackgroundImage:[UIImage imageNamed:@"yellowcolor"] forState:UIControlStateNormal];
    }else if (btntag==4){
        texture=@"4";
        [btn setBackgroundImage:[UIImage imageNamed:@"yellowcolor"] forState:UIControlStateNormal];
    }else if (btntag==5){
        texture=@"5";
        [btn setBackgroundImage:[UIImage imageNamed:@"yellowcolor"] forState:UIControlStateNormal];
    }else if (btntag==6){
        texture=@"6";
        [btn setBackgroundImage:[UIImage imageNamed:@"yellowcolor"] forState:UIControlStateNormal];
    }else if (btntag==7){
        texture=@"7";
        [btn setBackgroundImage:[UIImage imageNamed:@"yellowcolor"] forState:UIControlStateNormal];
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
            [serieindex appendString:@","];
            [serieindex appendString:index];
        }else{
            [serieindex appendString:index];
        }
    }
    
    list = [NSMutableArray arrayWithCapacity:10];
    [productcollect reloadData];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 耗时的操作（异步操作）
        sqlService *sql=[[sqlService alloc]init];
        list=[sql GetProductList:styleindex type2:textrueindex type3:inlayindex type4:serieindex page:1 pageSize:1500];
        
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
        [btn setBackgroundImage:[UIImage imageNamed:@"yellowcolor"] forState:UIControlStateNormal];
    }else if (btntag==1){
        inlay=@"0.00-0.02";
        [btn setBackgroundImage:[UIImage imageNamed:@"yellowcolor"] forState:UIControlStateNormal];
    }else if (btntag==2){
        inlay=@"0.03-0.07";
        [btn setBackgroundImage:[UIImage imageNamed:@"yellowcolor"] forState:UIControlStateNormal];
    }else if (btntag==3){
        inlay=@"0.08-0.12";
        [btn setBackgroundImage:[UIImage imageNamed:@"yellowcolor"] forState:UIControlStateNormal];
    }else if (btntag==4){
        inlay=@"0.13-0.17";
        [btn setBackgroundImage:[UIImage imageNamed:@"yellowcolor"] forState:UIControlStateNormal];
    }else if (btntag==5){
        inlay=@"0.18-0.22";
        [btn setBackgroundImage:[UIImage imageNamed:@"yellowcolor"] forState:UIControlStateNormal];
    }else if (btntag==6){
        inlay=@"0.23-0.28";
        [btn setBackgroundImage:[UIImage imageNamed:@"yellowcolor"] forState:UIControlStateNormal];
    }else if (btntag==7){
        inlay=@"0.29-0.39";
        [btn setBackgroundImage:[UIImage imageNamed:@"yellowcolor"] forState:UIControlStateNormal];
    }else if (btntag==8){
        inlay=@"0.40-0.49";
        [btn setBackgroundImage:[UIImage imageNamed:@"yellowcolor"] forState:UIControlStateNormal];
    }else if (btntag==9){
        inlay=@"0.50-0.59";
        [btn setBackgroundImage:[UIImage imageNamed:@"yellowcolor"] forState:UIControlStateNormal];
    }else if (btntag==10){
        inlay=@"0.60-0.69";
        [btn setBackgroundImage:[UIImage imageNamed:@"yellowcolor"] forState:UIControlStateNormal];
    }else if (btntag==11){
        inlay=@"0.70-0.69";
        [btn setBackgroundImage:[UIImage imageNamed:@"yellowcolor"] forState:UIControlStateNormal];
    }else if (btntag==12){
        inlay=@"0.80-0.69";
        [btn setBackgroundImage:[UIImage imageNamed:@"yellowcolor"] forState:UIControlStateNormal];
    }else if (btntag==13){
        inlay=@"0.90-0.69";
        [btn setBackgroundImage:[UIImage imageNamed:@"yellowcolor"] forState:UIControlStateNormal];
    }else if (btntag==14){
        inlay=@"1-100000";
        [btn setBackgroundImage:[UIImage imageNamed:@"yellowcolor"] forState:UIControlStateNormal];
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
            [serieindex appendString:@","];
            [serieindex appendString:index];
        }else{
            [serieindex appendString:index];
        }
    }
    
    list = [NSMutableArray arrayWithCapacity:10];
    [productcollect reloadData];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 耗时的操作（异步操作）
        sqlService *sql=[[sqlService alloc]init];
        list=[sql GetProductList:styleindex type2:textrueindex type3:inlayindex type4:serieindex page:1 pageSize:1500];
        
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
        [btn setBackgroundImage:[UIImage imageNamed:@"yellowcolor"] forState:UIControlStateNormal];
    }else if(btntag==2){
        serie=@"Pro_hotE=1";
        [btn setBackgroundImage:[UIImage imageNamed:@"yellowcolor"] forState:UIControlStateNormal];
    }else if (btntag==0){
        for (UIButton * btn4 in btnarray4) {
            [btn4 setBackgroundImage:nil forState:UIControlStateNormal];
        }
        [btnarray4 removeAllObjects];
        [seriearray removeAllObjects];
        [btn setBackgroundImage:[UIImage imageNamed:@"yellowcolor"] forState:UIControlStateNormal];
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


//商品添加到购物车
-(IBAction)addshopcart:(id)sender{
    sqlService * sql=[[sqlService alloc] init];
    //productEntity *goods=[sql GetProductDetail:productnumber];
    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    buyproduct * entity=[[buyproduct alloc]init];
    entity.producttype=Pro_type;
    entity.productid=productnumber;
    entity.pcount=numberText.text;
    entity.pcolor=colortext.text;
    entity.pdetail=fontText.text;
    entity.pvvs=nettext.text;
    entity.psize=sizeText.text;
    entity.pgoldtype=texturetext.text;
    entity.pweight=maintext.text;
    entity.customerid=myDelegate.entityl.uId;
    entity.pprice=womanprice;
    entity.pname=modellable.text;
    buyproduct *successadd=[sql addToBuyproduct:entity];
    buyproduct *successaddman=[[buyproduct alloc]init];
    if ([goods.Pro_Class isEqualToString:@"3"] && [goods.Pro_typeWenProId isEqualToString:@"0"]) {
        buyproduct * manentity=[[buyproduct alloc]init];
        manentity.producttype=goodsman.Pro_Type;
        manentity.productid=productnumber;
        manentity.pcount=numberText.text;
        manentity.pcolor=mamColorText.text;
        manentity.pdetail=manFontText.text;
        manentity.pvvs=manNetText.text;
        manentity.psize=manSizeText.text;
        manentity.pgoldtype=manTextureText.text;
        manentity.pweight=mamMainText.text;
        manentity.customerid=myDelegate.entityl.uId;
        manentity.pprice=manprice;
        manentity.pname=modellable.text;
        sql=[[sqlService alloc]init];
        successaddman=[sql addToBuyproduct:manentity];
    }
    
    if (successadd && successaddman) {
        sql=[[sqlService alloc]init];
        myDelegate.entityl.resultcount=[sql getBuyproductcount:myDelegate.entityl.uId];
        NSString *goodscount=myDelegate.entityl.resultcount;
        if (goodscount && ![goodscount isEqualToString:@""] && ![goodscount isEqualToString:@"0"]) {
            shopcartcount.hidden=NO;
            [shopcartcount setTitle:goodscount forState:UIControlStateNormal];
        }else{
            shopcartcount.hidden=YES;
        }
        
        NSString *rowString =@"成功加入购物车！";
        UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示" message:rowString delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alter show];
    } else{
        NSString *rowString =@"加入购物车失败！";
        UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示" message:rowString delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alter show];
    }
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
        NSURL *imgUrl=[NSURL URLWithString:[NSString stringWithFormat:@"http://seyuu.com%@",entity.Pro_smallpic]];
        if (hasCachedImage(imgUrl)) {
            cell.productImage.image=[UIImage imageWithContentsOfFile:pathForURL(imgUrl)];
        }else
        {
            cell.productImage.image=[UIImage imageNamed:@""];
            NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:imgUrl,@"url",cell.productImage,@"imageView",nil];
            [NSThread detachNewThreadSelector:@selector(cacheImage:) toTarget:[ImageCacher defaultCacher] withObject:dic];
            
        }
//    }

    cell.productLable.text = entity.Pro_model;
    return cell;
}

//点击事件
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    productEntity *entity = [list objectAtIndex:[indexPath row]];
    primaryShadeView.alpha=0.5;
    secondaryView.frame = CGRectMake(140, 95, secondaryView.frame.size.width, secondaryView.frame.size.height);
    secondaryView.hidden = NO;
    sqlService * sql=[[sqlService alloc] init];
    productnumber=entity.Id;
    goods=[sql GetProductDetail:productnumber];
    Pro_type=goods.Pro_Type;
    //productimageview.image=[UIImage imageNamed:@"diamonds.png"];
    
    [self hidemenlproduct];
    
    title1lable.text=goods.Pro_name;
    modellable.text=goods.Pro_model;
    //weightlable.text=goods.Pro_goldWeight;//约重
    mainlable.text=[NSString stringWithFormat:@"%@ 颗",goods.Pro_Z_count];//goods.Pro_Z_count;
    fitNolable.text=[NSString stringWithFormat:@"%@ 颗",goods.Pro_f_count];//goods.Pro_f_count;
    fitweightlable.text=[NSString stringWithFormat:@"%@ ct",goods.Pro_f_weight];
    //maintext.text=@"111";
    nettext.text=@"SI";
    colortext.text=@"I-J";
    Commons * common=[[Commons alloc]init];
    texturetext.text=[common getGoldtypename:goods.Pro_goldType];
    
    sizetext.text=goods.Pro_goldsize;
    fonttext.text=nil;
    numbertext.text=@"1";
    inlayarry=[[NSMutableArray alloc] init];
    inlayarryman=[[NSMutableArray alloc] init];
    sql=[[sqlService alloc] init];
    inlayarry=[sql getwithmouths:goods.Id];
    NSMutableArray *mainarry=[[NSMutableArray alloc] init];
    NSString * AuWeight=nil;
    for (withmouth *inlay in inlayarry) {
        [mainarry addObject:inlay.zWeight];
        if(AuWeight==nil){
            AuWeight=inlay.AuWeight;
            weightlable.text=[NSString stringWithFormat:@"%@ g",inlay.AuWeight];//约重
        }
    }

    NSMutableArray *mainarryman=[[NSMutableArray alloc] init];
    
    NSString * AuWeightman=nil;
    //如果是对戒，查找男戒数据
    if ([goods.Pro_Class isEqualToString:@"3"] && [goods.Pro_typeWenProId isEqualToString:@"0"]) {
        [self showmenlproduct];
        sqlService * sql=[[sqlService alloc] init];
        goodsman=[sql GetProductBoyDetail:goods.Id];
        sql=[[sqlService alloc] init];
        inlayarryman=[sql getwithmouths:goodsman.Id];
        for (withmouth *inlayman in inlayarryman) {
            [mainarryman addObject:inlayman.zWeight];
            if(AuWeightman==nil){
                AuWeightman=inlayman.AuWeight;
                _manMainLabel.text=[NSString stringWithFormat:@"男戒:%@ g",inlayman.AuWeight];
            }
        }
        
        weightlable.text=[NSString stringWithFormat:@"女戒:%@ g",AuWeight];
        mainlable.text=[NSString stringWithFormat:@"女戒:%@ 颗",goods.Pro_Z_count];
        fitNolable.text=[NSString stringWithFormat:@"女戒:%@ 颗",goods.Pro_f_count];
        float wwight=goods.Pro_f_weight.doubleValue*goods.Pro_f_count.doubleValue;
        fitweightlable.text=[NSString stringWithFormat:@"女戒:%@ ct",[self notRounding:wwight afterPoint:2]];
        
        _manjdLabel.text=[NSString stringWithFormat:@"男戒:%@ 颗",goodsman.Pro_Z_count];
        _manColorLabel.text=[NSString stringWithFormat:@"男戒:%@ 颗",goodsman.Pro_f_count];
        _mancjLabel.text=[NSString stringWithFormat:@"男戒:%@ ct",goodsman.Pro_f_weight];
        manNetText.text=@"SI";
        mamColorText.text=@"I-J";
        Commons * common=[[Commons alloc]init];
        manTextureText.text=[common getGoldtypename:goodsman.Pro_goldType];
        
        manSizeText.text=goodsman.Pro_goldsize;
        manFontText.text=nil;
    }
    
    self.mainlist=mainarry;
    self.mainmanlist=mainarryman;
    
    if(self.mainlist.count>0)
        maintext.text=[self.mainlist objectAtIndex:0];
    if (self.mainmanlist>0 && [goods.Pro_Class isEqualToString:@"3"] && [goods.Pro_typeWenProId isEqualToString:@"0"]) {
        mamMainText.text=[self.mainmanlist objectAtIndex:0];
    }
    
    NSURL *imgUrl=[NSURL URLWithString:[NSString stringWithFormat:@"http://seyuu.com%@",goods.Pro_smallpic]];
    NSArray  * array= [goods.Pro_bigpic componentsSeparatedByString:@","];
    //遍历这个数组
    if ([array count]>0) {
        imgUrl=[NSURL URLWithString:[NSString stringWithFormat:@"http://seyuu.com%@",[array objectAtIndex: 0]]];
    }

    if (hasCachedImage(imgUrl)) {
        [self.productimageview setImage:[UIImage imageWithContentsOfFile:pathForURL(imgUrl)]];
    }else
    {
        [self.productimageview setImage:[UIImage imageNamed:@""]];//diamonds
        NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:imgUrl,@"url",self.productimageview,@"imageView",nil];
        [NSThread detachNewThreadSelector:@selector(cacheImage:) toTarget:[ImageCacher defaultCacher] withObject:dic];
    }
    
    //获取商品价格
    @try {
        //可以在此加代码提示用户说正在加载数据中
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            // 耗时的操作（异步操作）
            pricelable.text=@"获取价格中。。。";
            NSString *proprice=nil;
            productApi *priceApi=[[productApi alloc]init];
            womanprice=[priceApi getPrice:goods.Pro_Class goldType:goods.Pro_goldType goldWeight:AuWeight mDiaWeight:maintext.text mDiaColor:@"I-J" mVVS:@"SI" sDiaWeight:goods.Pro_f_weight sCount:goods.Pro_f_count proid:goods.Id];
            if ([goods.Pro_Class isEqualToString:@"3"] && [goods.Pro_typeWenProId isEqualToString:@"0"]) {
                
                manprice=[priceApi getPrice:goodsman.Pro_Class goldType:goodsman.Pro_goldType goldWeight:AuWeightman mDiaWeight:mamMainText.text mDiaColor:@"I-J" mVVS:@"SI" sDiaWeight:goodsman.Pro_f_weight sCount:goodsman.Pro_f_count proid:goodsman.Id];
                
                
                proprice=[NSString stringWithFormat:@"%d",womanprice.intValue+manprice.intValue];
            }else{
                proprice=womanprice;
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                if (proprice) {
                    //pricelable.text=[@"¥" stringByAppendingString:proprice];
                    NSArray *price=[[NSString stringWithFormat:@"%@",proprice] componentsSeparatedByString:@"."];
                    pricelable.text=[NSString stringWithFormat:@"¥ %@",[price objectAtIndex:0]];
                    //pricelable.text=[NSString stringWithFormat:@"¥%@",proprice];
                }else{
                    pricelable.text=@"暂无价格信息";
                }
                
            });
        });
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
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

-(BOOL)isexistsfile
{
    BOOL isshow=FALSE;
    for(int i=1;i<60;i++){
        NSString *strApend;
        if(i<9)
            strApend=@"00";
        else
            strApend=@"0";
        
        NSString *path = [NSString stringWithFormat:@"%@_%@%d.jpg", goods.Pro_author, strApend,i];
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


//隐藏对戒男戒
-(void)hidemenlproduct{
    
    [mamMainText setHidden:TRUE];
    [manNetText setHidden:TRUE];
    [mamColorText setHidden:TRUE];
    [manTextureText setHidden:TRUE];
    [manSizeText setHidden:TRUE];
    [manFontText setHidden:TRUE];
    
    [_manMainbutton setHidden:TRUE];
    [_manjdbutton setHidden:TRUE];
    [_manColorbutton setHidden:TRUE];
    [_mancjbutton setHidden:TRUE];
    
    [_manMainLabel setHidden:TRUE];
    [_manjdLabel setHidden:TRUE];
    [_manColorLabel setHidden:TRUE];
    [_mancjLabel setHidden:TRUE];
    [button3dman setHidden:TRUE];
    [button3dwoman setHidden:TRUE];
    
    if ([self isexistsfile]) {
        [button3D setHidden:NO];
    }else{
        [button3D setHidden:TRUE];
    }

}
//显示对戒男戒
-(void)showmenlproduct{
    
    [mamMainText setHidden:NO];
    [manNetText setHidden:NO];
    [mamColorText setHidden:NO];
    [manTextureText setHidden:NO];
    [manSizeText setHidden:NO];
    [manFontText setHidden:NO];
    
    [_manMainbutton setHidden:NO];
    [_manjdbutton setHidden:NO];
    [_manColorbutton setHidden:NO];
    [_mancjbutton setHidden:NO];
    
    [_manMainLabel setHidden:NO];
    [_manjdLabel setHidden:NO];
    [_manColorLabel setHidden:NO];
    [_mancjLabel setHidden:NO];
    
    if ([self isexistsfile]) {
        [button3dman setHidden:NO];
        [button3dwoman setHidden:NO];
    }else{
        [button3dman setHidden:TRUE];
        [button3dwoman setHidden:TRUE];
    }
    [button3D setHidden:TRUE];

}

-(void)showmenlproduct:(NSString *)girlid{
    
    sqlService * sql=[[sqlService alloc] init];
    productEntity *goods=[sql GetProductBoyDetail:girlid];

    mamMainText.text=goods.Pro_name;
    manNetText.text=goods.Pro_model;
    manTextureText.text=goods.Pro_goldWeight;
    
    Commons * common=[[Commons alloc]init];
    mamColorText.text=[common getGoldtypename:goods.Pro_goldType];
    
    manSizeText.text=goods.Pro_goldsize;
    
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
    
}
//女的约重
-(NSString *)getweightg:(NSString *)weig{
    
    for (withmouth *inlay in inlayarry) {
        if ([inlay.zWeight isEqualToString:maintext.text]) {
            if ([goods.Pro_Class isEqualToString:@"3"] && [goods.Pro_typeWenProId isEqualToString:@"0"]) {
                weightlable.text=[NSString stringWithFormat:@"女戒:%@ g",inlay.AuWeight];
            }else{
                weightlable.text=[NSString stringWithFormat:@"%@ g",inlay.AuWeight];
            }
            return inlay.AuWeight;
        }
    }
    
    return @"";
    
}
//男的约重
-(NSString *)getweightman:(NSString *)weig{
    
    for (withmouth *inlayman in inlayarryman) {
        if ([inlayman.zWeight isEqualToString:mamMainText.text]) {
            _manMainLabel.text=[NSString stringWithFormat:@"男戒:%@ g",inlayman.AuWeight];
            return inlayman.AuWeight;
        }
    }
    
    return @"";
}

//核对密码
-(IBAction)chenckpassword:(id)sender
{
    fivethview.hidden=NO;
}

//关闭核对
-(IBAction)closecheck:(id)sender
{
    checkpassword.text=@"";
    fivethview.hidden=YES;
}

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
//展示图片集
-(void)showPhotoBrowser
{
    NSMutableArray *photos = [[NSMutableArray alloc] init];
    //NSMutableArray *thumbs = [[NSMutableArray alloc] init];
    //MWPhoto *photot;
    
    NSArray  * array= [goods.Pro_bigpic componentsSeparatedByString:@","];
    int count = [array count];
    //遍历这个数组
    for (int i = 0; i < count; i++) {
        //NSLog(@"普通的遍历：i = %d 时的数组对象为: %@",i,[array objectAtIndex: i]);
        NSString * patht=[NSString stringWithFormat:@"http://seyuu.com%@",[array objectAtIndex: i]];
        NSURL *imgUrl=[NSURL URLWithString:patht];
        if (hasCachedImage(imgUrl)) {
            [photos addObject:[MWPhoto photoWithImage:[UIImage imageWithContentsOfFile:pathForURL(imgUrl)]]];
        }else
        {
            [photos addObject:[MWPhoto photoWithURL:[NSURL URLWithString:patht]]];
        }
        
        //[thumbs addObject:[MWPhoto photoWithURL:[NSURL URLWithString:patht]]];
    }

    self.photos = photos;
    //self.thumbs = thumbs;
    
//    _selections = [NSMutableArray new];
//    for (int i = 0; i < photos.count; i++) {
//        [_selections addObject:[NSNumber numberWithBool:NO]];
//    }
    
    // Create browser
	MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
    browser.displayActionButton = NO;
    browser.displayNavArrows = YES;
    browser.displaySelectionButtons = NO;
    browser.alwaysShowControls = NO;
    browser.zoomPhotosToFill = YES;
#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_7_0
    browser.wantsFullScreenLayout = YES;
#endif
    browser.enableGrid = NO;
    browser.startOnGrid = NO;
    browser.enableSwipeToDismiss = YES;
    [browser setCurrentPhotoIndex:0];
    
    // Push
    [self.navigationController pushViewController:browser animated:NO];

}

#pragma mark - MWPhotoBrowserDelegate

- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser {
    return _photos.count;
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
    if (index < _photos.count)
        return [_photos objectAtIndex:index];
    return nil;
}

//- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser thumbPhotoAtIndex:(NSUInteger)index {
//    if (index < _thumbs.count)
//        return [_thumbs objectAtIndex:index];
//    return nil;
//}

- (void)photoBrowser:(MWPhotoBrowser *)photoBrowser didDisplayPhotoAtIndex:(NSUInteger)index {
    //NSLog(@"Did start viewing photo at index %lu", (unsigned long)index);
}

- (void)photoBrowserDidFinishModalPresentation:(MWPhotoBrowser *)photoBrowser {
    // If we subscribe to this method we must dismiss the view controller ourselves
    //NSLog(@"Did finish modal presentation");
    [self dismissViewControllerAnimated:YES completion:nil];
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
