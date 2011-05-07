//
//  CoverAnimationComponent.m
//  GameBook
//
//  Created by James Pamplona on 5/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CoverAnimationComponent.h"
#import <QuartzCore/QuartzCore.h>

	/////private interface decleration///////

@interface CoverAnimationComponent ()

- (void)setupInsidePages;

@end



@implementation CoverAnimationComponent

@synthesize animationInitiator;
@synthesize viewToOpen = _viewToOpen;
@synthesize toView = _toView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void) beginAnimationOfView:(UIView *)viewToOpen toView: (UIView *)toView duration:(NSTimeInterval)duration sender: (id)sender {
	pageImages = [self pageImagesForView: toView];

	self.animationInitiator = sender;
	self.toView = toView;
	self.viewToOpen = viewToOpen;
	self.viewToOpen.clipsToBounds = YES;
	openViewFrame = _viewToOpen.frame;
	// Remove existing animations before stating new animation
//    [_viewToOpen.layer removeAllAnimations];
	[self setupInsidePages];
	

    
		// Make sure view is visible
    _viewToOpen.hidden = NO;
    
		// disable the view so it’s not doing anythign while animating
    _viewToOpen.userInteractionEnabled = NO;
		// Set the CALayer anchorPoint to the left edge and
		// translate the button to account for the new
		// anchorPoint. In case you want to reuse the animation
		// for this button, we only do the translation and
		// anchor point setting once.
//    if (viewToOpen.layer.anchorPoint.x != 0.0f) {
//        viewToOpen.layer.anchorPoint = CGPointMake(0.0f, 0.5f);
	_viewToOpen.layer.anchorPoint = CGPointMake(0.25f, 0.5f);

   _viewToOpen.center = CGPointMake(_viewToOpen.center.x - _viewToOpen.bounds.size.width/4.0f, _viewToOpen.center.y);
//    }
		// create an animation to hold the page turning
		//    CABasicAnimation *transformAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
	CAKeyframeAnimation *transformAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
	transformAnimation.delegate = self;
	transformAnimation.removedOnCompletion = NO;
	CATransform3D startingTransform = CATransform3DIdentity;
		//	CATransform3D halfwayTransform = startingTransform;
	CATransform3D halfwayTransform = CATransform3DMakeRotation(3.141f/2, 
															   0.0f, 
															   -1.0f, 
															   0.0f);
	halfwayTransform.m14 = -0.001f;
	halfwayTransform.m34 = 0.0015f;
	
		//	CATransform3D endingTransform = halfwayTransform;
	CATransform3D endingTransform = CATransform3DMakeRotation(3.141f, 
															  0.0f, 
															  -1.0f, 
															  0.0f);
	endingTransform.m34 = 0.001f;
	endingTransform.m14 = 0.00f;
	
	NSArray *transforms = [NSArray arrayWithObjects: 
						   [NSValue valueWithCATransform3D:startingTransform], 
						   [NSValue valueWithCATransform3D: halfwayTransform], 
						   [NSValue valueWithCATransform3D: endingTransform], nil];
	
	NSArray *keyTimes = [NSArray arrayWithObjects: 
						 [NSNumber numberWithFloat: 0.0],
						 [NSNumber numberWithFloat: 0.5], 
						 [NSNumber numberWithFloat: 1.0], nil];
	
    transformAnimation.removedOnCompletion = NO;
    transformAnimation.duration = duration;
	transformAnimation.keyTimes = keyTimes;
	transformAnimation.values = transforms;
	[_viewToOpen.layer addAnimation: transformAnimation forKey:@"transform"];
	
//	PageImageRefs pageImages = [self pageImagesForView: toView];
	

}


