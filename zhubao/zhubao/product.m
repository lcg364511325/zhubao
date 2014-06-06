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
    [self.navigationController setNavigationBarHidden:YES];

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

- (IBAction)goAction:(id)sender
{
    primaryShadeView.alpha=0.5;
    secondaryView.frame = CGRectMake(140, 95, secondaryView.frame.size.width, secondaryView.frame.size.height);
    secondaryView.hidden = NO;
    productimageview.image=[UIImage imageNamed:@"diamonds.png"];
    title1lable.text=@"18K钻石女戒 18K/0.12克拉S03651W(C20455031)";
    pricelable.text=@"¥18507";
    modellable.text=@"S036531W";
    weightlable.text=@"2.21g";
    mainlable.text=@"1颗";
    fitNolable.text=@"0颗";
    fitweightlable.text=@"0.00ct";
    maintext.text=@"0.400";
    nettext.text=@"SI";
    colortext.text=@"H";
    texturetext.text=@"18K黄";
    sizetext.text=@"7";
    fonttext.text=nil;
    numbertext.text=@"1";
}

- (IBAction)closeAction:(id)sender
{
    primaryShadeView.alpha=0;
    secondaryView.hidden = YES;
}

- (IBAction)goAction1:(id)sender
{
    secondShadeView.alpha=0.5;
    thridaryView.frame = CGRectMake(140, 95, thridaryView.frame.size.width, thridaryView.frame.size.height);
    thridaryView.hidden = NO;
}

- (IBAction)closeAction1:(id)sender
{
    thridaryView.hidden = YES;
    secondShadeView.alpha=0;
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
    }else if(selecttype==1){
        rowString = [self.netlist objectAtIndex:[indexPath row]];
        nettext.text=rowString;
        netselect.hidden=YES;
    }else if(selecttype==2){
        rowString = [self.colorlist objectAtIndex:[indexPath row]];
        colortext.text=rowString;
        colorselect.hidden=YES;
    }else if (selecttype==3){
        rowString = [self.texturelist objectAtIndex:[indexPath row]];
        texturetext.text=rowString;
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
        }
    }else if(selecttype==1){
        if (!CGRectContainsPoint([netselect frame], pt)) {
            //to-do
            netselect.hidden=YES;
        }
    }else if(selecttype==2){
        if (!CGRectContainsPoint([colorselect frame], pt)) {
            //to-do
            colorselect.hidden=YES;
        }
    }else if (selecttype==3){
        if (!CGRectContainsPoint([textureselect frame], pt)) {
            //to-do
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
    }else if(btntag==1){
        netselect.hidden=NO;
        [netselect reloadData];
    }else if (btntag==2){
        colorselect.hidden=NO;
        [colorselect reloadData];
    }else if (btntag==3){
        textureselect.hidden=NO;
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
        style=nil;
    }else if (btntag==1){
        style=@"1";
    }else if (btntag==2){
        style=@"2";
    }else if (btntag==3){
        style=@"3";
    }else if (btntag==4){
        style=@"4";
    }else if (btntag==5){
        style=@"5";
    }else if (btntag==6){
        style=@"6";
    }else if (btntag==7){
        style=@"7";
    }else if (btntag==8){
        style=@"8";
    }else if (btntag==9){
        style=@"9";
    }
    sqlService *productlist =[[sqlService alloc] init];
    NSMutableArray *list=[productlist GetProductList:style type2:nil type3:nil type4:nil page:0 pageSize:10];
}


//材质选择
-(IBAction)textureselect:(id)sender
{
    UIButton* btn = (UIButton*)sender;
    NSInteger btntag=[btn tag];
}

//镶口选择
-(IBAction)inlayselect:(id)sender
{
    UIButton* btn = (UIButton*)sender;
    NSInteger btntag=[btn tag];
}

//系列
-(IBAction)serie:(id)sender
{
    UIButton* btn = (UIButton*)sender;
    NSInteger btntag=[btn tag];
    NSString * serie=nil;
    if (btntag==1) {
        serie=@"1";
    }else if(btntag==2){
        serie=@"ture";
    }
}

-(IBAction)addshopcart:(id)sender{
    NSString *rowString =@"成功加入购物车！";
    UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示" message:rowString delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alter show];
}

@end
