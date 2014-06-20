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
        NSString *rowString =@"删除成功！";
        UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示" message:rowString delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alter show];
        
        AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
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
    NSString *orderinfo=[sql saveOrder:myDelegate.entityl.uId];
    if (![orderinfo isEqualToString:@""]) {
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
                myDelegate.thridView=thirdaryView;
                
                
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
//                case 1:
//                    // 相机
//                    sourceType = UIImagePickerControllerSourceTypeCamera;
//                    break;
//                    
                case 2:
                    // 相册
                    sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
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
        
        [self presentViewController:imagePickerController animated:YES completion:^{}];
        
    }
}

@end
