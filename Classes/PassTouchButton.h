//
//  PassTouchButton.h
//  pageFlipPrototypeControllerVersion
//
//  Created by James Pamplona on 1/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface PassTouchButton : UIButton {
	NSSet *receivedTouch;
	UIEvent *receivedEvent;
}
@property (nonatomic, retain) NSSet *receivedTouch;
@property (nonatomic, retain) UIEvent *receivedEvent;

@end
