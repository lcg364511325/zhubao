//
//  ustomtailor.m
//  zhubao
//
//  Created by johnson on 14-5-28.
//  Copyright (c) 2014年 SUNYEARS___FULLUSERNAME. All rights reserved.
//

#import "ustomtailor.h"

@interface ustomtailor ()
{
    BOOL isFullScreen;
}
@end

@implementation ustomtailor

@synthesize primaryView;
@synthesize secondaryView;
@synthesize primaryShadeView;
@synthesize thirdaryView;
@synthesize fourthview;
@synthesize textureselect;
@synthesize mainlist=_mainlist;
@synthesize texturetext;
@synthesize goldweightText;
@synthesize miandiaText;
@synthesize mianNoText;
@synthesize fitDiaText;
@synthesize fitNoText;
@synthesize sizeText;
@synthesize fontText;
@synthesize goodsview;
@synthesize shopcartcount;
@synthesize logoImage;
@synthesize checkpassword;

//区分图片位置
NSInteger pictag=0;
//保存图片路径
NSString *pic1=nil;
NSString *pic2=nil;
NSString *pic3=nil;
//区分view
NSInteger vies=0;

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
    NSArray *mainarray = [[NSArray alloc] initWithObjects:@"18K黄", @"18K白",
                          @"18K双色", @"18K玫瑰金", @"PT900", @"Pt950", @"PD950",nil];
    self.mainlist = mainarray;
    texturetext.userInteractionEnabled=NO;
    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    NSString *logopathsm = [[Tool getTargetFloderPath] stringByAppendingPathComponent:[NSString stringWithFormat:@"logopathsm.png"]];
    if ([[NSFileManager defaultManager] fileExistsAtPath:logopathsm]) {
        [logoImage setImage:[[UIImage alloc] initWithContentsOfFile:logopathsm]];
    }
    else {
        [logoImage setImage:[UIImage imageNamed:@"logo"]];
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
    diploma * _diploma = [[diploma alloc] init];
    
    [self.navigationController pushViewController:_diploma animated:NO];
}

-(IBAction)doReg4:(id)sender
{
    member * _member = [[member alloc] init];
    
    [self.navigationController pushViewController:_member animated:NO];
}

