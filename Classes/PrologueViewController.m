    //
//  PrologueViewController.m
//  GameBook
//
//  Created by James Pamplona on 10/22/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "PrologueViewController.h"
	//#import "WaxLua.h"
#import <QuartzCore/QuartzCore.h>

	//#import <unistd.h>

@implementation PrologueViewController

@synthesize prologueTextLabel;
@synthesize doneWithPrologueButton;
@synthesize prologueText;
	//@synthesize lua;


- (IBAction) dismissPrologue {
		//[self dismissModalViewControllerAnimated: YES]; // animated is YES for now, just to have a transition placeholder until a custom one is implemented. 
		//[self.delegate dismissPrologue];
		//[delegate crossfadeTo: [[self delegate] prologueViewController] duration: 2.0];
	[delegate newGame: self];
}

- (void) beginPrologueWithCursorScroll {
	doneWithPrologueButton.alpha = 0.0f;

	
	padding = [NSMutableString stringWithString: @""];
	[padding retain];
	
	path = [[NSBundle mainBundle] pathForResource: @"prologue" ofType: @"txt"];
	prologueText = [NSString stringWithContentsOfFile:path
							  encoding:NSUTF8StringEncoding
								 error:NULL];
	LogMessage(@"prologue", 0, @"prologueText instance is: %p", prologueText);
	
	
	
	/*  // this code is unneeded now I think
		//count the number of lines
	unsigned numberOfLines, index, stringLength = [prologueText length];
	for (index = 0, numberOfLines = 0; index < stringLength; numberOfLines++) {
		index = NSMaxRange([prologueText lineRangeForRange:NSMakeRange(index, 0)]);
	}
		//numberOfLines = 10;
	
		//for (index = 0; index < numberOfLines; index++) {

	*/
	
	for (int index = 0; index < 27; index++) {
		[padding appendString: @"\n"];
	}
	
	prologueTextLength = [prologueText length];
		//	char buffer[len + 1];
		//	unichar buffer[prologueTextLength + 1];
	delay = 0.00;
		//This way:
		//strncpy(buffer, [prologueText UTF8String]);
	
		//Or this way (preferred):
	
		//	[prologueText getCharacters:buffer range:NSMakeRange(0, prologueTextLength)];
	
	
	for(prologueTextIndex = 0; prologueTextIndex < prologueTextLength; ++prologueTextIndex) {
		currentChar = [prologueText characterAtIndex: prologueTextIndex];

		[self performSelector: @selector(printPrologueTextWithCursor) withObject: nil afterDelay: delay];
		
		[[NSRunLoop currentRunLoop] runUntilDate:[[NSDate date] addTimeInterval: delay] ];
		
		if (currentChar == '\n' || (currentChar == '.' && [prologueText characterAtIndex: prologueTextIndex + 1] == '.') || (currentChar == '.' && [prologueText characterAtIndex: prologueTextIndex - 1] == '.') ) {
			delay = 1;
		
			if (currentChar == '\n') {
				if ([padding length] > 1) {
					[padding deleteCharactersInRange: NSMakeRange(0, 1)];
				} 
				else {
					
					NSLog(@"The location of the newline is %i", [prologueText rangeOfString:@"\n"].location);
					int cutoutPartLength = [prologueText rangeOfString: @"\n"].location + 1;
					self.prologueText = [prologueText substringFromIndex: cutoutPartLength];
						// prologueText = [prologueText substringFromIndex: [prologueText rangeOfString: @"\n"].location + 1];
					prologueTextIndex -= cutoutPartLength;

					prologueTextLength = [prologueText length];					
				}			
			
			}
//			else if (currentChar == '…') {
//				
//				
//			}
		}
		else {
			delay = 0.00;
		}
//		[self performSelector: @selector(printChar) withObject: nil afterDelay: delay];
//
//		[[NSRunLoop currentRunLoop] runUntilDate:[[NSDate date] addTimeInterval: delay] ];
			//		[self performSelector: @selector(printChar) withObject: nil afterDelay: delay];


	}
	[[NSRunLoop currentRunLoop] runUntilDate:[[NSDate date] addTimeInterval: delay] ];
	[UIView beginAnimations:@"buttonAppear" context:nil];
	[UIView setAnimationDuration: 2.0f];
	doneWithPrologueButton.alpha = 1.0f;
	[UIView commitAnimations];
	
}

