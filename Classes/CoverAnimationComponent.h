//
//  CoverAnimationComponent.h
//  GameBook
//
//  Created by James Pamplona on 5/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef struct {
	CGImageRef leftHalf;
	CGImageRef rightHalf;
} PageImageRefs;


@interface CoverAnimationComponent : UIViewController {
    CGRect leftHalf, rightHalf;
	CGRect openViewFrame;
	
	UIView *_viewToOpen;
	UIView *_toView;
	
}

@property (assign, nonatomic) UIViewController *animationInitiator;
@property (retain, nonatomic) UIView *viewToOpen;
@property (retain, nonatomic) UIView *toView;

- (void) beginAnimationOfView:(UIView *)viewToOpen toView: (UIView *)toView duration:(NSTimeInterval)duration sender: (id)sender;

- (PageImageRefs)pageImagesForView: (UIView *)viewToRender;

@end
