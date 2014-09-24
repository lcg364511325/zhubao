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
    cell.stateLabel.text=@"未确认";
    [cell.checkButton addTarget:self action:@selector(localorderdetail:) forControlEvents:UIControlEventTouchDown];
    [cell.deleteButton addTarget:self action:@selector(deletelocalorder:) forControlEvents:UIControlEventTouchDown];
    
    return cell;
}

//tableview点击操作，裸钻详情页面显示
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
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