- (void) beginPrologueWithLineScroll {
	doneWithPrologueButton.alpha = 0.0f;
	
	
	padding = [NSMutableString stringWithString: @""];
	[padding retain];
	
	path = [[NSBundle mainBundle] pathForResource: @"prologue" ofType: @"txt"];
	self.prologueText = [NSString stringWithContentsOfFile:path
											   encoding:NSUTF8StringEncoding
												  error:NULL];
	LogMessage(@"prologue", 0, @"prologueText instance is: %p", prologueText);

	
	
	/*  // this code is unneeded now I think
	 //count the number of lines
	 unsigned numberOfLines, index, stringLength = [prologueText length];
	 for (index = 0, numberOfLines = 0; index < stringLength; numberOfLines++) {
	 index = NSMaxRange([prologueText lineRangeForRange:NSMakeRange(index, 0)]);
	 }
	 //numberOfLines = 10;
	 
	 //for (index = 0; index < numberOfLines; index++) {
	 
	 */
	
	for (int index = 0; index < 27; index++) {
		[padding appendString: @"\n"];
	}
	
	prologueTextLength = [prologueText length];
		//	char buffer[len + 1];
		//	unichar buffer[prologueTextLength + 1];
	delay = 0.00;
		//This way:
		//strncpy(buffer, [prologueText UTF8String]);
	
		//Or this way (preferred):
	
		//	[prologueText getCharacters:buffer range:NSMakeRange(0, prologueTextLength)];
	
	
	for(prologueTextIndex = 0; prologueTextIndex < prologueTextLength; ++prologueTextIndex) {
		currentChar = [prologueText characterAtIndex: prologueTextIndex];
		
//		[self performSelector: @selector(printChar) withObject: nil afterDelay: delay];
//		
//		[[NSRunLoop currentRunLoop] runUntilDate:[[NSDate date] addTimeInterval: delay] ];
		
		if (currentChar == '\n' || (currentChar == '.' && [prologueText characterAtIndex: prologueTextIndex + 1] == '.') || (currentChar == '.' && [prologueText characterAtIndex: prologueTextIndex - 1] == '.') ) {
			
			delay = .01; //!!!: change to 1.0 for release

			[self performSelector: @selector(printPrologueText) withObject: nil afterDelay: delay];
			
			[[NSRunLoop currentRunLoop] runUntilDate:[[NSDate date] addTimeInterval: delay] ];
			
			
			if (currentChar == '\n') {
				if ([padding length] > 1) {
					[padding deleteCharactersInRange: NSMakeRange(0, 1)];
				} 
				else {
					
					NSLog(@"The location of the newline is %i", [prologueText rangeOfString:@"\n"].location);
					int cutoutPartLength = [prologueText rangeOfString: @"\n"].location + 1;
					self.prologueText = [prologueText substringFromIndex: cutoutPartLength];
						// prologueText = [prologueText substringFromIndex: [prologueText rangeOfString: @"\n"].location + 1];
					prologueTextIndex -= cutoutPartLength;
					
					prologueTextLength = [prologueText length];					
				}			
				
			}
				//			else if (currentChar == '…') {
				//				
				//				
				//			}
		}
		else {
			delay = 0.00;
		}
			//		[self performSelector: @selector(printChar) withObject: nil afterDelay: delay];
			//
			//		[[NSRunLoop currentRunLoop] runUntilDate:[[NSDate date] addTimeInterval: delay] ];
			//		[self performSelector: @selector(printChar) withObject: nil afterDelay: delay];
		
		
	}
		// make the ending button appear at the end
		//[[NSRunLoop currentRunLoop] runUntilDate:[[NSDate date] addTimeInterval: delay] ];
/*
	
	[UIView beginAnimations:@"buttonAppear" context:nil];
		//[UIView setAnimationDelay: 2.0f];
	[UIView setAnimationDuration: 0.5];
	self.doneWithPrologueButton.alpha = 0.5;
	[UIView setAnimationDelegate:self];
	
	[UIView setAnimationDidStopSelector: @selector(pulseButton:finished:context:)];
		//[UIView setAnimationDidStopSelector: @selector(longPulse:finished:context:)];
	[UIView commitAnimations];
*/	 
		//[self performSelector: @selector(pulseButton:finished:context:) withObject: nil afterDelay: delay];
		//[self pulseButton: nil finished: nil context: nil];
	self.doneWithPrologueButton.alpha = 0.1;
		//[self pulseButton: nil finished: nil context: nil];
		//	longPulseAnimation = [CABasicAnimation animationWithKeyPath: @"opacity"];
		//shortPulseAnimation = [CABasicAnimation animationWithKeyPath: @"opacity"];
//	pulseAnimation = [CABasicAnimation animationWithKeyPath: @"opacity"];
	
	/* //this shit is not working no matter how i try and do it and i have no idea why
	longPulseAnimation = [ [CABasicAnimation animationWithKeyPath: @"opacity"] retain];
	shortPulseAnimation = [ [CABasicAnimation animationWithKeyPath: @"opacity"] retain];

	longPulse = YES;
	longPulseAnimation.delegate = self;
	shortPulseAnimation.delegate = self;
	
	longPulseAnimation.fromValue = [NSNumber numberWithFloat: 0.1];
	longPulseAnimation.toValue = [NSNumber numberWithFloat: 1.0];
	longPulseAnimation.repeatCount = 1.0;
	longPulseAnimation.duration = 2.0;
	longPulseAnimation.autoreverses = YES;
	longPulseAnimation.timingFunction = [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseInEaseOut]; 
	
	
	shortPulseAnimation.fromValue = [NSNumber numberWithFloat: 0.1];
	shortPulseAnimation.toValue = [NSNumber numberWithFloat: 1.0];
	shortPulseAnimation.repeatCount = 2.0;
	shortPulseAnimation.duration = 2.0;
	shortPulseAnimation.autoreverses = YES;
	shortPulseAnimation.timingFunction = [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseInEaseOut]; 
	 */
	

		//[self pulseButton];
	
		[self shortPulse: nil finished: nil context: NULL];
		//	prologueTextIndex = 0;
	
		//[self longPulse: @"buttonPulse" finished: nil context: nil];
		//[self shortPulse: @"buttonPulse" finished: YES context: nil];
}

