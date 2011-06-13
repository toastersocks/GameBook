    //
//  PagesViewController.m
//  GameBook
//
//  Created by James Pamplona on 10/16/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//


#import "PagesViewController.h"

#import "SectionParser.h"
#import "SectionView.h"

#import "Constants.h"

#import "TextView.h"
#import "GameBookViewWithDelegate.h"
#import "GamebookLog.h"

#import "NSDictionary+Section.h"

#import "PassTouchButton.h"
#import "GBTouchable.h"



@implementation PagesViewController

@synthesize section;

@synthesize gameData;

@synthesize sectionView;
@synthesize nextSectionView;

@synthesize gamebookLog;
@synthesize currentObject;

@synthesize renderedImageCache;

@synthesize currentSectionIndex;
@synthesize nextSectionIndex;

@synthesize sectionViewCache;
@synthesize transitionDelegate;

#pragma mark -

- (CGImageRef) renderImageForView: (UIView *)viewToRender {
	UIGraphicsBeginImageContext(viewToRender.frame.size);
	
	CGContextRef context = UIGraphicsGetCurrentContext();
	[viewToRender.layer renderInContext: context];

	CGImageRef renderedImage = [UIGraphicsGetImageFromCurrentImageContext() CGImage];
	
	UIGraphicsEndImageContext();
	
	return renderedImage;
	
}


- (void) initialize {
	self.gameData = [[SectionParser alloc] init];	
	self.sectionViewCache = [NSMutableDictionary dictionaryWithCapacity: 3];
}


- (void) popoverControllerDidDismissPopover: inPopoverController {
		//[self.currentObject release];
}


- (void) showPopupForCurrentOptionFromTouchable: (id)touchable  {
    NSLog(@"loading the popup...");
	
	if (popupTextView != nil) {
		[popupTextView release];
	}
	popupTextView = [[TextView alloc] init];
	
	popupTextView.tag = OBJECT_POPUP_TEXT;
		//[popupController.view addSubview: popup];
	objectTextPopupController.view = popupTextView;
	
	NSLog(@"currentObject at %p retain count before assignment is: %i", self.currentObject, [self.currentObject retainCount] );

	self.currentObject = [[gameData objectNamed: [currentOption valueForKey: @"pop"] ] retain];
	NSLog(@"currentObject at %p retain count after assignment is: %i", self.currentObject, [self.currentObject retainCount] );

	NSLog(@"Popup object in popup method is:\n%@", currentObject);



	
	objectTextPopupController.view.backgroundColor = self.sectionView.backgroundColor;


	popupTextView.pageContents = self.currentObject;

	NSLog(@"textView height is: %f\noptionsContainer height is: %f", popupTextView.mainTextView.bounds.size.height, popupTextView.optionsContainer.bounds.size.height);
	NSLog(@"height of popup is %f", objectTextPopupController.contentSizeForViewInPopover.height);


	NSLog(@"pop type is: %@", popoverController.contentViewController.view.class);
	objectTextPopupController.contentSizeForViewInPopover = CGSizeMake(300, 400);

//	popoverController.popoverContentSize = [popupTextView sizeThatFits: CGSizeMake(250, 100)];

	[popoverController presentPopoverFromRect: [touchable frame] 
								   inView: [touchable superview] 
				 permittedArrowDirections: UIPopoverArrowDirectionAny 
								 animated: YES];

	
	NSLog(@"The textView's contentSize is %f, %f", popupTextView.mainTextView.contentSize.width, popupTextView.mainTextView.contentSize.height);

	NSLog(@"The popup's view size is %f, %f", popupTextView.frame.size.width, popupTextView.frame.size.height);
	
		//[self.currentObject release];
}



- (void)processCommandsForTouchable: (id)touchable {
	if ([currentOption valueForKey: @"pop"]) {
		[self.gamebookLog logDatabaseEntry: [currentOption valueForKey: @"pop"]];
		
	} else if ([currentOption valueForKey: @"load"]) {
		[self.gamebookLog logSection: [currentOption valueForKey: @"load"]]; // record the choice in the log
	}
	
	if ([currentOption valueForKey: @"logs"]) {
		for (NSString *logItem in [currentOption valueForKey: @"logs"]) {
			[self.gamebookLog logKeyEvent: logItem];
			}
	}
}


- (IBAction) getChosenOption: (id)sender {
	
	currentOption = [sender option];
	if ([currentOption valueForKey: @"pop"]) {
			//	NSLog(@"Popup object in choice method is:\n%@", currentObject);
		[self showPopupForCurrentOptionFromTouchable: sender];
		
		
	} else if ([currentOption valueForKey: @"load"]) {
		[self willLoadSectionFromTouchable: sender];
			//self.nextSectionIndex = [currentOption valueForKey: @"load"];
		
	} else if ([currentOption valueForKey: @"logs"]) {
		for (NSString *currentLog in [currentOption valueForKey: @"logs"]) {
			[self.gamebookLog logKeyEvent: currentLog];
		}
	} else {
		LogMessage(@"ERROR", 0, @"INVALID OR NO OPTION");
	}
	
}

