//
//  BookViewController.h
//  GameBook
//
//  Created by James Pamplona on 10/22/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoverViewController.h"
#import "GameBookViewWithDelegate.h"

@class PagesViewController;
@class PrologueViewController;
@class CoverViewController;
@class MainTitleMenu;
@class GamebookLog;





@interface BookViewController : UIViewController <GameBookViewDelegate> {
	PagesViewController *pagesViewController;
	PrologueViewController *prologueViewController;
	CoverViewController *coverViewController;
	MainTitleMenu *mainTitleMenu;

	GamebookLog *gamebookLog;
		

}

//- (void) displayCover;
// - (void) changeToView: (UIViewController *)newView; // maybe eventually abstract all the view changing methods to something general like this.
- (IBAction) respondToButton:(id)sender; // this doesn't do anything right now. maybe it will in the future, instead of having a seperate method for each button, have one method that responds to all the buttons and calls the appropriate methods accordingly.
- (void) startGamebook;


//- (IBAction) displayMainMenu; 


@property (retain, nonatomic) IBOutlet PagesViewController *pagesViewController;
@property (retain, nonatomic) IBOutlet PrologueViewController *prologueViewController;
@property (retain, nonatomic) IBOutlet CoverViewController *coverViewController;
@property (retain, nonatomic) IBOutlet MainTitleMenu *mainTitleMenu;

@property (nonatomic, retain) IBOutlet GamebookLog *gamebookLog;



@end
