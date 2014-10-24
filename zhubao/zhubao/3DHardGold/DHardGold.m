//
//  3DHardGold.m
//  zhubao
//
//  Created by johnson on 14-10-21.
//  Copyright (c) 2014年 SUNYEARS___FULLUSERNAME. All rights reserved.
//

#import "DHardGold.h"
#import "sqlService.h"
#import "productApi.h"

@interface DHardGold ()

@end

@implementation DHardGold

@synthesize productpic;//产品图片
@synthesize addtoshopcart;//加入购物车按钮
@synthesize show3D;//3D展示按钮（非对戒）
@synthesize watchmorepic;//查看更多图片
@synthesize modellable;//型号
@synthesize weighlable;//约重
@synthesize titlelable;//产品标题
@synthesize pricelable;//产品价格
@synthesize childview;//3D视图
@synthesize closebutton;//关闭按钮

@synthesize mainlist=_mainlist;
@synthesize dmainlist=_dmainlist;
@synthesize netlist=_netlist;
@synthesize colorlist=_colorlist;
@synthesize texturelist=_texturelist;



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
    [self showproductDetai];//加载产品数据
    [self tableviewvalue];//tableview数据
    
    selecttype=0;
    
    //定义图片标签的点击事件
    productpic.userInteractionEnabled=YES;
    UITapGestureRecognizer *singleTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showPhotoBrowser)];
    [productpic addGestureRecognizer:singleTap];
    
    [watchmorepic addTarget:self action:@selector(showPhotoBrowser) forControlEvents:UIControlEventTouchUpInside];
}

-(void)closesc{
    if (self.popupViewController != nil) {
        [self dismissPopupViewControllerAnimated:YES completion:^{
            NSLog(@"popup view dismissed");
        }];
    }
}

-(IBAction)closeDetail:(id)sender
{
    [_mydelegate performSelector:@selector(closeAction)];
}
// tableview数据
-(void)tableviewvalue
{
    //净度
    NSArray *netarray = [[NSArray alloc]initWithObjects:@"VVS",@"VS",@"SI",@"P", nil];
    //颜色
    NSArray *colorarray = [[NSArray alloc]initWithObjects:@"F-G",@"H",@"I-J",@"K-L",@"M-N", nil];
    //材质
    NSArray *texture1array = [[NSArray alloc]initWithObjects:@"18K黄",@"18K白",@"18K双色",@"18K玫瑰金",@"PT900",@"PT950",@"PD950", nil];
    self.netlist=netarray;
    self.colorlist=colorarray;
    self.texturelist=texture1array;
}

-(void)closeImageView
{
    [rImageView stopTimer];
    [rImageView removeFromSuperview];
    [btnBack removeFromSuperview];
    rImageView=nil;
    btnBack=nil;
}

