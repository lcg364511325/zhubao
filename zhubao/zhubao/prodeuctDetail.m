//
//  prodeuctDetail.m
//  zhubao
//
//  Created by johnson on 14-7-28.
//  Copyright (c) 2014年 SUNYEARS___FULLUSERNAME. All rights reserved.
//

#import "prodeuctDetail.h"

@interface prodeuctDetail ()

@end

@implementation prodeuctDetail

@synthesize productpic;//产品图片
@synthesize addtoshopcart;//加入购物车按钮
@synthesize show3D;//3D展示按钮（非对戒）
@synthesize show3Dman;//3D展示（对戒男）
@synthesize show3Dwoman;//3D展示（对戒女）
@synthesize watchmorepic;//查看更多图片
@synthesize miantext;//主石
@synthesize nettext;//净度
@synthesize colortext;//颜色
@synthesize texturetext;//材质
@synthesize sizetext;//尺寸
@synthesize fonttext;//刻字
@synthesize numbertext;//数量
@synthesize dmiantext;//对戒主石
@synthesize dnettext;//对戒净度
@synthesize dcolortext;//对戒颜色
@synthesize dtexturetext;//对戒材质
@synthesize dsizetext;//对戒尺寸
@synthesize dfonttext;//对戒刻字
@synthesize mainselect;//主石选择
@synthesize netselect;//净度选择
@synthesize colorselect;//颜色选择
@synthesize texttureselect;//材质选择
@synthesize dmainselect;//对戒主石选择
@synthesize dnetselect;//对戒净度选择
@synthesize dcolorselect;//对戒颜色选择
@synthesize dtextureselect;//对戒材质选择
@synthesize miantable;//主石下拉框
@synthesize nettable;//净度下拉框
@synthesize colortable;//颜色下拉框
@synthesize texturetable;//材质下拉框
@synthesize modellable;//型号
@synthesize weighlable;//约重
@synthesize mainnanolable;//主石数量
@synthesize fitnanolable;//副石数量
@synthesize fitnaweighlable;//副石总重
@synthesize dweighlable;//对戒约重
@synthesize dmiannanolable;//对戒主石数量
@synthesize dfitnanolable;//对戒副石数量
@synthesize dfitweighlable;//对戒副石总重
@synthesize titlelable;//产品标题
@synthesize pricelable;//产品价格
@synthesize childview;//3D视图
@synthesize closebutton;//关闭按钮
@synthesize kelalable;

@synthesize mainlist=_mainlist;
@synthesize dmainlist=_dmainlist;
@synthesize netlist=_netlist;
@synthesize colorlist=_colorlist;
@synthesize texturelist=_texturelist;

//产品id
NSString * productnumber=nil;
//默认商品
productEntity *goods;
//对戒男戒
productEntity *goodsman;
//商品类型
NSString * Pro_type;
//主石约重
NSMutableArray *inlayarry;
//男主石约重
NSMutableArray *inlayarryman;
//女戒价格
NSString *womanprice=nil;
//男戒价格
NSString *manprice=nil;
//判定点击来哪个tableview
NSInteger selecttype=0;



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
    [self prohibit];//禁止编辑和限制只能数字输入
    
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

