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
- (CGImageRef)renderImageForView: (UIView *)viewToRender;
- (CGImageRef)mirrorXAxisOfCGImage: (CGImageRef)image;


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
//	CALayer *coverLayer = [CALayer layer];
//	coverLayer.contents =

	self.animationInitiator = sender;
	self.toView = toView;
	self.viewToOpen = viewToOpen;
	openViewFrame = _viewToOpen.frame;
	// Remove existing animations before stating new animation
//    [_viewToOpen.layer removeAllAnimations];
	pageImages = [self pageImagesForView: toView];

	CGImageRef viewToOpenImage = [self renderImageForView: viewToOpen];
	LogImageData(@"Cover", 2, 512, 768, UIImagePNGRepresentation([UIImage imageWithCGImage: viewToOpenImage]));
	
	pageImages.leftHalf = [self mirrorXAxisOfCGImage: pageImages.leftHalf];

	CALayer *viewToOpenOverlay = [CALayer layer];
	viewToOpenOverlay.contents = (id)viewToOpenImage;
	CALayer *rightInsideLayer = [CALayer layer];
	rightInsideLayer.frame = viewToOpen.frame;

//	rightInsideLayer.frame = CGRectMake(512, 0, 512, 768);
	
	[self.animationInitiator.view.layer addSublayer: rightInsideLayer];
	viewToOpen.hidden = YES;
	
		//	viewToOpenOverlay.backgroundColor = [UIColor greenColor].CGColor;
	viewToOpenOverlay.bounds = rightInsideLayer.bounds;
	LogImageData(@"cover", 2, 512, 768, UIImagePNGRepresentation([UIImage imageWithCGImage: pageImages.rightHalf]));
	rightInsideLayer.contents = (id)pageImages.rightHalf;

	[rightInsideLayer addSublayer: viewToOpenOverlay];
	viewToOpenOverlay.anchorPoint = CGPointMake(0.0f, 0.0f);

		// create an animation to hold the page turning
	CAKeyframeAnimation *transformAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
	transformAnimation.delegate = self;
	transformAnimation.removedOnCompletion = NO;
	CATransform3D startingTransform = CATransform3DIdentity;
	CATransform3D halfwayTransform = CATransform3DMakeRotation(3.141f/2, 
															   0.0f, 
															   -1.0f, 
															   0.0f);
	halfwayTransform.m14 = -0.001f;
	halfwayTransform.m34 = 0.0005f;
	
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
	transformAnimation.fillMode = kCAFillModeForwards;
    transformAnimation.duration = duration;
	transformAnimation.keyTimes = keyTimes;
	transformAnimation.values = transforms;
	transformAnimation.timingFunction = [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseInEaseOut];
	
	
	CABasicAnimation *changeImage = [CABasicAnimation animationWithKeyPath: @"contents"];
	changeImage.duration = 0.001f;
	changeImage.toValue = (id)pageImages.leftHalf;
	changeImage.removedOnCompletion = NO;
	changeImage.fillMode = kCAFillModeForwards;
	changeImage.beginTime = CACurrentMediaTime() + duration/2;
	
		/////////MoveToRightAnimation///////////
	CABasicAnimation *moveToRight = [CABasicAnimation animationWithKeyPath: @"position.x"];
	moveToRight.removedOnCompletion = NO;
	moveToRight.fillMode = kCAFillModeForwards;
	moveToRight.timingFunction = [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseInEaseOut];
	moveToRight.duration = 1.5f;
//	moveToRight.duration = 2.0f;

	moveToRight.toValue = [NSNumber numberWithInt: 512+256];
	
//	rightInsideLayer.delegate = self;
	

	
	[rightInsideLayer addAnimation: moveToRight forKey: @"position.x"];
	
//	CAAnimationGroup *overlayAnimations = [CAAnimationGroup animation];
//	overlayAnimations.animations = [NSArray arrayWithObjects: transformAnimation, changeImage, nil];
	
	[viewToOpenOverlay addAnimation: changeImage forKey:@"contents"];
	[viewToOpenOverlay addAnimation: transformAnimation forKey:@"transform"];
	
//	PageImageRefs pageImages = [self pageImagesForView: toView];
	

}

- (CGImageRef)mirrorXAxisOfCGImage: (CGImageRef)imageToFlip {
	NSInteger imageWidth = CGImageGetWidth(imageToFlip);
	NSInteger imageHeight = CGImageGetHeight(imageToFlip);
	LogMessage(@"cover", 3, @"image width: %i, height: %i", imageWidth, imageHeight);
	CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
	CGContextRef context = CGBitmapContextCreate(NULL, imageWidth, imageHeight, 8, imageWidth * 4, colorSpace, kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
	
	CGColorSpaceRelease(colorSpace);
	
	CGRect rect = CGRectMake(0, 0, -imageWidth, imageHeight);
	
//	CGContextClipToRect(context, rect);
	
	
	
//	CGContextScaleCTM(context, -1.0, 1.0);
//	CGContextSaveGState(context);
	CGContextScaleCTM(context, -1.0, 1.0);

	
	CGContextDrawImage(context, rect, imageToFlip);
	
//	CGContextRestoreGState(context);
	CGImageRef transformedImage = CGBitmapContextCreateImage(context);
	
	CGContextRelease(context);

	LogImageData(@"Cover", 2, 512, 768, UIImagePNGRepresentation([UIImage imageWithCGImage: transformedImage]));
	
	return transformedImage;
	
}

- (void)setupInsidePages {
	CALayer *rightInsidePage = [CALayer layer];
	CALayer *leftInsidePage = [CALayer layer];
	
//	pageImages = [self pageImagesForView: self.toView];
	
//	rightInsidePage.frame = openViewFrame;
	rightInsidePage = self.viewToOpen.layer;
	rightInsidePage.contents = (id)pageImages.rightHalf;
//	[self.viewToOpen.layer insertSublayer: rightInsidePage below: self.viewToOpen.layer];
//	rightInsidePage.anchorPoint = CGPointMake(0.5, 0);
//	rightInsidePage.position = CGPointMake(256*3, 0);
	
//	[self.animationInitiator.view.layer insertSublayer: rightInsidePage below: self.viewToOpen.layer];
	
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
	CGSize viewSize = viewToRender.bounds.size;
	UIGraphicsBeginImageContext(viewSize);
	
	
	CGContextRef context = UIGraphicsGetCurrentContext();
	[viewToRender.layer renderInContext: context];
		//	[viewToRender.layer.presentationLayer renderInContext: context];
	
	CGImageRef renderedImage = [UIGraphicsGetImageFromCurrentImageContext() CGImage];
	
	UIGraphicsEndImageContext();
	LogImageData(@"Cover", 2, viewSize.width, viewSize.height, UIImagePNGRepresentation([UIImage imageWithCGImage: renderedImage]));
	
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
