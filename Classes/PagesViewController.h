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
	//#import "SectionView.h"

@class SectionContents;
@class OptionViewController;
	//@class SinglePageController;
@class SectionView;
@class GamebookLog;
@class TextView;


@interface PagesViewController : GameBookViewWithDelegate { // how to declare in the interface that a class can take a delegate protocol? this probably exists and would eliminate a lot of duplicate code...
	
	NSDictionary *section;
	
	SectionParser *gameData;
	SectionView *sectionView;
	
	GamebookLog *gamebookLog;

	
	NSDictionary *currentObject;
	
	GameBookViewWithDelegate *objectTextPopupController;
	UIPopoverController *popoverController;
	TextView *popupTextView;

//	OptionViewController *optionContainerController;
//	UITextView *mainText;

}

@property (retain, nonatomic) NSDictionary *section;


@property (retain, nonatomic) SectionParser *gameData;

	//using one view which takes care of displaying the section correctly
@property (retain, nonatomic) SectionView *sectionView;
@property (retain, nonatomic) GamebookLog *gamebookLog;

@property (retain, nonatomic) GameBookViewWithDelegate *objectTextPopupController;

//@property (retain, nonatomic) IBOutlet OptionViewController *optionContainerController;
//@property (retain, nonatomic) IBOutlet UITextView *mainText;



- (void) startParser;


- (void) beginNewGame;

- (void) continueGame;

- (void) initPopup;



- (void) loadSection: (NSString *) sectionIndex;
- (IBAction) getChosenOption: (id) sender;
//- (void) logChoice: (NSString *) pageIndex;



@end
