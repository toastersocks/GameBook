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



- (void) changeToView:(UIViewController *) newView {
	
	
}


//- (IBAction) respondToButton:(id)sender {
//	
//	[self.view addSubview: [ 
//}



//- (void) startBook


//- (void) startNewGame {
//	//[self.view addSubview: prologueViewController.vew];
//	[self.view addSubview: pagesViewController.view];
//	[self presentModalViewController: prologueViewController animated: NO];
//	
//	
//}
//
//
//- (void) loadNewView: sender {
//	
//	
//}


- (void) displayCover {
	//self.coverViewController.delegate = self;
	//[self presentModalViewController: self.coverViewController animated: NO];
	[self.coverViewController.view setFrame:[[UIScreen mainScreen] applicationFrame]];
	[self.coverViewController.view setFrame: CGRectMake(0, 0, 1024, 768)];

	[self.view addSubview: self.coverViewController.view];
		//self.view = self.coverViewController.view;
//	self.coverViewController.modalPresentationStyle = UIModalPresentationFullScreen;
//self.coverViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
	//[self performSelector: @selector(presentModalViewController:animated:) withObject: self.coverViewController afterDelay:0.0];
	
	//NSLog(@"This is the displayCover method");
	
	
	NSLog(@"The subviews are:\n%@", self.view.subviews);
}
	 


//- (IBAction) displayMainMenu {
//	
//	//[self presentModalViewController: self.coverViewController animated: NO]; // this is not working. no idea why...
//
//	//[self.coverViewController.view removeFromSuperview];
//}


- (IBAction) respondToButton: (id)sender {
	
}

- (IBAction) openCover: (id)sender {
		//NSLog(@"Sender tag is:\n%i", [sender tag]); // sender tag NEEDS format specifier of %i otherwise you will crash without any usefull error messages.
//[self dismissModalViewControllerAnimated: NO];
		//[self.view addSubview: self.mainTitleMenu.view];
	[self.coverViewController.view removeFromSuperview];
	[self.mainTitleMenu.view setFrame: CGRectMake(0, 0, 1024, 768)];
	[self.view addSubview: self.mainTitleMenu.view];
	
		//[self presentModalViewController: self.mainTitleMenu animated: NO];

}

- (void) startGamebook {
	[self dismissModalViewControllerAnimated: NO];
	self.gamebookLog = [[GamebookLog alloc] init];
	self.pagesViewController.gamebookLog = self.gamebookLog;
	

}


- (IBAction) newGame: (id)sender {
		//	[self.view.subviews // if self.view has any subviews, remove those before adding the new view? can get the topmost view by calling the very convenient method -lastObject e.g. [[self.view subviews] lastObject]
		//[self.view addSubview: prologueViewController.view];
//	[self dismissModalViewControllerAnimated: NO];
//	self.prologueViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;	
//	[self presentModalViewController: self.prologueViewController animated: YES]; // the prologue modal view dismisses itself for now. If ANY other functionality is needed besides just dismissing itself, probably best to move the -dismissModalView: call from the prologueViewController to this method after doing whatever else you want to do.
	self.prologueViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;	
	[self presentModalViewController: self.prologueViewController animated: YES]; // the prologue modal view dismisses itself for now. If ANY other functionality is needed besides just dismissing itself, probably best to move the -dismissModalView: call from the prologueViewController to this method after doing whatever else you want to do.

	[self startGamebook];
	[self.pagesViewController.view setFrame: CGRectMake(0, 0, 1024, 768)]; // i don't know why these are necessary. The subview should automatically get sized to the size of the parent view. Only thing I can think of is that the mainWindow is in portrait and shouldn't be. Can't figure out how to control that though. Doesn't seem to be an option in IB and there's no controller for the main window. Should there be? Can't find anything about it on the internets.
	[self.view addSubview: self.pagesViewController.view];
	[self.pagesViewController beginNewGame];


}


- (IBAction) continueGame: (id)sender {
		//	[self.pagesViewController continueGame];
	[self startGamebook];
	[self.view addSubview: self.pagesViewController.view];
	[self.pagesViewController continueGame];

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
	[self performSelector: @selector(displayCover) withObject: NULL afterDelay:0.0]; // this is a stupid hack workaround because the presentModalView method does nothing unless you delay it. Even delaying by 0.0 will make it work... STUPID

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
