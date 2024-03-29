//
//  LeavesView.m
//  Leaves
//
//  Created by Tom Brow on 4/18/10.
//  Copyright 2010 Tom Brow. All rights reserved.
//

#import "LeavesView.h"
#import "LeavesCache.h"
#import "PassTouchButton.h"


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

@synthesize contentView;
@synthesize contentViewFrame;



@synthesize pageCache;




- (void) setPageEdgeAndContentFrames {
		/////////////////////// 
//	  prevPageRect = leftHalf;
	pageEdgeLeftFrame = CGRectMake(0, 0, 10, self.bounds.size.height);
	pageEdgeRightFrame = CGRectMake(self.bounds.size.width - 10, 0, 10, self.bounds.size.height);
	contentViewFrame = CGRectMake(pageEdgeLeftFrame.size.width, 0, pageEdgeRightFrame.origin.x - pageEdgeRightFrame.size.width, self.bounds.size.height - 20);
	
	pageEdgeLeft.frame = pageEdgeLeftFrame;
	pageEdgeRight.frame = pageEdgeRightFrame;
	self.contentView.frame = contentViewFrame;

}

- (void) setUpLayers {
	self.clipsToBounds = YES;
[self setPageEdgeAndContentFrames];

		///////////////////////
	
	topPage = [[CALayer alloc] init];
	topPage.masksToBounds = YES;
	topPage.contentsGravity = kCAGravityLeft;
	topPage.backgroundColor = [[UIColor yellowColor] CGColor];
	
	topPageOverlay = [[CALayer alloc] init];
	topPageOverlay.backgroundColor = [[[UIColor blackColor] colorWithAlphaComponent:0.2] CGColor];
	
	topPageShadow = [[CAGradientLayer alloc] init];
	topPageShadow.colors = [NSArray arrayWithObjects:
							(id)[[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.6] CGColor],
							(id)[[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.0] CGColor],
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
									(id)[[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.6] CGColor],
									(id)[[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.0] CGColor],
									nil];
	topPageReverseShading.startPoint = CGPointMake(1,0.5);
	topPageReverseShading.endPoint = CGPointMake(0,0.5);
	
	bottomPage = [[CALayer alloc] init];
		//bottomPage.backgroundColor = [[UIColor orangeColor] CGColor];
	bottomPage.masksToBounds = YES;
	
	bottomPageShadow = [[CAGradientLayer alloc] init];
	bottomPageShadow.colors = [NSArray arrayWithObjects:
							   (id)[[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.6] CGColor],
							   (id)[[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.0] CGColor],
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
	
	[self setupDecorations];
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
	LogMessage(@"leavesView", 3, @"self.bounds is: %@", NSStringFromCGRect(self.bounds));
//	pageEdgeLeftFrame = CGRectMake(0, -3, 12, self.bounds.size.height + 5);
//	pageEdgeRightFrame = CGRectMake(self.bounds.size.width - 12, -2, 12, self.bounds.size.height + 5);
//	contentViewFrame = CGRectMake(pageEdgeLeftFrame.size.width, 0, pageEdgeRightFrame.origin.x, self.bounds.size.height);
		//[self addSubview: self.contentView];
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

- (id) initWithFrame:(CGRect)frame contentView: (UIView *)newContentView {
	if ([self initWithFrame: frame]) {
		self.contentView = newContentView;
	}
	return self;
}

	//- (void) startTransition


- (id) initWithCoder:(NSCoder *)aDecoder {
	if ((self = [super initWithCoder:aDecoder])) {
		[self setUpLayers];
		[self initialize];
	}
	return self;
}

//- (void) awakeFromNib {
//	[super awakeFromNib];
//	[self setUpLayers];
//	[self initialize];
//		//self.mode = LeavesViewModeFacingPages;
//}


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

	/* 
	if (currentPageIndex > 1 && backgroundRendering) {
		[pageCache precacheImageForPageIndex:currentPageIndex-2];
	}
	if (currentPageIndex > 2 && backgroundRendering) {
		[pageCache precacheImageForPageIndex:currentPageIndex-2];
	}
	*/
	
//	CGImageRef fullTopPageImage = [pageCache cachedImageForPageIndex: topPageIndex];
//	CGImageRef fullBottomPageImage = [pageCache cachedImageForPageIndex: bottomPageIndex];
	CGImageRef fullTopPageImage = [pageCache imageForPageIndex: topPageIndex];
	CGImageRef fullBottomPageImage = [pageCache imageForPageIndex: bottomPageIndex];

	LogImageData(@"leavesView", 2, 1004, 748, UIImagePNGRepresentation([UIImage imageWithCGImage: fullBottomPageImage]));


	if (currentPageIndex) {
//		topPage.contents = (id)CGImageCreateWithImageInRect(fullTopPageImage, rightHalf);
		
		[CATransaction begin];
		[CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
		topPage.contents = (id)CGImageCreateWithImageInRect(fullTopPageImage, CGRectMake(502, 0, 502, 748));
		//change background colour
		[CATransaction commit];

		[CATransaction begin];
		[CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
					//		leftPage.contents = (id)CGImageCreateWithImageInRect(fullTopPageImage, leftHalf);
		leftPage.contents = (id)CGImageCreateWithImageInRect(fullTopPageImage, CGRectMake(0, 0, 502, 748));
	//change background colour
		[CATransaction commit];

			//		topPage.backgroundColor = [UIColor blueColor].CGColor;
//		leftPage.backgroundColor = [UIColor greenColor].CGColor;
	} else {
		LogMessage(@"error", 0, @"currentPageIndex is NULL");
	}
	if (nextPageIndex) {
//		bottomPage.backgroundColor = [UIColor orangeColor].CGColor;
//		topPageReverseImage.backgroundColor = [UIColor redColor].CGColor;
//		CGImageRef bottomRightPageImage = CGImageCreateWithImageInRect(fullBottomPageImage, rightHalf);
		CGImageRef bottomRightPageImage = CGImageCreateWithImageInRect(fullBottomPageImage, CGRectMake(502, 0, 502, 748));

		LogImageData(@"leavesView", 2, 1024, 768, UIImagePNGRepresentation([UIImage imageWithCGImage: bottomRightPageImage]));
//		topPageReverseImage.contents = (id)CGImageCreateWithImageInRect(fullBottomPageImage, leftHalf);
		
		[CATransaction begin];
		[CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
		topPageReverseImage.contents = (id)CGImageCreateWithImageInRect(fullBottomPageImage, CGRectMake(0, 0, 502, 748));
		[CATransaction commit];

//		bottomPage.contents = (id)CGImageCreateWithImageInRect(fullBottomPageImage, rightHalf);
		[CATransaction begin];
		[CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
			//change background colour
		bottomPage.contents = (id)bottomRightPageImage;

		[CATransaction commit];
		
	}

		//           [pageCache minimizeToPageIndex:currentPageIndex viewMode:self.mode]; //TODO: implement this later to flush old images from the cache

}


- (CGImageRef) imageForPageIndex:(NSString *)pageIndex {
	pageSize = CGSizeMake(1004, 748);
	CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
	CGContextRef context = CGBitmapContextCreate(NULL, 
												 pageSize.width, 
												 pageSize.height, 
												 8,						/* bits per component*/
												 pageSize.width * 4, 	/* bytes per row */
												 colorSpace, 
												 kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
	CGColorSpaceRelease(colorSpace);
	CGContextClipToRect(context, CGRectMake(0, 0, pageSize.width, pageSize.height));
	
	[dataSource renderPageAtIndex: pageIndex inContext:context];
	
	CGImageRef image = CGBitmapContextCreateImage(context);
	CGContextRelease(context);
	
		//LogImageData(@"leaves Cache", 2, 1024, 768, UIImagePNGRepresentation([UIImage imageWithCGImage:image]));
	
		//!!!: DONT FORGET TO UNCOMMENT THIS LINE! should need it, but the cgimageref is being overreleased somewhere...
		//CGImageRelease(image);
	
	return image;
}



#pragma mark -
#pragma mark Layout

- (void) setLayerFrames {
//    rightPageBoundsRect = self.layer.bounds;

	
		/////////////////////// 
[self setPageEdgeAndContentFrames];
		///////////////////////

//	CGRect twoPageSpreadRect = self.layer.bounds;
	CGRect twoPageSpreadRect = self.contentViewFrame;

//rightPageBoundsRect = self.contentViewFrame;

		//    CGRect leftHalf, rightHalf;
    CGRectDivide(twoPageSpreadRect, &leftHalf, &rightHalf, CGRectGetWidth(twoPageSpreadRect) / 2.0f, CGRectMinXEdge);
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
	
//	pageEdgeLeftFrame = CGRectMake(0, -3, 12, self.bounds.size.height + 5);
//	pageEdgeRightFrame = CGRectMake(self.bounds.size.width - 12, -2, 12, self.bounds.size.height + 5);
//	contentViewFrame = CGRectMake(pageEdgeLeftFrame.size.width, 0, pageEdgeRightFrame.origin.x, self.bounds.size.height);
	
	
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
			//topPage.backgroundColor = [UIColor blueColor].CGColor;
		leftPage.backgroundColor = [UIColor greenColor].CGColor;
		bottomPage.backgroundColor = [UIColor orangeColor].CGColor;
		topPageReverseImage.backgroundColor = [UIColor redColor].CGColor;        
    }
}

- (void) willTurnToPageAtIndex:(NSString *)index {
	if ([delegate respondsToSelector:@selector(leavesView:willTurnToPageAtIndex:)])
		[delegate leavesView:self willTurnToPageAtIndex:index];
}

- (void) didTurnToPageAtIndex:(NSString *)index {
//	[pageSubviews makeObjectsPerformSelector: @selector(setHidden:) withObject: (id)NO];
	self.contentView.hidden = NO;
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


- (void) setupDecorations {
	
	leftPageShadow = [[CAGradientLayer alloc] init];
//	leftPageShadow.colors = [NSArray arrayWithObjects:
//							 (id)[[[UIColor blackColor] colorWithAlphaComponent:0.6] CGColor],
//							 (id)[[UIColor clearColor] CGColor],
//							 nil];

//	leftPageShadow.colors = [NSArray arrayWithObjects:
//							 (id)[[[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0] colorWithAlphaComponent:0.6] CGColor],
//							 (id)[[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.0] CGColor],
//							 nil];

	leftPageShadow.colors = [NSArray arrayWithObjects:
							 (id)[[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.6] CGColor],
							 (id)[[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.0] CGColor],
							 nil];
	
	leftPageShadow.startPoint = CGPointMake(0,0.5);
	leftPageShadow.endPoint = CGPointMake(1,0.5);
	leftPageShadow.frame = CGRectMake(contentViewFrame.size.width / 2, 
									  contentViewFrame.origin.y, 
									  40, 
									  contentViewFrame.size.height);
	rightPageShadow = [[CAGradientLayer alloc] init];
	rightPageShadow.colors = [NSArray arrayWithObjects:
							  (id)[[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.6] CGColor],
							  (id)[[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.0] CGColor],
							  nil];
	rightPageShadow.startPoint = CGPointMake(1,0.5);
	rightPageShadow.endPoint = CGPointMake(0,0.5);
	rightPageShadow.frame = CGRectMake(contentViewFrame.size.width / 2, 
									   contentViewFrame.origin.y, 
									   -40, 
									   contentViewFrame.size.height);

	
	leftUnderPageShadow = [[CAGradientLayer alloc] init];
	[NSArray arrayWithObjects:
	 (id)[[[UIColor blackColor] colorWithAlphaComponent:0.6] CGColor],
	 (id)[[UIColor clearColor] CGColor],
	 nil];
//	leftUnderPageShadow.colors = [NSArray arrayWithObjects:
//							  (id)[[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.6] CGColor],
//							  (id)[[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.0] CGColor],
//							  nil];
	leftUnderPageShadow.colors = [NSArray arrayWithObjects:
								  (id)[[[UIColor blackColor] colorWithAlphaComponent:0.6] CGColor],
								  (id)[[UIColor clearColor] CGColor],
								  nil];
	leftUnderPageShadow.startPoint = CGPointMake(1,0.5);
	leftUnderPageShadow.endPoint = CGPointMake(0,0.5);
	leftUnderPageShadow.frame = CGRectMake(contentViewFrame.size.width / 2, 
									   contentViewFrame.origin.y, 
									   -40, 
									   contentViewFrame.size.height);

	
	
	rightUnderPageShadow = [[CAGradientLayer alloc] init];
//	rightUnderPageShadow.colors = [NSArray arrayWithObjects:
//								  (id)[[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.6] CGColor],
//								  (id)[[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.0] CGColor],
//								  nil];
	rightUnderPageShadow.colors = [NSArray arrayWithObjects:
								   (id)[[[UIColor blackColor] colorWithAlphaComponent:0.6] CGColor],
								   (id)[[UIColor clearColor] CGColor],
								   nil];

	rightUnderPageShadow.startPoint = CGPointMake(0,0.5);
	rightUnderPageShadow.endPoint = CGPointMake(1.0,0.5);
	rightUnderPageShadow.frame = CGRectMake(0, 
										   contentViewFrame.origin.y, 
										   40, 
										   contentViewFrame.size.height);
	
	
	
	
	
	[leftPage addSublayer: leftUnderPageShadow];
	[topPage addSublayer: rightUnderPageShadow];
	
	
	[self.contentView.layer insertSublayer:rightPageShadow below: topPageReverse];
	[self.contentView.layer insertSublayer:leftPageShadow below: topPageReverse];
	
//	pageEdgeRight = [CALayer layer];
//	pageEdgeLeft = [CALayer layer];
	pageEdgeRight = [PassTouchButton buttonWithType: UIButtonTypeCustom];
	pageEdgeLeft = [PassTouchButton buttonWithType: UIButtonTypeCustom];

	pageEdgeLeft.frame = pageEdgeLeftFrame;
	pageEdgeRight.frame = pageEdgeRightFrame;
//	pageEdgeLeft.contents = (id)[UIImage imageNamed: @"pageEdge_left.png"].CGImage;
//	pageEdgeRight.contents = (id)[UIImage imageNamed: @"pageEdge_right.png"].CGImage;
	[pageEdgeLeft setImage: [UIImage imageNamed: @"pageEdge_left.png"] forState: UIControlStateNormal];
	[pageEdgeRight setImage: [UIImage imageNamed: @"pageEdge_right.png"] forState: UIControlStateNormal];
	[pageEdgeLeft addTarget: self.delegate action: @selector(pageEdgeLeftAction:) forControlEvents: UIControlEventTouchDown];
	[pageEdgeRight addTarget: self.delegate action: @selector(pageEdgeRightAction:) forControlEvents: UIControlEventTouchDown];
//	[self.layer addSublayer: pageEdgeLeft];
//	[self.layer addSublayer: pageEdgeRight];
	[self addSubview: pageEdgeLeft];
	[self addSubview: pageEdgeRight];

}

- (void)resetShadows {
	[self.contentView.layer insertSublayer:rightPageShadow below: topPageReverse];
	[self.contentView.layer insertSublayer:leftPageShadow below: topPageReverse];
}


#pragma mark -
#pragma mark accessors

- (id<LeavesViewDataSource>) dataSource {
	return pageCache.dataSource;
}

- (void) setDataSource:(id<LeavesViewDataSource>)value {
	pageCache.dataSource = value;
//	dataSource = value;
}

- (void) setDelegate:(id<LeavesViewDelegate>)aDelegate {
	delegate = aDelegate;
	[pageEdgeLeft addTarget: self.delegate action: @selector(pageEdgeLeftAction:) forControlEvents: UIControlEventTouchDown];
	[pageEdgeRight addTarget: self.delegate action: @selector(pageEdgeRightAction:) forControlEvents: UIControlEventTouchDown];
}


- (void) setLeafEdge:(CGFloat)aLeafEdge {
	leafEdge = aLeafEdge;
	
    CGFloat pageOpacity = MIN(1.0, 4*(1-leafEdge));
    
    topPageShadow.opacity        = pageOpacity;
	bottomPageShadow.opacity     = pageOpacity;
	topPageOverlay.opacity       = pageOpacity;
	leftPageOverlay.opacity		 = pageOpacity;

    [self setLayerFrames];
}


- (void) setContentView: (UIView *)newContentView{
	[contentView removeFromSuperview];
		//contentView = nil here?
		//[contentView autorelease];
	contentView = newContentView;
	contentView.frame = contentViewFrame;
	[self addSubview: contentView];
//	[self setupDecorations];
	[self resetShadows];
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

- (void) flipBackwardToPageIndex: (NSString *)pageIndexToFlipTo {
	float duration;
	self.leafEdge = 0.0;
	[self setImagesForTopPage: nextPageIndex BottomPage: currentPageIndex];
//	[pageSubviews makeObjectsPerformSelector: @selector(setHidden:) withObject: (id)YES];
	self.contentView.hidden = NO;
	
	[CATransaction begin];

	self.leafEdge = 1;
	duration = 1 - leafEdge;
	interactionLocked = YES;
	[CATransaction setValue:[NSNumber numberWithFloat:duration]
					 forKey:kCATransactionAnimationDuration];
	[CATransaction commit];
	
	
	
	
}


- (void) flipForwardToPageIndex: (NSString *) pageIndexToFlipTo {
	float duration;
//	pageSubviews = self.contentView.subviews;
	pageSubviews = [NSArray arrayWithObject: self.contentView];

	[CATransaction begin];
	[CATransaction setValue:(id)kCFBooleanTrue
					 forKey:kCATransactionDisableActions];
	self.leafEdge = 1.0;
	[self setImagesForTopPage: currentPageIndex BottomPage: nextPageIndex];
//	[pageSubviews makeObjectsPerformSelector: @selector(setHidden:) withObject: (id)YES];
	self.contentView.hidden = YES;
	[CATransaction commit];
	
	duration = leafEdge;
	
	
	[CATransaction begin];
	
	self.leafEdge = 0.0;
//	duration = leafEdge;
	interactionLocked = YES;
	[CATransaction setValue:[NSNumber numberWithFloat:duration]
					 forKey:kCATransactionAnimationDuration];
	[CATransaction commit];
	
	[self performSelector:@selector(didTurnPageForwardToIndex:)
			   withObject: nextPageIndex
			   afterDelay:duration + 0.25];
	
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
//	pageSubviews = self.subviews;
//	pageSubviews = self.contentView;
	
	if ([self touchedPrevPage] && [self hasNextPage]) {
		[CATransaction begin];
		[CATransaction setValue:(id)kCFBooleanTrue
						 forKey:kCATransactionDisableActions];
		
		[self setImagesForTopPage: nextPageIndex BottomPage: currentPageIndex];
		//[self.subviews makeObjectsPerformSelector: @selector(setHidden:) withObject: (id)YES];
//		[pageSubviews makeObjectsPerformSelector: @selector(setHidden:) withObject: (id)YES];
		self.contentView.hidden = YES;
		
        self.leafEdge = 0.0;
		[CATransaction commit];
		touchIsActive = YES;		
	} 
	else if ([self touchedNextPage] && [self hasNextPage]) {
		touchIsActive = YES;
		[CATransaction begin];
		[CATransaction setValue:(id)kCFBooleanTrue
						 forKey:kCATransactionDisableActions];
		[self setImagesForTopPage: currentPageIndex BottomPage: nextPageIndex];
		//[self.subviews makeObjectsPerformSelector: @selector(setHidden:) withObject: (id)YES];
		self.leafEdge = 1.0;
		[CATransaction commit];
//		[pageSubviews makeObjectsPerformSelector: @selector(setHidden:) withObject: (id)YES];
		self.contentView.hidden = YES;
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
//        desiredPageSize = CGSizeMake(self.bounds.size.width - 20, self.bounds.size.height);
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
		
//		CGFloat touchRectsWidth = self.bounds.size.width / 7;
		CGFloat touchRectsWidth = self.bounds.size.width / 4;

		nextPageRect = CGRectMake(self.bounds.size.width - touchRectsWidth,
								  0,
								  touchRectsWidth,
								  self.bounds.size.height);
//		nextPageRect = rightHalf;
		prevPageRect = CGRectMake(0,
								  0,
								  touchRectsWidth,
								  self.bounds.size.height);

			/////////////////////////
		[self setPageEdgeAndContentFrames];
			//////////////////////////
		
		
		leftPageShadow.frame = CGRectMake(contentViewFrame.size.width / 2, 
										  contentViewFrame.origin.y, 
										  40, 
										  contentViewFrame.size.height);
		rightPageShadow.frame = CGRectMake(contentViewFrame.size.width / 2, 
										   contentViewFrame.origin.y, 
										   -40, 
										   contentViewFrame.size.height);

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


