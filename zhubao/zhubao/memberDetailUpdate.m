//
//  memberDetailUpdate.m
//  zhubao
//
//  Created by johnson on 14-7-31.
//  Copyright (c) 2014年 SUNYEARS___FULLUSERNAME. All rights reserved.
//

#import "memberDetailUpdate.h"

@interface memberDetailUpdate ()

@end

@implementation memberDetailUpdate

@synthesize selectTableView;
@synthesize provinceText;
@synthesize cityText;
@synthesize divisionText;
@synthesize companyText;
@synthesize cusnameText;
@synthesize mobileText;
@synthesize telText;
@synthesize addressText;
@synthesize provincelist=_provincelist;
@synthesize citylist=_citylist;
@synthesize Divisionlist=_Divisionlist;

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
    
    [self showmemberdetail];
    provinceText.userInteractionEnabled=NO;
    cityText.userInteractionEnabled=NO;
    divisionText.userInteractionEnabled=NO;
    
    NSArray *Divisionarray = [[NSArray alloc] initWithObjects:@"办公室", @"市场部",
                              @"采购部", @"技术部",@"人力资源",@"其他", nil];
    //NSArray *province=[[NSArray alloc] initWithObjects:@"广东",@"广西",@"河北", nil];
    NSArray *province = [[NSArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"city" ofType:@"plist"]];
    
    self.provincelist=province;
    self.Divisionlist=Divisionarray;
}

-(IBAction)closememberdetail:(id)sender
{
    [_mydelegate performSelector:@selector(closesc)];
}

-(void)showmemberdetail
{
    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    companyText.text=myDelegate.entityl.userTrueName;
    cusnameText.text=myDelegate.entityl.lxrName;
    mobileText.text=myDelegate.entityl.Phone;
    telText.text=myDelegate.entityl.Lxphone;
    provinceText.text=myDelegate.entityl.Sf;
    cityText.text=myDelegate.entityl.Cs;
    addressText.text=myDelegate.entityl.Address;
    NSString *division=nil;
    
    @try {
        if (!myDelegate.entityl.bmName) {
            division=@"其他";
        }else if ([ myDelegate.entityl.bmName isEqualToString:@"1"]) {
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
    }
    @catch (NSException *exception) {
        division=@"其他";
    }
    @finally {
        
    }
    
    
    divisionText.text=division;
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
    }else if (btntag==1){
        selectTableView.frame=CGRectMake(403, 267, 90, 100);
    }else if (btntag==2){
        selectTableView.frame=CGRectMake(293, 348, 97, 100);
        
    }
    [selectTableView reloadData];
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
        NSDictionary *rowString = [self.provincelist objectAtIndex:[indexPath row]];
        cell.textLabel.text = [rowString objectForKey:@"state"];
        
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
        NSDictionary *rowString = [self.provincelist objectAtIndex:[indexPath row]];
        NSString * proname=[rowString objectForKey:@"state"];
        NSArray * cities=[rowString objectForKey:@"cities"];
        
        provinceText.text=proname;
        self.citylist=cities;
        cityText.text=nil;
        
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
    if([man.Email isEqualToString:@"(null)"] || !man.Email)man.Email=@"";
    if([man.sfUrl isEqualToString:@"(null)"] || !man.sfUrl)man.sfUrl=@"";
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
    sql=[[sqlService alloc]init];
    [sql HandleSql:[NSString stringWithFormat:@"delete from customer where uId=%@ ",man.uId]];
    sql= [[sqlService alloc]init];
    customer *updateman=[sql updateCustomer:man];
    if (updateman) {
        myDelegate.entityl.userTrueName=companyText.text;
        myDelegate.entityl.lxrName=cusnameText.text;
        myDelegate.entityl.Phone=mobileText.text;
        myDelegate.entityl.Lxphone=telText.text;
        myDelegate.entityl.Sf=provinceText.text;
        myDelegate.entityl.Cs=cityText.text;
        myDelegate.entityl.Address=addressText.text;
        if ([divisionText.text isEqualToString:@"办公室"]) {
            myDelegate.entityl.bmName=@"1";
        }else if ([divisionText.text isEqualToString:@"市场部"]){
            myDelegate.entityl.bmName=@"2";
        }else if ([divisionText.text isEqualToString:@"采购部"]){
            myDelegate.entityl.bmName=@"3";
        }else if ([divisionText.text isEqualToString:@"技术部"]){
            myDelegate.entityl.bmName=@"4";
        }else if ([divisionText.text isEqualToString:@"人力资源"]){
            myDelegate.entityl.bmName=@"5";
        }else if ([divisionText.text isEqualToString:@"其他"]){
            myDelegate.entityl.bmName=@"6";
        }
        NSString *rowString =@"修改成功！";
        UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示" message:rowString delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alter show];
    }else{
        NSString *rowString =@"修改失败！";
        UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示" message:rowString delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alter show];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
