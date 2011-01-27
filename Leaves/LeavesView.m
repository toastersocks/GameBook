//
//  LeavesView.m
//  Leaves
//
//  Created by Tom Brow on 4/18/10.
//  Copyright 2010 Tom Brow. All rights reserved.
//

#import "LeavesView.h"
#import "LeavesCache.h"


#pragma mark -
#pragma mark Private interface

@interface LeavesView () 

@property (nonatomic, assign) CGFloat leafEdge;

- (void)setUpLayers;
- (void)setUpLayersForViewingMode;

@end

CGFloat distance(CGPoint a, CGPoint b);



#pragma mark -
#pragma mark Implementation

@implementation LeavesView

@synthesize delegate;
@synthesize mode;
@synthesize leafEdge, backgroundRendering;
@synthesize currentPageIndex, nextPageIndex;

@synthesize pageCache;




- (void) setUpLayers {
	self.clipsToBounds = YES;
    
	topPage = [[CALayer alloc] init];
	topPage.masksToBounds = YES;
	topPage.contentsGravity = kCAGravityLeft;
	topPage.backgroundColor = [[UIColor whiteColor] CGColor];
	
	topPageOverlay = [[CALayer alloc] init];
	topPageOverlay.backgroundColor = [[[UIColor blackColor] colorWithAlphaComponent:0.2] CGColor];
	
	topPageShadow = [[CAGradientLayer alloc] init];
	topPageShadow.colors = [NSArray arrayWithObjects:
							(id)[[[UIColor blackColor] colorWithAlphaComponent:0.6] CGColor],
							(id)[[UIColor clearColor] CGColor],
							nil];
	topPageShadow.startPoint = CGPointMake(1,0.5);
	topPageShadow.endPoint = CGPointMake(0,0.5);
	
	topPageReverse = [[CALayer alloc] init];
	topPageReverse.backgroundColor = [[UIColor whiteColor] CGColor];
	topPageReverse.masksToBounds = YES;
	
	topPageReverseImage = [[CALayer alloc] init];
	topPageReverseImage.masksToBounds = YES;
	
	topPageReverseOverlay = [[CALayer alloc] init];
	
	topPageReverseShading = [[CAGradientLayer alloc] init];
	topPageReverseShading.colors = [NSArray arrayWithObjects:
									(id)[[[UIColor blackColor] colorWithAlphaComponent:0.6] CGColor],
									(id)[[UIColor clearColor] CGColor],
									nil];
	topPageReverseShading.startPoint = CGPointMake(1,0.5);
	topPageReverseShading.endPoint = CGPointMake(0,0.5);
	
	bottomPage = [[CALayer alloc] init];
		//bottomPage.backgroundColor = [[UIColor orangeColor] CGColor];
	bottomPage.masksToBounds = YES;
	
	bottomPageShadow = [[CAGradientLayer alloc] init];
	bottomPageShadow.colors = [NSArray arrayWithObjects:
							   (id)[[[UIColor blackColor] colorWithAlphaComponent:0.6] CGColor],
							   (id)[[UIColor clearColor] CGColor],
							   nil];
	bottomPageShadow.startPoint = CGPointMake(0,0.5);
	bottomPageShadow.endPoint = CGPointMake(1,0.5);
	
	[topPage addSublayer:topPageOverlay];
	[topPageReverse addSublayer:topPageReverseImage];
	[topPageReverse addSublayer:topPageReverseOverlay];
	[topPageReverse addSublayer:topPageReverseShading];
	[bottomPage addSublayer:bottomPageShadow];

    // Setup for the left page in two-page mode
    leftPage = [[CALayer alloc] init];
	leftPage.masksToBounds = YES;
	leftPage.contentsGravity = kCAGravityLeft;
	leftPage.backgroundColor = [[UIColor whiteColor] CGColor];
	
	leftPageOverlay = [[CALayer alloc] init];
	leftPageOverlay.backgroundColor = [[[UIColor blackColor] colorWithAlphaComponent:0.2] CGColor];
		
	[leftPage addSublayer:leftPageOverlay];
    
	[self.layer addSublayer:leftPage];
	[self.layer addSublayer:bottomPage];
	[self.layer addSublayer:topPage];
	[self.layer addSublayer:topPageReverse];
    [self.layer addSublayer:topPageShadow];
    
    [self setUpLayersForViewingMode];
	
	self.leafEdge = 1.0;
}


