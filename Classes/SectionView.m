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

@synthesize leftPageView; 
@synthesize rightPageView;
@synthesize spreadSceneView;

//@synthesize leftTextView;
//@synthesize rightTextView;


- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
		
		self.backgroundColor = [UIColor colorWithRed: (255.0 / 255.0)
											   green: (250.0 / 255.0) 
												blue: (235.0 / 255.0) 
											   alpha: 1];
		fullSpreadRect = CGRectMake(self.bounds.origin.x + 12, 0, self.bounds.size.width - 24, self.bounds.size.height);
			//		leftHalfRect = fullSpreadRect;

		CGRectDivide(fullSpreadRect, &leftHalfRect, &rightHalfRect, CGRectGetWidth(fullSpreadRect) / 2.0f, CGRectMinXEdge);
		
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
		
		if ([section valueForKeyPath: @"left.text"]) {
				//NSLog(@"Right page text is: %@", [section valueForKeyPath: @"right.text"]);
				//NSLog(@"Right page text is: %@", self.textViewRightText.text);
			self.leftPageView = [[TextView alloc] initWithFrame: leftHalfRect];
			
			self.leftPageView.tag = LEFT_PAGE_TEXT;
//			self.leftPageView.backgroundColor = [UIColor clearColor];
//	self.leftPageView.backgroundColor = [UIColor blueColor];

				//NSLog(@"textViewRight is:\n%@", leftPageView);
			
			[self.leftPageView setPageContents: [section valueForKey: @"left"]];
				//NSLog(@"The right Text is: \n%@", self.leftPageView.text);
			[self addSubview: self.leftPageView];
		}
		else {
			
				//NSLog(@"%@: leftSceneView frame is: %@", self, NSStringFromCGRect(self.bounds));
				//self.leftPageView.hidden = YES;
			self.leftPageView = [[SceneView alloc] initWithFrame: leftHalfRect];
			
			self.leftPageView.tag = LEFT_PAGE_SCENE;
			[self.leftPageView setPageContents: [section valueForKey: @"left"]];
			[self addSubview: self.leftPageView];
			[self.layer insertSublayer: self.leftPageView.layer below: topPageReverse];
		}

		
		
#pragma mark Right Page

		
		if ([section valueForKeyPath: @"right.text"]) {
			
				//NSLog(@"Right page text is: %@", [section valueForKeyPath: @"right.text"]);
				//NSLog(@"Right page text is: %@", self.textViewRightText.text);
			self.rightPageView = [[TextView alloc] initWithFrame: rightHalfRect];
			
				// the division is to convert from 0-255 color values to the 0-1 color values UIColor uses.
			self.rightPageView.tag = RIGHT_PAGE_TEXT;
			
//			self.rightPageView.backgroundColor = [UIColor clearColor];
//	self.rightPageView.backgroundColor = [UIColor blueColor];

				//NSLog(@"textViewRight is:\n%@", rightPageView);
			
			[self.rightPageView setPageContents: [section valueForKey: @"right"]];
				//NSLog(@"The right Text is: \n%@", self.rightPageView.text);
				//NSLog(@"RIGHT_PAGE_TEXT is: %i", RIGHT_PAGE_TEXT);
				//NSLog(@"rightPageView tag is: %i", self.rightPageView.tag);
			[self addSubview: self.rightPageView];
			
		}
		else {
				//NSLog(@" right page is a scene");
			self.rightPageView = [[SceneView alloc] initWithFrame: rightHalfRect];
			self.rightPageView.tag = RIGHT_PAGE_SCENE;
			
			[self.rightPageView setPageContents: [section valueForKey: @"right"]];
			NSLog(@"RIGHT_PAGE_SCENE is: %i", RIGHT_PAGE_SCENE);
			NSLog(@"rightPageViewTag is: %i", self.rightPageView.tag);
			[self addSubview: self.rightPageView];
			[self.layer insertSublayer: self.rightPageView.layer below: topPageReverse];

				//[self addSubview: self.rightPageView];			
			
			
			
		}
		
			  
	}
#pragma mark Spread Page

	else {
		NSLog(@"section is:\n%@", section);
		self.spreadSceneView = [[SceneView alloc] initWithFrame: fullSpreadRect];
		self.spreadSceneView.tag = SPREAD_PAGE_SCENE;

		[self.spreadSceneView setPageContents: [section valueForKey: @"spread"]];
		[self addSubview: self.spreadSceneView];
		[self.layer insertSublayer: self.spreadSceneView.layer below: topPageReverse];
				
	}
	[self setupShadows];

}

- (void) setupShadows {
	leftPageShadow = [[CAGradientLayer alloc] init];
	leftPageShadow.colors = [NSArray arrayWithObjects:
							 (id)[[[UIColor blackColor] colorWithAlphaComponent:0.6] CGColor],
							 (id)[[UIColor clearColor] CGColor],
							 nil];
	leftPageShadow.startPoint = CGPointMake(0,0.5);
	leftPageShadow.endPoint = CGPointMake(1,0.5);
	leftPageShadow.frame = CGRectMake(self.bounds.size.width / 2, 
									  self.bounds.origin.y, 
									  40, 
									  self.bounds.size.height);
	rightPageShadow = [[CAGradientLayer alloc] init];
	rightPageShadow.colors = [NSArray arrayWithObjects:
							  (id)[[[UIColor blackColor] colorWithAlphaComponent:0.6] CGColor],
							  (id)[[UIColor clearColor] CGColor],
							  nil];
	rightPageShadow.startPoint = CGPointMake(1,0.5);
	rightPageShadow.endPoint = CGPointMake(0,0.5);
	rightPageShadow.frame = CGRectMake(self.bounds.size.width / 2, 
									   self.bounds.origin.y, 
									   -40, 
									   self.bounds.size.height);
	[self.layer insertSublayer:rightPageShadow below: topPageReverse];
	[self.layer insertSublayer:leftPageShadow below: topPageReverse];
	
	CALayer *pageEdgeRight = [CALayer layer];
	CALayer *pageEdgeLeft = [CALayer layer];
	pageEdgeLeft.frame = CGRectMake(0, -3, 12, self.bounds.size.height + 5);
	pageEdgeRight.frame = CGRectMake(self.bounds.size.width - 12, -2, 12, self.bounds.size.height + 5);
	pageEdgeLeft.contents = (id)[UIImage imageNamed: @"pageEdge_left.png"].CGImage;
	pageEdgeRight.contents = (id)[UIImage imageNamed: @"pageEdge_right.png"].CGImage;
	[self.layer addSublayer: pageEdgeLeft];
	[self.layer addSublayer: pageEdgeRight];
//	[self.layer addSublayer: rightPageShadow];
//	[self.layer addSublayer: leftPageShadow];
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
