//
//  RotateImageView.h
//  testUIImageRotate
//
//  Created by very good on 14-6-26.
//  Copyright (c) 2014年 dengdeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RotateImageView : UIImageView{
    NSTimer *timer;
    NSInteger current;
    NSInteger numberOfImages;
    int previous;
}

@property NSInteger current;
@property NSInteger numberOfImages;
@property (strong,nonatomic) NSMutableArray *animationImages;

-(void)initTimer;
-(void)setNextImage;
-(void)setRotate:(BOOL)flag;
-(void)stopTimer;

@end
