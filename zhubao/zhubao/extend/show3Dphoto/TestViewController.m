//
//  TestViewController.m
//  testTimer
//
//  Created by very good on 14-6-10.
//  Copyright (c) 2014年 dengdeng. All rights reserved.
//

#import "TestViewController.h"

@interface TestViewController ()

@end

@implementation TestViewController

@synthesize code;

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
    
    //定制导航栏左按钮
    UIImage* image= [UIImage imageNamed:@"close"];
    CGRect frame_1= CGRectMake(self.view.frame.size.width+50, 10, 48, 48);
    UIButton* btnBack= [[UIButton alloc] initWithFrame:frame_1];
    [btnBack setBackgroundImage:image forState:UIControlStateNormal];
    //[btnBack setTitle:@"返回" forState:UIControlStateNormal];
    //[btnBack setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //btnBack.titleLabel.font=[UIFont systemFontOfSize:16];
    [btnBack addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
	// Do any additional setup after loading the view.
//    CGRect frame= CGRectMake(0, 0, self.view.frame.size.width+220, self.view.frame.size.height-420);
//    UIImageView *animView=[[UIImageView alloc]initWithFrame:frame];
    UIImageView *animView=[[UIImageView alloc]initWithFrame:CGRectMake(self.view.center.x/2, 0, self.view.frame.size.width*0.8, self.view.frame.size.height*0.8)];
    animView.backgroundColor=[UIColor redColor];
    animView.contentMode=UIViewContentModeScaleAspectFill;

    NSMutableArray *imgArray = [NSMutableArray arrayWithCapacity:10];
    for(int i=1;i<60;i++){
        NSString *strApend;
        if(i<9)
            strApend=@"00";
        else
            strApend=@"0";
        
        NSString *path = [NSString stringWithFormat:@"%@_%@%d.jpg", code, strApend,i];
        NSLog(@"%@", path);
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *dcoumentpath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
        // 解压缩文件夹路径
        NSString* unzipPath = [dcoumentpath stringByAppendingString:@"/images"];
        
        NSLog(@"---------------本地的图片:%@", [NSString stringWithFormat:@"%@/%@",unzipPath,path]);
        
        NSData *data = [NSData dataWithContentsOfFile:[NSString stringWithFormat:@"%@/%@",unzipPath,path]];
        
        UIImage *img =  [UIImage imageWithData:data];//[[UIImage alloc] initWithContentsOfFile:path];
        if(img)[imgArray addObject:img];
    }
    //[animView.animationImages initWithArray:imgArray];
    if(imgArray.count>0){
        animView.animationImages=imgArray;
        
        animView.animationDuration=8;
        animView.animationRepeatCount = 0;
        animView.backgroundColor=[UIColor whiteColor];
        [self.view addSubview:animView];
        [animView startAnimating];
    }
    
    [self.view addSubview:btnBack];
}

- (void)back
{
    //[self.navigationController popViewControllerAnimated:YES];
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end