//禁止编辑和限制只能数字输入
-(void)prohibit
{
    miantext.userInteractionEnabled=NO;
    nettext.userInteractionEnabled=NO;
    colortext.userInteractionEnabled=NO;
    texturetext.userInteractionEnabled=NO;
    dmiantext.userInteractionEnabled=NO;
    dnettext.userInteractionEnabled=NO;
    dcolortext.userInteractionEnabled=NO;
    dtexturetext.userInteractionEnabled=NO;
    sizetext.keyboardType=UIKeyboardTypeNumberPad;
    dsizetext.keyboardType=UIKeyboardTypeNumberPad;
    fonttext.placeholder=@"8到12个字符";
    dfonttext.placeholder=@"8到12个字符";
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

//隐藏对戒男戒
-(void)hidemenlproduct{
    
    [dmiantext setHidden:TRUE];
    [dnettext setHidden:TRUE];
    [dcolortext setHidden:TRUE];
    [dtexturetext setHidden:TRUE];
    [dsizetext setHidden:TRUE];
    [dfonttext setHidden:TRUE];
    
    [dmainselect setHidden:TRUE];
    [dnetselect setHidden:TRUE];
    [dcolorselect setHidden:TRUE];
    [dtextureselect setHidden:TRUE];
    
    [dweighlable setHidden:TRUE];
    [dmiannanolable setHidden:TRUE];
    [dfitnanolable setHidden:TRUE];
    [dfitweighlable setHidden:TRUE];
    [show3Dman setHidden:TRUE];
    [show3Dwoman setHidden:TRUE];
    
    [kelalable setHidden:NO];
    
    if ([self isexistsfile:goods.Pro_author]) {
        [show3D setHidden:NO];
        
        addtoshopcart.frame=CGRectMake(70, 480, 180, 50);
        show3D.frame=CGRectMake(270, 480, 130, 50);
        NSLog(@"%f和%f",addtoshopcart.frame.origin.x,addtoshopcart.frame.origin.y);
    }else{
        [show3D setHidden:TRUE];
        addtoshopcart.frame=CGRectMake(150, 480, 180, 50);
    }
    
}
//显示对戒男戒
-(void)showmenlproduct{
    
    [dmiantext setHidden:NO];
    [dnettext setHidden:NO];
    [dcolortext setHidden:NO];
    [dtexturetext setHidden:NO];
    [dsizetext setHidden:NO];
    [dfonttext setHidden:NO];
    
    [dmainselect setHidden:NO];
    [dnetselect setHidden:NO];
    [dcolorselect setHidden:NO];
    [dtextureselect setHidden:NO];
    
    [dweighlable setHidden:NO];
    [dmiannanolable setHidden:NO];
    [dfitnanolable setHidden:NO];
    [dfitweighlable setHidden:NO];
    
    [kelalable setHidden:TRUE];
    
    if ([self isexistsfile:goods.Pro_author]) {
        [show3Dman setHidden:NO];
        [show3Dwoman setHidden:NO];
        addtoshopcart.frame=CGRectMake(25, 480, 180, 50);
        show3Dman.frame=CGRectMake(220, 480, 110, 50);
        show3Dwoman.frame=CGRectMake(345, 480, 110, 50);
    }else{
        [show3Dman setHidden:TRUE];
        [show3Dwoman setHidden:TRUE];
        addtoshopcart.frame=CGRectMake(150, 480, 180, 50);
    }
    [show3D setHidden:TRUE];
    
}


//自定义商品
-(void)localgoods
{
    //删除按钮
    deletebtn=[[UIButton alloc]initWithFrame:CGRectMake(325, 575, 110, 50)];
    [deletebtn setBackgroundImage:[UIImage imageNamed:@"deleteBtn"] forState:UIControlStateNormal];
    [deletebtn addTarget:self action:@selector(deletelocalgoods) forControlEvents:UIControlEventTouchDown];
    
    //更新按钮
    updatebtn=[[UIButton alloc]initWithFrame:CGRectMake(445, 575, 110, 50)];
    [updatebtn setBackgroundImage:[UIImage imageNamed:@"gengxinBtn"] forState:UIControlStateNormal];
    
    addtoshopcart.frame=CGRectMake(25, 480, 180, 50);
    [self.view addSubview:deletebtn];
    [self.view addSubview:updatebtn];
    [show3D setHidden:TRUE];
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
            UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示" message:rowString delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alter show];
            [self closeDetail:nil];
        }else{
            NSString *rowString =@"删除失败！";
            UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示" message:rowString delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alter show];
        }
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

//女的约重
-(NSString *)getweightg:(NSString *)weig{
    
    for (withmouth *inlay in inlayarry) {
        if ([inlay.zWeight isEqualToString:miantext.text]) {
            if ([goods.Pro_Class isEqualToString:@"3"] && [goods.Pro_typeWenProId isEqualToString:@"0"]) {
                weighlable.text=[NSString stringWithFormat:@"女戒:%@ g",inlay.AuWeight];
            }else{
                weighlable.text=[NSString stringWithFormat:@"%@ g",inlay.AuWeight];
            }
            return inlay.AuWeight;
        }
    }
    
    return @"";
    
}
//男的约重
-(NSString *)getweightman:(NSString *)weig{
    
    for (withmouth *inlayman in inlayarryman) {
        if ([inlayman.zWeight isEqualToString:dmiantext.text]) {
            dweighlable.text=[NSString stringWithFormat:@"男戒:%@ g",inlayman.AuWeight];
            return inlayman.AuWeight;
        }
    }
    
    return @"";
}


//产品详情
-(void)showproductDetai
{
    pricelable.text=@"";
    sqlService * sql=[[sqlService alloc] init];
    productnumber=_proid;
    goods=[sql GetProductDetail:productnumber];
    Pro_type=goods.Pro_Type;
    //productimageview.image=[UIImage imageNamed:@"diamonds.png"];
    
    [self hidemenlproduct];
    
    [self localgoods];
    
    titlelable.text=goods.Pro_name;
    modellable.text=goods.Pro_model;
    //weightlable.text=goods.Pro_goldWeight;//约重
    mainnanolable.text=[NSString stringWithFormat:@"%@ 颗",goods.Pro_Z_count];//goods.Pro_Z_count;
    fitnanolable.text=[NSString stringWithFormat:@"%@ 颗",goods.Pro_f_count];//goods.Pro_f_count;
    fitnaweighlable.text=[NSString stringWithFormat:@"%@ ct",goods.Pro_f_weight];
    //maintext.text=@"111";
    nettext.text=@"SI";
    colortext.text=@"I-J";
    if ([goods.producttype isEqualToString:@"1"]) {
        texturetext.text=@"18K白";
        sizetext.text=@"";
    }else
    {
        Commons * common=[[Commons alloc]init];
        texturetext.text=[common getGoldtypename:goods.Pro_goldType];
        
        sizetext.text=goods.Pro_goldsize;
    }
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
            weighlable.text=[NSString stringWithFormat:@"%@ g",inlay.AuWeight];//约重
        }
    }
    if ([goods.producttype isEqualToString:@"1"]) {
        weighlable.text=goods.Pro_goldWeight;
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
                dweighlable.text=[NSString stringWithFormat:@"男戒:%@ g",inlayman.AuWeight];
            }
        }
        
        weighlable.text=[NSString stringWithFormat:@"女戒:%@ g",AuWeight];
        mainnanolable.text=[NSString stringWithFormat:@"女戒:%@ 颗",goods.Pro_Z_count];
        fitnanolable.text=[NSString stringWithFormat:@"女戒:%@ 颗",goods.Pro_f_count];
        float wwight=goods.Pro_f_weight.doubleValue*goods.Pro_f_count.doubleValue;
        fitnaweighlable.text=[NSString stringWithFormat:@"女戒:%@ ct",[self notRounding:wwight afterPoint:2]];
        
        dmiannanolable.text=[NSString stringWithFormat:@"男戒:%@ 颗",goodsman.Pro_Z_count];
        dfitnanolable.text=[NSString stringWithFormat:@"男戒:%@ 颗",goodsman.Pro_f_count];
        dfitweighlable.text=[NSString stringWithFormat:@"男戒:%@ ct",goodsman.Pro_f_weight];
        dnettext.text=@"SI";
        dcolortext.text=@"I-J";
        Commons * common=[[Commons alloc]init];
        dtexturetext.text=[common getGoldtypename:goodsman.Pro_goldType];
        
        dsizetext.text=goodsman.Pro_goldsize;
        dfonttext.text=nil;
    }
    
    self.mainlist=mainarry;
    self.dmainlist=mainarryman;
    
    if(self.mainlist.count>0)
        miantext.text=[self.mainlist objectAtIndex:0];
    if (self.dmainlist>0 && [goods.Pro_Class isEqualToString:@"3"] && [goods.Pro_typeWenProId isEqualToString:@"0"]) {
        dmiantext.text=[self.dmainlist objectAtIndex:0];
    }
    if ([goods.producttype isEqualToString:@"1"]) {
        miantext.text=goods.Pro_Z_weight;
    }
    self.productpic.layer.cornerRadius=12;
    self.productpic.layer.masksToBounds=YES;
    CALayer *layer = [productpic layer];
    layer.borderColor=[UIColor colorWithRed:133.0/255.0 green:130.0/255.0 blue:154.0/255.0 alpha:1.0].CGColor;
    layer.borderWidth=1.0f;
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
    
    if ([goods.producttype isEqualToString:@"1"]) {
        pricelable.text=[NSString stringWithFormat:@"¥ %@",goods.Pro_price];
    }else{
        //获取商品价格
        @try {
            //可以在此加代码提示用户说正在加载数据中
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                // 耗时的操作（异步操作）
                NSString *proprice=nil;
                productApi *priceApi=[[productApi alloc]init];
                womanprice=[priceApi getPrice:goods.Pro_Class goldType:goods.Pro_goldType goldWeight:AuWeight mDiaWeight:miantext.text mDiaColor:@"I-J" mVVS:@"SI" sDiaWeight:goods.Pro_f_weight sCount:goods.Pro_f_count proid:goods.Id];
                if ([goods.Pro_Class isEqualToString:@"3"] && [goods.Pro_typeWenProId isEqualToString:@"0"]) {
                    
                    manprice=[priceApi getPrice:goodsman.Pro_Class goldType:goodsman.Pro_goldType goldWeight:AuWeightman mDiaWeight:dmiantext.text mDiaColor:@"I-J" mVVS:@"SI" sDiaWeight:goodsman.Pro_f_weight sCount:goodsman.Pro_f_count proid:goodsman.Id];
                    
                    
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
    }else if(selecttype==5)
    {
        value=[_dmainlist count];
    }
    return value;
    //只有一组，数组数即为行数。
}

//tableview值
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
            cell.textLabel.text=[self.dmainlist objectAtIndex:row];
        }
        return cell;
}


