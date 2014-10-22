//
//  localgoodsDetail.m
//  zhubao
//
//  Created by johnson on 14-10-21.
//  Copyright (c) 2014年 SUNYEARS___FULLUSERNAME. All rights reserved.
//

#import "localgoodsDetail.h"
#import "sqlService.h"

@interface localgoodsDetail ()

@end

@implementation localgoodsDetail

@synthesize productpic;//产品图片
@synthesize addtoshopcart;//加入购物车按钮
@synthesize watchmorepic;//查看更多图片
@synthesize modellable;//型号
@synthesize weighlable;//约重
@synthesize mainnanolable;//主石数量
@synthesize fitnanolable;//副石数量
@synthesize titlelable;//产品标题
@synthesize pricelable;//产品价格
@synthesize closebutton;//关闭按钮

@synthesize mainlist=_mainlist;
@synthesize dmainlist=_dmainlist;
@synthesize netlist=_netlist;
@synthesize colorlist=_colorlist;
@synthesize texturelist=_texturelist;
@synthesize ismember;



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

-(IBAction)closeDetail:(id)sender
{
    [_mydelegate performSelector:@selector(closeAction)];
}

-(void)closesc{
    if (self.popupViewController != nil) {
        [self dismissPopupViewControllerAnimated:YES completion:^{
            NSLog(@"popup view dismissed");
        }];
    }
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


//自定义商品
-(void)localgoods
{
    //删除按钮
    deletebtn=[[UIButton alloc]initWithFrame:CGRectMake(115, 575, 110, 50)];
    [deletebtn setBackgroundImage:[UIImage imageNamed:@"deleteBtn"] forState:UIControlStateNormal];
    [deletebtn addTarget:self action:@selector(deletelocalgoods) forControlEvents:UIControlEventTouchDown];
    
    //更新按钮
    updatebtn=[[UIButton alloc]initWithFrame:CGRectMake(445, 575, 110, 50)];
    [updatebtn setBackgroundImage:[UIImage imageNamed:@"gengxinBtn"] forState:UIControlStateNormal];
    [updatebtn addTarget:self action:@selector(updateloacalshop) forControlEvents:UIControlEventTouchDown];
    
    addtoshopcart.hidden=YES;
    [self.view addSubview:deletebtn];
    [self.view addSubview:updatebtn];
}

//删除商品
-(void)deletelocalgoods
{
    NSString *rowString =@"确定删除该商品？";
    UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示" message:rowString delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alter show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==1) {
        sqlService *_sqlService=[[sqlService alloc]init];
        NSString *info=[_sqlService deleteProduct:_proid];
        if (info) {
            NSString *rowString =@"删除成功！";
            UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示" message:rowString delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alter show];
            _sqlService=[[sqlService alloc]init];
            [_sqlService deleteBuyproductBypid:_proid];
            [self closeDetail:nil];
            [_mypdelegate performSelector:@selector(reloaddata)];
            [_mydelegate performSelector:@selector(refleshBuycutData)];
        }else{
            NSString *rowString =@"删除失败！";
            UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示" message:rowString delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alter show];
        }
    }
}

//更新商品页面跳转
-(void)updateloacalshop
{
    addlocalgoods *samplePopupViewController = [[addlocalgoods alloc] initWithNibName:@"addlocalgoods" bundle:nil];
    samplePopupViewController.mydelegate=self;
    samplePopupViewController.goods=goods;
    [self presentPopupViewController:samplePopupViewController animated:YES completion:^(void) {
        NSLog(@"popup view presented");
    }];
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
    //productimageview.image=[UIImage imageNamed:@"diamonds.png"];
    
    //本地商品加载按钮
    if ([goods.producttype isEqualToString:@"1"] && [ismember isEqualToString:@"1"]) {
        [self localgoods];
    }
    
    //标题
    titlelable.text=goods.Pro_name;
    
    NSString *price=[NSString stringWithFormat:@"%@",goods.Pro_price];
    if ([price isEqualToString:@""]) {
        pricelable.text=@"暂无价格信息";
    }
    
    //型号
    if (![goods.Pro_model isEqualToString:@""])
    {
        modellable.text=[NSString stringWithFormat:@"型号：%@",goods.Pro_model];
    }
    
    if (![goods.Pro_goldWeight isEqualToString:@""])
    {
        weighlable.text=[NSString stringWithFormat:@"约重：%@",goods.Pro_goldWeight];//约重
    }
    
    //主石数
    if (![goods.Pro_Z_count isEqualToString:@""])
    {
        mainnanolable.text=[NSString stringWithFormat:@"主石：%@ 颗 %@ ct",goods.Pro_Z_count,goods.Pro_Z_weight];//goods.Pro_Z_count;
    }
    
    //副石数
    if (![goods.Pro_f_count isEqualToString:@""])
    {
        fitnanolable.text=[NSString stringWithFormat:@"副石：%@ 颗 %@ ct",goods.Pro_f_count,goods.Pro_f_weight];//goods.Pro_f_count;
    }
    
    NSString *pic1=goods.Pro_smallpic;
    NSArray *fullth=[goods.Pro_bigpic componentsSeparatedByString:@","];
    if (![pic1 isEqualToString:@""]) {
        productpic.image=[[UIImage alloc] initWithContentsOfFile:pic1];
    }else if ([fullth count]!=0)
    {
        if (![[fullth objectAtIndex:0] isEqualToString:@""]) {
            productpic.image=[[UIImage alloc] initWithContentsOfFile:[fullth objectAtIndex:0]];
        }else
        {
            productpic.image=[[UIImage alloc] initWithContentsOfFile:[fullth objectAtIndex:1]];
        }
        
    }
    
    
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
    entity.pname=goods.Pro_name;
    entity.pro_model=goods.Pro_model;
    NSString *pic1=goods.Pro_smallpic;
    NSArray *fullth=[goods.Pro_bigpic componentsSeparatedByString:@","];
    if (![pic1 isEqualToString:@""]) {
        entity.photos=pic1;
    }else if ([fullth count]!=0)
    {
        if (![[fullth objectAtIndex:0] isEqualToString:@""]) {
             entity.photos=[fullth objectAtIndex:0];
        }else
        {
             entity.photos=[fullth objectAtIndex:1];
        }
        
    }
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
