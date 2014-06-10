//
//  FVImageSequenceDemoViewController.h
//  FVImageSequenceDemo
//
//  Created by Fernando Valente on 12/19/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FVImageSequence.h"

@interface FVImageSequenceDemoViewController : UIViewController {
	IBOutlet FVImageSequence *imageSquence;
}

@property(retain , nonatomic) NSString * code;//

- (IBAction)goAction:(id)sender;

@end

