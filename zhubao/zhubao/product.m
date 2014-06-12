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
@synthesize mianselect;
@synthesize netselect;
@synthesize colorselect;
@synthesize textureselect;
@synthesize mainlist=_mainlist;
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

//判定点击来哪个tableview
NSInteger selecttype=0;
//产品id
NSString * productnumber=nil;
//查询结果
NSMutableArray *list=nil;
//工厂款号
NSString * Pro_author;

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
    NSArray *colorarray = [[NSArray alloc]initWithObjects:@"D-E",@"F-G",@"H",@"I-J",@"K-L",@"M-N", nil];
    //材质
    NSArray *texture1array = [[NSArray alloc]initWithObjects:@"18K黄",@"18K白",@"18K双色",@"18K玫瑰金",@"PT900",@"PT950",@"PD950", nil];
    self.netlist=netarray;
    self.colorlist=colorarray;
    self.texturelist=texture1array;
    maintext.userInteractionEnabled=NO;
    nettext.userInteractionEnabled=NO;
    colortext.userInteractionEnabled=NO;
    texturetext.userInteractionEnabled=NO;
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
    //进来时候加载全部数据
    sqlService *sql=[[sqlService alloc]init];
    list=[sql GetProductList:nil type2:nil type3:nil type4:nil page:1 pageSize:100];

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
    secondaryView.hidden = YES;
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
}

- (IBAction)threeddAction:(id)sender
{
    
    //FVImageSequenceDemoViewController *sysmenu=[[FVImageSequenceDemoViewController alloc] init];
    TestViewController *sysmenu=[[TestViewController alloc] init];
    
    sysmenu.code=Pro_author;//@"3Y0012";//工厂款号
    [self.navigationController pushViewController:sysmenu animated:NO];
    
}

//设置页面跳转
-(IBAction)setup:(id)sender
{
    fourthView.hidden=NO;
    fourthView.frame=CGRectMake(750, 70, fourthView.frame.size.width, fourthView.frame.size.height);
}
//设置页面关闭
-(IBAction)closesetup:(id)sender
{
    fourthView.hidden=YES;
}


//tableview行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger value=0;
    if(selecttype==0){
        value=[_mainlist count];
    }else if(selecttype==1){
        value=[_netlist count];
    }else if(selecttype==2){
        value=[_colorlist count];
    }else if (selecttype==3){
        value=[_texturelist count];
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
    }else if(selecttype==1){
        cell.textLabel.text = [self.netlist objectAtIndex:row];
    }else if(selecttype==2){
        cell.textLabel.text = [self.colorlist objectAtIndex:row];
    }else if (selecttype==3){
        cell.textLabel.text = [self.texturelist objectAtIndex:row];
    }
    return cell;
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
    }
}

//点击tableview以外的地方触发事件
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint pt = [touch locationInView:self.view];
    //点击其他地方消失
    if(selecttype==0){
        if (!CGRectContainsPoint([mianselect frame], pt)) {
            //to-do
            mianselect.hidden=YES;
            colorselect.hidden=YES;
            netselect.hidden=YES;
            textureselect.hidden=YES;
        }
    }else if(selecttype==1){
        if (!CGRectContainsPoint([netselect frame], pt)) {
            //to-do
            mianselect.hidden=YES;
            colorselect.hidden=YES;
            netselect.hidden=YES;
            textureselect.hidden=YES;
        }
    }else if(selecttype==2){
        if (!CGRectContainsPoint([colorselect frame], pt)) {
            //to-do
            mianselect.hidden=YES;
            colorselect.hidden=YES;
            netselect.hidden=YES;
            textureselect.hidden=YES;
        }
    }else if (selecttype==3){
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
        [mianselect reloadData];
    }else if(btntag==1){
        netselect.hidden=NO;
        mianselect.hidden=YES;
        colorselect.hidden=YES;
        textureselect.hidden=YES;
        [netselect reloadData];
    }else if (btntag==2){
        colorselect.hidden=NO;
        mianselect.hidden=YES;
        netselect.hidden=YES;
        textureselect.hidden=YES;
        [colorselect reloadData];
    }else if (btntag==3){
        textureselect.hidden=NO;
        mianselect.hidden=YES;
        colorselect.hidden=YES;
        netselect.hidden=YES;
        [textureselect reloadData];
    }
    
}

//款式选择
-(IBAction)styleselect:(id)sender
{
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
    sqlService *sql=[[sqlService alloc]init];
    list=[sql GetProductList:styleindex type2:textrueindex type3:inlayindex type4:serieindex page:1 pageSize:100];
    [productcollect reloadData];
}


//材质选择
-(IBAction)textureselect:(id)sender
{
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
    sqlService *sql=[[sqlService alloc]init];
    list=[sql GetProductList:styleindex type2:textrueindex type3:inlayindex type4:serieindex page:1 pageSize:100];
    [productcollect reloadData];
}

