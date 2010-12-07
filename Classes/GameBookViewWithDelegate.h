//
//  GameBookViewWithDelegate.h
//  GameBook
//
//  Created by James Pamplona on 10/25/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GameBookViewDelegate <NSObject>
	// for future refactoring and simplification, think about whether it would be useful for these methods to send not just the UI controll that called the action (the sender: argument), but also the delegating object that it was called on. That way you could do different things depending on which type of view the action originated from. Then the same action called from a different view can do different things. e.g. do different things in the appropriate context from the user's point of view. Although the user doesn't need to be aware of this.

//- (IBAction) respondToButton: (id)sender;

- (IBAction) openCover: (id) sender;

- (IBAction) newGame: (id) sender;

- (IBAction) continueGame: (id) sender;

- (IBAction) gameBookOptions: (id)sender;

@optional

- (IBAction) getChosenOption: (id) sender;


@end


@interface GameBookViewWithDelegate : UIViewController <GameBookViewDelegate> {
	id delegate;

}

//- (IBAction) respondToButton: (id)sender;
/*
- (IBAction) openCover: (id) sender;

- (IBAction) newGame: (id) sender;

- (IBAction) continueGame: (id) sender;

- (IBAction) gameBookOptions: (id)sender;


*/

@property (assign, nonatomic) IBOutlet id<GameBookViewDelegate> delegate;

@end
