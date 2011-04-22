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
@synthesize cgImage;


//@synthesize leftTextView;
//@synthesize rightTextView;


- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
		
		self.backgroundColor = [UIColor colorWithRed: (255.0 / 255.0)
											   green: (250.0 / 255.0) 
												blue: (235.0 / 255.0) 
											   alpha: 1];
		fullSpreadRect = CGRectMake(self.bounds.origin.x, 0, self.bounds.size.width, self.bounds.size.height);
			//		leftHalfRect = fullSpreadRect;

		CGRectDivide(fullSpreadRect, &leftHalfRect, &rightHalfRect, CGRectGetWidth(fullSpreadRect) / 2.0f, CGRectMinXEdge);
		self.layer.opaque = YES;
		
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
//self.leftPageView.backgroundColor = [UIColor purpleColor];

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
				//			[self.layer insertSublayer: self.leftPageView.layer below: topPageReverse];
		}

		
		
#pragma mark Right Page

		
		if ([section valueForKeyPath: @"right.text"]) {
			
				//NSLog(@"Right page text is: %@", [section valueForKeyPath: @"right.text"]);
				//NSLog(@"Right page text is: %@", self.textViewRightText.text);
			self.rightPageView = [[TextView alloc] initWithFrame: rightHalfRect];
			
				// the division is to convert from 0-255 color values to the 0-1 color values UIColor uses.
			self.rightPageView.tag = RIGHT_PAGE_TEXT;
			
//			self.rightPageView.backgroundColor = [UIColor clearColor];
//self.rightPageView.backgroundColor = [UIColor purpleColor];

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
				//	[self.layer insertSublayer: self.rightPageView.layer below: topPageReverse];

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
			//	[self.layer insertSublayer: self.spreadSceneView.layer below: topPageReverse];
				
	}

		//self.cgImage = [self renderImageForView: self];
	//LogImageData(@"sectionView", 3, 1024, 768, UIImagePNGRepresentation([UIImage imageWithCGImage: self.cgImage]));
}



- (CGImageRef) renderImageForView: (UIView *)viewToRender {
	UIGraphicsBeginImageContext(viewToRender.bounds.size);
	
	CGContextRef context = UIGraphicsGetCurrentContext();
	[viewToRender.layer renderInContext: context];
		//	[viewToRender.layer.presentationLayer renderInContext: context];
	
	CGImageRef renderedImage = [UIGraphicsGetImageFromCurrentImageContext() CGImage];
	
	UIGraphicsEndImageContext();
	LogMessage(@"sectionView", 3, @"Retain count for renderedImage is: %i", CFGetRetainCount(renderedImage));

	return renderedImage;
	
}

-(void)setCgImage: (CGImageRef)newCGImageRef {
	if (!(newCGImageRef == cgImage)) {
		CGImageRelease(cgImage);
		cgImage = newCGImageRef;
		CGImageRetain(cgImage);
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
