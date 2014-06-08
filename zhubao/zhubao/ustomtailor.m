//
//  ustomtailor.m
//  zhubao
//
//  Created by johnson on 14-5-28.
//  Copyright (c) 2014年 SUNYEARS___FULLUSERNAME. All rights reserved.
//

#import "ustomtailor.h"

@interface ustomtailor ()

@end

@implementation ustomtailor

@synthesize primaryView;
@synthesize secondaryView;
@synthesize primaryShadeView;
@synthesize thirdaryView;
@synthesize textureselect;
@synthesize mainlist=_mainlist;
@synthesize texturetext;
@synthesize goldweightText;
@synthesize miandiaText;
@synthesize mianNoText;
@synthesize fitDiaText;
@synthesize fitNoText;
@synthesize sizeText;
@synthesize fontText;

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
    NSArray *mainarray = [[NSArray alloc] initWithObjects:@"18K黄", @"18K白",
                          @"18K双色", @"18K玫瑰金", @"PT900", @"Pt950", @"PD950",nil];
    self.mainlist = mainarray;
    texturetext.userInteractionEnabled=NO;
    
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
    secondaryView.frame = CGRectMake(140, 85, secondaryView.frame.size.width, secondaryView.frame.size.height);
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
    thirdaryView.hidden=NO;
    thirdaryView.frame=CGRectMake(750, 70, thirdaryView.frame.size.width, thirdaryView.frame.size.height);
}
//设置页面关闭
-(IBAction)closesetup:(id)sender
{
    thirdaryView.hidden=YES;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_mainlist count];
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
    cell.textLabel.text = [self.mainlist objectAtIndex:row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *rowString = [self.mainlist objectAtIndex:[indexPath row]];
    texturetext.text=rowString;
    textureselect.hidden=YES;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint pt = [touch locationInView:self.view];
    //点击其他地方消失
    if (!CGRectContainsPoint([textureselect frame], pt)) {
        //to-do
        textureselect.hidden=YES;
    }
}

// 材质下拉框
- (IBAction)mianselect:(id)sender
{
    textureselect.hidden=NO;
}

-(IBAction)orderOfGoods:(id)sender
{
    
}

@end
