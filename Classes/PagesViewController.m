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




	//@synthesize objectTextPopupController;


#pragma mark LeavesView delegate/datasource methods

/*
- (void) leavesView:(LeavesView *)leavesView didTurnToPageAtIndex:(NSString *)pageIndex {
	LogMessage(@"leaves delegate", 3, @"didTurnToPageAtIndex: %@", pageIndex);

	if (![pageIndex isEqualToString: self.currentSectionIndex]) {
			//CALL THE METHOD TO PROCESS THE COMMANDS HERE!!!
		
		previousSectionIndex = currentSectionIndex;
		currentSectionIndex = nextSectionIndex;
		nextSectionIndex = nil;
			//[self.sectionView removeFromSuperview];
		self.sectionView.contentView = [self viewForSection: currentSectionIndex];
		self.sectionView.currentPageIndex = self.currentSectionIndex;
		self.section = [self viewForSection: currentSectionIndex].section;
			//self.section = [self.gameData contentsForSection: currentSectionIndex];
			//[self.view addSubview: self.sectionView];
//		[self performSelectorInBackground: @selector(cachePages) withObject: nil];
//		[self performSelectorOnMainThread:@selector(cachePages) withObject: nil waitUntilDone: YES];
//		[[NSRunLoop currentRunLoop] runUntilDate:[NSDate date]];
//		[self cachePages];
		[self performSelector:@selector(cachePages) withObject: nil afterDelay: 0.0];
//		for (NSDictionary *link in [self.section sectionLinks]) {
//			//[self.sectionView.pageCache cachedImageForPageIndex: link];
//			[self.sectionView.pageCache precacheImageForPageIndex: link];
//		}
	} else {
			//	[self.sectionView.subviews makeObjectsPerformSelector: @selector(setHidden:) withObject: (id)NO];
	}

}
*/

//- (SectionView *)sectionView {
//	return (SectionView *)self.view;
//}

- (void) renderPageAtIndex:(NSString *)index inContext:(CGContextRef)ctx {
	LogMessage(@"leaves delegate", 3, @"In the renderPageAtIndex method.\nRequested page was: %@", index);
		////LogImageData(@"leaves delegate", 0, 1024, 768, UIImagePNGRepresentation([UIImage imageWithCGImage: (CGImageRef)[self.renderedImageCache objectAtIndex: index]]));
		CGImageRef image = (CGImageRef)[self renderImageForView: [self viewForSection: index]];
	//LogImageData(@"leaves delegate", 2, 1024, 768, UIImagePNGRepresentation([UIImage imageWithCGImage:image]));

	
	CGRect imageRect = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
		//CGAffineTransform transform = aspectFit(imageRect,
		//						CGContextGetClipBoundingBox(ctx));
		//	CGContextConcatCTM(ctx, transform);
	CGContextDrawImage(ctx, imageRect, image);
}



#pragma mark -

- (CGImageRef) renderImageForView: (UIView *)viewToRender {
	UIGraphicsBeginImageContext(viewToRender.frame.size);
	
	CGContextRef context = UIGraphicsGetCurrentContext();
	[viewToRender.layer renderInContext: context];
//	[viewToRender.layer.presentationLayer renderInContext: context];

	CGImageRef renderedImage = [UIGraphicsGetImageFromCurrentImageContext() CGImage];
	
	UIGraphicsEndImageContext();
	
	return renderedImage;
	
}

/*
- (void) cachePages {
	self.sectionViewCache = [NSMutableDictionary dictionaryWithCapacity: 2];
	for (NSString *link in [self.section sectionLinks]) {
			//		NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
			//[self.sectionView.pageCache cachedImageForPageIndex: link];
			//		[pool release];
			//[self.sectionView.pageCache precacheImageForPageIndex: link];
		[sectionViewCache setObject: [self viewForSection: link] forKey: link];
	}
	for (UIView *link in [self.section sectionLinks]) {
			//[self.sectionView.pageCache precacheImageForPageIndex: link]; //somthing changed in this method is causing the page not to turn sometimes for some reason
		[self.sectionView.pageCache cachedImageForPageIndex: link];
	}
	
}

*/

