//
//  NakedDiamondResult.m
//  zhubao
//
//  Created by johnson on 14-10-20.
//  Copyright (c) 2014年 SUNYEARS___FULLUSERNAME. All rights reserved.
//

#import "NakedDiamondResult.h"
#import "NoticeReportCell.h"
#import "sqlService.h"
#import "NakedDiamondDetail.h"

@interface NakedDiamondResult ()

@end

@implementation NakedDiamondResult

@synthesize nakediacount;

@synthesize shape;
@synthesize weight;
@synthesize price;
@synthesize color;
@synthesize net;
@synthesize cut;
@synthesize chasing;
@synthesize symmetry;
@synthesize fluorescence;
@synthesize diploma;
@synthesize number;

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
    
    sqlService *product=[[sqlService alloc] init];
    productlist=[product GetProductdiaList:shape type2:weight type3:price type4:color type5:net type6:cut type7:chasing type8:symmetry type9:fluorescence type10:diploma type11:number page:1 pageSize:40000];
}

-(IBAction)closeDetail:(id)sender
{
    [_mydelegate performSelector:@selector(closeAction)];
}

//初始化tableview数据
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger value=0;
    value=[productlist count];
    nakediacount.text=[NSString stringWithFormat:@"共搜索到%lu颗钻石",(unsigned long)[productlist count]];
    return value;
    //只有一组，数组数即为行数。
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *TableSampleIdentifier = @"NoticeReportCell";
    
    NoticeReportCell *cell = [tableView dequeueReusableCellWithIdentifier:TableSampleIdentifier];
    if (cell == nil) {
        NSArray * nib=[[NSBundle mainBundle]loadNibNamed:@"NoticeReportCell" owner:self options:nil];
        cell=[nib objectAtIndex:0];
    }
    productdia *entity =[productlist objectAtIndex:[indexPath row]];
    if ([entity.Dia_Shape isEqualToString:@"RB"]) {
        cell.notice.text=@"圆形";
        cell.showimage.image=[UIImage imageNamed:@"round.jpg"];
    }
    else if ([entity.Dia_Shape isEqualToString:@"PE"]){
        cell.notice.text=@"公主方";
        cell.showimage.image=[UIImage imageNamed:@"princess2.jpg"];
    }
    else if ([entity.Dia_Shape isEqualToString:@"EM"]){
        cell.notice.text=@"祖母绿";
        cell.showimage.image=[UIImage imageNamed:@"Emerald.jpg"];
    }
    else if ([entity.Dia_Shape isEqualToString:@"RD"]){
        cell.notice.text=@"雷蒂恩";
        cell.showimage.image=[UIImage imageNamed:@"radiant.jpg"];
    }
    else if ([entity.Dia_Shape isEqualToString:@"OL"]){
        cell.notice.text=@"椭圆形";
        cell.showimage.image=[UIImage imageNamed:@"Oval.jpg"];
    }
    else if ([entity.Dia_Shape isEqualToString:@"MQ"]){
        cell.notice.text=@"橄榄形";
        cell.showimage.image=[UIImage imageNamed:@"marquise.jpg"];
    }
    else if ([entity.Dia_Shape isEqualToString:@"CU"]){
        cell.notice.text=@"枕形";
        cell.showimage.image=[UIImage imageNamed:@"cushion.jpg"];
    }
    else if ([entity.Dia_Shape isEqualToString:@"PR"]){
        cell.notice.text=@"梨形";
        cell.showimage.image=[UIImage imageNamed:@"Pear2.jpg"];
    }
    else if ([entity.Dia_Shape isEqualToString:@"HT"]){
        cell.notice.text=@"心形";
        cell.showimage.image=[UIImage imageNamed:@"Heart.jpg"];
    }
    else if ([entity.Dia_Shape isEqualToString:@"ASH"]){
        cell.notice.text=@"镭射刑";
        cell.showimage.image=[UIImage imageNamed:@"Asscher2.jpg"];
    }
    cell.noticeDate.text=entity.Dia_CertNo;
    cell.tuDate.text=entity.Dia_Carat;
    cell.Dia_Col.text=entity.Dia_Col;
    cell.Dia_Clar.text=entity.Dia_Clar;
    cell.Dia_Cut.text=entity.Dia_Cut;
    NSArray *price1=[entity.Dia_Price componentsSeparatedByString:@"."];
    cell.chasinglable.text=[@"¥" stringByAppendingString:[price1 objectAtIndex:0]];
    cell.Dia_Sym.text=entity.Dia_Lab;
    cell.Dia_Lab.text=entity.Dia_Pol;
    cell.Dia_Price.text=entity.Dia_Sym;
    cell.teslable.text=@"查看";
    
    return cell;
}

//tableview点击操作，裸钻详情页面显示
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    productdia *entity = [productlist objectAtIndex:[indexPath row]];
    NakedDiamondDetail *prodeuctDetailcontroller = [[NakedDiamondDetail alloc] initWithNibName:@"NakedDiamondDetail" bundle:nil];
    prodeuctDetailcontroller.mydelegate=self;
    prodeuctDetailcontroller.mypdelegate= _mydelegate;
    prodeuctDetailcontroller.naid=entity.Id;
    
    [self presentPopupViewController:prodeuctDetailcontroller animated:YES completion:^(void) {
        NSLog(@"popup view presented");
    }];
    
}

- (void)closeAction
{
    if (self.popupViewController != nil) {
        [self dismissPopupViewControllerAnimated:YES completion:^{
            NSLog(@"popup view dismissed");
        }];
    }
}

-(void)refleshBuycutData
{
    
    sqlService *sql=[[sqlService alloc]init];
    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    myDelegate.entityl.resultcount=[sql getBuyproductcount:myDelegate.entityl.uId];
    
    sqlService *shopcar=[[sqlService alloc] init];
    shoppingcartlist=[shopcar GetBuyproductList:myDelegate.entityl.uId];
    shopcart *scg=[[shopcart alloc]init];
    [scg reloadshopcart];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
