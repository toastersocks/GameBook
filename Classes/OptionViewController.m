//
//  OptionViewController.m
//  GameBook
//
//  Created by James Pamplona on 10/18/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "OptionViewController.h"

	//!!!: THIS CLASS IS NOT USED ANYMORE
@implementation OptionViewController

@synthesize optionContainer;
@synthesize options;


- (void) setOptions: (NSArray *)inOptions {
	if (options != inOptions) {
		[options release];
		options	= [inOptions retain];
		NSLog(@"Setting options to:\n%@", options);

	}
	NSLog(@"Options not set");
	
		//NSLog(@"the array of UIButtons is: %@", [self.optionContainer subviews]);
	NSArray *optionButtonsArray = [self.optionContainer subviews];
	
	NSInteger index = 0;
		//	NSLog(@"optionButtonsArray is: %i", [optionButtonsArray count]);
		//	NSLog(@"options is: %i", [options count]);
		//	NSLog(@"Statement is: %@", ( [options count] < index ));
	
	for (UIButton *optionButton in optionButtonsArray) {
		if ( !( ([inOptions count] -1) < index ) ) { 
				//NSLog(@"I guess it was true");
			optionButton.hidden = NO;
			[optionButton setTitle: [[options objectAtIndex: index] valueForKey: @"optionText" ] forState: UIControlStateNormal];//<--TO DO: break this up into multiple lines with intermediate variables, so I can understand what the hell it does 6 months from now. // options is an array of arrays. each member array has two objects. the first is the text of the option and the second is the page index it points to. should probably try to eventually use one dictionary with the page index as the key and the option text as value, or visa-versa. OR MAYBE NOT. tried it. same issues one way or another. An ordered dictionary would actually be pretty awesome for this. 
			
			[optionButton sizeToFit];
		} else {
				//[optionButton removeFromSuperview];
			optionButton.hidden = YES;
		}
		
		index++;
		
	}
}

/*
- (void) displayOptions: (NSArray *)inOptions {
	//NSLog(@"the array of UIButtons is: %@", [self.optionContainer subviews]);
	NSArray *optionButtonsArray = [self.optionContainer subviews];
	
	NSInteger index = 0;
		//	NSLog(@"optionButtonsArray is: %i", [optionButtonsArray count]);
		//	NSLog(@"options is: %i", [options count]);
		//	NSLog(@"Statement is: %@", ( [options count] < index ));

	for (UIButton *optionButton in optionButtonsArray) {
		if ( !( ([inOptions count] -1) < index ) ) { 
			//NSLog(@"I guess it was true");
			optionButton.hidden = NO;
			[optionButton setTitle: [[inOptions objectAtIndex: index] valueForKey: @"optionText" ] forState: UIControlStateNormal];//<--TO DO: break this up into multiple lines with intermediate variables, so I can understand what the hell it does 6 months from now. // options is an array of arrays. each member array has two objects. the first is the text of the option and the second is the page index it points to. should probably try to eventually use one dictionary with the page index as the key and the option text as value, or visa-versa. OR MAYBE NOT. tried it. same issues one way or another. An ordered dictionary would actually be pretty awesome for this. 
			
			[optionButton sizeToFit];
		} else {
			//[optionButton removeFromSuperview];
			optionButton.hidden = YES;
		}

		index++;
		
	}
}

*/

@end
