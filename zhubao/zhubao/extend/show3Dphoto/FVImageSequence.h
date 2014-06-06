//
//  FVImageSequence.h
//  Untitled
//
//  Created by Fernando Valente on 12/19/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface FVImageSequence : UIImageView {
	NSString *prefix;
	int numberOfImages;
	int current;
	int previous;
	NSString *extension;
	int increment;
}

@property (readwrite) int increment;
@property (readwrite, copy) NSString *extension;
@property (readwrite, copy) NSString *prefix;
@property (readwrite) int numberOfImages;

@end