- (void) pulseButton: (NSString *)animationID finished: (NSNumber *)finished context: (void *)context {
	int longShort = 2;
	
	[UIView beginAnimations: animationID context: nil];
		[UIView setAnimationRepeatCount: HUGE_VAL];
		//[UIView setAnimationDuration: 8.0f];
	
		//		[UIView beginAnimations:nil context:nil];
			[UIView setAnimationDelegate:self];
				//[UIView setAnimationDidStopSelector: @selector(pulseButton:finished:context:)];
			[UIView setAnimationCurve: UIViewAnimationCurveEaseInOut];
		[UIView setAnimationRepeatCount: HUGE_VAL];
			[UIView setAnimationRepeatAutoreverses: YES];
				//[UIView setAnimationDelay: 2.0f];
	if (longShort < 2) {
		longShort++;
		[UIView setAnimationDuration: 1.0];
	} else {
		longShort = 0;
		[UIView setAnimationDuration: 2.0];
	}

		//	[UIView setAnimationDuration: 2.0];
		self.doneWithPrologueButton.alpha = 1.0;	
		[UIView commitAnimations];
	
//		[UIView beginAnimations: nil context: nil];	
//			[UIView setAnimationDelegate:self];
//				//[UIView setAnimationDidStopSelector: @selector(pulseButton:finished:context:)];
//			[UIView setAnimationCurve: UIViewAnimationCurveEaseInOut];
//			[UIView setAnimationRepeatCount: 2];
//			[UIView setAnimationRepeatAutoreverses: YES];
//			[UIView setAnimationDelay: 4.0];
//			[UIView setAnimationDuration: 1.0];
//			self.doneWithPrologueButton.alpha = 0.1;
//		[UIView commitAnimations];
	
		//	[UIView commitAnimations];
}


- (void) pulseButton {
	
	
		//	[UIView beginAnimations: @"buttonPulse" context: NULL];
	
		//[UIView setAnimationRepeatCount: 10.0];
		//[UIView setAnimationBeginsFromCurrentState: YES];
/*	
	[UIView beginAnimations: @"longPulse" context: NULL];	
	[UIView setAnimationRepeatCount: 1.0];
	[UIView setAnimationDuration: 2.0];
	[UIView setAnimationRepeatAutoreverses: YES];
	self.doneWithPrologueButton.alpha = 1.0;
	[UIView setAnimationBeginsFromCurrentState: YES];	
	[UIView commitAnimations];

	self.doneWithPrologueButton.alpha = 0.1;
	
	[UIView beginAnimations: @"shortPulse" context: NULL];
	[UIView setAnimationRepeatCount: 2.0];
	[UIView setAnimationDelay: 4.0];
	[UIView setAnimationDuration: 1.0];
	[UIView setAnimationRepeatAutoreverses: YES];
	[UIView setAnimationBeginsFromCurrentState: YES];
	[UIView commitAnimations];
	
		//	[UIView commitAnimations];
*/ 
	
	
//	pulseAnimation.fromValue = [NSNumber numberWithFloat: 0.1];
//	pulseAnimation.toValue = [NSNumber numberWithFloat: 1.0];
//	pulseAnimation.autoreverses = YES;
//	pulseAnimation.timingFunction = [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseInEaseOut]; 
	//pulseAnimation.duration = 2.0;
//	pulseAnimation.repeatCount = 10.0;
//	pulseAnimation.delegate = self;
	
		//	[self.doneWithPrologueButton.layer addAnimation: pulseAnimation forKey: @"opacity"];
	[self.doneWithPrologueButton.layer addAnimation: longPulseAnimation forKey: @"opacity"];
	
	
}

