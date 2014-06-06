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
                         @"采购部", @"技术部",@"人力资源", nil];
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

- (IBAction)goAction1:(id)sender
{
    thridaryView.frame = CGRectMake(195, 90, thridaryView.frame.size.width, thridaryView.frame.size.height);
    thridaryView.hidden = NO;
}

- (IBAction)closeAction1:(id)sender
{
    thridaryView.hidden = YES;
}

- (IBAction)goAction2:(id)sender
{
    fourtharyView.frame = CGRectMake(195, 90, fourtharyView.frame.size.width, fourtharyView.frame.size.height);
    fourtharyView.hidden = NO;
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

@end
