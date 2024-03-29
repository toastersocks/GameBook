//
//  LeavesView.h
//  Leaves
//
//  Created by Tom Brow on 4/18/10.
//  Copyright 2010 Tom Brow. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>


typedef enum {
	LeavesViewModeSinglePage,
    LeavesViewModeFacingPages,
} LeavesViewMode;



@class LeavesCache;
@class PassTouchButton;

@protocol LeavesViewDataSource;
@protocol LeavesViewDelegate;

@interface LeavesView : UIView {
	CALayer *topPage;
	CALayer *topPageOverlay;
	CAGradientLayer *topPageShadow;
	
	CALayer *topPageReverse;
	CALayer *topPageReverseImage;
	CALayer *topPageReverseOverlay;
	CAGradientLayer *topPageReverseShading;
	
	CALayer *bottomPage;
	CAGradientLayer *bottomPageShadow;

    // The left page in two-page mode.
    // Animation is always done on the right page
    CALayer *leftPage;
	CALayer *leftPageOverlay;
    
    // Single page or facing pages?
    LeavesViewMode mode;
    
	CGFloat leafEdge;
    
    // In two-page mode, this is always the index of the right page.
    // Pages with odd numbers (== pages where currentPageIndex is even) are always displayed 
    // on the right side (as in a book)
	NSString *currentPageIndex;
	NSString *nextPageIndex;
	NSString *previousPageIndex;
		//	NSUInteger numberOfPages;
		//  NSUInteger numberOfVisiblePages;
	id<LeavesViewDelegate> delegate;
	id<LeavesViewDataSource> dataSource;
	
	CGSize pageSize;
	LeavesCache *pageCache;
	BOOL backgroundRendering;
	
	BOOL dragged;
	CGPoint touchBeganPoint;
	CGPoint touchPoint;
	BOOL touchIsActive;
	CGRect nextPageRect, prevPageRect;
	BOOL interactionLocked;
	
	CGRect rightPageBoundsRect;
	CGRect leftHalf, rightHalf;
	
	UIView *contentView;
	
	NSArray *pageSubviews;
	
	CGRect pageEdgeLeftFrame;
	CGRect pageEdgeRightFrame;
	CGRect contentViewFrame;
	
//	CALayer *pageEdgeLeft;
//	CALayer *pageEdgeRight;
	PassTouchButton *pageEdgeLeft;
	PassTouchButton *pageEdgeRight;

	
	CAGradientLayer *leftPageShadow;
	CAGradientLayer *rightPageShadow;
	
	CAGradientLayer *leftUnderPageShadow;
	CAGradientLayer *rightUnderPageShadow;
	
}
	
@property (assign) IBOutlet id<LeavesViewDataSource> dataSource;
@property (assign) id<LeavesViewDelegate> delegate;
@property (nonatomic, assign) LeavesViewMode mode;
@property (readonly) CGFloat targetWidth;
@property (nonatomic, retain) NSString *currentPageIndex;
@property (nonatomic, retain) NSString *nextPageIndex;

@property (nonatomic, retain) LeavesCache *pageCache;

@property (nonatomic, retain) IBOutlet UIView *contentView;
@property (nonatomic, assign) CGRect contentViewFrame;




@property (assign) BOOL backgroundRendering;

- (void) reloadData;
- (void) setupDecorations;
- (void) flipForwardToPageIndex: (NSString *)pageIndexToFlipTo;
- (void) flipBackwardToPageIndex: (NSString *)pageIndexToFlipTo;
- (void)resetShadows;
@end


@protocol LeavesViewDataSource <NSObject>

	//- (NSUInteger) numberOfPagesInLeavesView:(LeavesView*)leavesView;
- (void) renderPageAtIndex:(NSString *)index inContext:(CGContextRef)ctx;

@end

@protocol LeavesViewDelegate <NSObject>

@optional

- (void) leavesView:(LeavesView *)leavesView willTurnToPageAtIndex:(NSString *)pageIndex;
- (void) leavesView:(LeavesView *)leavesView didTurnToPageAtIndex:(NSString *)pageIndex;

@end

