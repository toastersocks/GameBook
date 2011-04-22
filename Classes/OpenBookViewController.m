    //
//  OpenBookViewController.m
//  GameBook
//
//  Created by James Pamplona on 2/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "OpenBookViewController.h"
#import "ViewSwitchProtocol.h"
#import "PagesViewController.h"

#import "LeavesView.h"

@implementation OpenBookViewController
@synthesize leavesView;
@synthesize nextView;
@synthesize currentView;
@synthesize currentViewID, nextViewID;
@synthesize bookSectionController;
@synthesize currentSectionViewID;

@synthesize delegate;



//@synthesize viewIndexKeyPaths;
//@synthesize bookSections;



-(LeavesView *) leavesView {
	return (LeavesView *) self.view;
}

-(IBAction)actionForLeftEdge: (id)sender {
	if ([self.delegate respondsToSelector: _cmd]) {
		[self.delegate performSelector: _cmd withObject: sender];
	}
}
-(IBAction)actionForRightEdge: (id)sender{
	if ([self.delegate respondsToSelector: _cmd]) {
		[self.delegate performSelector: _cmd withObject: sender];
	}
}


//- (UIView *)viewForIndexKeyPath: (NSString *)indexKeyPath {
//	if (![self.viewIndexKeyPaths valueForKeyPath: indexKeyPath]) {
//		if (<#condition#>) {
//			<#statements#>
//		}
//	}
//	return [self.viewIndexKeyPaths valueForKeyPath: indexKeyPath];
//}


//- (BOOL) viewController:(UIViewController *)sender shouldTransitionToView:(UIView *)toView {
//	self.leavesView.nextPageIndex = [toView.section valueForKey: @"sectionIndex"];
//}

//-(BOOL) viewController:(UIViewController *)sender shouldTransitionToViewWithIndex:(NSString *)viewIndex {
//	self.leavesView.nextPageIndex = viewIndex;
//
//}



- (void) viewController: (UIViewController *)sender willTransitionToView: (UIView *)toView withID: (NSString *)viewID {
		//self.leavesView
	self.nextView = toView;
	self.nextViewID = viewID;
		//self.leavesView.currentPageIndex = @"currentView";
	self.leavesView.nextPageIndex = viewID;
	delegatingSender = sender;
		//self.leavesView.nextPageIndex = @"nextView";
}


- (void) leavesView:(LeavesView *)leavesView didTurnToPageAtIndex:(NSString *)pageIndex {
	LogMessage(@"leaves delegate", 3, @"didTurnToPageAtIndex: %@", pageIndex);
	
	if (![pageIndex isEqualToString: self.leavesView.currentPageIndex]) {
		self.currentView = self.nextView;
		self.nextView = nil;
		self.leavesView.nextPageIndex = nil;
		[self.leavesView.pageCache flush];
		[delegatingSender didTransitionToView: self.currentView withID: self.currentViewID];
		self.leavesView.contentView = self.currentView;
	}		
}
- (void) renderPageAtIndex:(NSString *)index inContext:(CGContextRef)ctx {
	LogMessage(@"leaves delegate", 3, @"In the renderPageAtIndex method.\nRequested page was: %@", index);
	CGImageRef image = nil;
	if ([index isEqualToString: self.nextViewID] && [self.nextView cgImage]) {
		image = (CGImageRef)[self.nextView cgImage];
	} else if ([index isEqualToString: self.currentViewID] && [self.currentView cgImage]) {
		image = (CGImageRef)[self.currentView cgImage];
	} else {
		image = [self renderImageForView: self.nextView];
	}

	
		//	LogMessage(@"leavesDelegate", 3, @"Retain count for image is: %i", CFGetRetainCount(image));
		//CGImageRef image = [self viewForIndexKeyPath: index].cgImage;

		//CGImageRef image = (CGImageRef)[self renderImageForView: [self viewForSection: index]];
		LogImageData(@"leaves delegate", 2, 1024, 768, UIImagePNGRepresentation([UIImage imageWithCGImage:image]));
	
	
	CGRect imageRect = CGRectMake(0, 0, self.leavesView.contentViewFrame.size.width, self.leavesView.contentViewFrame.size.height);
		//CGAffineTransform transform = aspectFit(imageRect,
		//						CGContextGetClipBoundingBox(ctx));
		//	CGContextConcatCTM(ctx, transform);
		//LogImageData(@"leaves delegate", 0, 1024, 768, UIImagePNGRepresentation([UIImage imageWithCGImage: image]));

	CGContextDrawImage(ctx, imageRect, image);
}

- (UIView *)viewForIndex: (NSString *)index {
	if ([index isEqualToString: @"nextView"]) {
		return self.nextView;
	} else if ([index isEqualToString: @"currentView"]) {
		return self.currentView;

	}
}


- (CGImageRef) renderImageForView: (UIView *)viewToRender {
	UIGraphicsBeginImageContext(viewToRender.frame.size);
	
	CGContextRef context = UIGraphicsGetCurrentContext();
	[viewToRender.layer renderInContext: context];
		//	[viewToRender.layer.presentationLayer renderInContext: context];
	
	CGImageRef renderedImage = [UIGraphicsGetImageFromCurrentImageContext() CGImage];
	
	UIGraphicsEndImageContext();
	
	return renderedImage;

}

 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
		//	self.currentView = self.leavesView.contentView;
//	self.leavesView.delegate = self;
//	self.leavesView.dataSource = self;
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Overriden to allow any orientation.
    return YES;
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}


- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
