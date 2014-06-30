//
//  FVImageSequenceDemoViewController.m
//  FVImageSequenceDemo
//
//  Created by Fernando Valente on 12/19/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FVImageSequenceDemoViewController.h"

@implementation FVImageSequenceDemoViewController

@synthesize code;

- (void)viewDidLoad {
    [super viewDidLoad];

    UIImage* image= [UIImage imageNamed:@"close"];
    CGRect frame_1= CGRectMake(self.view.frame.size.width+300, 10, 48, 48);
    UIButton* btnBack= [[UIButton alloc] initWithFrame:frame_1];
    [btnBack setBackgroundImage:image forState:UIControlStateNormal];
    //[btnBack setTitle:@"返回" forState:UIControlStateNormal];
    //[btnBack setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //btnBack.titleLabel.font=[UIFont systemFontOfSize:16];
    [btnBack addTarget:self action:@selector(goAction:) forControlEvents:UIControlEventTouchUpInside];
    
	//Set slides extension
	[imageSquence setExtension:@"jpg"];
	
	//Set slide prefix prefix
	//[imageSquence setPrefix:@"Seq_v04_640x378_"];
    [imageSquence setPrefix:[NSString stringWithFormat:@"%@_",code]];
	
	//Set number of slides
	[imageSquence setNumberOfImages:60];
    
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
        
        //NSData *data = [NSData dataWithContentsOfFile:[NSString stringWithFormat:@"%@/%@",unzipPath,path]];
        
        UIImage *img =  [[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/%@",unzipPath,path]];//[UIImage imageWithData:data];
        if(img)[imgArray addObject:img];
    }
    
    if(imgArray.count>0){
        imageSquence.animationImages=imgArray;
        
        imageSquence.animationDuration=3;
        imageSquence.animationRepeatCount = 0;
        //[imageSquence startAnimating];
        [imageSquence doRotate:TRUE];
    }
    
    [self.view addSubview:btnBack];

}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	if(interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight)
		return YES;
	return NO;
}

-(IBAction)goAction:(id)sender
{
    //[self dismissViewControllerAnimated:YES completion:nil];
    
    [self.navigationController popViewControllerAnimated:NO];
}


@end
