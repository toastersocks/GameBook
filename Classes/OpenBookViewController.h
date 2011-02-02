//
//  OpenBookViewController.h
//  GameBook
//
//  Created by James Pamplona on 2/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
	//#import "LeavesView.h"
@class LeavesView;

@interface OpenBookViewController : UIViewController {
	LeavesView *leavesView;
}
@property (nonatomic, assign) LeavesView *leavesView;

@end