- (void)setUpLayersForViewingMode {
	mode = LeavesViewModeFacingPages;
    if (self.mode == LeavesViewModeSinglePage) {
        topPageReverseImage.contentsGravity = kCAGravityRight;
        topPageReverseOverlay.backgroundColor = [[[UIColor whiteColor] colorWithAlphaComponent:0.8] CGColor];
        topPageReverseImage.transform = CATransform3DMakeScale(-1, 1, 1);
    } else {
        topPageReverseImage.contentsGravity = kCAGravityLeft;
        topPageReverseOverlay.backgroundColor = [[[UIColor whiteColor] colorWithAlphaComponent:0.0] CGColor];
        topPageReverseImage.transform = CATransform3DMakeScale(1, 1, 1);
    }
}



#pragma mark -
#pragma mark Initialization and teardown

- (void) initialize {
	mode = LeavesViewModeFacingPages;
		//	mode = LeavesViewModeSinglePage;
		//    numberOfVisiblePages = 1;

	backgroundRendering = NO;
    
    CGSize cachePageSize = self.bounds.size;
    if (mode == LeavesViewModeFacingPages) {
//      cachePageSize = CGSizeMake(self.bounds.size.width / 2.0f, self.bounds.size.height);
		cachePageSize = CGSizeMake(self.bounds.size.width, self.bounds.size.height);

    }
	pageCache = [[LeavesCache alloc] initWithPageSize:cachePageSize];
}


- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
			[self setUpLayers];
			[self initialize];
    }
    return self;
}

	//- (void) startTransition


- (void) awakeFromNib {
	[super awakeFromNib];
		//[self setUpLayers];
		//[self initialize];
	self.mode = LeavesViewModeFacingPages;
}


- (void)dealloc {
	[topPage release];
	[topPageShadow release];
	[topPageOverlay release];
	[topPageReverse release];
	[topPageReverseImage release];
	[topPageReverseOverlay release];
	[topPageReverseShading release];
	[bottomPage release];
	[bottomPageShadow release];
    [leftPage release];
	[leftPageOverlay release];
    
	[pageCache release];
	
    [super dealloc];
}



#pragma mark -
#pragma mark Image loading

- (void) reloadData {
	[pageCache flush];
		//numberOfPages = [pageCache.dataSource numberOfPagesInLeavesView:self];
		//	self.currentPageIndex = 1;
}


- (void) setImagesForTopPage: (NSString *)topPageIndex BottomPage: (NSString *)bottomPageIndex {

	/* //TODO: implement these for rendering the possible choice images if needed.
	if (currentPageIndex > 1 && backgroundRendering) {
		[pageCache precacheImageForPageIndex:currentPageIndex-2];
	}
	if (currentPageIndex > 2 && backgroundRendering) {
		[pageCache precacheImageForPageIndex:currentPageIndex-2];
	}
	*/
	
	CGImageRef fullTopPageImage = [pageCache cachedImageForPageIndex: topPageIndex];
	CGImageRef fullBottomPageImage = [pageCache cachedImageForPageIndex: bottomPageIndex];
	LogImageData(@"leavesView", 2, 1024, 786, UIImagePNGRepresentation([UIImage imageWithCGImage: fullBottomPageImage]));


	if (currentPageIndex) {
		topPage.contents = (id)CGImageCreateWithImageInRect(fullTopPageImage, rightHalf);
		leftPage.contents = (id)CGImageCreateWithImageInRect(fullTopPageImage, leftHalf);
	} else {
		LogMessage(@"error", 0, @"currentPageIndex is NULL");
	}
	if (nextPageIndex) {
		topPageReverseImage.contents = (id)CGImageCreateWithImageInRect(fullBottomPageImage, leftHalf);
			//	bottomPage.backgroundColor = [UIColor orangeColor].CGColor;
		CGImageRef bottomRightPageImage = CGImageCreateWithImageInRect(fullBottomPageImage, rightHalf);
		LogImageData(@"leavesView", 2, 1024, 768, UIImagePNGRepresentation([UIImage imageWithCGImage: bottomRightPageImage]));
		bottomPage.contents = (id)CGImageCreateWithImageInRect(fullBottomPageImage, rightHalf);
	}

		//           [pageCache minimizeToPageIndex:currentPageIndex viewMode:self.mode]; //TODO: implement this later to flush old images from the cache

}