//购物车
- (IBAction)goAction:(id)sender
{
    vies=1;
    primaryShadeView.alpha=0.5;
    secondaryView.frame = CGRectMake(140, 85, secondaryView.frame.size.width, secondaryView.frame.size.height);
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
//    fourthview.hidden=NO;
//}
//
////关闭核对
//-(IBAction)closecheck:(id)sender
//{
//    checkpassword.text=@"";
//    fourthview.hidden=YES;
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

- (IBAction)closeAction:(id)sender
{
    primaryShadeView.alpha=0;
    secondaryView.hidden = YES;
}

//设置页面跳转
-(IBAction)setup:(id)sender
{
    if ([[[UIDevice currentDevice]systemVersion]floatValue] >= 7.0)
    {
        _settingupdate.frame = CGRectMake(10, 55, _settingupdate.frame.size.width, _settingupdate.frame.size.height);
        _settinglogout.frame = CGRectMake(10, 90, _settinglogout.frame.size.width, _settinglogout.frame.size.height);
    }
    thirdaryView.hidden=NO;
    thirdaryView.frame=CGRectMake(750, 70, thirdaryView.frame.size.width, thirdaryView.frame.size.height);
}

//软件更新
-(IBAction)updatesofeware:(id)sender
{
    thirdaryView.hidden=YES;
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
        thirdaryView.hidden=YES;
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger value=0;
    if (vies==1) {
        value=[shoppingcartlist count];
    }else{
        value=[_mainlist count];
    }
    return value;
    //只有一组，数组数即为行数。
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (vies==1) {
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
        cell.textLabel.text = [self.mainlist objectAtIndex:row];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *rowString = [self.mainlist objectAtIndex:[indexPath row]];
    texturetext.text=rowString;
    textureselect.hidden=YES;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint pt = [touch locationInView:self.view];
    //点击其他地方消失
    if (!CGRectContainsPoint([textureselect frame], pt)) {
        //to-do
        textureselect.hidden=YES;
    }
    if (!CGRectContainsPoint([thirdaryView frame], pt)) {
        //to-do
        thirdaryView.hidden=YES;
    }
    
}

// 材质下拉框
- (IBAction)mianselect:(id)sender
{
    vies=0;
    textureselect.hidden=NO;
}

//确认定制
-(IBAction)orderOfGoods:(id)sender
{
    if (!pic1 && !pic2 && !pic3) {
        NSString *rowString =@"至少要选择一张图片！";
        UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示" message:rowString delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alter show];
        return;
    }
    
    sqlService * sql=[[sqlService alloc] init];
    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    buyproduct * entity=[[buyproduct alloc]init];
    entity.producttype=@"9";
    entity.customerid=myDelegate.entityl.uId;
    entity.photos=pic1;
    entity.photom=pic2;
    entity.photob=pic3;
    if ([texturetext.text isEqualToString:@"18K黄"]) {
        entity.pgoldtype=@"1";
    }else if([texturetext.text isEqualToString:@"18K白"]){
        entity.pgoldtype=@"2";
    }else if([texturetext.text isEqualToString:@"18K双色"]){
        entity.pgoldtype=@"3";
    }else if([texturetext.text isEqualToString:@"18K玫瑰金"]){
        entity.pgoldtype=@"4";
    }else if([texturetext.text isEqualToString:@"PT900"]){
        entity.pgoldtype=@"5";
    }else if([texturetext.text isEqualToString:@"PT950"]){
        entity.pgoldtype=@"6";
    }else if([texturetext.text isEqualToString:@"PD950"]){
        entity.pgoldtype=@"7";
    }
    entity.pweight=goldweightText.text;
    entity.Dia_Z_weight=miandiaText.text;
    entity.Dia_Z_count=mianNoText.text;
    entity.Dia_F_weight=fitDiaText.text;
    entity.Dia_F_count=fitNoText.text;
    entity.psize=sizeText.text;
    entity.pdetail=fontText.text;
    buyproduct *successadd=[sql addToBuyproduct:entity];
    if (successadd) {
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

//重置数据
-(IBAction)resetdata:(id)sender
{
    texturetext.text=nil;
    goldweightText.text=nil;
    miandiaText.text=nil;
    mianNoText.text=nil;
    fitDiaText.text=nil;
    fitNoText.text=nil;
    sizeText.text=nil;
    fontText.text=nil;
}
/////////////////////////////////////////以为图片上传位置/////////////////////////////////////////////////
//选择图片
- (IBAction)chooseImage:(id)sender {
    
    UIActionSheet *sheet;
    
    sheet = [[UIActionSheet alloc] initWithTitle:@"选择" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"取消" otherButtonTitles:@"从相册选择", nil];
    
    sheet.tag = 255;
    [sheet showInView:self.view];
    UIButton * btn=(UIButton *)sender;
    pictag=[btn tag];
}

#pragma mark - 保存图片至沙盒
- (void) saveImage:(UIImage *)currentImage withName:(NSString *)imageName
{
    
    NSData *imageData = UIImageJPEGRepresentation(currentImage, 0.5);
    // 获取沙盒目录
    
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:imageName];
    
    // 将图片写入文件
    
    [imageData writeToFile:fullPath atomically:NO];
}

#pragma mark - image picker delegte
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
	[picker dismissViewControllerAnimated:YES completion:^{}];
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    NSString *fullPath =nil;
    //记录文件
    
    if (pictag==0) {
        [self saveImage:image withName:@"currentImage1.png"];
        
        fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"currentImage1.png"];
        pic1=fullPath;
    }
    else if (pictag==1)
    {
        [self saveImage:image withName:@"currentImage2.png"];
        
        fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"currentImage2.png"];
        pic2=fullPath;
    }
    else if (pictag==2){
        [self saveImage:image withName:@"currentImage3.png"];
        
        fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"currentImage3.png"];
        pic3=fullPath;
    }
    
    UIImage *savedImage = [[UIImage alloc] initWithContentsOfFile:fullPath];
    
    isFullScreen = NO;
    if (pictag==0) {
        [self.zhengmianview setImage:savedImage];
        
        self.zhengmianview.tag = 100;
    }else if (pictag==1)
    {
        [self.fanmianview setImage:savedImage];
        
        self.fanmianview.tag = 100;
    }else if (pictag==2){
        [self.cemianview setImage:savedImage];
        
        self.cemianview.tag = 100;
    }
    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
	[self dismissViewControllerAnimated:YES completion:^{}];
}


#pragma mark - actionsheet delegate
-(void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag == 255) {
        
        NSUInteger sourceType = 0;
        
        // 判断是否支持相机
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            
            switch (buttonIndex) {
                case 0:
                    // 取消
                    return;
                case 1:
                    // 相册
                    sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                    break;
                    
                case 2:
                    // 相机
                    sourceType = UIImagePickerControllerSourceTypeCamera;
                    break;
            }
        }
        else {
            if (buttonIndex == 0) {
                
                return;
            } else {
                sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            }
        }
        // 跳转到相机或相册页面
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        
        imagePickerController.delegate = self;
        
        imagePickerController.allowsEditing = YES;
        
        imagePickerController.sourceType = sourceType;
        

        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
            
            UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:imagePickerController];
            popoverController = popover;
            [popoverController presentPopoverFromRect:CGRectMake(0, 0, 300, 300) inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
            
        } else {
            [self presentViewController:imagePickerController animated:YES completion:^{}];
        }

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
