    //
//  BookViewController.m
//  GameBook
//
//  Created by James Pamplona on 10/22/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "BookViewController.h"
#import "PagesViewController.h"
#import "PrologueViewController.h"
#import "CoverViewController.h"
#import "MainTitleMenu.h"
#import "GamebookLog.h"


@implementation BookViewController 

@synthesize pagesViewController;
@synthesize prologueViewController;
@synthesize coverViewController;
@synthesize mainTitleMenu;

@synthesize gamebookLog;

@synthesize activeController;




//- (IBAction) respondToButton:(id)sender {
//	
//	[self.view addSubview: [ 
//}


- (void) displayCover {
	[self cutToController: self.coverViewController];
		//[self crossfadeTo: self.coverViewController duration: 2.0f];

		//NSLog(@"This is the displayCover method");
		//	NSLog(@"The subviews are:\n%@", self.view.subviews);
}
	 

- (IBAction) respondToButton: (id)sender {
	
}


- (void) crossfadeTo: (UIViewController *)controllerToDisplay duration: (float)aDuration {
	NSLog(@"In the crossfadeTo:duration method");
	NSLog(@"controllerToDisplay is:\n%@", controllerToDisplay);
	NSLog(@"activeController is:\n%@", activeController);
	
	[controllerToDisplay viewWillAppear:YES];
	[activeController viewWillDisappear:YES];
	
	[controllerToDisplay.view setFrame: CGRectMake(0, 0, 1024, 768)];
	controllerToDisplay.view.alpha = 0.0f;
	[self.view addSubview:controllerToDisplay.view];
	
	[controllerToDisplay viewDidAppear:YES];
	
	[UIView beginAnimations:@"crossfade" context:nil];
	[UIView setAnimationDuration:aDuration];
	controllerToDisplay.view.alpha = 1.0f;
	activeController.view.alpha = 0.0f;
	[UIView commitAnimations];
	
	[self performSelector:@selector(animationDone:) withObject:controllerToDisplay afterDelay:aDuration];
}

- (void) cutToController: (UIViewController *)controllerToDisplay {
	NSLog(@"In the cutToController method");
	NSLog(@"controllerToDisplay is:\n%@", controllerToDisplay);
	NSLog(@"activeController is:\n%@", activeController);
	
	[controllerToDisplay viewWillAppear:YES];
	[activeController viewWillDisappear:YES];
	
	/*
	controllerToDisplay.view.alpha = 0.0f;
	[self.view addSubview:controllerToDisplay.view];
	
	[controllerToDisplay viewDidAppear:YES];
	
	[UIView beginAnimations:@"crossfade" context:nil];
	[UIView setAnimationDuration:aDuration];
	controllerToDisplay.view.alpha = 1.0f;
	activeController.view.alpha = 0.0f;
	[UIView commitAnimations];
	
	[self performSelector:@selector(animationDone:) withObject:controllerToDisplay afterDelay:aDuration];
	 */
	
	[controllerToDisplay.view setFrame: CGRectMake(0, 0, 1024, 768)];
	[self.view addSubview:controllerToDisplay.view];
	[self animationDone: controllerToDisplay];
	
}


- (void) animationDone: (UIViewController *)newActiveController {
	[activeController.view removeFromSuperview];
	[activeController viewDidDisappear:YES];
		//[activeController release];
	self.activeController = newActiveController;
		//activeController = [aNewViewController retain];
}



- (IBAction) openCover: (id)sender {
	
	[self crossfadeTo:self.mainTitleMenu duration: 1.0f];	
}

- (void) startGamebook {
		//[self dismissModalViewControllerAnimated: NO];
		//[self crossfadeTo: self.prologueViewController duration: 2.0f];
	self.gamebookLog = [[GamebookLog alloc] init];
	self.pagesViewController.gamebookLog = self.gamebookLog;
		//[self crossfadeTo: self.pagesViewController duration: 1.0f];
	//[self.pagesViewController beginNewGame];

}


- (IBAction) showPrologue: (id)sender {

	[self crossfadeTo: self.prologueViewController duration: 2.0f];
	
		//	[self.prologueViewController beginPrologue];
	[self.prologueViewController performSelector:@selector(beginPrologue) withObject: nil afterDelay: 2.0f];

		//the prologueViewController calls -startGamebook on it's delegate (instance of this class). IT NO LONGER DOES
		//[self startGamebook]; 
//	[self crossfadeTo: self.pagesViewController duration: 1.0f];	
//	[self.pagesViewController beginNewGame];


}

-(IBAction) newGame: (id)sender {
	[self startGamebook];
	[self crossfadeTo: self.pagesViewController duration: 1.0f];	
	[self.pagesViewController beginNewGame];

}


- (IBAction) continueGame: (id)sender {
		//	[self.pagesViewController continueGame];
	[self startGamebook];
		//[self.pagesViewController.view setFrame: CGRectMake(0, 0, 1024, 768)];
		//[self.view addSubview: self.pagesViewController.view];
		//[self cutToController: self.pagesViewController];
	
		[self crossfadeTo: self.pagesViewController duration: 1.0f];
	
	[[self gamebookLog] loadLogs];
	[self.pagesViewController continueGame];
		//	[self crossfadeTo: self.pagesViewController duration: 1.0f];

}


- (IBAction) gameBookOptions: (id)sender {
		// [self.view addSubview: optionsViewController.view];
	
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
	// look in the Cocoa book where they had objects in a dictionary and called a selector on one from a ui action. Maybe something like that. Have the views in a dictionary, and switch to the right one, based on what button was pressed. At least for the major views like cover, prologue, inside pages.
	
		//	NSDictionary *buttonDictionary = [NSDictionary dictionaryWithObjectsAndKeys: @selector( // trying to call certain methods based on what button is tapped. -- Forget about this for now.
	
	NSLog(@"The bookViewController view has loaded");
	
    [super viewDidLoad];
		//[self displayCover];
		//now calling this method from the appDelegate
		//	[self performSelector: @selector(displayCover) withObject: NULL afterDelay:0.0]; // this is a stupid hack workaround because the presentModalView method does nothing unless you delay it. Even delaying by 0.0 will make it work... STUPID

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
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