#pragma mark -
#pragma mark Layout

- (void) setLayerFrames {
    rightPageBoundsRect = self.layer.bounds;
		//    CGRect leftHalf, rightHalf;
    CGRectDivide(rightPageBoundsRect, &leftHalf, &rightHalf, CGRectGetWidth(rightPageBoundsRect) / 2.0f, CGRectMinXEdge);
    if (self.mode == LeavesViewModeFacingPages) {
        rightPageBoundsRect = rightHalf;
    }
    
	topPage.frame = CGRectMake(rightPageBoundsRect.origin.x, 
							   rightPageBoundsRect.origin.y, 
							   leafEdge * rightPageBoundsRect.size.width, 
							   rightPageBoundsRect.size.height);
	topPageReverse.frame = CGRectMake(rightPageBoundsRect.origin.x + (2*leafEdge-1) * rightPageBoundsRect.size.width, 
									  rightPageBoundsRect.origin.y, 
									  (1-leafEdge) * rightPageBoundsRect.size.width, 
									  rightPageBoundsRect.size.height);
		//bottomPage.frame = rightPageBoundsRect;
	bottomPage.frame = rightHalf;
	topPageShadow.frame = CGRectMake(topPageReverse.frame.origin.x - 40, 
									 0, 
									 40, 
									 bottomPage.bounds.size.height);
	topPageReverseImage.frame = topPageReverse.bounds;
	
	topPageReverse.backgroundColor = [UIColor purpleColor].CGColor;
		//topPageReverseImage.backgroundColor = [UIColor redColor].CGColor;

	topPageReverseOverlay.frame = topPageReverse.bounds;
	topPageReverseShading.frame = CGRectMake(topPageReverse.bounds.size.width - 50, 
											 0, 
											 50 + 1, 
											 topPageReverse.bounds.size.height);
	
		//	topPageReverseOverlay.backgroundColor = [UIColor greenColor].CGColor;
	
//	bottomPageShadow.frame = CGRectMake(leafEdge * rightPageBoundsRect.size.width, 
//										0, 
//										40, 
//										bottomPage.bounds.size.height);
	bottomPageShadow.frame = CGRectMake(leafEdge * rightHalf.size.width, 
										0, 
										40, 
										bottomPage.bounds.size.height);
	
	
	topPageOverlay.frame = topPage.bounds;
	
		//topPageOverlay.backgroundColor = [UIColor blueColor].CGColor;

    
    LogMessage(@"leavesView", 2, @"topPageOverlay.frame %@ visible.", topPageOverlay.isHidden? @"is NOT":@"is");
    
    if (self.mode == LeavesViewModeSinglePage) {
        leftPage.hidden = YES;
        leftPageOverlay.hidden = leftPage.hidden;
    } else {
        leftPage.hidden = NO;
        leftPageOverlay.hidden = leftPage.hidden;
        leftPage.frame = CGRectMake(leftHalf.origin.x, 
                                   leftHalf.origin.y, 
                                   leftHalf.size.width, 
                                   leftHalf.size.height);
        leftPageOverlay.frame = leftPage.bounds;
        
    }
}

- (void) willTurnToPageAtIndex:(NSString *)index {
	if ([delegate respondsToSelector:@selector(leavesView:willTurnToPageAtIndex:)])
		[delegate leavesView:self willTurnToPageAtIndex:index];
}

- (void) didTurnToPageAtIndex:(NSString *)index {
	[pageSubviews makeObjectsPerformSelector: @selector(setHidden:) withObject: (id)NO];
	if ([delegate respondsToSelector:@selector(leavesView:didTurnToPageAtIndex:)]) {
		[delegate leavesView:self didTurnToPageAtIndex:index];
	}
		//[self.subviews makeObjectsPerformSelector: @selector(setHidden:) withObject: (id)NO];
}

- (void) didTurnPageBackwardToIndex: (NSString *)anIndex {
	interactionLocked = NO;
	[self didTurnToPageAtIndex: anIndex];
}