- (void)animationDidStop:(CAAnimation *)theAnimation finished:(BOOL)flag {
	if (longPulse) {
		longPulse = NO;
		[self.doneWithPrologueButton.layer addAnimation: shortPulseAnimation forKey: @"opacity"];
	} else {
		longPulse = YES;
		[self.doneWithPrologueButton.layer addAnimation: longPulseAnimation forKey: @"opacity"];
	}
	
		//[self pulseButton];
}


- (void) longPulse: (NSString *)animationID finished: (BOOL)finished context: (void *)context {
	LogMessage(@"Prologue animation", 0, @"finished is: %@", finished ? @"YES" : @"NO");
	LogMessage(@"Prologue animation", 0, @"retainCount of self is: %i", [self retainCount]);
		//	if (finished) {
		prologueTextIndex++;
			
		[UIView beginAnimations: animationID context:nil];
		[UIView setAnimationDelegate:self];
		[UIView setAnimationCurve: UIViewAnimationCurveEaseInOut];
			//[UIView setAnimationRepeatCount: 1e100f];
		[UIView setAnimationRepeatCount: 1.5];
		[UIView setAnimationRepeatAutoreverses: YES];
			//[UIView setAnimationDelay: 2.0f];
		[UIView setAnimationDuration: 2.0];
		doneWithPrologueButton.alpha = 1.0;
		[UIView setAnimationDidStopSelector: @selector(shortPulse:finished:context:)];
		[UIView setAnimationBeginsFromCurrentState: YES];
			//	[self release];
		[UIView commitAnimations];
		
		LogMessage(@"Prologue animation", 0, @"animation count is: %i", prologueTextIndex);

		//	}		
	
		//[self shortPulse: nil finished: nil context: nil];
}

- (void) shortPulse: (NSString *)animationID finished: (BOOL)finished context: (void *)context {
	LogMessage(@"PrologueAnimation", 0, @"In the shortPulse method");

	LogMessage(@"Prologue animation", 0, @"finished is: %@", finished ? @"YES" : @"NO");

		//	if (finished) {
			//	prologueTextIndex++;


		[UIView beginAnimations: animationID context: nil];	
		//	[UIView setAnimationDelegate:self];
		[UIView setAnimationCurve: UIViewAnimationCurveEaseInOut];
			//[UIView setAnimationRepeatCount: 2.5];
		[UIView setAnimationRepeatCount: HUGE_VAL];
		[UIView setAnimationRepeatAutoreverses: YES];
			//[UIView setAnimationDelay: 4.0];
		[UIView setAnimationDuration: 1.0];
		doneWithPrologueButton.alpha = 1.0;
		//[UIView setAnimationDidStopSelector: @selector(longPulse:finished:context:)];
		[UIView setAnimationBeginsFromCurrentState: YES];
		//[self release];
			//		LogMessage(@"prologue", 0, @"button retain count is: %i", [self.doneWithPrologueButton retainCount]);
		[UIView commitAnimations];
		
		//	}
		//[self longPulse: nil finished: nil context: nil];
	
}


- (void) printPrologueTextWithCursor {
	LogMessage(@"prologue", 0, @"prologue text is:\n%@", prologueText);
		//self.prologueTextLabel.text = [NSString stringWithFormat: @"%@%C", self.prologueTextLabel.text, currentChar];
	self.prologueTextLabel.text = [NSString stringWithFormat: @"%@%@%@", padding, [prologueText substringWithRange: NSMakeRange(0, prologueTextIndex)], @"█"];
	LogMessage(@"prologue", 0, @"Displayed prologue text is:\n%@", self.prologueTextLabel.text);
	
}

- (void) printPrologueText {
	LogMessage(@"prologue", 0, @"prologue text is:\n%@", prologueText);
		//self.prologueTextLabel.text = [NSString stringWithFormat: @"%@%C", self.prologueTextLabel.text, currentChar];
	self.prologueTextLabel.text = [NSString stringWithFormat: @"%@%@", padding, [prologueText substringWithRange: NSMakeRange(0, prologueTextIndex)] ];
	LogMessage(@"prologue", 0, @"Displayed prologue text is:\n%@", self.prologueTextLabel.text);
	
}


#pragma mark -
#pragma mark Boilerplate Methods

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
		//[self performSelector:@selector(beginPrologue) withObject: nil afterDelay:7.0];
		//[self beginPrologue]; // if something's wonky, try reversing these two lines.
}





- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Overriden to allow any orientation.
	if (UIInterfaceOrientationIsLandscape(interfaceOrientation)) {
			//NSLog(@"interface is landscape");
		return YES;
	} else {
		return NO;
	}	
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}


- (void)viewDidUnload {
    [super viewDidUnload];
		//	doneWithPrologueButton.alpha = 0.0f;

    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void) awakeFromNib {
		//self.lua = [[WaxLua alloc] init];
}


- (void)dealloc {
	[prologueText release];
    [super dealloc];
}


@end
