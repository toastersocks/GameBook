//
//  PrologueViewController.h
//  GameBook
//
//  Created by James Pamplona on 10/22/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GameBookViewWithDelegate.h"


@interface PrologueViewController : GameBookViewWithDelegate {

}

- (IBAction) dismissPrologue; // this just dismisses itself. if ANY other action needs to be taken besides just dismissing the prologue, add a method to the GameBookViewWithDelegate protocol and let the GameBookViewController take care of it.

@end
