//
//  TextView.m
//  GameBook
//
//  Created by James Pamplona on 11/28/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "TextView.h"
#import "Constants.h"
#import "PassTouchButton.h"

#import <QuartzCore/QuartzCore.h>

	//TODO: create a 'resize' method that resizes the various elements appropriately. OR even better just returns the optimum size of the various elements, and another method that actualy does the resizing. 


@implementation TextView

@synthesize text;
@synthesize options;
@synthesize pageContents;
@synthesize mainTextView;
@synthesize optionsContainer;

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
		margins = 20;
		
        mainTextView = [[UITextView alloc] initWithFrame: CGRectMake(margins, margins, self.bounds.size.width - margins*2, 565)];
			//text = mainTextView.text;
		mainTextView.editable = NO;
		mainTextView.scrollEnabled = NO;
		mainTextView.font = [UIFont fontWithName:@"Helvetica" size: 17.0];
		mainTextView.backgroundColor = [UIColor clearColor];
		self.userInteractionEnabled = YES;

		//optionsContainer = [[UIView alloc] initWithFrame: CGRectMake(20, 454, 472, 294)]; //frame height-> 294)];
		optionsContainer = [[UIView alloc] initWithFrame: CGRectMake(margins, 454, self.bounds.size.width - margins*2, 294)];
		optionsContainer.userInteractionEnabled = YES;
		self.layer.opaque = YES;
		self.optionsContainer.layer.opaque = YES;
		self.mainTextView.layer.opaque = YES;
		  //	mainTextView.backgroundColor = [UIColor redColor]; //debug
		  //	  optionsContainer.backgroundColor = [UIColor greenColor]; //debug

			//optionsContainer.backgroundColor = [UIColor whiteColor];
		
		[self addSubview: mainTextView];
		[self addSubview: optionsContainer];
			// Initialization code
    }
    return self;
}

- (void) setPageContents: (NSDictionary *)inPageContents {
		//NSLog(@"inLayout:\n%@", inLayout);
	if (pageContents != inPageContents) {
			//NSLog(@"layout set...");
		[pageContents release];
		pageContents = [inPageContents retain];
	}
	self.text = [pageContents valueForKey: @"text"];
	if ([pageContents valueForKey: @"options"]) {
		self.options = [pageContents valueForKey: @"options"];
	} else {
		NSLog(@"No options to set");
		self.options = nil; // TODO: change to nil
	}

	
}

- (void) setTag:(NSInteger) inTag {
	super.tag = inTag;
	optionsContainer.tag = self.tag;
}


- (void) setText:(NSString *) inMainText {
		//NSLog(@"inMainText is:\n%@", inMainText);
	if (text != inMainText) {
		[text release];
		text = [inMainText retain];
			//NSLog(@"Set text...");
	}
		//NSLog(@"text set?");
	mainTextView.text = text;
	[mainTextView sizeToFit];
	
}

- (NSString *) text {
	return mainTextView.text;
}


