//
//  PassTouchButton.m
//  pageFlipPrototypeControllerVersion
//
//  Created by James Pamplona on 1/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PassTouchButton.h"


@implementation PassTouchButton

@synthesize receivedTouch;
@synthesize receivedEvent;


- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	LogMessage(@"PassTouchButton", 2, @"In the touchesBegan method of PassTouchButton");

	self.receivedTouch = touches;
	self.receivedEvent = event;
	[super touchesBegan: touches withEvent: event];

	[self.nextResponder touchesBegan:touches withEvent:event];

}


- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	LogMessage(@"PassTouchButton", 2, @"In the touchesEnded method of PassTouchButton");
	[super touchesEnded: touches withEvent: event];
	[self.nextResponder touchesEnded: touches withEvent: event];

}

- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	LogMessage(@"PassTouchButton", 2, @"In the touchesMoved method of PassTouchButton");
	[super touchesMoved: touches withEvent: event];
	[self.nextResponder touchesMoved: touches withEvent: event];

}

- (void) touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
	LogMessage(@"PassTouchButton", 2, @"In the touchesCancelled method of PassTouchButton");
	[super touchesCancelled: touches withEvent: event];
	[self.nextResponder touchesCancelled: touches withEvent: event];

}
@end
