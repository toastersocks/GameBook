    //
//  PrologueViewController.m
//  GameBook
//
//  Created by James Pamplona on 10/22/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "PrologueViewController.h"
#import "WaxLua.h"

#import <unistd.h>

@implementation PrologueViewController

@synthesize prologueTextLabel;
<<<<<<< HEAD
=======
@synthesize doneWithPrologueButton;
>>>>>>> implemented a view transition system to do fading etc... implemented scrolling prologue added a mo betta logging system, NSLogger much needed code cleanup
	//@synthesize lua;


- (IBAction) dismissPrologue {
		//[self dismissModalViewControllerAnimated: YES]; // animated is YES for now, just to have a transition placeholder until a custom one is implemented. 
		//[self.delegate dismissPrologue];
		//[delegate crossfadeTo: [[self delegate] prologueViewController] duration: 2.0];
	[delegate newGame: self];
}

- (void) beginPrologue {
<<<<<<< HEAD
		//[lua setObject: prologueText asGlobalNamed: "prologueDisplay"];
		//[lua doScript: @"prologueHelper.lua"];

		//NSString *testString = @"This is only a test";
=======
	doneWithPrologueButton.alpha = 0.0f;

	
>>>>>>> implemented a view transition system to do fading etc... implemented scrolling prologue added a mo betta logging system, NSLogger much needed code cleanup
	padding = [NSMutableString stringWithString: @""];
	[padding retain];
	
	path = [[NSBundle mainBundle] pathForResource: @"prologue" ofType: @"txt"];
	prologueText = [ [NSString stringWithContentsOfFile:path
							  encoding:NSUTF8StringEncoding
								 error:NULL] retain];
	
<<<<<<< HEAD
=======
	
	
	/*  // this code is unneeded now I think
>>>>>>> implemented a view transition system to do fading etc... implemented scrolling prologue added a mo betta logging system, NSLogger much needed code cleanup
		//count the number of lines
	unsigned numberOfLines, index, stringLength = [prologueText length];
	for (index = 0, numberOfLines = 0; index < stringLength; numberOfLines++) {
		index = NSMaxRange([prologueText lineRangeForRange:NSMakeRange(index, 0)]);
	}
		//numberOfLines = 10;
	
		//for (index = 0; index < numberOfLines; index++) {
<<<<<<< HEAD
	for (index = 0; index < 30; index++) {
		[padding appendString: @"\n"];
	}
	
	
	
	prologueTextLength = [prologueText length];
		//	char buffer[len + 1];
	unichar buffer[prologueTextLength + 1];
=======

	*/
	
	for (int index = 0; index < 27; index++) {
		[padding appendString: @"\n"];
	}
	
	prologueTextLength = [prologueText length];
		//	char buffer[len + 1];
		//	unichar buffer[prologueTextLength + 1];
>>>>>>> implemented a view transition system to do fading etc... implemented scrolling prologue added a mo betta logging system, NSLogger much needed code cleanup
	delay = 0.02;
		//This way:
		//strncpy(buffer, [prologueText UTF8String]);
	
		//Or this way (preferred):
	
<<<<<<< HEAD
	[prologueText getCharacters:buffer range:NSMakeRange(0, prologueTextLength)];
	
	
	for(prologueTextIndex = 0; prologueTextIndex < prologueTextLength; ++prologueTextIndex) {
			//currentChar = buffer[prologueTextIndex];
		currentChar = [prologueText characterAtIndex: prologueTextIndex];
//		[self performSelector: @selector(printChar) withObject: nil afterDelay:0.0];
			//self.prologueTextLabel.text = [NSString stringWithFormat: @"%@%C", self.prologueTextLabel.text, currentChar];//[NSString stringWithFormat: @"%@%c", self.prologueTextLabel.text, currentChar]; // something may be wrong with creating a string using stringWithFormat and %c char types. Consider another way if there's weird problems
			
			//[self.view setNeedsDisplay];
			//usleep(1000);
=======
		//	[prologueText getCharacters:buffer range:NSMakeRange(0, prologueTextLength)];
	
	
	for(prologueTextIndex = 0; prologueTextIndex < prologueTextLength; ++prologueTextIndex) {
		currentChar = [prologueText characterAtIndex: prologueTextIndex];
>>>>>>> implemented a view transition system to do fading etc... implemented scrolling prologue added a mo betta logging system, NSLogger much needed code cleanup

		[self performSelector: @selector(printChar) withObject: nil afterDelay: delay];
		
		[[NSRunLoop currentRunLoop] runUntilDate:[[NSDate date] addTimeInterval: delay] ];
		
<<<<<<< HEAD
		
=======
>>>>>>> implemented a view transition system to do fading etc... implemented scrolling prologue added a mo betta logging system, NSLogger much needed code cleanup
		if (currentChar == '\n' || currentChar == '.') {
			delay = 0.5;
		
			if (currentChar == '\n') {
<<<<<<< HEAD
			
					//		delay = 0.5;

=======
					//		delay = 0.5;
>>>>>>> implemented a view transition system to do fading etc... implemented scrolling prologue added a mo betta logging system, NSLogger much needed code cleanup
				if ([padding length] > 1) {
					[padding deleteCharactersInRange: NSMakeRange(0, 1)];
				} 
				else {
					
					NSLog(@"The location of the newline is %i", [prologueText rangeOfString:@"\n"].location);
					int cutoutPartLength = [prologueText rangeOfString: @"\n"].location + 1;
					prologueText = [prologueText substringFromIndex: cutoutPartLength];
//					prologueText = [prologueText substringFromIndex: [prologueText rangeOfString: @"\n"].location + 1];
					prologueTextIndex -= cutoutPartLength;

					prologueTextLength = [prologueText length];
						//	unichar buffer[prologueTextLength + 1];

						//	[prologueText getCharacters:buffer range:NSMakeRange(0, prologueTextLength)];
					
				}			
			
			} 
		}
		else {
			delay = 0.02;
		}
//		[self performSelector: @selector(printChar) withObject: nil afterDelay: delay];
//
//		[[NSRunLoop currentRunLoop] runUntilDate:[[NSDate date] addTimeInterval: delay] ];
			//		[self performSelector: @selector(printChar) withObject: nil afterDelay: delay];


	}
<<<<<<< HEAD

=======
	[[NSRunLoop currentRunLoop] runUntilDate:[[NSDate date] addTimeInterval: delay] ];
	[UIView beginAnimations:@"buttonAppear" context:nil];
	[UIView setAnimationDuration: 2.0f];
	doneWithPrologueButton.alpha = 1.0f;
	[UIView commitAnimations];
>>>>>>> implemented a view transition system to do fading etc... implemented scrolling prologue added a mo betta logging system, NSLogger much needed code cleanup
	
}

- (void) printChar {
	LogMessage(@"prologue", 0, @"prologue text is:\n%@", prologueText);
		//self.prologueTextLabel.text = [NSString stringWithFormat: @"%@%C", self.prologueTextLabel.text, currentChar];
	self.prologueTextLabel.text = [NSString stringWithFormat: @"%@%@%@", padding, [prologueText substringWithRange: NSMakeRange(0, prologueTextIndex)], @"█"];
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
