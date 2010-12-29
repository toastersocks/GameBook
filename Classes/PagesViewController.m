    //
//  PagesViewController.m
//  GameBook
//
//  Created by James Pamplona on 10/16/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "PagesViewController.h"

	//#import "SectionContents.h"
#import "SectionParser.h"
	//#import "OptionViewController.h"
//#import "SceneView.h"
#import "SectionView.h"

#import "Constants.h"

#import "TextView.h"
#import "GameBookViewWithDelegate.h"
# import "GamebookLog.h"



@implementation PagesViewController

@synthesize section;

@synthesize gameData;

@synthesize sectionView;
@synthesize gamebookLog;

@synthesize objectTextPopupController;

- (void) startParser {
	self.gameData = [[SectionParser alloc] init];
}


	// TODO: break the various functionality of this method up into several methods
- (IBAction) getChosenOption: (id) sender {
	NSLog(@"option was chosen");
	NSString *senderPageSide;
	SEL currentFace;
	NSString *optionFace;
	NSString *touchables = @"options";
	
		//NSLog(@"%@", self.section);
	/*
	if ([sender superview].tag == LEFT_PAGE_TEXT || LEFT_PAGE_SCENE) {
		NSLog(@"TRUE");

	}

	if ([sender superview].tag == RIGHT_PAGE_TEXT) {
		NSLog(@"TRUE");
		
	}
	NSLog(@"%i",RIGHT_PAGE_TEXT || RIGHT_PAGE_SCENE);
	
	
	
	NSLog(@"sender's superview's tag is: %i", [sender superview].tag);
	NSLog(@"RIGHT_PAGE_SCENE is: %i", RIGHT_PAGE_SCENE);
	NSLog(@"RIGHT_PAGE_TEXT is: %i", RIGHT_PAGE_TEXT);
	NSLog(@"LEFT_PAGE_SCENE is: %i", LEFT_PAGE_SCENE);
	NSLog(@"LEFT_PAGE_TEXT is: %i", LEFT_PAGE_TEXT);
	NSLog(@"SPREAD_PAGE_SCENE is: %i", SPREAD_PAGE_SCENE);
	 */

		//NSLog(@"Sender's superview is:\n%@", [sender superview] );
		//NSLog(@"RIGHT_PAGE_TEXT is: %i", RIGHT_PAGE_TEXT);
	
	if ( ([sender superview].tag == RIGHT_PAGE_TEXT) || ([sender superview].tag == RIGHT_PAGE_SCENE) ) {
		NSLog(@"it's the right page");
		senderPageSide = @"right.";
		
	} 
	else if ( ([sender superview].tag == LEFT_PAGE_TEXT) || ([sender superview].tag == LEFT_PAGE_SCENE) ) {
		NSLog(@"it's the left page");
		
		senderPageSide = @"left.";
	}
	else {
		senderPageSide = @"spread.";
	}

	
	
	if ( ([sender superview].tag == RIGHT_PAGE_TEXT) || ([sender superview].tag == LEFT_PAGE_TEXT) || ([sender superview].tag == OBJECT_POPUP_TEXT) ) {
		NSLog(@"it's a text page");

		currentFace = @selector(currentTitle);
		optionFace = @"optionText";
	} else if ( ([sender superview].tag == RIGHT_PAGE_SCENE) || ([sender superview].tag == LEFT_PAGE_SCENE) || ([sender superview].tag == SPREAD_PAGE_SCENE) ) {
		NSLog(@"it's a scene page");
		
		touchables = @"touchables";
		currentFace = @selector(currentImage);
		optionFace = @"sceneSprite";
	}
		//NSLog(@"touchable face is:%@",[sender performSelector: currentFace]);
	
		// loop through the options from the appropriate section side ( left/right/spread )
		//	NSLog(@"looking for option in:\n%@",[self.section valueForKeyPath: [NSString stringWithFormat:@"%@%@", senderPageSide, touchables]]);
	NSArray *optionsToCheck;
	
	if ([sender superview].tag == OBJECT_POPUP_TEXT) {
		optionsToCheck = [currentObject valueForKeyPath: @"options"];
	} else {
		optionsToCheck = [self.section valueForKeyPath: [NSString stringWithFormat:@"%@%@", senderPageSide, touchables]];
	}

	
	for (NSArray *currentOption in optionsToCheck) {
		/*	// DEBUG
		if ([[currentOption valueForKey: optionFace] isEqual: [sender performSelector: currentFace]]) {
			
			NSLog(@"FOUND A MATCH! %@ isEqual %@",[currentOption valueForKey: optionFace], [sender performSelector: currentFace]);
		}
		if ([currentOption valueForKey: optionFace] == [sender performSelector: currentFace]) {
			NSLog(@"FOUND A MATCH! %@ == %@",[currentOption valueForKey: optionFace], [sender performSelector: currentFace]);
		}
		
			// END DEBUG
		 */
		
			//	NSLog(@"Checking %@", currentOption);
			// find the chosen option
		if ( [[currentOption valueForKey: optionFace] isEqual: [sender performSelector: currentFace]] ) {
			NSLog(@"Found the option");
				// record the logs, if there are any
				// TODO: create a 'log' method that records the logs and makes sure there aren't duplicates.
			if ([currentOption valueForKey: @"logs"]) {

				for (NSString *logItem in [currentOption valueForKey: @"logs"]) {
					
					[self.gamebookLog logKeyEvent: logItem];
					
				}			
			}
				//TODO: clean up this code.
				//TODO: create a 'showPopup' method that does all the stuff below
				
				//show the popup, if there is one
			if ([currentOption valueForKey: @"pop"]) {
				NSLog(@"loading the popup...");
				currentObject = [gameData objectNamed: [currentOption valueForKey: @"pop"]];
				[self.gamebookLog logDatabaseEntry:[currentOption valueForKey: @"pop"]];
				 //				**[self.databaseLog addObject: [currentOption valueForKey: @"pop"]]; // record the object in the database log
				
				
				popupTextView.layout = currentObject;
				objectTextPopupController.contentSizeForViewInPopover = [popupTextView sizeThatFits:CGSizeMake(250, 100)];

				
				NSLog(@"textView height is: %f\noptionsContainer height is: %f", popupTextView.mainTextView.bounds.size.height, popupTextView.optionsContainer.bounds.size.height);
				NSLog(@"height of popup is %f", objectTextPopupController.contentSizeForViewInPopover.height);

				//if ([currentObject valueForKey: @"description"]) {
//					<#statements#>
//				}

				NSLog(@"pop type is: %@", popoverController.contentViewController.view.class);
				
					//[popController setPopoverContentSize:CGSizeMake(200.0, 200.0)];
				[popoverController presentPopoverFromRect: [sender frame] 
											   inView: [sender superview] 
							 permittedArrowDirections: UIPopoverArrowDirectionAny 
											 animated: YES];
				

				
					//	[popup release];
				
				
				NSLog(@"The textView's contentSize is %f, %f", popupTextView.mainTextView.contentSize.width, popupTextView.mainTextView.contentSize.height);

				
				
					//	NSLog(@"the sceneObject is:\n%@", [gameData objectNamed: [currentOption valueForKey: @"pop"]]);
				//[self loadSection: [currentOption valueForKey: @"load"]];
			}
			
			
			
				// load the section, if there's a load command
			if ([currentOption valueForKey: @"load"]) {
				NSLog(@"loading the next section: %@", [currentOption valueForKey: @"load"]);
				[self.gamebookLog logSection: [currentOption valueForKey: @"load"]]; // record the choice in the log
				
				[self loadSection: [currentOption valueForKey: @"load"]];
			}
			
			break; //<-- not good style maybe, but a negative 'while' with 'else' not working for some reason. 

		}
	}

}


