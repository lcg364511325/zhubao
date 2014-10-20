//
//  proclass.m
//  zhubao
//
//  Created by moko on 14-9-30.
//  Copyright (c) 2014年 SUNYEARS___FULLUSERNAME. All rights reserved.
//

#import "proclass.h"

@interface proclass ()

@end

@implementation proclass

@synthesize orderTView;

proclasslistCell *stedcell;
proclassEntity * proclassentity;


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
    list=[_sqlService GetProclassList:myDelegate.entityl.uId page:1 pageSize:1500];
}

-(IBAction)closeaddlocalg:(id)sender
{
    [_mydelegate performSelector:@selector(closesc)];
}

//添加类别
- (IBAction)addproclass:(id)sender {
    
    proclassentity=nil;//设为空，表示新加
    [self creategetmoneyview:nil];
}


//初始化tableview数据
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [list count];
    //只有一组，数组数即为行数。
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *TableSampleIdentifier = @"proclasslistCell";
    
    proclasslistCell *cell = [tableView dequeueReusableCellWithIdentifier:TableSampleIdentifier];
    if (cell == nil) {
        NSArray * nib=[[NSBundle mainBundle]loadNibNamed:@"proclasslistCell" owner:self options:nil];
        cell=[nib objectAtIndex:0];
    }
    proclassEntity *entity=[list objectAtIndex:[indexPath row]];
    cell.ordernoLabel.text=entity.Id;
    cell.usernameLabel.text=entity.name;

    [cell.deleteButton addTarget:self action:@selector(deletelocalorder:) forControlEvents:UIControlEventTouchDown];
    [cell.stateButton addTarget:self action:@selector(creategetmoneyview:) forControlEvents:UIControlEventTouchDown];
    
    return cell;
}

//tableview点击操作，裸钻详情页面显示
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

//更改商品类别名称
- (void)creategetmoneyview:(id)sender
{
    NSString * name=@"";
    if(sender){
        stedcell=(proclasslistCell *)[[sender superview]superview];
        NSIndexPath * path = [orderTView indexPathForCell:stedcell];
        proclassentity=[list objectAtIndex:[path row]];
        name=proclassentity.name;
    }
    
    hiview=[[UIView alloc]initWithFrame:self.view.frame];
    hiview.backgroundColor=[UIColor blackColor];
    hiview.alpha=0.5;
    getmoneyview = [[UIView alloc] initWithFrame:CGRectMake(410, 305, 220, 100)];
    [getmoneyview setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"backgroundcolor"]]];
    UILabel *title=[[UILabel alloc]initWithFrame:CGRectMake(75, 5, 70, 30)];
    title.text=@"类别名称";
    title.font=[UIFont systemFontOfSize:17.0f];
    [title setTextColor:[UIColor colorWithRed:185/255.0f green:12/255.0f blue:20/255.0f alpha:1.0f]];
    [title setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"backgroundcolor"]]];
    
    moneyText=[[UITextField alloc]initWithFrame:CGRectMake(35, 35, 150, 30)];
    [moneyText setBorderStyle:UITextBorderStyleBezel];
    [moneyText setBackground:[UIImage imageNamed:@"writetextbox"]];
    moneyText.font=[UIFont boldSystemFontOfSize:12.0f];
    moneyText.text=name;
    
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


//更改类别名称或者新加类别
-(void)changegetmoney:(UIButton *)btn
{
    if (btn.tag==0) {
        sqlService *_sqlService=[[sqlService alloc]init];
        
        if(proclassentity){
            proclassentity.name=moneyText.text;
            
            NSIndexPath * path = [orderTView indexPathForCell:stedcell];
            proclassEntity *entity=[list objectAtIndex:[path row]];
            NSString *info=[_sqlService updateProclass:@"name" value:moneyText.text oid:entity.Id];
            if (info) {
                //stedcell.usernameLabel.text=moneyText.text;
                [self loaddata];
                [orderTView reloadData];
            }else
            {
                NSString *rowString =@"未知错误";
                UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示" message:rowString delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alter show];
            }
            
        }else{
            AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
            proclassentity=[[proclassEntity alloc]init];
            proclassentity.uId=myDelegate.entityl.uId;
            proclassentity.name=moneyText.text;
            
            sqlService *_sqlService=[[sqlService alloc]init];
            proclassEntity * tientity=[_sqlService addProclass:proclassentity];
            
            NSString *rowString =@"未知错误";
            if(tientity){
                rowString =@"添加类别成功。";
                
                [self loaddata];
                [orderTView reloadData];
            }
            
            UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示" message:rowString delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alter show];
            
        }
    }
    [hiview removeFromSuperview];
    [getmoneyview removeFromSuperview];
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


//商品类别删除
-(void)deletelocalorder:(UIButton *)btn
{
    
    [[[UIAlertView alloc] initWithTitle:@"信息提示" message:@"确定删除该商品类别？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil] show];
    UITableViewCell * cell = (UITableViewCell *)[[btn superview] superview];
    NSIndexPath * path = [self.orderTView indexPathForCell:cell];
    selectedentity=[list objectAtIndex:path.row];
}


//alertview触发事件
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==1) {
        sqlService *_sqlService=[[sqlService alloc]init];
        NSString *info=[_sqlService deleteProclass:selectedentity.Id];
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
