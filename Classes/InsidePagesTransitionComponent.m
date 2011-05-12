//
//  InsidePagesViewController.m
//  GameBook
//
//  Created by James Pamplona on 3/30/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "InsidePagesTransitionComponent.h"
#import "LeavesView.h"


@implementation InsidePagesTransitionComponent

@synthesize leavesView;
@synthesize currentView, nextView;
@synthesize transitionInitiator;
@synthesize contentView;
@synthesize delegate;

- (void)setContentView:(UIView *)aContentView {
	if (aContentView != contentView) {
//		[contentView release];
//		[self.leavesView.contentView removeFromSuperview];
		contentView = aContentView;
		
	}
	leavesView.contentView = contentView;
	self.currentView = contentView;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
		self.leavesView = [[LeavesView alloc] initWithFrame: CGRectMake(0, 0, 1024, 748)];
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (void) renderPageAtIndex:(NSString *)index inContext:(CGContextRef)ctx {
	CGImageRef image;
	if ([index isEqualToString: @"currentView"]) {
		image = [self renderImageForView: self.leavesView.contentView];
	} else if ([index isEqualToString: @"nextView"]) {
		image = [self renderImageForView: self.nextView];
	} else {
		LogMessage(@"ERROR", 0, @"View Index \"%@\" is invalid", index);
	}
	CGRect imageRect = CGRectMake(0, 0, 1004, 748);
	CGContextDrawImage(ctx, imageRect, image);
	
}

- (void)beginCutToView: (UIView *)newNextView sender: (UIViewController *)sender {
	self.nextView = newNextView;
	self.transitionInitiator = sender;
	[self leavesView:nil didTurnToPageAtIndex: @"nextView"];
}

- (void)beginTransitionToView: (UIView *)newNextView sender: (UIViewController *)sender {
	
	self.nextView = newNextView;
	self.transitionInitiator = sender;
	self.leavesView.currentPageIndex = @"currentView";
	self.leavesView.nextPageIndex = @"nextView";	
}


- (void)beginFlipForwardToView: (UIView *)newNextView sender: (id)sender {
	self.nextView = newNextView;
	self.transitionInitiator = sender;
	self.leavesView.currentPageIndex = @"currentView";
	self.leavesView.nextPageIndex = @"nextView";
	[self.leavesView flipForwardToPageIndex: @"nextView"];
	
}


- (void) leavesView:(LeavesView *)leavesView didTurnToPageAtIndex:(NSString *)pageIndex {
	if ([pageIndex isEqualToString: @"nextView"]) {
		self.currentView = self.nextView;
		[self.transitionInitiator didTransitionToView: self.nextView];
//		[self.contentView layoutIfNeeded];
		[self.leavesView resetShadows];
	}
	self.leavesView.nextPageIndex = nil;
	[self.leavesView.pageCache flush];
}

- (IBAction)pageEdgeLeftAction: (id)sender {
	if ([self.delegate respondsToSelector: _cmd]) {
		[self.delegate pageEdgeLeftAction: self];
	}
}

- (IBAction)pageEdgeRightAction: (id)sender {
	LogMessage(@"insidePagesTransitionComponent", 2, @"in the pageEdgeRightAction");
	if ([self.delegate respondsToSelector: _cmd]) {
		[self.delegate pageEdgeRightAction: self];
	}
}


- (CGImageRef) renderImageForView: (UIView *)viewToRender {
	UIGraphicsBeginImageContext(viewToRender.frame.size);
//	UIGraphicsBeginImageContext(CGSizeMake(1024, 768));
//	NSInteger imageWidth = viewToRender.bounds.size.width;
//	NSInteger imageHeight = viewToRender.bounds.size.height;
	

	
	CGContextRef context = UIGraphicsGetCurrentContext();
	
//	CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
//	CGContextRef context = CGBitmapContextCreate(NULL, imageWidth, imageHeight, 8, imageWidth * 4, colorSpace, kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
//	CGColorSpaceRelease(colorSpace);
	
	[viewToRender.layer renderInContext: context];
		//	[viewToRender.layer.presentationLayer renderInContext: context];
	
	CGImageRef renderedImage = [UIGraphicsGetImageFromCurrentImageContext() CGImage];
//	CGImageRef renderedImage = CGBitmapContextCreateImage(context);
	
	
//	CGContextRelease(context);
	UIGraphicsEndImageContext();
	
	return renderedImage;
	
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
	self.leavesView.delegate = self;
	self.leavesView.dataSource = self;
//	[self.view addSubview: self.leavesView];
//	[self.view performSelector: @selector(addSubview:) withObject: self.leavesView afterDelay: 0.0];
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

@end
