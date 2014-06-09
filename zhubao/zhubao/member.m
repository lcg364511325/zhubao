//
//  member.m
//  zhubao
//
//  Created by johnson on 14-5-29.
//  Copyright (c) 2014年 SUNYEARS___FULLUSERNAME. All rights reserved.
//

#import "member.h"

@interface member ()

@end

@implementation member

@synthesize primaryView;
@synthesize secondaryView;
@synthesize primaryShadeView;
@synthesize thridaryView;
@synthesize fourtharyView;
@synthesize fiftharyView;
@synthesize selectTableView;
@synthesize provincelist=_provincelist;
@synthesize citylist=_citylist;
@synthesize Divisionlist=_Divisionlist;
@synthesize provinceText;
@synthesize cityText;
@synthesize divisionText;
@synthesize companyText;
@synthesize cusnameText;
@synthesize mobileText;
@synthesize telText;
@synthesize addressText;
@synthesize oldpassword;
@synthesize newpassword;
@synthesize affirmpassword;


//判定点击来哪个tableview
NSInteger selecttable=0;


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
    NSArray *Divisionarray = [[NSArray alloc] initWithObjects:@"办公室", @"市场部",
                         @"采购部", @"技术部",@"人力资源",@"其他", nil];
    self.Divisionlist=Divisionarray;
    
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
    ustomtailor * _ustomtailor = [[ustomtailor alloc] init];
    
    [self.navigationController pushViewController:_ustomtailor animated:NO];
}

-(IBAction)doReg4:(id)sender
{
    diploma * _diploma = [[diploma alloc] init];
    
    [self.navigationController pushViewController:_diploma animated:NO];
}


//购物车页面跳转
- (IBAction)goAction:(id)sender
{
    primaryShadeView.alpha=0.5;
    secondaryView.frame = CGRectMake(145, 90, secondaryView.frame.size.width, secondaryView.frame.size.height);
    secondaryView.hidden = NO;
}

- (IBAction)closeAction:(id)sender
{
    primaryShadeView.alpha=0;
    secondaryView.hidden = YES;
}

//会员密码修改页面跳转
- (IBAction)goAction1:(id)sender
{
    thridaryView.frame = CGRectMake(195, 90, thridaryView.frame.size.width, thridaryView.frame.size.height);
    thridaryView.hidden = NO;
}

- (IBAction)closeAction1:(id)sender
{
    thridaryView.hidden = YES;
}

//会员资料修改页面跳转
- (IBAction)goAction2:(id)sender
{
    fourtharyView.frame = CGRectMake(195, 90, fourtharyView.frame.size.width, fourtharyView.frame.size.height);
    fourtharyView.hidden = NO;
    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    companyText.text=myDelegate.entityl.userTrueName;
    cusnameText.text=myDelegate.entityl.lxrName;
    mobileText.text=myDelegate.entityl.Phone;
    telText.text=myDelegate.entityl.Lxphone;
    provinceText.text=myDelegate.entityl.Sf;
    cityText.text=myDelegate.entityl.Cs;
    addressText.text=myDelegate.entityl.Address;
    NSString *division=nil;
    if ([ myDelegate.entityl.bmName isEqualToString:@"1"]) {
        division=@"办公室";
    }else if ([ myDelegate.entityl.bmName isEqualToString:@"2"]){
        division=@"市场部";
    }else if ([ myDelegate.entityl.bmName isEqualToString:@"3"]){
        division=@"采购部";
    }else if ([ myDelegate.entityl.bmName isEqualToString:@"4"]){
        division=@"技术部";
    }else if ([ myDelegate.entityl.bmName isEqualToString:@"5"]){
        division=@"人力资源";
    }else if ([ myDelegate.entityl.bmName isEqualToString:@"6"]){
        division=@"其他";
    }
    divisionText.text=division;
}

- (IBAction)closeAction2:(id)sender
{
    fourtharyView.hidden = YES;
}

