//
//  CoverViewController.h
//  GameBook
//
//  Created by James Pamplona on 10/23/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GameBookViewWithDelegate.h"


//@protocol CoverViewControllerDelegate <NSObject>
//
//- (IBAction) openCover: (id)sender;
//
//@end


//@class GameBookViewWithDelegate;


@interface CoverViewController : GameBookViewWithDelegate {
	
	UIButton *coverButton;
	//id delegate;

}

@property (retain, nonatomic) IBOutlet UIButton *coverButton;
//@property(retain, nonatomic) IBOutlet id <CoverViewControllerDelegate> delegate;

- (IBAction) openCover: (id)sender;

//- (IBAction) coverButtonTouched;

@end
