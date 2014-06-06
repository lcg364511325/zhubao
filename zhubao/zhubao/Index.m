//
//  Index.m
//  zhubao
//
//  Created by johnson on 14-5-27.
//  Copyright (c) 2014年 SUNYEARS___FULLUSERNAME. All rights reserved.
//

#import "Index.h"

@interface Index ()

@end

@implementation Index

@synthesize primaryView;
@synthesize secondaryView;
@synthesize primaryShadeView;
@synthesize thridView;

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
    product * _product = [[product alloc] init];
    
    [self.navigationController pushViewController:_product animated:NO];
}

-(IBAction)doReg1:(id)sender
{
    NakedDiamond * _NakedDiamond = [[NakedDiamond alloc] init];
    
    [self.navigationController pushViewController:_NakedDiamond animated:NO];
}

-(IBAction)doReg2:(id)sender
{
    //ustomtailor * _ustomtailor = [[ustomtailor alloc] init];
    ustomtailor * _ustomtailor=[[ustomtailor alloc] init];
    
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
    secondaryView.frame = CGRectMake(140, 95, secondaryView.frame.size.width, secondaryView.frame.size.width);
    secondaryView.hidden = NO;
    sqlService *shopcar=[[sqlService alloc] init];
    //NSMutableArray *shoppingcart=[shopcar GetBuyproductList:(NSString *)]
    
}

- (IBAction)closeAction:(id)sender
{
    secondaryView.hidden = YES;
    primaryShadeView.alpha=0;
}

-(IBAction)setup:(id)sender
{
    thridView.hidden=NO;
    thridView.frame=CGRectMake(750, 70, thridView.frame.size.width, thridView.frame.size.height);
}

-(IBAction)closesetup:(id)sender
{
    thridView.hidden=YES;
}

////初始化tableview数据
//-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    return 1;
//    //只有一组，数组数即为行数。
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//    static NSString *TableSampleIdentifier = @"shoppingcart";
//    
//    shoppingcart *cell = [tableView dequeueReusableCellWithIdentifier:TableSampleIdentifier];
//    if (cell == nil) {
//        NSArray * nib=[[NSBundle mainBundle]loadNibNamed:@"shoppingcart" owner:self options:nil];
//        cell=[nib objectAtIndex:0];
//    }
//    cell.productImageView.image=[UIImage imageNamed:@"diamond01"];
//    cell.modelLable.text=@"测试 ";
//    cell.diplomaLable.text=@"测试 ";
//    cell.numberLable.text=@"测试 ";
//    cell.model1Lable.text=@"测试 ";
//    cell.weightLable.text=@"测试 ";
//    cell.colorLable.text=@"测试 ";
//    cell.modelLable.text=@"测试 ";
//    cell.netLable.text=@"测试 ";
//    cell.cutLable.text=@"测试 ";
//    cell.chasingLable.text=@"测试 ";
//    cell.symmetryLable.text=@"测试 ";
//    //cell.buyNoLable.text=@"测试 ";
//    return cell;
//}
//
////tableview点击操作
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    //NSString *rowString = [self.list objectAtIndex:[indexPath row]];
//    //Nakeddisplay.hidden=YES;
//}

//购物车删除
-(IBAction)deleteshoppingcart:(id)sender
{
    
}

@end
