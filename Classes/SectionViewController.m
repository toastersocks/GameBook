//
//  SectionViewController.m
//  GameBook
//
//  Created by James Pamplona on 3/24/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SectionViewController.h"
#import "SectionView.h"
#import "GamebookLog.h"
#import "GBTouchable.h"
#import "SectionParser.h"

@implementation SectionViewController

@synthesize sectionView;
@synthesize touchedObject;
@synthesize gamebookLog;
@synthesize gameData;

@synthesize transitionDelegate;


- (IBAction) getChosenOption: (id)sender {
		//NSAssert([sender isKindOfClass: @"GBTouchable", <#desc#>, <#...#>)
	self.touchedObject = [sender option];
	NSDictionary *touchableOptions = [sender option];
	if ([touchableOptions valueForKey: @"pop"]) {
			//	NSLog(@"Popup object in choice method is:\n%@", currentObject);
		[self showPopupForCurrentOptionFromTouchable: sender];
		
		
	} else if ([touchableOptions valueForKey: @"load"]) {
		[self beginTransitionToSection: [touchableOptions valueForKey: @"load"]];
			//self.nextSectionIndex = [currentOption valueForKey: @"load"];
		
	} else if ([touchableOptions valueForKey: @"logs"]) {
		for (NSString *currentLog in [touchableOptions valueForKey: @"logs"]) {
			[self.gamebookLog logKeyEvent: currentLog];
		}
	} else {
		LogMessage(@"ERROR", 0, @"INVALID OR NO OPTION");
	}
	
}

- (void)beginTransitionToSection: (NSString *)sectionIndex {
	[self.transitionDelegate beginTranitionToView: [self viewForSection: sectionIndex] sender: self];
}

- (SectionView *)viewForSection: (NSString *)sectionIndex {
		//TODO: change this to use SectionView's as of yet nonexistent initWithSection method, if it's fast enough that it's not neccesary to cache the views.
	SectionView *nextSectionView = [[[SectionView alloc] initWithFrame: self.view.bounds] autorelease];
	nextSectionView.section = [self.gameData contentsForSection: sectionIndex];
	return nextSectionView;
}

- (void) showPopupForCurrentOptionFromTouchable: (id)touchable  {

}

- (void)didTransitionToView: (UIView *)newSectionView {
	[self.gamebookLog logOptions: self.touchedObject];
	self.sectionView = newSectionView;
}

- (void)setSectionView:(SectionView *)newSectionView {
	[sectionView removeFromSuperview];
	[sectionView release];
	sectionView = newSectionView;
		//sectionView.frame = self.view.frame;
	[self.view addSubview: sectionView];
}

	//Code below commented out for now to focus on getting section loading working

/*
- (void) showPopupForCurrentOptionFromTouchable: (id)touchable  {
    NSLog(@"loading the popup...");
	
	objectTextPopupController = [[GameBookViewWithDelegate alloc] init];
	objectTextPopupController.delegate = self;
	popoverController = [[UIPopoverController alloc] initWithContentViewController: objectTextPopupController];
	popoverController.delegate = self;
	
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
	
	popoverController.popoverContentSize = [popupTextView sizeThatFits: CGSizeMake(250, 100)];
	
	[popoverController presentPopoverFromRect: [touchable frame] 
									   inView: [touchable superview] 
					 permittedArrowDirections: UIPopoverArrowDirectionAny 
									 animated: YES];
	
	
	NSLog(@"The textView's contentSize is %f, %f", popupTextView.mainTextView.contentSize.width, popupTextView.mainTextView.contentSize.height);
	
	NSLog(@"The popup's view size is %f, %f", popupTextView.frame.size.width, popupTextView.frame.size.height);
	
		//[self.currentObject release];
}
*/

//- (void)logTouchableOptions: (NSDictionary *)options {
//	[self.gamebookLog logOptions: options];
//}




- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    if (UIInterfaceOrientationIsLandscape(interfaceOrientation)) {
			//NSLog(@"interface is landscape");
		return YES;
	} else {
		return NO;
	}	
}

@end
