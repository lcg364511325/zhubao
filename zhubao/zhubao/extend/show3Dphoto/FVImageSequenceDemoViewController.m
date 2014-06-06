//
//  FVImageSequenceDemoViewController.m
//  FVImageSequenceDemo
//
//  Created by Fernando Valente on 12/19/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FVImageSequenceDemoViewController.h"

@implementation FVImageSequenceDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	
	//Set slides extension
	[imageSquence setExtension:@"jpg"];
	
	//Set slide prefix prefix
	[imageSquence setPrefix:@"Seq_v04_640x378_"];
	
	//Set number of slides
	[imageSquence setNumberOfImages:72];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	if(interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight)
		return YES;
	return NO;
}


@end