- (void)willLoadSectionFromTouchable: (id)touchable {
	self.nextSectionView = [self viewForSection: [currentOption valueForKey: @"load"]];
//	[self.transitionDelegate viewController: self willTransitionToView: [self viewForSection: [currentOption valueForKey: @"load"]]];
	[self.transitionDelegate viewController: self willTransitionToView: self.nextSectionView withID: [currentOption valueForKey: @"load"]];

}

- (void) willTransitionToView: (UIView *)newView withID: (NSString *)viewID {


	
}

- (void) didTransitionToView: (UIView *)newView withID: (NSString *)viewID {
	if ((newView == self.nextSectionView)) {
		[self processCommandsForTouchable: nil];
			//[self.sectionView removeFromSuperview];
		self.sectionView = (SectionView *)newView;
			//[self.view addSubview: self.sectionView];
		previousSectionIndex = currentSectionIndex;
		currentSectionIndex = nextSectionIndex;
		nextSectionIndex = nil;
		self.section = self.sectionView.section;
			//cache the possible next views for the new section
		for (NSString *link in [self.sectionView.section sectionLinks]) {
			[self viewForSection: link];
		}
	}
}

- (UIView *)view {
	return sectionView;
}


- (SectionView *) viewForSection: (NSString *)sectionIndexToLoad {
	
		//NSLog(@"section at %p retainCount before assignment is: %i", self.section, self.section.retainCount);
			
	if ([self.sectionViewCache valueForKey: sectionIndexToLoad]) {
		return [self.sectionViewCache valueForKey: sectionIndexToLoad];
	} else {
		
		
		NSDictionary *sectionToLoad = [self.gameData contentsForSection: sectionIndexToLoad];
		
			//NSLog(@"section at %p retainCount after assignment is: %i", self.section, self.section.retainCount);

		NSLog(@"the sectionLog so far is:\n%@", self.gamebookLog.sectionLog);

		NSLog(@"the keyEventLog so far is:\n%@", self.gamebookLog.keyEventLog);
		NSLog(@"the databaseLog so far is:\n%@", self.gamebookLog.databaseLog);
		
//		SectionView *sectionViewToReturn = [[SectionView alloc] initWithFrame: CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
//		SectionView *sectionViewToReturn = [[SectionView alloc] initWithFrame: CGRectMake(0, 0, [[UIApplication sharedApplication] delegate].window.bounds.size.height, [UIApplication sharedApplication].delegate.window.bounds.size.width)];
		SectionView *sectionViewToReturn = [[SectionView alloc] initWithFrame: CGRectMake(0, 0, 1000, 768)];
		sectionViewToReturn.section = sectionToLoad;
		[self.sectionViewCache setValue: sectionViewToReturn forKey: sectionIndexToLoad];
		
		return sectionViewToReturn;
	}
}



#pragma mark -

//- (void) logChoice: (NSString *) pageIndex {
//	
//}

- (void) startGameWithSection: (NSString *)aSection {
	self.currentSectionIndex = aSection;
		//	self.section = [self.gameData contentsForSection: currentSectionIndex];
	self.sectionView = [self viewForSection: currentSectionIndex];
	//self.sectionView.contentView = [self viewForSection: currentSectionIndex];

		//	self.sectionView.currentPageIndex = self.currentSectionIndex;
	self.currentSectionIndex = aSection;
	[self.transitionDelegate setCurrentView: self.sectionView];
		//[self.view addSubview: self.sectionView];
	
}

- (void) beginNewGame {
	[self startGameWithSection: @"IndexTEST"];
	//[self startGameWithSection: @"wells"];
}

- (void) continueGame {
	[self startGameWithSection: [self.gamebookLog.sectionLog lastObject]];
	if ([self.gamebookLog.sectionLog count] >= 2) {
		previousSectionIndex = [self.gamebookLog.sectionLog objectAtIndex: [self.gamebookLog.sectionLog count] - 2];
	}

	NSLog(@"Resuming game at section: %@", currentSectionIndex);
}

- (void) initPopup {
	objectTextPopupController = [[GameBookViewWithDelegate alloc] init];
	objectTextPopupController.delegate = self;
	popoverController = [[UIPopoverController alloc] initWithContentViewController: objectTextPopupController];
	popoverController.delegate = self;
}

#pragma mark -
#pragma mark Boilerplate Methods


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {

	
    [super viewDidLoad];
	
	

	
}

- (void) awakeFromNib {
	NSLog(@"PagesViewController has awoken from the nib...");
	[self initPopup];
	[self initialize];
	self.view = self.sectionView;
		//LoggerSetOptions(NULL, kLoggerOption_LogToConsole);


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
		//[objectTextPopupController dealloc];
    [super dealloc];
}


@end
