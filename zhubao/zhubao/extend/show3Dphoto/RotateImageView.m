//
//  RotateImageView.m
//  testUIImageRotate
//
//  Created by very good on 14-6-26.
//  Copyright (c) 2014年 dengdeng. All rights reserved.
//

#import "RotateImageView.h"

@implementation RotateImageView

@synthesize current;
@synthesize numberOfImages;
@synthesize animationImages;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setBackgroundColor:[UIColor blackColor]];
        self.contentMode=UIViewContentModeScaleAspectFit;
    }
    return self;
}

-(void)initTimer{
    
    /*UISwipeGestureRecognizer *recognizer;
    
    recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeFromRight)];
    [recognizer setDirection:(UISwipeGestureRecognizerDirectionRight)];
    [self addGestureRecognizer:recognizer];
    
    recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeFromLeft)];
    [recognizer setDirection:(UISwipeGestureRecognizerDirectionLeft)];
    [self addGestureRecognizer:recognizer];*/
    
    timer= [NSTimer scheduledTimerWithTimeInterval:0.08 target:self selector:@selector(setNextImage) userInfo:Nil repeats:YES];
}

-(void)stopTimer{
    
    //取消定时器
    @try {
        [timer invalidate];
        timer = nil;
        
        animationImages=nil;
    }
    @catch (NSException *exception) {
        
    }
}

-(void)setNextImage{
    if(current>numberOfImages){
        current=0;
    }
    
    [self setImage:[animationImages objectAtIndex:current]];
    
    current++;
}

-(void)setpreviousImage{
    if(current<0){
        current=numberOfImages;
    }
    
    [self setImage:[animationImages objectAtIndex:current]];
    
    current--;
}

-(void)setRotate:(BOOL)flag{
    if(flag){
        [timer setFireDate:[NSDate distantPast]];
    }else{
        [timer setFireDate:[NSDate distantFuture]];
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    NSDate *today=[[NSDate alloc]init];
    [timer setFireDate:[today dateByAddingTimeInterval:5]];
    
    [super touchesBegan:touches withEvent:event];
    
    UITouch *touch=[[event allTouches]anyObject];
    CGPoint touchLocation=[touch locationInView:self];
    
    previous=touchLocation.x;
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesMoved:touches withEvent:event];
    
    UITouch *touch=[[event allTouches]anyObject];
    CGPoint touchLocation=[touch locationInView:self];
    
    int location=touchLocation.x;
    
    //
    if(location-previous>100){
        [timer invalidate];
        timer= [NSTimer scheduledTimerWithTimeInterval:0.08 target:self selector:@selector(setpreviousImage) userInfo:Nil repeats:YES];
    }else if(location-previous<-100){
        [timer invalidate];
        timer= [NSTimer scheduledTimerWithTimeInterval:0.08 target:self selector:@selector(setNextImage) userInfo:Nil repeats:YES];
    }
    
    
    if(location<previous){
        current+=1;
    }else{
        current-=1;
    }
    
    previous=location;
    
   
    if(current>numberOfImages){
        current=0;
    }
    if(current<0){
        current=numberOfImages;
    }
    
    [self setImage:[animationImages objectAtIndex:current]];
}

/*-(void)swipeFromLeft{

}

-(void)swipeFromRight{

}*/

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
