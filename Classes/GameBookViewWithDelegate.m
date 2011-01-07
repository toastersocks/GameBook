    //
//  GameBookViewWithDelegate.m
//  GameBook
//
//  Created by James Pamplona on 10/25/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "GameBookViewWithDelegate.h"


@implementation GameBookViewWithDelegate

@synthesize delegate;


//-(IBAction) respondToButton: (id)sender {
//	if (self.delegate != NULL && [self.delegate respondsToSelector:@selector (respondToButton:) ] ) {
//		[self.delegate respondToButton: sender];
//	}	
//
//}

- (IBAction) openCover: sender {
	if (self.delegate != NULL && [self.delegate respondsToSelector:@selector(openCover: ) ] ) {
		[self.delegate openCover: sender];
	}	
	
}


//- (IBAction) respondToButton: (id)sender;
//
//- (IBAction) openCover: (id) sender;

- (IBAction) newGame: (id) sender {
	if (self.delegate != NULL && [self.delegate respondsToSelector:@selector(newGame: ) ] ) {
		[self.delegate newGame: sender];
	}	
	
}

- (IBAction) continueGame: (id) sender {
	if (self.delegate != NULL && [self.delegate respondsToSelector:@selector(continueGame: ) ] ) {
		[self.delegate continueGame: sender];
	}	
	
}

- (IBAction) gameBookOptions: (id)sender {
	if (self.delegate != NULL && [self.delegate respondsToSelector:@selector(gameBookOptions: ) ] ) {
		[self.delegate gameBookOptions: sender];
	}	
	
}

- (IBAction) getChosenOption: (id)sender {
	if (self.delegate != NULL && [self.delegate respondsToSelector:@selector(getChosenOption: ) ] ) {
		[self.delegate getChosenOption: sender];
	}	
	
}

- (IBAction) showPrologue: (id)sender {
	if (self.delegate != NULL && [self.delegate respondsToSelector:@selector(showPrologue: ) ] ) {
		[self.delegate showPrologue: sender];
	}
}


/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

//-(void) 


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
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
