//
//  localorder.m
//  zhubao
//
//  Created by johnson on 14-9-23.
//  Copyright (c) 2014年 SUNYEARS___FULLUSERNAME. All rights reserved.
//

#import "localorder.h"
#import "localorderCell.h"
#import "sqlService.h"
#import "localorderdetail.h"

@interface localorder ()

@end

@implementation localorder

@synthesize orderTView;

localorderCell *stedcell;

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
    
    [self loaddata];
}

-(void)loaddata
{
    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    sqlService *_sqlService=[[sqlService alloc]init];
    list=[_sqlService GetLocalOrderList:myDelegate.entityl.uId page:1 pageSize:1500];
}

-(IBAction)closeaddlocalg:(id)sender
{
    [_mydelegate performSelector:@selector(closesc)];
}

//初始化tableview数据
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [list count];
    //只有一组，数组数即为行数。
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *TableSampleIdentifier = @"localorderCell";
    
    localorderCell *cell = [tableView dequeueReusableCellWithIdentifier:TableSampleIdentifier];
    if (cell == nil) {
        NSArray * nib=[[NSBundle mainBundle]loadNibNamed:@"localorderCell" owner:self options:nil];
        cell=[nib objectAtIndex:0];
    }
    orderbill *entity=[list objectAtIndex:[indexPath row]];
    cell.ordernoLabel.text=entity.Id;
    cell.usernameLabel.text=entity.username;
    cell.mobileLabel.text=entity.mobile;
    NSArray *array=[entity.createdate componentsSeparatedByString:@" "];
    cell.createdateLabel.text=[array objectAtIndex:0];
    cell.propriceLabel.text=entity.allprice;
    cell.inputpriceLabel.text=entity.getprice;
    NSString *status=entity.state;
    NSString *statusstr;
    if ([status isEqualToString:@"1"]) {
        statusstr=@"待确认";
    }else if ([status isEqualToString:@"2"])
    {
        statusstr=@"已确认";
    }else if ([status isEqualToString:@"2"])
    {
        statusstr=@"已付款";
    }else if ([status isEqualToString:@"2"])
    {
        statusstr=@"已取消";
    }
    cell.stateLabel.text=statusstr;
    [cell.checkButton addTarget:self action:@selector(localorderdetail:) forControlEvents:UIControlEventTouchDown];
    [cell.deleteButton addTarget:self action:@selector(deletelocalorder:) forControlEvents:UIControlEventTouchDown];
    [cell.stateButton addTarget:self action:@selector(createDemoView:) forControlEvents:UIControlEventTouchDown];
    [cell.getmoneybtn addTarget:self action:@selector(creategetmoneyview:) forControlEvents:UIControlEventTouchDown];
    
    return cell;
}

//tableview点击操作，裸钻详情页面显示
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