- (void) loadSection: (NSString *) sectionIndex {
			
	self.section = [self.gameData contentsForSection: sectionIndex];

	NSLog(@"the sectionLog so far is:\n%@", self.gamebookLog.sectionLog);

	NSLog(@"the keyEventLog so far is:\n%@", self.gamebookLog.keyEventLog);
	NSLog(@"the databaseLog so far is:\n%@", self.gamebookLog.databaseLog);

	self.sectionView = [[SectionView alloc] initWithFrame: self.view.bounds];
	self.sectionView.section = self.section;
	
		//NSLog(@"The section type is: %@", [section class]);
		//NSLog(@"The current section contents are:\n%@", self.section);
	
	[self.view addSubview: self.sectionView];
	
}



#pragma mark -

//- (void) logChoice: (NSString *) pageIndex {
//	
//}



- (void) beginNewGame {
	/*
	self.sectionLog = [NSMutableArray arrayWithCapacity: 2];
	self.keyEventLog = [NSMutableArray arrayWithCapacity: 2];
	self.inventoryLog = [NSMutableArray arrayWithCapacity: 2];
	self.databaseLog = [NSMutableArray arrayWithCapacity: 2];
	 */

	[self loadSection: @"IndexTEST"];
	

}

// - (void) startGame {

//}


//
- (void) continueGame {
	[self.gamebookLog loadLogs];
	NSLog(@"Resuming game at section: %@", [self.gamebookLog.sectionLog lastObject]);
	[self loadSection: [self.gamebookLog.sectionLog lastObject]];
	
//	[self loadPages: savedGame.currentPage? //? something something?];
//	
}

- (void) initPopup {
	objectTextPopupController = [[GameBookViewWithDelegate alloc] init];

	objectTextPopupController.delegate = self;
	popupTextView = [[TextView alloc] init];
	popupTextView.tag = OBJECT_POPUP_TEXT;
		//[popupController.view addSubview: popup];
	objectTextPopupController.view = popupTextView;
	objectTextPopupController.view.backgroundColor = self.sectionView.backgroundColor;
	popoverController = [[UIPopoverController alloc] initWithContentViewController: objectTextPopupController];
	
}


#pragma mark -
#pragma mark Boilerplate Methods


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
		//[self beginNewGame];
	
	// Start off the view with the initial page
	//[self loadPages: @"Index"]; // disabled for now. Need a method to call to start loading pages but not knowing whether it's a new game or not. Just a startup game method or something. Then that method can decide whether it's a new game or a continue.
	
	
	
    [super viewDidLoad];
	[self initPopup];

	
}

- (void) awakeFromNib {
	NSLog(@"PagesViewController has awoken from the nib...");
	[self startParser];

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
	[self.objectTextPopupController dealloc];
    [super dealloc];
}


@end