- (void) setOptions:(NSArray *) inOptions {
	if (options	!= inOptions) {
		[options release];
		options = [inOptions retain];
		NSLog(@"Setting Options...");
	}
		//NSLog(@"Options are: %@", options);
	
	if (!options) { //if there are no options, shrink the options container
					//optionsContainer.bounds = CGRectMake(0, 0, 1, 1);
		self.optionsContainer.hidden = YES;
		NSLog(@"No Options: Shrinking the optionsContainer");
		
	} else {
		if (self.tag == OBJECT_POPUP_TEXT) {
			CGRect textViewFrame = self.bounds;
			textViewFrame.size.width = POPUP_WIDTH;
			self.bounds = textViewFrame;
			self.backgroundColor = [UIColor whiteColor];
		}
		CGSize maximumLabelSize = CGSizeMake(optionsContainer.bounds.size.width, 200);
		NSLog(@"textView: self.bounds.size.width is: %f", self.bounds.size.width);

				

		
			//NSInteger index = 0;
		nextButtonYLocation = 10;
		for (NSDictionary *option in options) {
//			PassTouchButton *button = [PassTouchButton buttonWithType: UIButtonTypeCustom];
			PassTouchButton *button = [PassTouchButton buttonWithType: UIButtonTypeCustom];
				//UIButton *button = [UIButton buttonWithType: UIButtonTypeCustom ];
//			PassTouchButton *button = [PassTouchButton buttonWithType: UIButtonTypeRoundedRect ];//debug
			
				//Button Looks
			button.titleLabel.lineBreakMode = UILineBreakModeWordWrap;
			button.titleLabel.numberOfLines = 0;
			button.titleLabel.font = [UIFont fontWithName:@"Helvetica" size: 17];
			[button setTitleColor: [UIColor blackColor] 
						 forState: UIControlStateNormal];
				//button.backgroundColor = [UIColor grayColor];

			NSLog(@"OptionText is: %@", [option valueForKey: @"optionText"]);
			
			CGSize expectedLabelSize = [ [option valueForKey: @"optionText"] sizeWithFont: button.titleLabel.font 
																		constrainedToSize: maximumLabelSize 
																			lineBreakMode: button.titleLabel.lineBreakMode]; 

			NSLog(@"maximum size for the button is: %f, %f", maximumLabelSize.width, maximumLabelSize.height);
			NSLog(@"expected size for the button is: %f, %f", expectedLabelSize.width, expectedLabelSize.height);
			
				//NSLog(@"Helvetica fonts are:\n%@", [UIFont fontNamesForFamilyName: @"Helvetica"]);
			
			button.option = option;
			[button setTitle: [option valueForKey: @"optionText"]
					forState: UIControlStateNormal]; 
			
			
			
			
			CGRect newFrame = button.titleLabel.frame;
				//newFrame.size.height = expectedLabelSize.height;
				//button.titleLabel.frame = newFrame;

			newFrame.origin.y = nextButtonYLocation;
			button.titleLabel.frame = newFrame;

			if (self.frame.origin.x > 480 && self.tag != OBJECT_POPUP_TEXT) {
				button.frame = CGRectMake(optionsContainer.bounds.size.width - expectedLabelSize.width - 10,
										  nextButtonYLocation,
										  expectedLabelSize.width + 10, 
										  expectedLabelSize.height + 10); // <-- magic number is to give the button a little margin 
			} else {			
				button.frame = CGRectMake(0,
										  nextButtonYLocation,
										  expectedLabelSize.width + 10, 
										  expectedLabelSize.height + 10); // <-- magic number is to give the button a little margin around the text, otherwise it's exactly the size of the text.
			}
			 
				//	[button.titleLabel sizeToFit]; // <-- this causes the buttons to always be one line tall, even when there is more text than can fit in one line. Seems like this shouldn't be the case. sizeToFit is turning out to be pretty useless in most situations...
			
			nextButtonYLocation = button.frame.origin.y + button.frame.size.height + 10;
			
//			[button addTarget: NULL 
//					   action: @selector(getChosenOption:) 
//			 forControlEvents: UIControlEventTouchUpInside];

			[button addTarget: NULL 
					   action: @selector(getChosenOption:) 
			 forControlEvents: UIControlEventTouchDown];
			
			
			[optionsContainer addSubview: button];
		}
			//keep the options at the bottom of the page
		optionsContainer.frame = CGRectMake(margins, 
											optionsContainer.frame.origin.y + (optionsContainer.frame.size.height - nextButtonYLocation),
											self.bounds.size.width - margins*2, 
											nextButtonYLocation);
	}
	
	[self layoutSubviews];
	
}


- (void)layoutSubviews {
	CGSize maximumTextViewSize = CGSizeMake(self.bounds.size.width - margins * 2, self.bounds.size.height - margins * 2);
	CGSize expectedTextViewSize = [self.text sizeWithFont: self.mainTextView.font 
										constrainedToSize: maximumTextViewSize 
											lineBreakMode: UILineBreakModeWordWrap]; 
	

	self.mainTextView.frame = CGRectMake(margins, margins, self.bounds.size.width - margins * 2, expectedTextViewSize.height + 100);
	
	
	if (self.tag == OBJECT_POPUP_TEXT) {
		CGRect textViewFrame = self.bounds;
		textViewFrame.size.width = POPUP_WIDTH;
		self.bounds = textViewFrame;
//		self.backgroundColor = [UIColor whiteColor];
	
	
		if (!self.options) {
			self.optionsContainer.hidden = YES;
				//optionsContainer.bounds = CGRectMake(0, 0, 1, 1);
			
		} else {
			
			self.optionsContainer.hidden = NO;
			CGRect optionsFrame = self.optionsContainer.frame;
			optionsFrame.origin.y = self.mainTextView.frame.size.height + 10;
			optionsFrame.size.width = self.mainTextView.frame.size.width;
			self.optionsContainer.frame = optionsFrame;
			
			
		}
	}	
}



