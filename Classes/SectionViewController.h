//
//  SectionViewController.h
//  GameBook
//
//  Created by James Pamplona on 3/24/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GameBookViewWithDelegate.h"

@class SectionView;
@class GamebookLog;
@class SectionParser;
@class InsidePagesTransitionComponent;
@class TextView;

@interface SectionViewController : GameBookViewWithDelegate {
	SectionView *sectionView;
	NSDictionary *touchedObject;
	GamebookLog *gamebookLog;
	SectionParser *gameData;
	
	InsidePagesTransitionComponent *transitionDelegate;
	
	
	GameBookViewWithDelegate *objectTextPopupController;
	UIPopoverController *popoverController;
	TextView *popupTextView;
}

@property (nonatomic, retain) SectionView *sectionView;
@property (nonatomic, retain) NSDictionary *touchedObject;
@property (retain, nonatomic) GamebookLog *gamebookLog;
@property (retain, nonatomic) IBOutlet SectionParser *gameData;

@property (retain, nonatomic) InsidePagesTransitionComponent *transitionDelegate;

- (void) showPopupForCurrentOptionFromTouchable: (id)touchable;
- (SectionView *)viewForSection: (NSString *)sectionIndex;

@end