- (void)setupInsidePages {
	CALayer *rightInsidePage = [CALayer layer];
	CALayer *leftInsidePage = [CALayer layer];
	
//	pageImages = [self pageImagesForView: self.toView];
	
	rightInsidePage.frame = openViewFrame;
	rightInsidePage.contents = (id)pageImages.rightHalf;
//	[self.viewToOpen.layer insertSublayer: rightInsidePage below: self.viewToOpen.layer];
//	rightInsidePage.anchorPoint = CGPointMake(0.5, 0);
//	rightInsidePage.position = CGPointMake(256*3, 0);
	
	[self.animationInitiator.view.layer insertSublayer: rightInsidePage below: self.viewToOpen.layer];
//	rightInsidePage.position = CGPointMake([[self.viewToOpen.layer presentationLayer] position].x, 0);
	rightInsidePage.position = CGPointMake(self.viewToOpen.layer.position.x, 0);
	
	rightInsidePage.anchorPoint = CGPointMake(0.5, 0);
	rightInsidePage.position = CGPointMake(512, 0);	
	CABasicAnimation *underPagePositionAnimation = [CABasicAnimation animationWithKeyPath: @"position.x"];
	underPagePositionAnimation.duration = 2.0f;
	underPagePositionAnimation.toValue = [NSNumber numberWithInt: 512+256]; //TODO: change this to screen width /2
	[rightInsidePage addAnimation: underPagePositionAnimation forKey: @"position.x"];
	
//	rightInsidePage.bounds = CGRectMake(0, 0, 0, 768);
	
//	CABasicAnimation *underPageAnimation = [CABasicAnimation animationWithKeyPath: @"bounds.size.width"];
//	underPageAnimation.duration = 2.0f;
//	underPageAnimation.toValue = [NSNumber numberWithInt: 512]; //TODO: change this to screen width /2
//	[rightInsidePage addAnimation: underPageAnimation forKey: @"bounds.size.width"];
	
//	rightInsidePage.contentsRect = CGRectMake(1.0, 0, 0, 1.0);
	
//	CALayer *mask = [CALayer layer];
//	rightInsidePage.mask = mask;
//	mask.anchorPoint = CGPointMake(0.0, 0);
//	mask.bounds = CGRectMake(0, 0, 212, 768);
	
//	CABasicAnimation *underPageContentsRectAnimation = [CABasicAnimation animationWithKeyPath: @"bounds"];
//	underPageContentsRectAnimation.duration = 2.0f;
//	underPageContentsRectAnimation.toValue = [NSValue valueWithCGRect: CGRectMake(0, 0, 512, 768)]; //TODO: change this to screen width /2
//	[mask addAnimation: underPageContentsRectAnimation forKey: @"bounds"];
//	
//
//
}


- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
	if (flag) {
		[self.animationInitiator coverDidOpen];
	}
}



- (CGImageRef)renderImageForView: (UIView *)viewToRender {
		//	UIGraphicsBeginImageContext(viewToRender.frame.size);
	UIGraphicsBeginImageContext(CGSizeMake(1024, 768));
	
	
	CGContextRef context = UIGraphicsGetCurrentContext();
	[viewToRender.layer renderInContext: context];
		//	[viewToRender.layer.presentationLayer renderInContext: context];
	
	CGImageRef renderedImage = [UIGraphicsGetImageFromCurrentImageContext() CGImage];
	
	UIGraphicsEndImageContext();
	LogImageData(@"Cover", 2, 1024, 768, UIImagePNGRepresentation([UIImage imageWithCGImage: renderedImage]));
	
	return renderedImage;
}

- (PageImageRefs)pageImagesForView: (UIView *)viewToRender {
	CGRect twoPageSpreadRect = viewToRender.bounds;
	CGImageRef image = [self renderImageForView: viewToRender];
//	CGRect leftHalf, rightHalf;
	CGRectDivide(twoPageSpreadRect, &leftHalf, &rightHalf, CGRectGetWidth(twoPageSpreadRect) / 2.0f, CGRectMinXEdge);
	PageImageRefs pageImageRefs;
	pageImageRefs.rightHalf = CGImageCreateWithImageInRect(image, rightHalf);
	pageImageRefs.leftHalf = CGImageCreateWithImageInRect(image, leftHalf);
	
	return pageImageRefs;
	
}


- (void)dealloc
{
    [super dealloc];
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

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/

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
