//
//  BookController.h
//  GameBook
//
//  Created by James Pamplona on 3/31/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GameBookViewWithDelegate.h"

@class CoverViewController;
@class MainTitleMenu;
@class PrologueViewController;
@class InsidePagesTransitionComponent;
@class CoverAnimationComponent;
@class SectionViewController;
@class OrderedDictionary;


@class GamebookLog;

@interface BookController : GameBookViewWithDelegate {
	OrderedDictionary *_bookParts;
	GamebookLog *gamebookLog;
    
}
	//@property (retain, nonatomic) UIView *insideContentView;

//@property (retain, nonatomic) IBOutlet CoverViewController *coverViewController;
@property (retain, nonatomic) IBOutlet UIView *coverView;
@property (retain, nonatomic) IBOutlet UIButton *cover;
@property (retain, nonatomic) IBOutlet MainTitleMenu *mainTitleMenu;
@property (retain, nonatomic) IBOutlet PrologueViewController *prologueViewController;
@property (retain, nonatomic) IBOutlet SectionViewController *sectionViewController;
@property (retain, nonatomic) IBOutlet InsidePagesTransitionComponent *insideTransitionDelegate;
@property (retain, nonatomic) IBOutlet CoverAnimationComponent *coverAnimationDelegate;
@property (retain, nonatomic) IBOutlet UIView *insideBookView;
@property (assign, nonatomic) UIView *currentView;
@property (retain, nonatomic) GamebookLog *gamebookLog;

	//@property (retain, nonatomic) UIView *insideContentView;

@property (copy, nonatomic) NSString *currentBookSectionID;

- (void)saveLogs;
- (void)loadLogs;

@end
