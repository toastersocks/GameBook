//
//  PagesViewController.h
//  GameBook
//
//  Created by James Pamplona on 10/16/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GameBookViewWithDelegate.h"
#import "SectionParser.h"
#import "SectionView.h"

	//#import "SectionView.h"
//@protocol LeavesViewDelegate;
//@protocol LeavesViewDataSource;

@class SectionContents;
@class OptionViewController;
	//@class SinglePageController;
@class SectionView;
@class GamebookLog;
@class TextView;


@interface PagesViewController : GameBookViewWithDelegate <GameBookViewDelegate, UIPopoverControllerDelegate, LeavesViewDelegate, LeavesViewDataSource> { // how to declare in the interface that a class can take a delegate protocol? this probably exists and would eliminate a lot of duplicate code...
	
	NSDictionary *section;
	
	SectionParser *gameData;
	LeavesView *sectionView;
	
	GamebookLog *gamebookLog;

	
	NSDictionary *currentObject;
	
	NSDictionary *currentOption;
	
	GameBookViewWithDelegate *objectTextPopupController;
	UIPopoverController *popoverController;
	TextView *popupTextView;

	NSMutableArray *renderedImageCache;
	
	NSString *currentSectionIndex;
	NSString *nextSectionIndex;
	NSString *previousSectionIndex;
	
	NSMutableDictionary *sectionViewCache;

}

@property (retain, nonatomic) NSDictionary *section;


@property (retain, nonatomic) SectionParser *gameData;

	//using one view which takes care of displaying the section correctly
@property (retain, nonatomic) LeavesView *sectionView;
@property (retain, nonatomic) GamebookLog *gamebookLog;

@property (retain, nonatomic) NSDictionary *currentObject;


@property (nonatomic, retain) NSMutableArray *renderedImageCache;

@property (nonatomic, retain) NSString *currentSectionIndex;
@property (nonatomic, retain) NSString *nextSectionIndex;

@property (nonatomic, retain) NSMutableDictionary *sectionViewCache;



	//@property (retain, nonatomic) GameBookViewWithDelegate *objectTextPopupController;

//@property (retain, nonatomic) IBOutlet OptionViewController *optionContainerController;
//@property (retain, nonatomic) IBOutlet UITextView *mainText;



- (void) initialize;

- (void) beginNewGame;
- (void) continueGame;

- (void) initPopup;


- (CGImageRef) renderImageForView: (UIView *)viewToRender;


- (SectionView *) viewForSection: (NSString *) sectionIndex;
- (IBAction) getChosenOption: (id) sender;
//- (void) logChoice: (NSString *) pageIndex;



@end
