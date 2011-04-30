//
//  BookController.m
//  GameBook
//
//  Created by James Pamplona on 3/31/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BookController.h"

#import "OrderedDictionary.h"

#import "CoverViewController.h"
#import "MainTitleMenu.h"
#import "PrologueViewController.h"
#import "SectionViewController.h"
#import "InsidePagesTransitionComponent.h"
#import "GamebookLog.h"

	//!!!!: Replacement class for BookViewController

@implementation BookController

//@synthesize insideContentView;

//@synthesize insideContentViewID;

//@synthesize coverViewController;
@synthesize coverView;
@synthesize mainTitleMenu;
@synthesize prologueViewController;
@synthesize sectionViewController;
@synthesize insideTransitionDelegate;
@synthesize insideBookView;
@synthesize currentView;
@synthesize gamebookLog;

@synthesize currentBookSectionID;


- (IBAction) openCover: (id)sender {
	[self.coverView removeFromSuperview];
	self.insideTransitionDelegate.currentView = self.mainTitleMenu;
	self.currentBookSectionID = @"MainMenu";
		//	[self.insideBookView addSubview: self.mainTitleMenu.view];
	self.insideBookView.frame = self.insideTransitionDelegate.leavesView.contentViewFrame;
	self.insideTransitionDelegate.contentView = self.insideBookView;
	self.insideTransitionDelegate.view.frame = CGRectMake(0, 0, 1024, 768);
	[self.view addSubview: self.insideTransitionDelegate.view];
	
}

- (IBAction) showPrologue {
	LogMessage(@"BookController", 0, @"In the showPrologue method");
	[self.view addSubview: self.prologueViewController.view];
}

- (IBAction)newGame:(id)sender {
	LogMessage(@"BookController", 0, @"In the newGame method");
	self.sectionViewController.sectionView = [self.sectionViewController viewForSection: @"IndexTest"];
	[self.insideTransitionDelegate beginCutToView: [_bookParts objectForKey: @"StorySections"] sender: self];
//	self.currentBookSectionID = @"StorySections";
//	self.sectionViewController.sectionView = [self.sectionViewController viewForSection: @"IndexTest"];
	
//	self.insideTransitionDelegate.leavesView.contentView = 
}

- (void)didTransitionToView: (UIView *)aView {
	self.currentBookSectionID = [[_bookParts allKeysForObject: aView] lastObject];
	NSAssert(self.currentBookSectionID != nil, @"currentBookSectionID is nil", nil);
}

- (void)saveLogs {
	[self.gamebookLog saveLogs];
}

- (void)loadLogs {
	[self.gamebookLog loadLogs];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
		self.gamebookLog = [GamebookLog sharedGamebookLog];
//		self.coverViewController.delegate = self;
		_bookParts = [[OrderedDictionary alloc] initWithCapacity: 4 ];
		[_bookParts setObject: self.mainTitleMenu.view forKey:@"MainMenu"];
		[_bookParts setObject: self.sectionViewController.view forKey:@"StorySections"];
//		self.insideTransitionDelegate.leavesView.contentView = self.insideBookView;
        // Custom initialization
    }
    return self;
}

- (void)setCurrentBookSectionID:(NSString *)newCurrentBookSectionID {
	[[_bookParts valueForKey: currentBookSectionID] removeFromSuperview];
	currentBookSectionID = [newCurrentBookSectionID copy];
	[[_bookParts valueForKey: currentBookSectionID] setFrame: CGRectMake(0, 0, 1004, 768)];
	[self.insideBookView addSubview: [_bookParts valueForKey: currentBookSectionID]];
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


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
	
	self.gamebookLog = [GamebookLog sharedGamebookLog];
		//		self.coverViewController.delegate = self;
	_bookParts = [[OrderedDictionary alloc] initWithCapacity: 4 ];
	[_bookParts setObject: self.mainTitleMenu.view forKey:@"MainMenu"];
	[_bookParts setObject: self.sectionViewController.view forKey:@"StorySections"];
//	self.insideTransitionDelegate.leavesView.contentView = self.insideBookView;
	self.sectionViewController.transitionDelegate = self.insideTransitionDelegate;
}


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