- (void) didTurnPageForwardToIndex: (NSString *)anIndex {
	interactionLocked = NO;
	[self didTurnToPageAtIndex: anIndex];
}

- (BOOL) hasPrevPage {
		// return self.currentPageIndex > (numberOfVisiblePages - 1);
	return previousPageIndex != NULL? YES : NO;
}

- (BOOL) hasNextPage {
		return nextPageIndex != NULL? YES : NO;
}


- (BOOL) touchedNextPage {
	return CGRectContainsPoint(nextPageRect, touchBeganPoint);
}

- (BOOL) touchedPrevPage {
	return CGRectContainsPoint(prevPageRect, touchBeganPoint);
}

- (CGFloat) dragThreshold {
	// Magic empirical number
	return 10;
}

- (CGFloat) targetWidth {
	// Magic empirical formula
	return MAX(28, self.bounds.size.width / 5);
}

#pragma mark -
#pragma mark accessors

- (id<LeavesViewDataSource>) dataSource {
	return pageCache.dataSource;
}

- (void) setDataSource:(id<LeavesViewDataSource>)value {
	pageCache.dataSource = value;
}

- (void) setLeafEdge:(CGFloat)aLeafEdge {
	leafEdge = aLeafEdge;
	
    CGFloat pageOpacity = MIN(1.0, 4*(1-leafEdge));
    
    topPageShadow.opacity        = pageOpacity;
	bottomPageShadow.opacity     = pageOpacity;
	topPageOverlay.opacity       = pageOpacity;
	leftPageOverlay.opacity   = pageOpacity;

    [self setLayerFrames];
}


- (void) setCurrentPageIndex:(NSString *)aCurrentPageIndex {
    currentPageIndex = aCurrentPageIndex;
	[pageCache cachedImageForPageIndex: currentPageIndex];

	/*
	if (self.mode == LeavesViewModeFacingPages && aCurrentPageIndex % 2 != 0) {
        currentPageIndex = aCurrentPageIndex + 1;
    }
	*/
	/*
	[CATransaction begin];
	[CATransaction setValue:(id)kCFBooleanTrue
					 forKey:kCATransactionDisableActions];
	
		//[self getImages];
	
	self.leafEdge = 1.0;
	
	[CATransaction commit];
	*/
}


- (void) setNextPageIndex:(NSString *)aNextPageIndex {
	nextPageIndex = aNextPageIndex;
		//	[pageCache cachedImageForPageIndex: nextPageIndex];
	
}



- (void) setMode:(LeavesViewMode)newMode
{
    mode = newMode;
	
	[self setUpLayersForViewingMode];
    [self setNeedsLayout];
}



#pragma mark -
#pragma mark UIView methods

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	LogMessage(@"LeavesView", 2, @"In the touchesBegan method of LeavesView");
	dragged = NO;
	
	if (!nextPageIndex) {
		return;
	}
	if (interactionLocked)
		return;
	
	UITouch *touch = [event.allTouches anyObject];
	touchBeganPoint = [touch locationInView: self];

	LogMessage(@"leavesview", 0, @"touchedNextPage is %@, hasNextPage is %@", [self touchedNextPage]? @"TRUE":@"FALSE", [self hasNextPage]? @"TRUE":@"FALSE");
	pageSubviews = self.subviews;
	
	if ([self touchedPrevPage] && [self hasNextPage]) {
		[CATransaction begin];
		[CATransaction setValue:(id)kCFBooleanTrue
						 forKey:kCATransactionDisableActions];
		
		[self setImagesForTopPage: nextPageIndex BottomPage: currentPageIndex];
		//[self.subviews makeObjectsPerformSelector: @selector(setHidden:) withObject: (id)YES];
		[pageSubviews makeObjectsPerformSelector: @selector(setHidden:) withObject: (id)YES];
		
        self.leafEdge = 0.0;
		[CATransaction commit];
		touchIsActive = YES;		
	} 
	else if ([self touchedNextPage] && [self hasNextPage]) {
		touchIsActive = YES;
		
		[self setImagesForTopPage: currentPageIndex BottomPage: nextPageIndex];
		//[self.subviews makeObjectsPerformSelector: @selector(setHidden:) withObject: (id)YES];
		[pageSubviews makeObjectsPerformSelector: @selector(setHidden:) withObject: (id)YES];
	} else 
		touchIsActive = NO;
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	LogMessage(@"LeavesView", 2, @"In the touchesMoved method of LeavesView");

	if (!touchIsActive)
		return;
	UITouch *touch = [event.allTouches anyObject];
	touchPoint = [touch locationInView: self];
	
	[CATransaction begin];
	[CATransaction setValue:[NSNumber numberWithFloat:0.07]
					 forKey:kCATransactionAnimationDuration];
	self.leafEdge = touchPoint.x / self.bounds.size.width;
	[CATransaction commit];
		//LogMessage
	if (!dragged && distance(touchPoint, touchBeganPoint) > [self dragThreshold]) {
		dragged = YES;
	}
}


- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	LogMessage(@"LeavesView", 2, @"In the touchesEnded method of LeavesView");

	
	if (!touchIsActive)
		return;
	touchIsActive = NO;
	UITouch *touch = [event.allTouches anyObject];
	touchPoint = [touch locationInView: self];

	LogMessage(@"leavesview", 3, @"touchedNextPage is %@, touchedPrevPage is %@, dragged is %@, leafEdge is %f", [self touchedNextPage]? @"TRUE":@"FALSE", [self touchedPrevPage]? @"TRUE":@"FALSE", dragged? @"TRUE":@"FALSE", self.leafEdge);

	[CATransaction begin];
	float duration;
	if ((dragged && self.leafEdge < 0.5) || (!dragged && ([self touchedNextPage]) )) {

		self.leafEdge = 0;
		duration = leafEdge;
		interactionLocked = YES;
		if ([self touchedNextPage]) {
			[self performSelector:@selector(didTurnPageForwardToIndex:)
					   withObject: nextPageIndex
					   afterDelay:duration + 0.25];
		} else if ([self touchedPrevPage]) {
			[self performSelector:@selector(didTurnPageForwardToIndex:)
					   withObject: currentPageIndex
					   afterDelay:duration + 0.25];
		}
			

	} else if ( (dragged && self.leafEdge >= 0.5) || (!dragged && [self touchedPrevPage]) ) {
			self.leafEdge = 1;
			duration = 1 - leafEdge;
			interactionLocked = YES;
		if ([self touchedPrevPage]) {
			[self performSelector:@selector(didTurnPageBackwardToIndex:)
					   withObject: nextPageIndex 
					   afterDelay:duration + 0.25];			
		} else if ([self touchedNextPage]) {
			[self performSelector:@selector(didTurnPageBackwardToIndex:)
					   withObject: currentPageIndex 
					   afterDelay:duration + 0.25];			
		}
	}
	
	[CATransaction setValue:[NSNumber numberWithFloat:duration]
					 forKey:kCATransactionAnimationDuration];
	[CATransaction commit];
}

- (void) layoutSubviews {
	[super layoutSubviews];	
    
	CGSize desiredPageSize = self.bounds.size;
	
    if (self.mode == LeavesViewModeFacingPages) {
        desiredPageSize = CGSizeMake(self.bounds.size.width, self.bounds.size.height);
    }
    
	if (!CGSizeEqualToSize(pageSize, desiredPageSize)) {
		pageSize = desiredPageSize;
		
		[CATransaction begin];
		[CATransaction setValue:(id)kCFBooleanTrue
						 forKey:kCATransactionDisableActions];
		[self setLayerFrames];
		[CATransaction commit];
		pageCache.pageSize = pageSize;
			//	[self getImages];
		
		CGFloat touchRectsWidth = self.bounds.size.width / 7;
		nextPageRect = CGRectMake(self.bounds.size.width - touchRectsWidth,
								  0,
								  touchRectsWidth,
								  self.bounds.size.height);
		prevPageRect = CGRectMake(0,
								  0,
								  touchRectsWidth,
								  self.bounds.size.height);

//		nextPageRect = CGRectMake(877,
//								  0,
//								  146,
//								  768);
//		prevPageRect = CGRectMake(0,
//								  0,
//								  146,
//								  768);
		
	
	
	}

}

@end

CGFloat distance(CGPoint a, CGPoint b) {
	return sqrtf(powf(a.x-b.x, 2) + powf(a.y-b.y, 2));
}
//CGFloat distance(CGPoint a, CGPoint b) {
//	return a.x - b.x;
//}