/*


- (CGSize) sizeThatFits: (CGSize)size {
		// TODO: Clean up this method. Some of this shit might not even do anything...
		//self.mainTextView.scrollEnabled = NO;
	CGRect textFrame = self.mainTextView.frame;
	
		//[self.mainTextView sizeToFit];
	
	NSLog(@"contentSize.width is %f", self.mainTextView.contentSize.width);
		//NSLog(@"text size is)
	
//	if ( self.mainTextView.contentSize.width < (size.width - 40) ) {
//		textFrame.size.width = self.mainTextView.contentSize.width;
//	}
	CGSize maximumTextViewSize = CGSizeMake(self.bounds.size.width - margins*2, 768);

	
	
	
		//CGSize expectedTextViewSize = [ [text] si
	
	
	CGSize expectedTextViewSize = [self.text sizeWithFont: self.mainTextView.font 
																constrainedToSize: maximumTextViewSize 
																	lineBreakMode: UILineBreakModeWordWrap]; 
	
	
	NSLog(@"expected size for mainTextView is: %f, %f", expectedTextViewSize.width, expectedTextViewSize.height);

	
	if ( [self.text sizeWithFont: self.mainTextView.font 
			   constrainedToSize: size].width < (size.width - margins*2) ) {
		textFrame.size.width = [self.text sizeWithFont: self.mainTextView.font 
									 constrainedToSize: size].width;
		textFrame.size.height = 400;
	}	
	else {
		textFrame.size.width = size.width - margins*2;

	}
	
	self.mainTextView.frame = textFrame;
	[self.mainTextView sizeToFit];
		//textFrame = self.mainTextView.frame;
	
	
		//[self.mainTextView setContentSize:CGSizeMake(self.mainTextView.contentSize.width, self.mainTextView.contentSize.height - 24)];
	
	
	if (!self.options) {
		self.optionsContainer.hidden = YES;
			//optionsContainer.bounds = CGRectMake(0, 0, 1, 1);
		
	} else {
		CGRect optionsFrame = self.optionsContainer.frame;
		optionsFrame.origin.y = self.mainTextView.frame.size.height + 10;
		optionsFrame.size.width = self.mainTextView.frame.size.width;
		self.optionsContainer.frame = optionsFrame;
		
	}
	
	
		//textFrame.size.height -= 24;
		//textFrame.origin.x = 20;
		//	textFrame.size.height += 24;
		//textFrame.origin.y = 10;
		//self.mainTextView.bounds = textFrame;
		//	[self.mainTextView scrollRectToVisible:<#(CGRect)rect#> animated:<#(BOOL)animated#>
		//[self.mainTextView scrollRangeToVisible:NSMakeRange(0, [mainTextView.text length])];
	NSLog(@"textview width is %f", self.mainTextView.bounds.size.width);
		//[self.mainTextView setContentOffset: CGPointMake(0, 0) animated: NO];
		//self.mainTextView.contentSize = textFrame.size;
	
		//self.bounds = CGRectMake(0, 0, self.mainTextView.bounds.size.width, self.mainTextView.bounds.size.height + self.optionsContainer.bounds.size.height + 40);
	CGSize sizeThatFitsPopup = CGSizeMake (self.mainTextView.bounds.size.width + margins*2, 
										   self.mainTextView.bounds.size.height + self.optionsContainer.bounds.size.height + margins*2);
	NSLog(@"The content size to fit in a popup is: width: %f, height: %f", sizeThatFitsPopup.width, sizeThatFitsPopup.height);
		//self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, sizeThatFitsPopup.width, sizeThatFitsPopup.height);
	return sizeThatFitsPopup;
}

*/

/*
- (void) sizeToFitPopup {
	
}
*/


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)dealloc {
	[pageContents release];
	[text release];
	[options release];
		//layout;
	[mainTextView release];
	[optionsContainer release];
    [super dealloc];
}


@end


