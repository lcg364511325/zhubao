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
@synthesize shopcartcount;
@synthesize logoImage;
@synthesize checkpassword;
@synthesize texturebutton;

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
    texturetext.text=@"18K白";
//    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
//    NSString *logopathsm = [[Tool getTargetFloderPath] stringByAppendingPathComponent:[NSString stringWithFormat:@"logopathsm.png"]];
//    if ([[NSFileManager defaultManager] fileExistsAtPath:logopathsm]) {
//        [logoImage setImage:[[UIImage alloc] initWithContentsOfFile:logopathsm]];
//    }
//    else {
//        [logoImage setImage:[UIImage imageNamed:@"logo"]];
//    }
//    
//    NSString *goodscount=myDelegate.entityl.resultcount;
//    if (goodscount && ![goodscount isEqualToString:@""] && ![goodscount isEqualToString:@"0"]) {
//        shopcartcount.hidden=NO;
//        [shopcartcount setTitle:goodscount forState:UIControlStateNormal];
//    }else{
//        shopcartcount.hidden=YES;
//    }
    
    goldweightText.keyboardType=UIKeyboardTypeNumberPad;
    miandiaText.keyboardType=UIKeyboardTypeNumberPad;
    mianNoText.keyboardType=UIKeyboardTypeNumberPad;
    fitDiaText.keyboardType=UIKeyboardTypeNumberPad;
    fitNoText.keyboardType=UIKeyboardTypeNumberPad;
    sizeText.keyboardType=UIKeyboardTypeNumberPad;

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

//购物车显示
- (IBAction)goAction:(id)sender
{
    shopcart *samplePopupViewController = [[shopcart alloc] initWithNibName:@"shopcart" bundle:nil];
    samplePopupViewController.mydelegate=self;
    
    [self presentPopupViewController:samplePopupViewController animated:YES completion:^(void) {
        NSLog(@"popup view presented");
    }];
}

-(void)closesc{
    if (self.popupViewController != nil) {
        [self dismissPopupViewControllerAnimated:YES completion:^{
            NSLog(@"popup view dismissed");
        }];
    }
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

//设置页面跳转
-(IBAction)setup:(id)sender
{
    if ([[[UIDevice currentDevice]systemVersion]floatValue] >= 7.0)
    {
        _settingupdate.frame = CGRectMake(10, 55, _settingupdate.frame.size.width, _settingupdate.frame.size.height);
        _settinglogout.frame = CGRectMake(10, 90, _settinglogout.frame.size.width, _settinglogout.frame.size.height);
        _settingsoftware.frame = CGRectMake(10, 20, _settingsoftware.frame.size.width, _settingsoftware.frame.size.height);
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
                //[getdata getAllZIPPhotos];
                [getdata getAllProductPhotos];
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
    value=[_mainlist count];
    return value;
    //只有一组，数组数即为行数。
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
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
    textureselect.frame=CGRectMake(texturetext.frame.origin.x, texturetext.frame.origin.y+30, texturetext.frame.size.width+texturebutton.frame.size.width, 200);
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
    NSString * pgoldtypett=[NSString stringWithFormat:@"%@",texturetext.text];
    if (!pgoldtypett || [pgoldtypett isEqualToString:@""]) {
        NSString *rowString =@"请选择材质！";
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
//    if ([texturetext.text isEqualToString:@"18K黄"]) {
//        entity.pgoldtype=@"1";
//    }else if([texturetext.text isEqualToString:@"18K白"]){
//        entity.pgoldtype=@"2";
//    }else if([texturetext.text isEqualToString:@"18K双色"]){
//        entity.pgoldtype=@"3";
//    }else if([texturetext.text isEqualToString:@"18K玫瑰金"]){
//        entity.pgoldtype=@"4";
//    }else if([texturetext.text isEqualToString:@"PT900"]){
//        entity.pgoldtype=@"5";
//    }else if([texturetext.text isEqualToString:@"PT950"]){
//        entity.pgoldtype=@"6";
//    }else if([texturetext.text isEqualToString:@"PD950"]){
//        entity.pgoldtype=@"7";
//    }
    entity.pgoldtype=pgoldtypett;

    entity.pweight=goldweightText.text;
    entity.Dia_Z_weight=miandiaText.text;
    entity.Dia_Z_count=mianNoText.text;
    entity.Dia_F_weight=fitDiaText.text;
    entity.Dia_F_count=fitNoText.text;
    entity.psize=sizeText.text;
    entity.pdetail=fontText.text;
    entity.pcount=@"1";
    buyproduct *successadd=[sql addToBuyproduct:entity];
    if (successadd) {
//        sql=[[sqlService alloc]init];
//        myDelegate.entityl.resultcount=[sql getBuyproductcount:myDelegate.entityl.uId];
//        NSString *goodscount=myDelegate.entityl.resultcount;
//        if (goodscount && ![goodscount isEqualToString:@""] && ![goodscount isEqualToString:@"0"]) {
//            shopcartcount.hidden=NO;
//            [shopcartcount setTitle:goodscount forState:UIControlStateNormal];
//        }else{
//            shopcartcount.hidden=YES;
//        }
        
        [self.parentViewController.self performSelector:@selector(refleshBuycutData)];
        
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


@end
