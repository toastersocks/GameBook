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


- (void)setContentView:(UIView *)aContentView {
	if (aContentView != contentView) {
//		[contentView release];
//		[self.leavesView.contentView removeFromSuperview];
		contentView = aContentView;
	}
	self.leavesView.contentView = contentView;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
		self.leavesView = [[LeavesView alloc] initWithFrame: CGRectMake(0, 0, 1024, 768)];
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
	CGRect imageRect = CGRectMake(0, 0, 1024, 768);
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

- (void) leavesView:(LeavesView *)leavesView didTurnToPageAtIndex:(NSString *)pageIndex {
	if ([pageIndex isEqualToString: @"nextView"]) {
		self.currentView = self.nextView;
		[self.transitionInitiator didTransitionToView: self.nextView];
		[self.contentView layoutIfNeeded];
		[self.leavesView setupDecorations];
	}
	[self.leavesView.pageCache flush];
}

- (CGImageRef) renderImageForView: (UIView *)viewToRender {
//	UIGraphicsBeginImageContext(viewToRender.frame.size);
	UIGraphicsBeginImageContext(CGSizeMake(1024, 768));

	
	CGContextRef context = UIGraphicsGetCurrentContext();
	[viewToRender.layer renderInContext: context];
		//	[viewToRender.layer.presentationLayer renderInContext: context];
	
	CGImageRef renderedImage = [UIGraphicsGetImageFromCurrentImageContext() CGImage];
	
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