//点击tableview触发事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *rowString=nil;
    if(selecttype==0){
        rowString = [self.mainlist objectAtIndex:[indexPath row]];
        miantext.text=rowString;
        miantable.hidden=YES;
        colortable.hidden=YES;
        nettable.hidden=YES;
        texturetable.hidden=YES;
        
    }else if(selecttype==1){
        rowString = [self.netlist objectAtIndex:[indexPath row]];
        nettext.text=rowString;
        miantable.hidden=YES;
        colortable.hidden=YES;
        nettable.hidden=YES;
        texturetable.hidden=YES;
    }else if(selecttype==2){
        rowString = [self.colorlist objectAtIndex:[indexPath row]];
        colortext.text=rowString;
        miantable.hidden=YES;
        colortable.hidden=YES;
        nettable.hidden=YES;
        texturetable.hidden=YES;
    }else if (selecttype==3){
        rowString = [self.texturelist objectAtIndex:[indexPath row]];
        texturetext.text=rowString;
        miantable.hidden=YES;
        colortable.hidden=YES;
        nettable.hidden=YES;
        texturetable.hidden=YES;
    }else if(selecttype==5){
        rowString = [self.dmainlist objectAtIndex:[indexPath row]];
        dmiantext.text=rowString;
        miantable.hidden=YES;
        colortable.hidden=YES;
        nettable.hidden=YES;
        texturetable.hidden=YES;
        
    }else if(selecttype==6){
        rowString = [self.netlist objectAtIndex:[indexPath row]];
        dnettext.text=rowString;
        miantable.hidden=YES;
        colortable.hidden=YES;
        nettable.hidden=YES;
        texturetable.hidden=YES;
    }else if(selecttype==7){
        rowString = [self.colorlist objectAtIndex:[indexPath row]];
        dcolortext.text=rowString;
        miantable.hidden=YES;
        colortable.hidden=YES;
        nettable.hidden=YES;
        texturetable.hidden=YES;
    }else if (selecttype==8){
        rowString = [self.texturelist objectAtIndex:[indexPath row]];
        dtexturetext.text=rowString;
        miantable.hidden=YES;
        colortable.hidden=YES;
        nettable.hidden=YES;
        texturetable.hidden=YES;
    }
    if (![goods.producttype isEqualToString:@"1"]) {
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
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                // 耗时的操作（异步操作）
                
                NSString *proprice=nil;
                productApi *priceApi=[[productApi alloc]init];
                womanprice=[priceApi getPrice:goods.Pro_Class goldType:texturetext.text goldWeight:weightg mDiaWeight:miantext.text mDiaColor:colortext.text mVVS:nettext.text sDiaWeight:goods.Pro_f_weight sCount:goods.Pro_f_count proid:goods.Id];
                if ([goods.Pro_Class isEqualToString:@"3"] && [goods.Pro_typeWenProId isEqualToString:@"0"]) {
                    priceApi=[[productApi alloc]init];
                    manprice=[priceApi getPrice:goodsman.Pro_Class goldType:dtexturetext.text goldWeight:weightman mDiaWeight:dmiantext.text mDiaColor:dcolortext.text mVVS:dnettext.text sDiaWeight:goodsman.Pro_f_weight sCount:goodsman.Pro_f_count proid:goodsman.Id];
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
}

//点击tableview以外的地方触发事件
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint pt = [touch locationInView:self.view];

    //点击其他地方消失
    if(selecttype==0 || selecttype==5){
        if (!CGRectContainsPoint([miantable frame], pt)) {
            //to-do
            miantable.hidden=YES;
            colortable.hidden=YES;
            nettable.hidden=YES;
            texturetable.hidden=YES;
        }
    }else if(selecttype==1 || selecttype==6){
        if (!CGRectContainsPoint([nettable frame], pt)) {
            //to-do
            miantable.hidden=YES;
            colortable.hidden=YES;
            nettable.hidden=YES;
            texturetable.hidden=YES;
        }
    }else if(selecttype==2 || selecttype==7){
        if (!CGRectContainsPoint([colortable frame], pt)) {
            //to-do
            miantable.hidden=YES;
            colortable.hidden=YES;
            nettable.hidden=YES;
            texturetable.hidden=YES;
        }
    }else if (selecttype==3 || selecttype==8){
        if (!CGRectContainsPoint([texturetable frame], pt)) {
            //to-do
            miantable.hidden=YES;
            colortable.hidden=YES;
            nettable.hidden=YES;
            texturetable.hidden=YES;
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
        if (![goods.producttype isEqualToString:@"1"]) {
            miantable.hidden=NO;
            colortable.hidden=YES;
            nettable.hidden=YES;
            texturetable.hidden=YES;
            miantable.frame=CGRectMake(548, miantable.frame.origin.y, miantable.frame.size.width, miantable.frame.size.height);
            [miantable reloadData];
        }
    }else if(btntag==1){
        nettable.hidden=NO;
        miantable.hidden=YES;
        colortable.hidden=YES;
        texturetable.hidden=YES;
        nettable.frame=CGRectMake(548, nettable.frame.origin.y, nettable.frame.size.width, nettable.frame.size.height);
        [nettable reloadData];
    }else if (btntag==2){
        colortable.hidden=NO;
        miantable.hidden=YES;
        nettable.hidden=YES;
        texturetable.hidden=YES;
        colortable.frame=CGRectMake(548, colortable.frame.origin.y, colortable.frame.size.width, colortable.frame.size.height);
        [colortable reloadData];
    }else if (btntag==3){
        texturetable.hidden=NO;
        miantable.hidden=YES;
        colortable.hidden=YES;
        nettable.hidden=YES;
        texturetable.frame=CGRectMake(548, texturetable.frame.origin.y, texturetable.frame.size.width, texturetable.frame.size.height);
        [texturetable reloadData];
    }else if(btntag==5){
        miantable.hidden=NO;
        colortable.hidden=YES;
        nettable.hidden=YES;
        texturetable.hidden=YES;
        miantable.frame=CGRectMake(548+135, miantable.frame.origin.y, miantable.frame.size.width, miantable.frame.size.height);
        [miantable reloadData];
    }else if(btntag==6){
        nettable.hidden=NO;
        miantable.hidden=YES;
        colortable.hidden=YES;
        texturetable.hidden=YES;
        nettable.frame=CGRectMake(548+135, nettable.frame.origin.y, nettable.frame.size.width, nettable.frame.size.height);
        [nettable reloadData];
    }else if (btntag==7){
        colortable.hidden=NO;
        miantable.hidden=YES;
        nettable.hidden=YES;
        texturetable.hidden=YES;
        colortable.frame=CGRectMake(548+135, colortable.frame.origin.y, colortable.frame.size.width, colortable.frame.size.height);
        [colortable reloadData];
    }else if (btntag==8){
        texturetable.hidden=NO;
        miantable.hidden=YES;
        colortable.hidden=YES;
        nettable.hidden=YES;
        texturetable.frame=CGRectMake(548+135, texturetable.frame.origin.y, texturetable.frame.size.width, texturetable.frame.size.height);
        [texturetable reloadData];
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
    entity.pcount=numbertext.text;
    entity.pcolor=colortext.text;
    entity.pdetail=fonttext.text;
    entity.pvvs=nettext.text;
    entity.psize=sizetext.text;
    entity.pgoldtype=texturetext.text;
    entity.pweight=goods.Pro_goldWeight;
    entity.customerid=myDelegate.entityl.uId;
    entity.pprice=womanprice;
    entity.pname=modellable.text;
    buyproduct *successadd=[sql addToBuyproduct:entity];
    buyproduct *successaddman=[[buyproduct alloc]init];
    if ([goods.Pro_Class isEqualToString:@"3"] && [goods.Pro_typeWenProId isEqualToString:@"0"]) {
        buyproduct * manentity=[[buyproduct alloc]init];
        manentity.producttype=goodsman.Pro_Type;
        manentity.productid=goodsman.Id;
        manentity.pcount=numbertext.text;
        manentity.pcolor=dcolortext.text;
        manentity.pdetail=dfonttext.text;
        manentity.pvvs=dnettext.text;
        manentity.psize=dsizetext.text;
        manentity.pgoldtype=dtexturetext.text;
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
    int count = [array count];
    //遍历这个数组
    for (int i = 0; i < count; i++) {
        if ([goods.producttype isEqualToString:@"1"]) {
            NSString *patht=[NSString stringWithFormat:@"%@",[array objectAtIndex: i]];
            [photos addObject:[MWPhoto photoWithImage:[UIImage imageWithContentsOfFile:patht]]];
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