/*

- (void) cachePages {
		//[self.view addSubview: nextView];
		//[currentView removeFromSuperview];
	
	self.renderedImageCache = [NSMutableArray arrayWithCapacity: 4];
	
	CGRect halfPageRect = CGRectMake(0, 0, currentView.bounds.size.width / 2, currentView.bounds.size.height);
	
	[self.renderedImageCache addObject: (id)CGImageCreateWithImageInRect([self renderImageForView: [self loadSection: currentSectionIndex], halfPageRect)];
	halfPageRect.origin.x = halfPageRect.size.width;
	[self.renderedImageCache addObject: (id)CGImageCreateWithImageInRect([self renderImageForView: currentView], halfPageRect)];
	
	halfPageRect.origin.x = 0;
	[self.renderedImageCache addObject: (id)CGImageCreateWithImageInRect([self renderImageForView: nextView], halfPageRect)];
	halfPageRect.origin.x = halfPageRect.size.width;
	[self.renderedImageCache addObject: (id)CGImageCreateWithImageInRect([self renderImageForView: nextView], halfPageRect)];
	
	for (id cachedImage in self.renderedImageCache) {
		//LogImageData(@"leavesViewController", 2, 512, 768, UIImagePNGRepresentation([UIImage imageWithCGImage: (CGImageRef)cachedImage]));
	}
	
}

*/

	//- (IBAction) touchedOption



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
		//objectTextPopupController.contentSizeForViewInPopover = [popupTextView sizeThatFits: CGSizeMake(250, 100)];
		//popupTextView.bounds = CGRectMake(0, 0, [popupTextView sizeThatFits: CGSizeMake(250, 100)].width, [popupTextView sizeThatFits: CGSizeMake(250, 100)].height);//[popupTextView sizeThatFits: CGSizeMake(250, 100)];


	NSLog(@"textView height is: %f\noptionsContainer height is: %f", popupTextView.mainTextView.bounds.size.height, popupTextView.optionsContainer.bounds.size.height);
	NSLog(@"height of popup is %f", objectTextPopupController.contentSizeForViewInPopover.height);


	NSLog(@"pop type is: %@", popoverController.contentViewController.view.class);

		//[popController setPopoverContentSize:CGSizeMake(200.0, 200.0)];
	popoverController.popoverContentSize = [popupTextView sizeThatFits: CGSizeMake(250, 100)];

	[popoverController presentPopoverFromRect: [touchable frame] 
								   inView: [touchable superview] 
				 permittedArrowDirections: UIPopoverArrowDirectionAny 
								 animated: YES];

		//objectTextPopupController.contentSizeForViewInPopover = [popupTextView sizeThatFits: CGSizeMake(250, 100)];

	
		//	[popup release];
	
	
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

- (void) didTransitionToView: (UIView *)newView withID: (NSString *)viewID {
	if ((newView == self.nextSectionView)) {
		[self processCommandsForTouchable: nil];
		[self.sectionView removeFromSuperview];
		self.sectionView = (SectionView *)newView;
		[self.view addSubview: self.sectionView];
		previousSectionIndex = currentSectionIndex;
		currentSectionIndex = nextSectionIndex;
		nextSectionIndex = nil;
		self.section = self.sectionView.section;
			//cache the possible next views for the new section
		for (NSString *link in [self.section sectionLinks]) {
			[self viewForSection: link];
		}
	}
}


- (SectionView *) viewForSection: (NSString *)sectionIndexToLoad {
	
	NSLog(@"section at %p retainCount before assignment is: %i", self.section, self.section.retainCount);
			
	if ([self.sectionViewCache valueForKey: sectionIndexToLoad]) {
		return [self.sectionViewCache valueForKey: sectionIndexToLoad];
	} else {
		
		
		NSDictionary *sectionToLoad = [self.gameData contentsForSection: sectionIndexToLoad];
		
			//NSLog(@"section at %p retainCount after assignment is: %i", self.section, self.section.retainCount);

		NSLog(@"the sectionLog so far is:\n%@", self.gamebookLog.sectionLog);

		NSLog(@"the keyEventLog so far is:\n%@", self.gamebookLog.keyEventLog);
		NSLog(@"the databaseLog so far is:\n%@", self.gamebookLog.databaseLog);
		
		SectionView *sectionViewToReturn = [[SectionView alloc] initWithFrame: CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
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
	self.section = [self.gameData contentsForSection: currentSectionIndex];
	self.sectionView = [self viewForSection: currentSectionIndex];
	//self.sectionView.contentView = [self viewForSection: currentSectionIndex];

		//	self.sectionView.currentPageIndex = self.currentSectionIndex;
	self.currentSectionIndex = aSection;
	[self.transitionDelegate setCurrentView: self.sectionView];
	[self.view addSubview: self.sectionView];
	
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
	
//	self.section = [self.gameData contentsForSection: currentSectionIndex];
//	
//	self.sectionView.currentPageIndex = self.currentSectionIndex;
//	self.sectionView.contentView = [self viewForSection: currentSectionIndex];
//	[self.view addSubview: self.sectionView];
}

- (void) initPopup {
	objectTextPopupController = [[GameBookViewWithDelegate alloc] init];
	objectTextPopupController.delegate = self;
	popoverController = [[UIPopoverController alloc] initWithContentViewController: objectTextPopupController];
	popoverController.delegate = self;
//	popupTextView = [[TextView alloc] init];
//	
//	popupTextView.tag = OBJECT_POPUP_TEXT;
//		//[popupController.view addSubview: popup];
//	objectTextPopupController.view = popupTextView;
}



//- (void) setNextSectionIndex: (NSString *)newNextSectionIndex {
//	nextSectionIndex = newNextSectionIndex;
//	sectionView.nextPageIndex = newNextSectionIndex;
//}

//- (void) setCurrentSectionIndex: (NSString *)newCurrentSectionIndex {
//	currentSectionIndex = newCurrentSectionIndex;
//	sectionView.currentPageIndex = newCurrentSectionIndex;
//}


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
	[self initialize];
	
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
