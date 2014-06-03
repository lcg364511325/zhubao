//
//  NakedDiamond.m
//  zhubao
//
//  Created by johnson on 14-5-28.
//  Copyright (c) 2014年 SUNYEARS___FULLUSERNAME. All rights reserved.
//

#import "NakedDiamond.h"

@interface NakedDiamond ()

@end

@implementation NakedDiamond

@synthesize primaryView;
@synthesize secondaryView;
@synthesize primaryShadeView;
@synthesize thridaryView;
@synthesize secondShadeView;
@synthesize fourtharyView;
@synthesize thirdShadeView;

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
    ustomtailor * _ustomtailor = [[ustomtailor alloc] init];
    
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
    secondaryView.frame = CGRectMake(140, 95, secondaryView.frame.size.width, secondaryView.frame.size.height);
    secondaryView.hidden = NO;
}

- (IBAction)closeAction:(id)sender
{
    secondaryView.hidden = YES;
    primaryShadeView.alpha=0;
}

- (IBAction)goAction1:(id)sender
{
    secondShadeView.alpha=0.5;
    thridaryView.frame = CGRectMake(140, 95, thridaryView.frame.size.width, thridaryView.frame.size.height);
    thridaryView.hidden = NO;
}

- (IBAction)closeAction1:(id)sender
{
    thridaryView.hidden = YES;
    secondShadeView.alpha=0;
}

- (IBAction)goAction2:(id)sender
{
    thirdShadeView.alpha=0.5;
    fourtharyView.frame = CGRectMake(140, 95, fourtharyView.frame.size.width, fourtharyView.frame.size.height);
    fourtharyView.hidden = NO;
}

- (IBAction)closeAction2:(id)sender
{
    fourtharyView.hidden = YES;
    thirdShadeView.alpha=0;
}

@end
