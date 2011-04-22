//
//  InsidePagesViewController.h
//  GameBook
//
//  Created by James Pamplona on 3/30/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LeavesView.h"
//@protocol LeavesViewDelegate, LeavesViewDataSource;
@class LeavesView;


@interface InsidePagesTransitionComponent : UIViewController 
<LeavesViewDelegate, LeavesViewDataSource> {
	
	LeavesView *leavesView;
	UIView *nextView;
	UIView *currentView;
	UIViewController *transitionInitiator;
    
}
@property (nonatomic, retain) IBOutlet LeavesView *leavesView;
@property (nonatomic, retain) IBOutlet UIView *nextView;
@property (nonatomic, retain) IBOutlet UIView *currentView;
@property (assign, nonatomic) UIViewController *transitionInitiator;


- (CGImageRef) renderImageForView: (UIView *)viewToRender;
- (void)beginTransitionToView: (UIView *)newNextView sender: (UIViewController *)sender;



@end
