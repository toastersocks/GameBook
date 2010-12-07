//
//  SectionView.m
//  GameBook
//
//  Created by James Pamplona on 11/26/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "SectionView.h"
#import "SceneView.h"
#import "TextView.h"
//#import "OptionViewController.h"

#import "Constants.h"


@implementation SectionView

@synthesize section;

@synthesize leftSceneView; 
@synthesize rightSceneView;
@synthesize spreadSceneView;

@synthesize leftTextView;
@synthesize rightTextView;


- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
		
		self.backgroundColor = [UIColor colorWithRed: (255.0 / 255.0)
											   green: (250.0 / 255.0) 
												blue: (235.0 / 255.0) 
											   alpha: 1];
		// Initialization code
		//NSLog(@"%@: Frame is:%@", self, NSStringFromCGRect(frame));
    }
    return self;
}

- (void) setSection:(NSDictionary *) inSection {
	if (section != inSection) {
		[section release];
		section = [inSection retain];
	}
		//NSLog(@"Section is:\n%@", self.section);
		// TODO: combine the left and right ifs into one since they are basically the same.
	if (![section valueForKey: @"spread"]) {
#pragma mark Left Page
		
		if (![section valueForKeyPath: @"left.text"]) {
				//NSLog(@"%@: leftSceneView frame is: %@", self, NSStringFromCGRect(self.bounds));
				//self.leftTextView.hidden = YES;
			self.leftSceneView = [[SceneView alloc] initWithFrame: CGRectMake(self.bounds.origin.x, 
																			  self.bounds.origin.y, 
																			  self.bounds.size.width / 2, 
																			  self.bounds.size.height)];
			self.leftSceneView.tag = LEFT_PAGE_SCENE;
			self.leftSceneView.scene = [section valueForKey: @"left"];
			[self addSubview: self.leftSceneView];
			
		}
		else {
				//NSLog(@"Right page text is: %@", [section valueForKeyPath: @"right.text"]);
				//NSLog(@"Right page text is: %@", self.textViewRightText.text);
			self.leftTextView = [[TextView alloc] initWithFrame: CGRectMake(self.bounds.origin.x, 
																			 self.bounds.origin.y, 
																			 self.bounds.size.width / 2,
																			 self.bounds.size.height)];
				
			self.leftTextView.tag = LEFT_PAGE_TEXT;
			self.leftTextView.backgroundColor = [UIColor clearColor];
				//NSLog(@"textViewRight is:\n%@", leftTextView);
			
			self.leftTextView.layout = [section valueForKey: @"left"];
				//NSLog(@"The right Text is: \n%@", self.leftTextView.text);
			[self addSubview: self.leftTextView];
		}
		
#pragma mark Right Page

		
		if (![section valueForKeyPath: @"right.text"]) {
				//NSLog(@" right page is a scene");
			self.rightSceneView = [[SceneView alloc] initWithFrame: CGRectMake(self.bounds.size.width / 2, 
																		  self.bounds.origin.y, 
																		  self.bounds.size.width / 2,
																		  self.bounds.size.height)];
			self.rightSceneView.tag = RIGHT_PAGE_SCENE;

			self.rightSceneView.scene = [section valueForKey: @"right"];
			NSLog(@"RIGHT_PAGE_SCENE is: %i", RIGHT_PAGE_SCENE);
			NSLog(@"rightSceneViewTag is: %i", self.rightSceneView.tag);
			[self addSubview: self.rightSceneView];			
		}
		else {
				//NSLog(@"Right page text is: %@", [section valueForKeyPath: @"right.text"]);
				//NSLog(@"Right page text is: %@", self.textViewRightText.text);
			self.rightTextView = [[TextView alloc] initWithFrame: CGRectMake(self.bounds.size.width / 2, 
																			   self.bounds.origin.y, 
																			   self.bounds.size.width / 2,
																			   self.bounds.size.height)];
				// the division is to convert from 0-255 color values to the 0-1 color values UIColor uses.
			self.rightTextView.tag = RIGHT_PAGE_TEXT;

			self.rightTextView.backgroundColor = [UIColor clearColor];
				//NSLog(@"textViewRight is:\n%@", rightTextView);

			self.rightTextView.layout = [section valueForKey: @"right"];
			//NSLog(@"The right Text is: \n%@", self.rightTextView.text);
			//NSLog(@"RIGHT_PAGE_TEXT is: %i", RIGHT_PAGE_TEXT);

			//NSLog(@"rightTextView tag is: %i", self.rightTextView.tag);

			[self addSubview: self.rightTextView];
		}
			  
	}
#pragma mark Spread Page

	else {
		NSLog(@"section is:\n%@", section);
		self.spreadSceneView = [[SceneView alloc] initWithFrame: CGRectMake(0,
																	   0, 
																	   self.bounds.size.width, 
																	   self.bounds.size.height)];
		self.spreadSceneView.tag = SPREAD_PAGE_SCENE;

		self.spreadSceneView.scene = [section valueForKey: @"spread"];
		[self addSubview: self.spreadSceneView];	
	}

}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void) awakeFromNib {
		//NSLog(@"textViewRight is:\n%@", self.textViewRight);
}

- (void)dealloc {
    [super dealloc];
}


@end