-(BOOL)isexistsfile:(NSString *)Pro_author
{
    BOOL isshow=FALSE;
    for(int i=1;i<60;i++){
        NSString *strApend;
        if(i<9)
            strApend=@"00";
        else
            strApend=@"0";
        
        NSString *path = [NSString stringWithFormat:@"%@_%@%d.jpg",Pro_author, strApend,i];
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

//保留小数位数
-(NSString *)notRounding:(float)price afterPoint:(int)position{
    NSDecimalNumberHandler* roundingBehavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundDown scale:position raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
    NSDecimalNumber *ouncesDecimal;
    NSDecimalNumber *roundedOunces;
    
    ouncesDecimal = [[NSDecimalNumber alloc] initWithFloat:price];
    roundedOunces = [ouncesDecimal decimalNumberByRoundingAccordingToBehavior:roundingBehavior];
    return [NSString stringWithFormat:@"%@",roundedOunces];
}


//产品详情
-(void)showproductDetai
{
    pricelable.text=@"";
    sqlService * sql=[[sqlService alloc] init];
    
    //产品id
    productnumber=_proid;
    goods=[sql GetProductDetail:productnumber];
    Pro_type=goods.Pro_Type;
    
    
    //标题
    titlelable.text=goods.Pro_name;
    
    //型号
    modellable.text=[NSString stringWithFormat:@"型号：%@",goods.Pro_model];
    weighlable.text=[NSString stringWithFormat:@"约重：%@",goods.Pro_goldWeight];//约重
    
    //价格
    productApi *priceApi=[[productApi alloc]init];
    NSString *womanprice=[priceApi getPrice:goods.Pro_Class goldType:@"5" goldWeight:nil mDiaWeight:nil mDiaColor:nil mVVS:nil sDiaWeight:nil sCount:goods.Pro_f_count proid:goods.Id];
    NSInteger price=[womanprice integerValue];
    if (price>0) {
        pricelable.text=[NSString stringWithFormat:@"%ld",(long)price];
    }else{
        pricelable.text=@"暂无价格信息";
    }
    
    
    if ([self isexistsfile:goods.Pro_author]) {
        [show3D setHidden:NO];
        
        addtoshopcart.frame=CGRectMake(70, 480, 180, 50);
        show3D.frame=CGRectMake(270, 480, 130, 50);
        NSLog(@"%f和%f",addtoshopcart.frame.origin.x,addtoshopcart.frame.origin.y);
    }else{
        [show3D setHidden:TRUE];
        addtoshopcart.frame=CGRectMake(150, 480, 180, 50);
    }
    
    NSURL *imgUrl=[NSURL URLWithString:[NSString stringWithFormat:@"http://seyuu.com%@",goods.Pro_smallpic]];
    NSArray  * array= [goods.Pro_bigpic componentsSeparatedByString:@","];
    //遍历这个数组
    if ([array count]>0) {
        imgUrl=[NSURL URLWithString:[NSString stringWithFormat:@"http://seyuu.com%@",[array objectAtIndex: 0]]];
    }
    if ([goods.producttype isEqualToString:@"1"]) {
        self.productpic.image=[[UIImage alloc] initWithContentsOfFile:[array objectAtIndex: 0]];
    }else
    {
        if (hasCachedImage(imgUrl)) {
            [self.productpic setImage:[UIImage imageWithContentsOfFile:pathForURL(imgUrl)]];
        }else
        {
            [self.productpic setImage:[UIImage imageNamed:@""]];//diamonds
            NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:imgUrl,@"url",self.productpic,@"imageView",nil];
            [NSThread detachNewThreadSelector:@selector(cacheImage:) toTarget:[ImageCacher defaultCacher] withObject:dic];
        }
    }
    
    
}

//3D展示
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
    
    CGRect frame_0= CGRectMake(childview.frame.origin.x-30, childview.frame.origin.y-30, childview.frame.size.width+90, childview.frame.size.height+120);
    rImageView=[[RotateImageView alloc]initWithFrame:frame_0];
    rImageView.animationImages=imgArray;
    [rImageView setUserInteractionEnabled:YES];
    rImageView.layer.cornerRadius=12;
    rImageView.layer.masksToBounds=YES;
    [self.view addSubview:rImageView];
    
    //旋转初使化
    rImageView.numberOfImages=[imgArray count]-1;
    [rImageView initTimer];
    
    UIImage* image= [UIImage imageNamed:@"close"];
    CGRect frame_1= CGRectMake(closebutton.frame.origin.x+60, closebutton.frame.origin.y-30, 40, 40);
    btnBack= [[UIButton alloc] initWithFrame:frame_1];
    [btnBack setBackgroundImage:image forState:UIControlStateNormal];
    [btnBack addTarget:self action:@selector(closeImageView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnBack];
}

//商品添加到购物车
-(IBAction)addshopcart:(id)sender{
    sqlService * sql=[[sqlService alloc] init];
    //productEntity *goods=[sql GetProductDetail:productnumber];
    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    buyproduct * entity=[[buyproduct alloc]init];
    entity.producttype=Pro_type;
    entity.productid=productnumber;
    entity.pweight=goods.Pro_goldWeight;
    entity.customerid=myDelegate.entityl.uId;
    entity.pprice=womanprice;
    entity.pname=goods.Pro_model;
    entity.pro_model=goods.Pro_model;
    entity.photos=goods.Pro_smallpic;
    entity.pcount=@"1";
    buyproduct *successadd=[sql addToBuyproduct:entity];
    buyproduct *successaddman=[[buyproduct alloc]init];
    if ([goods.Pro_Class isEqualToString:@"3"] && [goods.Pro_typeWenProId isEqualToString:@"0"]) {
        buyproduct * manentity=[[buyproduct alloc]init];
        manentity.producttype=goodsman.Pro_Type;
        manentity.productid=goodsman.Id;
        manentity.pweight=goodsman.Pro_goldWeight;
        manentity.customerid=myDelegate.entityl.uId;
        manentity.pprice=manprice;
        manentity.pname=goodsman.Pro_model;//modellable.text;
        sql=[[sqlService alloc]init];
        successaddman=[sql addToBuyproduct:manentity];
    }
    
    if (successadd && successaddman) {
        [_mydelegate performSelector:@selector(refleshBuycutData)];
        NSString *rowString =@"成功加入购物车！";
        UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示" message:rowString delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alter show];
    } else{
        NSString *rowString =@"加入购物车失败！";
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
    NSInteger count = [array count];
    //遍历这个数组
    for (int i = 0; i < count; i++) {
        if ([goods.producttype isEqualToString:@"1"]) {
            NSString *patht=[NSString stringWithFormat:@"%@",[array objectAtIndex: i]];
            UIImage *localimg=[UIImage imageWithContentsOfFile:patht];
            CGSize size=CGSizeMake(1300, localimg.size.height);
            UIImage *localimg1=[self OriginImage:localimg scaleToSize:size];
            [photos addObject:[MWPhoto photoWithImage:localimg1]];
        }else
        {
            //NSLog(@"普通的遍历：i = %d 时的数组对象为: %@",i,[array objectAtIndex: i]);
            NSString * patht=[NSString stringWithFormat:@"http://seyuu.com%@",[array objectAtIndex: i]];
            NSURL *imgUrl=[NSURL URLWithString:patht];
            if (hasCachedImage(imgUrl)) {
                [photos addObject:[MWPhoto photoWithImage:[UIImage imageWithContentsOfFile:pathForURL(imgUrl)]]];
            }else
            {
                [photos addObject:[MWPhoto photoWithURL:[NSURL URLWithString:patht]]];
            }
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
    [browser setWantsFullScreenLayout:NO];
    
    // Push
    [self presentViewController:browser animated:YES completion:nil];
    //[self dismissViewControllerAnimated:YES completion:nil];
    //[self.navigationController pushViewController:browser animated:NO];
    //[self presentPopupViewController:browser animated:YES completion:^(void) {
    //    NSLog(@"popup view presented");
    //}];
    
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

-(UIImage*)  OriginImage:(UIImage *)image   scaleToSize:(CGSize)size
{
	// 创建一个bitmap的context
	// 并把它设置成为当前正在使用的context
	UIGraphicsBeginImageContext(size);
	
	// 绘制改变大小的图片
	[image drawInRect:CGRectMake(0, 0, size.width, size.height)];
	
	// 从当前context中创建一个改变大小后的图片
	UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
	
	// 使当前的context出堆栈
	UIGraphicsEndImageContext();
	
	// 返回新的改变大小后的图片
	return scaledImage;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
