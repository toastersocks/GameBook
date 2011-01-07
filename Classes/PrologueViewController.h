//
//  PrologueViewController.h
//  GameBook
//
//  Created by James Pamplona on 10/22/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GameBookViewWithDelegate.h"

	//@class WaxLua;


@interface PrologueViewController : GameBookViewWithDelegate {
	UILabel *prologueTextLabel;
		//	WaxLua *lua;
	unichar currentChar;
	NSString *path;
	NSString *prologueText;
	int prologueTextIndex;
	
	NSMutableString *padding;
	
	unsigned int prologueTextLength; //change this to NSUInteger?
	
	NSTimeInterval delay;


}


@property (retain, nonatomic) IBOutlet UILabel *prologueTextLabel;

	//@property (retain, nonatomic) WaxLua *lua;

- (IBAction) dismissPrologue; // this just dismisses itself. if ANY other action needs to be taken besides just dismissing the prologue, add a method to the GameBookViewWithDelegate protocol and let the GameBookViewController take care of it.

- (void) beginPrologue;

- (void) printChar;

@end
