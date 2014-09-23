//
//  localorderdetail.m
//  zhubao
//
//  Created by johnson on 14-9-23.
//  Copyright (c) 2014年 SUNYEARS___FULLUSERNAME. All rights reserved.
//

#import "localorderdetail.h"
#import "sqlService.h"
#import "localorderglistCell.h"

@interface localorderdetail ()

@end

@implementation localorderdetail

@synthesize order;
@synthesize nameLabel;
@synthesize mobileLabel;
@synthesize telLabel;
@synthesize addrLabel;
@synthesize comtentsLabel;
@synthesize ordernoLabel;
@synthesize createtimeLabel;
@synthesize allmoneyLabel;
@synthesize getpriceLabel;
@synthesize stateLbel;
@synthesize dTView;

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
    
    sqlService *_sqlService=[[sqlService alloc]init];
    list=[_sqlService GetLocalOrderDetailList:order.Id page:1 pageSize:1500];
    
    [self loaddata];
}

-(void)loaddata
{
    nameLabel.text=[NSString stringWithFormat:@"姓名:%@",order.username];
    mobileLabel.text=[NSString stringWithFormat:@"手机:%@",order.mobile];
    telLabel.text=[NSString stringWithFormat:@"电话:%@",order.phone];
    addrLabel.text=[NSString stringWithFormat:@"地址:%@",order.addr];
    comtentsLabel.text=[NSString stringWithFormat:@"备注:%@",order.comtents];
    ordernoLabel.text=[NSString stringWithFormat:@"订单号:%@",order.Id];
    createtimeLabel.text=[NSString stringWithFormat:@"下单时间:%@",order.createdate];
    allmoneyLabel.text=[NSString stringWithFormat:@"金额:%@",order.allprice];
    getpriceLabel.text=[NSString stringWithFormat:@"已付:%@",order.getprice];
    stateLbel.text=@"状态:待确认";
}

//初始化tableview数据
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [list count];
    //只有一组，数组数即为行数。
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *TableSampleIdentifier = @"localorderglistCell";
    
    localorderglistCell *cell = [tableView dequeueReusableCellWithIdentifier:TableSampleIdentifier];
    if (cell == nil) {
        NSArray * nib=[[NSBundle mainBundle]loadNibNamed:@"localorderglistCell" owner:self options:nil];
        cell=[nib objectAtIndex:0];
    }
    orderdetail *entity=[list objectAtIndex:[indexPath row]];
    cell.typeLabel.text=[NSString stringWithFormat:@"类型:%@",entity.goldType];
    cell.colorLabel.text=[NSString stringWithFormat:@"材质:%@",entity.diaColor];
    cell.sizeLabel.text=[NSString stringWithFormat:@"手寸:%@",entity.size];
    cell.modelLabel.text=[NSString stringWithFormat:@"型号:%@",entity.Pro_model];
    cell.goldwLabel.text=[NSString stringWithFormat:@"金重:%@",entity.goldWeight];
    cell.fontLabel.text=@"刻字:";
    cell.savemodelLabel.text=[NSString stringWithFormat:@"库存型号:%@",entity.Pro_model];
    cell.goldpLabel.text=[NSString stringWithFormat:@"金价:%@",entity.goldPrice];
    cell.priceLabel.text=[NSString stringWithFormat:@"价格:%@",entity.Pro_price];
    cell.logoimg.image=[[UIImage alloc] initWithContentsOfFile:entity.logopic];
    
    return cell;
}

//tableview点击操作，裸钻详情页面显示
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

-(IBAction)closeaddlocalg:(id)sender
{
    [_mydelegate performSelector:@selector(closed)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
