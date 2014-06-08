//
//  diploma.m
//  zhubao
//
//  Created by johnson on 14-5-29.
//  Copyright (c) 2014年 SUNYEARS___FULLUSERNAME. All rights reserved.
//

#import "diploma.h"

@interface diploma ()

@end

@implementation diploma

@synthesize primaryView;
@synthesize secondaryView;
@synthesize primaryShadeView;
@synthesize thirdView;
@synthesize DiplomaSelect;
@synthesize selecttext;
@synthesize dipomaNoText;
@synthesize diamondWeightText;
@synthesize list = _list;

//证书类型
NSInteger diptype=0;

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
    NSArray *array = [[NSArray alloc] initWithObjects:@"GIA(美国宝石学院)", @"NGTC(国家珠宝玉石质量监督中心)",
                      @"IGI(世界宝石学院)", @"HRD(比利时钻石高阶层会议)", @"AGS(美国宝石学学会)", @"EGL(欧洲宝石学院)", nil];
    self.list = array;
    selecttext.userInteractionEnabled=NO;
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
    member * _member = [[member alloc] init];
    
    [self.navigationController pushViewController:_member animated:NO];
}

- (IBAction)goAction:(id)sender
{
    primaryShadeView.alpha=0.5;
    secondaryView.frame = CGRectMake(140, 95, secondaryView.frame.size.width, secondaryView.frame.size.height);
    secondaryView.hidden = NO;
}

- (IBAction)closeAction:(id)sender
{
    primaryShadeView.alpha=0;
    secondaryView.hidden = YES;
}

//设置页面跳转
-(IBAction)setup:(id)sender
{
    thirdView.hidden=NO;
    thirdView.frame=CGRectMake(750, 70, thirdView.frame.size.width, thirdView.frame.size.height);
}
//设置页面关闭
-(IBAction)closesetup:(id)sender
{
    thirdView.hidden=YES;
}

//初始化tableview数据
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_list count];
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
    cell.textLabel.text = [self.list objectAtIndex:row];
    return cell;
}

//tableview点击操作
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *rowString = [self.list objectAtIndex:[indexPath row]];
    diptype=[indexPath row];
    selecttext.text=rowString;
    DiplomaSelect.hidden=YES;
}

//点击tableview以外得地方关闭
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint pt = [touch locationInView:self.view];
    //点击其他地方消失
    if (!CGRectContainsPoint([DiplomaSelect frame], pt)) {
        //to-do
        DiplomaSelect.hidden=YES;
    }
}

//证书下拉选择
- (IBAction)diplomaselect:(id)sender
{
    DiplomaSelect.hidden=NO;
}


//证书查询浏览器页面跳转
//0为GIA，1为NGTC，2为IGI，3为HRD，4为AGS，5为EGL
-(IBAction)diplomasearch:(id)sender
{
    if (diptype==0) {
        NSString *url=[@"https://myapps.gia.edu/ReportCheckPortal/getReportData.do?&reportno=" stringByAppendingString:dipomaNoText.text];
        url=[url stringByAppendingString:@"&weight="];
        url=[url stringByAppendingString:diamondWeightText.text];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
    }else if (diptype==1){
        NSString *url=[@"HTTP://seyuu.com/Unrelated/TurnTongtc.asp?reportno=" stringByAppendingString:dipomaNoText.text];
        url=[url stringByAppendingString:@"&weight="];
        url=[url stringByAppendingString:diamondWeightText.text];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
    }else if (diptype==2){
        NSString *url=[@"HTTP://seyuu.com/Unrelated/TurnToIGI.asp?reportno=" stringByAppendingString:dipomaNoText.text];
        url=[url stringByAppendingString:@"&weight="];
        url=[url stringByAppendingString:diamondWeightText.text];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
    }else if (diptype==3){
        NSString *url=[@"http://www.hrdantwerplink.be/?record_number=" stringByAppendingString:dipomaNoText.text];
        url=[url stringByAppendingString:@"&weight="];
        url=[url stringByAppendingString:diamondWeightText.text];
        url=[url stringByAppendingString:@"&L="];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
    }else if (diptype==4){
        NSString *url=[@"http://agslab.com/reportTypes/dqr.php?StoneID=" stringByAppendingString:dipomaNoText.text];
        url=[url stringByAppendingString:@"&Weight="];
        url=[url stringByAppendingString:diamondWeightText.text];
        url=[url stringByAppendingString:@"&D=1"];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
    }else if (diptype==5){
        NSString *url=[@"http://www.eglusa.com/oresults/SearchPage3.php?st_num=" stringByAppendingString:dipomaNoText.text];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
    }
}

@end
