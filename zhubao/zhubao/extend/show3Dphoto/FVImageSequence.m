//
//  FVImageSequence.m
//  Untitled
//
//  Created by Fernando Valente on 12/19/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FVImageSequence.h"


@implementation FVImageSequence
@synthesize prefix, numberOfImages, extension, increment;

-(void)doRotate:(BOOL)flag{
    if(flag){
        [self startAnimating];
    }else{
        [self stopAnimating];
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
	if(increment == 0)
		increment = 1;
	[super touchesBegan:touches withEvent:event];
	
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint touchLocation = [touch locationInView:self];
	
	previous = touchLocation.x;
    
    [self doRotate:false];
}

-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesCancelled:touches withEvent:event];
    
    //[self doRotate:true];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesEnded:touches withEvent:event];
    
    [self doRotate:true];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	[super touchesMoved:touches withEvent:event];
	
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint touchLocation = [touch locationInView:self];
	
	int location = touchLocation.x;
	
	if(location < previous)
		current += increment;
	else
		current -= increment;
	
	previous = location;
	
	if(current > numberOfImages)
		current = 0;
	if(current < 0)
		current = numberOfImages;

	//NSString *path = [NSString stringWithFormat:@"%@%d", prefix, current];
    
    NSString * currents=@"";
    if (current<10) {
        if(current==0)current=1;
        currents=[NSString stringWithFormat:@"00%d",current];
    }else if(current>=10){
        currents=[NSString stringWithFormat:@"0%d",current];
    }
    
    NSString *path = [NSString stringWithFormat:@"%@%@", prefix, currents];
    NSLog(@"%@", path);
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *dcoumentpath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
    // 解压缩文件夹路径
    NSString* unzipPath = [dcoumentpath stringByAppendingString:@"/images"];
    
    NSLog(@"---------------本地的图片:%@", [NSString stringWithFormat:@"%@/%@.%@",unzipPath,path,extension]);
    
    //NSData *data = [NSData dataWithContentsOfFile:[NSString stringWithFormat:@"%@/%@.%@",unzipPath,path,extension]];
	
	//path = [[NSBundle mainBundle] pathForResource:path ofType:extension];
	
	
	UIImage *img =  [[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/%@.%@",unzipPath,path,extension]];//[UIImage imageWithData:data];
	
	[self setImage:img];
	
	//[img release];
}


@end
