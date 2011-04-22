//
//  OpenBookViewController.h
//  GameBook
//
//  Created by James Pamplona on 2/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewSwitchProtocol.h"
#import "LeavesView.h"
#import "ViewSwitchProtocol.h"
//@protocol ViewSwitchDelegateProtocol;
//@protocol LeavesViewDelegate;
//@protocol LeavesViewDataSource;

@class LeavesView;
@class PagesViewController;

@interface OpenBookViewController : UIViewController <ViewSwitchDelegateProtocol, LeavesViewDelegate, LeavesViewDataSource> {
	LeavesView *leavesView;
	UIView *nextView;
	UIView *currentView;
	NSString *currentViewID;
	NSString *nextViewID;
	NSString *currentSectionViewID;
	
	PagesViewController *bookSectionController;
	
		//NSMutableDictionary *viewIndexKeyPaths;
		//NSArray *bookSections;
	id delegatingSender;
	id delegate;
}
@property (nonatomic, retain) IBOutlet LeavesView *leavesView;
@property (nonatomic, retain) IBOutlet UIView *nextView;
@property (nonatomic, retain) IBOutlet UIView *currentView;
@property (nonatomic, copy) NSString *currentViewID;
@property (nonatomic, copy) NSString *nextViewID;
@property (nonatomic, copy) NSString *currentSectionViewID;

@property (nonatomic, retain) PagesViewController *bookSectionController;


@property (nonatomic, assign) id delegate;

	//@property (nonatomic, retain) NSMutableDictionary *viewIndexKeyPaths;
	//@property (nonatomic, retain) NSArray *bookSections;
-(IBAction)actionForLeftEdge: (id)sender;
-(IBAction)actionForRightEdge: (id)sender;

@end
