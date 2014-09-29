//
//  myindex.m
//  zhubao
//
//  Created by moko on 14-9-22.
//  Copyright (c) 2014年 SUNYEARS___FULLUSERNAME. All rights reserved.
//

#import "myindex.h"

@interface myindex ()

@end

@implementation myindex

@synthesize fourthView;
@synthesize biglogo;
@synthesize aboutus;
UISwipeGestureRecognizer *recognizer;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    NSString *logopath = [[Tool getTargetFloderPath] stringByAppendingPathComponent:[NSString stringWithFormat:@"logopath.png"]];
    
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:logopath]) {
        [biglogo setImage:[[UIImage alloc] initWithContentsOfFile:logopath] forState:UIControlStateNormal];
    }
    else {
        [biglogo setImage:[UIImage imageNamed:@"logoshengyu"] forState:UIControlStateNormal];
    }

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    //web标签背景色透明
    aboutus.backgroundColor = [UIColor clearColor];
    aboutus.opaque = NO;
    //[aboutus setUserInteractionEnabled: YES ];	 //是否支持交互
    [aboutus setDelegate:self];				 //委托document.body.style.webkitTouchCallout='none'
    [aboutus stringByEvaluatingJavaScriptFromString:@"document.body.style.webkitUserSelect='none';"];
    // Disable callout
    [aboutus stringByEvaluatingJavaScriptFromString:@"document.body.style.webkitTouchCallout='none';"];
    
    //设置了左右滑动
    //    UISwipeGestureRecognizer *recognizer;
    //
    //    recognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom:)];
    //    [recognizer setDirection:(UISwipeGestureRecognizerDirectionRight)];
    //    aboutus.delegate = self;
    //    [[self view] addGestureRecognizer:recognizer];
    //    [aboutus addGestureRecognizer:recognizer];
    
    recognizer= [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom:)];
    recognizer.delegate=self;
    [recognizer setDirection:(UISwipeGestureRecognizerDirectionRight)];
    recognizer.cancelsTouchesInView=NO;
    [[self view] addGestureRecognizer:recognizer];
    
    //    recognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom:)];
    //    [recognizer setDirection:(UISwipeGestureRecognizerDirectionLeft)];
    //    [[self view] addGestureRecognizer:recognizer];
    
    //    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeLeftAction)];
    //    swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    //    swipeLeft.delegate = self;
    //    [webView addGestureRecognizer:swipeLeft];
    
    //更新ui(如果已经存在的，则不再自动更新)
    [self loadmyInfo];
}



//更新ui
-(void)loadmyInfo
{
    @try {
        
        NSString *logopath = [[Tool getTargetFloderPath] stringByAppendingPathComponent:[NSString stringWithFormat:@"logopath.png"]];
        
        
        if ([[NSFileManager defaultManager] fileExistsAtPath:logopath]) {
            [biglogo setImage:[[UIImage alloc] initWithContentsOfFile:logopath] forState:UIControlStateNormal];
        }
        else {
            [biglogo setImage:[UIImage imageNamed:@"logoshengyu"] forState:UIControlStateNormal];
        }
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            // 耗时的操作（异步操作）
            bool isexists=true;
            if (![[NSFileManager defaultManager] fileExistsAtPath:logopath]){
                myApi *myapi=[[myApi alloc]init];
                [myapi getMyInfo];
                isexists=false;
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                // 更新界面（处理结果）
                
                if (!isexists){
                    
                    sleep(1);//等1秒再执行
                    
                    [self.parentViewController.self performSelector:@selector(updateIndexUI)];
                    
                    if ([[NSFileManager defaultManager] fileExistsAtPath:logopath]) {
                        [biglogo setImage:[[UIImage alloc] initWithContentsOfFile:logopath] forState:UIControlStateNormal];
                    }
                    else {
                        [biglogo setImage:[UIImage imageNamed:@"logoshengyu"] forState:UIControlStateNormal];
                    }
                }
            });
        });
        
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
    
}


- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    return YES;
}
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    return YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    // Disable user selection
    [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitUserSelect='none';"];
    // Disable callout
    [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitTouchCallout='none';"];
}

-(void)handleSwipeFrom:(UISwipeGestureRecognizer *)recognizer{
    
    if(recognizer.direction==UISwipeGestureRecognizerDirectionLeft) {
        
        NSLog(@"swipe left");
        //执行程序
        
    }
    
    if(recognizer.direction==UISwipeGestureRecognizerDirectionRight) {
        
        NSLog(@"swipe right");
        //执行程序
        [fourthView setHidden:YES];
        [biglogo setHidden:NO];
    }
    
}

//关于我们
-(IBAction)openaboutus:(id)sender
{
    NSString *filePath = [[Tool getTargetFloderPath] stringByAppendingPathComponent:[NSString stringWithFormat:@"about.webarchive"]];
    NSURL *aURL = [NSURL fileURLWithPath:filePath];
    NSURLRequest *request = [NSURLRequest requestWithURL:aURL];
    //AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    fourthView.hidden=NO;
    //NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:myDelegate.myinfol.details]];
    [aboutus loadRequest:request];
    aboutus.scrollView.delegate=self;
    [aboutus.scrollView setShowsHorizontalScrollIndicator:NO];
    
    [fourthView setHidden:NO];
    [biglogo setHidden:YES];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.x > 0)
        scrollView.contentOffset=CGPointMake(0, scrollView.contentOffset.y);
}

-(IBAction)closeaboutus:(id)sender
{
    fourthView.hidden=YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
