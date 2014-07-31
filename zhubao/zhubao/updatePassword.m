//
//  updatePassword.m
//  zhubao
//
//  Created by johnson on 14-7-31.
//  Copyright (c) 2014年 SUNYEARS___FULLUSERNAME. All rights reserved.
//

#import "updatePassword.h"

@interface updatePassword ()

@end

@implementation updatePassword

@synthesize affirmpassword;
@synthesize oldpassword;
@synthesize newpassword;

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

-(IBAction)closeupdatepassword:(id)sender
{
    [_mydelegate performSelector:@selector(closesc)];
}

//密码修改
-(IBAction)updatepassword:(id)sender
{
    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    sqlService *sql=[[sqlService alloc]init];
    customer *newnam=[sql getCustomer:myDelegate.entityl.uId];
    
    if ([[Commons md5:[NSString stringWithFormat:@"%@",oldpassword.text]]  isEqualToString:myDelegate.entityl.userPass]) {
        
        if(![[NSString stringWithFormat:@"%@",newpassword.text] isEqualToString:[NSString stringWithFormat:@"%@",affirmpassword.text]]){
            NSString *rowString =@"两次输入密码不一致！";
            UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示" message:rowString delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alter show];
            return;
        }
        
        newnam.userPass=[Commons md5:[NSString stringWithFormat:@"%@",newpassword.text]];
        newnam.oldpassword=[Commons md5:[NSString stringWithFormat:@"%@",oldpassword.text]];
        sql=[[sqlService alloc]init];
        customer *updatesuccess=[sql updateCustomerPasswrod:newnam];
        if (updatesuccess) {
            NSString *rowString =@"修改成功！";
            UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示" message:rowString delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alter show];
            myDelegate.entityl.userPass=[Commons md5:[NSString stringWithFormat:@"%@",newpassword.text]];
        }else{
            NSString *rowString =@"修改失败！";
            UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示" message:rowString delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alter show];
        }
    }else{
        NSString *rowString =@"请输入正确的原密码！";
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
