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
UISwipeGestureRecognizer *recognizer;

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
    //web标签背景色透明
    aboutus.backgroundColor = [UIColor clearColor];
    aboutus.opaque = NO;
    //[aboutus setUserInteractionEnabled: YES ];	 //是否支持交互
    [aboutus setDelegate:self];				 //委托document.body.style.webkitTouchCallout='none'
    [aboutus stringByEvaluatingJavaScriptFromString:@"document.body.style.webkitUserSelect='none';"];
    // Disable callout
    [aboutus stringByEvaluatingJavaScriptFromString:@"document.body.style.webkitTouchCallout='none';"];
    
    //更新ui(如果已经存在的，则不再自动更新)
    [self loadmyInfo];
    
    
    //设置了左右滑动
//    UISwipeGestureRecognizer *recognizer;
//    
//    recognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom:)];
//    [recognizer setDirection:(UISwipeGestureRecognizerDirectionRight)];
//    aboutus.delegate = self;
//    [[self view] addGestureRecognizer:recognizer];
//    [aboutus addGestureRecognizer:recognizer];
    
     recognizer= [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom:)];
    recognizer.delegate=self;
    [recognizer setDirection:(UISwipeGestureRecognizerDirectionRight)];
    recognizer.cancelsTouchesInView=NO;
    [[self view] addGestureRecognizer:recognizer];
    
//    recognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom:)];
//    [recognizer setDirection:(UISwipeGestureRecognizerDirectionLeft)];
//    [[self view] addGestureRecognizer:recognizer];
    
//    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeLeftAction)];
//    swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
//    swipeLeft.delegate = self;
//    [webView addGestureRecognizer:swipeLeft];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    return YES;
}
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    return YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    // Disable user selection
    [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitUserSelect='none';"];
    // Disable callout
    [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitTouchCallout='none';"];
}

-(void)handleSwipeFrom:(UISwipeGestureRecognizer *)recognizer{
    
    if(recognizer.direction==UISwipeGestureRecognizerDirectionLeft) {
        
        NSLog(@"swipe left");
        //执行程序
        
    }
    
    if(recognizer.direction==UISwipeGestureRecognizerDirectionRight) {
        
        NSLog(@"swipe right");
        //执行程序
        [fourthView setHidden:YES];
        [biglogo setHidden:NO];
    }
    
}

//更新ui
-(void)loadmyInfo
{
    @try {
        
        NSString *logopathsm = [[Tool getTargetFloderPath] stringByAppendingPathComponent:[NSString stringWithFormat:@"logopathsm.png"]];
        NSString *logopath = [[Tool getTargetFloderPath] stringByAppendingPathComponent:[NSString stringWithFormat:@"logopath.png"]];
        
        if ([[NSFileManager defaultManager] fileExistsAtPath:logopathsm]) {
            [logoImage setImage:[[UIImage alloc] initWithContentsOfFile:logopathsm]];
        }
        else {
            [logoImage setImage:[UIImage imageNamed:@"logo"]];
        }

        if ([[NSFileManager defaultManager] fileExistsAtPath:logopath]) {
            [biglogo setImage:[[UIImage alloc] initWithContentsOfFile:logopath] forState:UIControlStateNormal];
        }
        else {
            [biglogo setImage:[UIImage imageNamed:@"logoshengyu"] forState:UIControlStateNormal];
        }
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            // 耗时的操作（异步操作）
            bool isexists=true;
            if (![[NSFileManager defaultManager] fileExistsAtPath:logopathsm]){
                myApi *myapi=[[myApi alloc]init];
                [myapi getMyInfo];
                isexists=false;
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                // 更新界面（处理结果）

                if (!isexists){
                    
                    sleep(1);//等1秒再执行
                    
                    if ([[NSFileManager defaultManager] fileExistsAtPath:logopathsm]) {
                        [logoImage setImage:[[UIImage alloc] initWithContentsOfFile:logopathsm]];
                    }
                    else {
                        [logoImage setImage:[UIImage imageNamed:@"logo"]];
                    }
                
                
                    if ([[NSFileManager defaultManager] fileExistsAtPath:logopath]) {
                        [biglogo setImage:[[UIImage alloc] initWithContentsOfFile:logopath] forState:UIControlStateNormal];
                    }
                    else {
                        [biglogo setImage:[UIImage imageNamed:@"logoshengyu"] forState:UIControlStateNormal];
                    }
                }
            });
        });
        
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
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

//购物车显示
- (IBAction)goAction:(id)sender
{
//    primaryShadeView.alpha=0.5;
//    //secondaryView.frame = CGRectMake(140, 95, secondaryView.frame.size.width, secondaryView.frame.size.width);
//    secondaryView.hidden = NO;
//    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
//    sqlService *shopcar=[[sqlService alloc] init];
//    shoppingcartlist=[shopcar GetBuyproductList:myDelegate.entityl.uId];
//    [goodsview reloadData];
    
    
    
    test *samplePopupViewController = [[test alloc] initWithNibName:@"test" bundle:nil];
    samplePopupViewController.mydelegate=self;
    
    [self presentPopupViewController:samplePopupViewController animated:YES completion:^(void) {
        NSLog(@"popup view presented");
    }];
}

- (IBAction)closeAction:(id)sender
{
    secondaryView.hidden = YES;
    primaryShadeView.alpha=0;
}

-(void)closeAc{
    if (self.popupViewController != nil) {
        [self dismissPopupViewControllerAnimated:YES completion:^{
            NSLog(@"popup view dismissed");
        }];
    }
}

-(IBAction)setup:(id)sender
{
    if ([[[UIDevice currentDevice]systemVersion]floatValue] >= 7.0)
    {
        _settingupdate.frame = CGRectMake(10, 55, _settingupdate.frame.size.width, _settingupdate.frame.size.height);
        _settinglogout.frame = CGRectMake(10, 90, _settinglogout.frame.size.width, _settinglogout.frame.size.height);
         _settingsoftware.frame = CGRectMake(10, 20, _settingsoftware.frame.size.width, _settingsoftware.frame.size.height);
    }
    
    thridView.hidden=NO;
    thridView.frame=CGRectMake(750, 70, thridView.frame.size.width, thridView.frame.size.height);
}
//关于我们
-(IBAction)openaboutus:(id)sender
{
    NSString *filePath = [[Tool getTargetFloderPath] stringByAppendingPathComponent:[NSString stringWithFormat:@"about.webarchive"]];
    NSURL *aURL = [NSURL fileURLWithPath:filePath];
    NSURLRequest *request = [NSURLRequest requestWithURL:aURL];
    //AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    fourthView.hidden=NO;
    //NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:myDelegate.myinfol.details]];
    [aboutus loadRequest:request];
    aboutus.scrollView.delegate=self;
    [aboutus.scrollView setShowsHorizontalScrollIndicator:NO];
    
    [fourthView setHidden:NO];
    [biglogo setHidden:YES];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.x > 0)
        scrollView.contentOffset=CGPointMake(0, scrollView.contentOffset.y);
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
            
            [self refleshBuycutData];
            
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
                //[alter dismissWithClickedButtonIndex:0 animated:YES];
                
                [myDelegate stopTimer];

                //同步完数据了，则再去下载图片组
                //[getdata getAllZIPPhotos];
                [getdata getAllProductPhotos];
                
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

-(void)refleshBuycutData
{
    sqlService * sql=[[sqlService alloc]init];
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
    
}

@end