//镶口选择
-(IBAction)inlayselect:(id)sender
{
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
        inlay=@"0.40";
        [btn setBackgroundImage:[UIImage imageNamed:@"yellowcolor"] forState:UIControlStateNormal];
    }else if (btntag==9){
        inlay=@"0.50";
        [btn setBackgroundImage:[UIImage imageNamed:@"yellowcolor"] forState:UIControlStateNormal];
    }else if (btntag==10){
        inlay=@"0.60";
        [btn setBackgroundImage:[UIImage imageNamed:@"yellowcolor"] forState:UIControlStateNormal];
    }else if (btntag==11){
        inlay=@"0.70";
        [btn setBackgroundImage:[UIImage imageNamed:@"yellowcolor"] forState:UIControlStateNormal];
    }else if (btntag==12){
        inlay=@"0.80";
        [btn setBackgroundImage:[UIImage imageNamed:@"yellowcolor"] forState:UIControlStateNormal];
    }else if (btntag==13){
        inlay=@"0.90";
        [btn setBackgroundImage:[UIImage imageNamed:@"yellowcolor"] forState:UIControlStateNormal];
    }else if (btntag==14){
        inlay=@"1";
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
    sqlService *sql=[[sqlService alloc]init];
    list=[sql GetProductList:styleindex type2:textrueindex type3:inlayindex type4:serieindex page:1 pageSize:100];
    [productcollect reloadData];
}

//系列
-(IBAction)serie:(id)sender
{
    UIButton* btn = (UIButton*)sender;
    NSInteger btntag=[btn tag];
    NSString * serie=nil;
    if (btntag==1) {
        serie=@"Pro_hotE=1";
        [btn setBackgroundImage:[UIImage imageNamed:@"yellowcolor"] forState:UIControlStateNormal];
    }else if(btntag==2){
        serie=@"Pro_f_pair='ture'";
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
            [serieindex appendString:@","];
            [serieindex appendString:index];
        }else{
            [serieindex appendString:index];
        }
    }
    sqlService *sql=[[sqlService alloc]init];
    list=[sql GetProductList:styleindex type2:textrueindex type3:inlayindex type4:serieindex page:1 pageSize:100];
    [productcollect reloadData];
}


//商品添加到购物车
-(IBAction)addshopcart:(id)sender{
    sqlService * sql=[[sqlService alloc] init];
    productEntity *goods=[sql GetProductDetail:productnumber];
    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    buyproduct * entity=[[buyproduct alloc]init];
    entity.producttype=@"0";
    entity.productid=productnumber;
    entity.pcount=numberText.text;
    entity.pcolor=colortext.text;
    entity.pdetail=fontText.text;
    entity.pvvs=nettext.text;
    entity.psize=sizeText.text;
    entity.pgoldtype=texturetext.text;
    entity.pweight=maintext.text;
    entity.customerid=myDelegate.entityl.uId;
    entity.pprice=goods.Pro_price;
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
    NSURL *imgUrl=[NSURL URLWithString:[NSString stringWithFormat:@"http://seyuu.com%@",entity.Pro_smallpic]];
    if (hasCachedImage(imgUrl)) {
        cell.productImage.image=[UIImage imageWithContentsOfFile:pathForURL(imgUrl)];
    }else
    {
        cell.productImage.image=[UIImage imageNamed:@"diamonds"];
        NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:imgUrl,@"url",self.productimageview,@"imageView",nil];
        [NSThread detachNewThreadSelector:@selector(cacheImage:) toTarget:[ImageCacher defaultCacher] withObject:dic];
        
    }
    
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
    productEntity *goods=[sql GetProductDetail:productnumber];
    Pro_author=goods.Pro_author;
    
    //productimageview.image=[UIImage imageNamed:@"diamonds.png"];
    title1lable.text=goods.Pro_name;
    pricelable.text=[@"¥" stringByAppendingString:goods.Pro_price];
    modellable.text=goods.Pro_model;
    weightlable.text=goods.Pro_goldWeight;
    mainlable.text=goods.Pro_Z_count;
    fitNolable.text=goods.Pro_f_count;
    fitweightlable.text=goods.Pro_f_weight;
    maintext.text=[self.mainlist objectAtIndex:0];
    nettext.text=@"SI";
    colortext.text=@"I-J";
    if ([goods.Pro_goldType isEqualToString:@"1"]) {
        texturetext.text=@"18K黄";
    }
    else if ([goods.Pro_goldType isEqualToString:@"2"]){
        texturetext.text=@"18K白";
    }
    else if ([goods.Pro_goldType isEqualToString:@"3"]){
        texturetext.text=@"18K双色";
    }
    else if ([goods.Pro_goldType isEqualToString:@"4"]){
        texturetext.text=@"18K玫瑰金";
    }
    else if ([goods.Pro_goldType isEqualToString:@"5"]){
        texturetext.text=@"PT900";
    }
    else if ([goods.Pro_goldType isEqualToString:@"6"]){
        texturetext.text=@"PT950";
    }
    else if ([goods.Pro_goldType isEqualToString:@"7"]){
        texturetext.text=@"PD950";
    }
    sizetext.text=goods.Pro_goldsize;
    fonttext.text=nil;
    numbertext.text=@"1";
    NSMutableArray *inlayarry=[[NSMutableArray alloc] init];
    inlayarry=[sql getwithmouths:goods.Id];
    NSMutableArray *mainarry=[[NSMutableArray alloc] init];
    for (withmouth *inlay in inlayarry) {
        [mainarry addObject:inlay.zWeight];
    }
    self.mainlist=mainarry;
    NSURL *imgUrl=[NSURL URLWithString:[NSString stringWithFormat:@"http://seyuu.com%@",goods.Pro_smallpic]];
    if (hasCachedImage(imgUrl)) {
        [self.productimageview setImage:[UIImage imageWithContentsOfFile:pathForURL(imgUrl)]];
    }else
    {
        [self.productimageview setImage:[UIImage imageNamed:@"diamonds"]];
        NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:imgUrl,@"url",self.productimageview,@"imageView",nil];
        [NSThread detachNewThreadSelector:@selector(cacheImage:) toTarget:[ImageCacher defaultCacher] withObject:dic];
        
    }
    
}

@end