//更改数量
- (void)creategetmoneyview:(id)sender
{
    stedcell=(localorderCell *)[[sender superview]superview];
    NSIndexPath * path = [orderTView indexPathForCell:stedcell];
    orderbill *entity=[list objectAtIndex:[path row]];
    
    hiview=[[UIView alloc]initWithFrame:self.view.frame];
    hiview.backgroundColor=[UIColor blackColor];
    hiview.alpha=0.5;
    getmoneyview = [[UIView alloc] initWithFrame:CGRectMake(410, 305, 220, 100)];
    [getmoneyview setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"backgroundcolor"]]];
    UILabel *title=[[UILabel alloc]initWithFrame:CGRectMake(75, 5, 70, 30)];
    title.text=@"已付金额";
    title.font=[UIFont systemFontOfSize:17.0f];
    [title setTextColor:[UIColor colorWithRed:185/255.0f green:12/255.0f blue:20/255.0f alpha:1.0f]];
    [title setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"backgroundcolor"]]];
    
    moneyText=[[UITextField alloc]initWithFrame:CGRectMake(35, 35, 150, 30)];
    [moneyText setBorderStyle:UITextBorderStyleBezel];
    [moneyText setBackground:[UIImage imageNamed:@"writetextbox"]];
    moneyText.font=[UIFont boldSystemFontOfSize:12.0f];
    moneyText.text=entity.getprice;
    moneyText.keyboardType=UIKeyboardTypeNumberPad;
    
    UIButton *okbtn=[[UIButton alloc]initWithFrame:CGRectMake(41, 67, 30, 30)];
    [okbtn setTitle:@"确定" forState:UIControlStateNormal];
    [okbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    okbtn.titleLabel.font=[UIFont boldSystemFontOfSize:15.0f];
    okbtn.tag=0;
    [okbtn addTarget:self action:@selector(changegetmoney:) forControlEvents:UIControlEventTouchDown];
    
    UIButton *canclebtn=[[UIButton alloc]initWithFrame:CGRectMake(141, 67, 30, 30)];
    [canclebtn setTitle:@"取消" forState:UIControlStateNormal];
    [canclebtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    canclebtn.titleLabel.font=[UIFont boldSystemFontOfSize:15.0f];
    canclebtn.tag=1;
    [canclebtn addTarget:self action:@selector(changegetmoney:) forControlEvents:UIControlEventTouchDown];
    
    [getmoneyview addSubview:okbtn];
    [getmoneyview addSubview:canclebtn];
    [getmoneyview addSubview:moneyText];
    [getmoneyview addSubview:title];
    [self.view addSubview:hiview];
    [self.view addSubview:getmoneyview];
}


//更改已付金额
-(void)changegetmoney:(UIButton *)btn
{
    if (btn.tag==0) {
        stedcell.inputpriceLabel.text=moneyText.text;
    }
    [hiview removeFromSuperview];
    [getmoneyview removeFromSuperview];
}

//更改状态
- (void)createDemoView:(id)sender
{
    stedcell=(localorderCell *)[[sender superview]superview];
//    NSIndexPath * path = [orderTView indexPathForCell:stedcell];
//    orderbill *entity=[list objectAtIndex:[path row]];
    
    hiview=[[UIView alloc]initWithFrame:self.view.frame];
    hiview.backgroundColor=[UIColor blackColor];
    hiview.alpha=0.5;
    demoView = [[UIView alloc] initWithFrame:CGRectMake(410, 305, 250, 100)];
    [demoView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"backgroundcolor"]]];
    UILabel *title=[[UILabel alloc]initWithFrame:CGRectMake(0, 5, 250, 30)];
    title.text=@"更改订单状态为";
    title.font=[UIFont systemFontOfSize:17.0f];
    [title setTextColor:[UIColor colorWithRed:185/255.0f green:12/255.0f blue:20/255.0f alpha:1.0f]];
    [title setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"backgroundcolor"]]];
    title.textAlignment=NSTextAlignmentCenter;
    
    UIButton *radio1=[[UIButton alloc]initWithFrame:CGRectMake(11, 35, 15,15)];
    [radio1 setImage:[UIImage imageNamed:@"select"] forState:UIControlStateNormal];
    [radio1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    radio1.titleLabel.font=[UIFont boldSystemFontOfSize:12.0f];
    radio1.tag=1;
    [radio1 addTarget:self action:@selector(changebtnimg:) forControlEvents:UIControlEventTouchDown];
    
    UILabel *label1=[[UILabel alloc]initWithFrame:CGRectMake(27, 35, 40,15)];
    label1.text=@"待确认";
    label1.font=[UIFont boldSystemFontOfSize:12.0f];
    label1.backgroundColor=[UIColor clearColor];
    
    
    UIButton *radio2=[[UIButton alloc]initWithFrame:CGRectMake(70, 35, 15,15)];
    [radio2 setImage:[UIImage imageNamed:@"select"] forState:UIControlStateNormal];
    [radio2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    radio2.titleLabel.font=[UIFont boldSystemFontOfSize:12.0f];
    radio2.tag=2;
    [radio2 addTarget:self action:@selector(changebtnimg:) forControlEvents:UIControlEventTouchDown];
    
    UILabel *label2=[[UILabel alloc]initWithFrame:CGRectMake(86, 35, 40,15)];
    label2.text=@"已确认";
    label2.font=[UIFont boldSystemFontOfSize:12.0f];
    label2.backgroundColor=[UIColor clearColor];
    
    UIButton *radio3=[[UIButton alloc]initWithFrame:CGRectMake(129, 35, 15,15)];
    [radio3 setImage:[UIImage imageNamed:@"select"] forState:UIControlStateNormal];
    [radio3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    radio3.titleLabel.font=[UIFont boldSystemFontOfSize:12.0f];
    radio3.tag=3;
    [radio3 addTarget:self action:@selector(changebtnimg:) forControlEvents:UIControlEventTouchDown];
    
    UILabel *label3=[[UILabel alloc]initWithFrame:CGRectMake(145, 35, 40,15)];
    label3.text=@"已付款";
    label3.font=[UIFont boldSystemFontOfSize:12.0f];
    label3.backgroundColor=[UIColor clearColor];
    
    UIButton *radio4=[[UIButton alloc]initWithFrame:CGRectMake(188, 35, 15,15)];
    [radio4 setImage:[UIImage imageNamed:@"select"] forState:UIControlStateNormal];
    [radio4 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    radio4.titleLabel.font=[UIFont boldSystemFontOfSize:12.0f];
    radio4.tag=4;
    [radio4 addTarget:self action:@selector(changebtnimg:) forControlEvents:UIControlEventTouchDown];
    
    UILabel *label4=[[UILabel alloc]initWithFrame:CGRectMake(204, 35, 40,15)];
    label4.text=@"已取消";
    label4.font=[UIFont boldSystemFontOfSize:12.0f];
    label4.backgroundColor=[UIColor clearColor];
    
    UIButton *okbtn=[[UIButton alloc]initWithFrame:CGRectMake(41, 67, 30, 30)];
    [okbtn setTitle:@"确定" forState:UIControlStateNormal];
    [okbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    okbtn.titleLabel.font=[UIFont boldSystemFontOfSize:15.0f];
    okbtn.tag=0;
    [okbtn addTarget:self action:@selector(changestate:) forControlEvents:UIControlEventTouchDown];
    
    UIButton *canclebtn=[[UIButton alloc]initWithFrame:CGRectMake(182, 67, 30, 30)];
    [canclebtn setTitle:@"取消" forState:UIControlStateNormal];
    [canclebtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    canclebtn.titleLabel.font=[UIFont boldSystemFontOfSize:15.0f];
    canclebtn.tag=1;
    [canclebtn addTarget:self action:@selector(changestate:) forControlEvents:UIControlEventTouchDown];
    
    [demoView addSubview:okbtn];
    [demoView addSubview:canclebtn];
    [demoView addSubview:radio1];
    [demoView addSubview:radio2];
    [demoView addSubview:radio3];
    [demoView addSubview:radio4];
    [demoView addSubview:label1];
    [demoView addSubview:label2];
    [demoView addSubview:label3];
    [demoView addSubview:label4];
    btnlist=[[NSArray alloc]initWithObjects:radio1,radio2,radio3,radio4, nil];
    [demoView addSubview:title];
    [self.view addSubview:hiview];
    [self.view addSubview:demoView];
}


//改变radiaobutton图案
-(void)changebtnimg:(UIButton *)btn
{
    for (UIButton *btn in btnlist) {
        [btn setImage:[UIImage imageNamed:@"select"] forState:UIControlStateNormal];
    }
    [btn setImage:[UIImage imageNamed:@"selected"] forState:UIControlStateNormal];
    statevalue=[NSString stringWithFormat:@"%d",btn.tag];
}

//更改状态
-(void)changestate:(UIButton *)btn
{
    if (btn.tag==0) {
        if ([statevalue isEqualToString:@"1"]) {
            stedcell.stateLabel.text=@"待确认";
        }else if ([statevalue isEqualToString:@"2"])
        {
            stedcell.stateLabel.text=@"已确认";
        }else if ([statevalue isEqualToString:@"3"])
        {
            stedcell.stateLabel.text=@"已付款";
        }else if ([statevalue isEqualToString:@"4"])
        {
            stedcell.stateLabel.text=@"已取消";
        }
    }
    [hiview removeFromSuperview];
    [demoView removeFromSuperview];
}

//本地订单详情页面跳转
- (void)localorderdetail:(UIButton *)btn
{
    UITableViewCell * cell = (UITableViewCell *)[[btn superview] superview];
     NSIndexPath * path = [self.orderTView indexPathForCell:cell];
    orderbill *entity=[list objectAtIndex:path.row];
    localorderdetail *samplePopupViewController = [[localorderdetail alloc] initWithNibName:@"localorderdetail" bundle:nil];
    samplePopupViewController.mydelegate=self;
    samplePopupViewController.order=entity;
    [self presentPopupViewController:samplePopupViewController animated:YES completion:^(void) {
        NSLog(@"popup view presented");
    }];
}

//本地订单删除
-(void)deletelocalorder:(UIButton *)btn
{
    
    [[[UIAlertView alloc] initWithTitle:@"信息提示" message:@"确定删除该订单？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil] show];
    UITableViewCell * cell = (UITableViewCell *)[[btn superview] superview];
    NSIndexPath * path = [self.orderTView indexPathForCell:cell];
    selectedentity=[list objectAtIndex:path.row];
}


//alertview触发事件
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==1) {
        sqlService *_sqlService=[[sqlService alloc]init];
        NSString *info=[_sqlService deletelocalorder:selectedentity.Id];
        if (info) {
            [[[UIAlertView alloc] initWithTitle:@"信息提示" message:@"删除成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
            [self loaddata];
            [orderTView reloadData];
            
        }else{
            [[[UIAlertView alloc] initWithTitle:@"信息提示" message:@"删除失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
        }
    }
}

-(void)closed{
    if (self.popupViewController != nil) {
        [self dismissPopupViewControllerAnimated:YES completion:^{
            NSLog(@"popup view dismissed");
        }];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
