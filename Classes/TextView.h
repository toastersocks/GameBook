//
//  TextView.h
//  GameBook
//
//  Created by James Pamplona on 11/28/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface TextView : UIView {
	UITextView *mainTextView;
	UIView *optionsContainer;
	NSString *text;
	NSArray *options;
	NSDictionary *layout;
	

}

@property (nonatomic, retain) NSString *text;
@property (nonatomic, retain) NSArray  *options;
@property (nonatomic, retain) NSDictionary *layout;

@property (nonatomic, retain) UITextView *mainTextView;
@property (nonatomic, retain) UIView *optionsContainer;

	//- (CGSize) popupSizeThatFits: (CGSize)size;
	//- (void) sizeToFitPopup;

@end