//设置页面跳转
-(IBAction)setup:(id)sender
{
     fiftharyView.hidden=NO;
    fiftharyView.frame=CGRectMake(750, 70, fiftharyView.frame.size.width, fiftharyView.frame.size.height);
}
//设置页面关闭
-(IBAction)closesetup:(id)sender
{
    fiftharyView.hidden=YES;
}
//下拉框
-(IBAction)selecttableview:(id)sender
{
    UIButton* btn = (UIButton*)sender;
    NSInteger btntag=[btn tag];
    selecttable=btntag;
    selectTableView.hidden=NO;
    if (btntag==0) {
        selectTableView.frame=CGRectMake(297, 267, 93, 100);
        [selectTableView reloadData];
    }else if (btntag==1){
        selectTableView.frame=CGRectMake(403, 267, 90, 100);
        [selectTableView reloadData];
    }else if (btntag==2){
        selectTableView.frame=CGRectMake(293, 348, 97, 100);
        [selectTableView reloadData];
    }
}

//初始化tableview数据
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray * list=nil;
    if (selecttable==0) {
        list=self.provincelist;
    }else if (selecttable==1){
        list=self.citylist;
    }else if (selecttable==2){
        list=self.Divisionlist;
    }
    return [list count];
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
    if (selecttable==0) {
        cell.textLabel.text = [self.provincelist objectAtIndex:row];
    }else if (selecttable==1){
        cell.textLabel.text = [self.citylist objectAtIndex:row];
    }else if (selecttable==2){
        cell.textLabel.text = [self.Divisionlist objectAtIndex:row];
    }
    return cell;
}

//tableview点击操作
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (selecttable==0) {
        NSString *rowString = [self.provincelist objectAtIndex:[indexPath row]];
        provinceText.text=rowString;
    }else if (selecttable==1){
        NSString *rowString = [self.citylist objectAtIndex:[indexPath row]];
        cityText.text=rowString;
    }else if (selecttable==2){
        NSString *rowString = [self.Divisionlist objectAtIndex:[indexPath row]];
        divisionText.text=rowString;
    }
    selectTableView.hidden=YES;
}

//点击tableview以外得地方关闭
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint pt = [touch locationInView:self.view];
    //点击其他地方消失
    if (!CGRectContainsPoint([selectTableView frame], pt)) {
        //to-do
        selectTableView.hidden=YES;
    }
}


//会员资料修改保存操作
-(IBAction)updatemember:(id)sender
{
    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    sqlService *sql=[[sqlService alloc]init];
    customer *man=[sql getCustomer:myDelegate.entityl.uId];
    man.userTrueName=companyText.text;
    man.lxrName=cusnameText.text;
    man.Phone=mobileText.text;
    man.Lxphone=telText.text;
    man.Sf=provinceText.text;
    man.Cs=cityText.text;
    man.Address=addressText.text;
    if ([divisionText.text isEqualToString:@"办公室"]) {
        man.bmName=@"1";
    }else if ([divisionText.text isEqualToString:@"市场部"]){
        man.bmName=@"2";
    }else if ([divisionText.text isEqualToString:@"采购部"]){
        man.bmName=@"3";
    }else if ([divisionText.text isEqualToString:@"技术部"]){
        man.bmName=@"4";
    }else if ([divisionText.text isEqualToString:@"人力资源"]){
        man.bmName=@"5";
    }else if ([divisionText.text isEqualToString:@"其他"]){
        man.bmName=@"6";
    }
    customer *updateman=[sql updateCustomer:man];
    if (updateman) {
        NSString *rowString =@"修改成功！";
        UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示" message:rowString delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alter show];
    }else{
        NSString *rowString =@"修改失败！";
        UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示" message:rowString delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alter show];
    }
}

//密码修改
-(IBAction)updatepassword:(id)sender
{
    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    sqlService *sql=[[sqlService alloc]init];
    customer *newnam=[sql getCustomer:myDelegate.entityl.uId];
    if ([[Commons md5:[NSString stringWithFormat:@"%@",oldpassword.text]]  isEqualToString:myDelegate.entityl.userPass]) {
        newnam.userPass=[Commons md5:[NSString stringWithFormat:@"%@",newpassword.text]];
        newnam.oldpassword=[Commons md5:[NSString stringWithFormat:@"%@",oldpassword.text]];
        customer *updatesuccess=[sql updateCustomerPasswrod:newnam];
        if (updatesuccess) {
            NSString *rowString =@"修改成功！";
            UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示" message:rowString delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alter show];
             myDelegate.entityl.userPass=[Commons md5:[NSString stringWithFormat:@"%@",newpassword.text]];
        }else{
            NSString *rowString =@"修改失败！";
            UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示" message:rowString delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alter show];
        }
    }else{
        NSString *rowString =@"请输入正确的原密码！";
        UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示" message:rowString delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alter show];
    }
}

@end
