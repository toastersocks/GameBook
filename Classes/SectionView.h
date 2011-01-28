//
//  SectionView.h
//  GameBook
//
//  Created by James Pamplona on 11/26/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LeavesView.h"
@class SceneView;
@class TextView;
//@class OptionViewController;

@interface SectionView : LeavesView {

	NSDictionary *section;
	
//	SceneView *leftSceneView;
//	SceneView *rightSceneView;
//	SceneView *spreadSceneView;
//	
//	TextView *leftTextView;	
//	TextView *rightTextView;
	UIView *leftPageView;
	UIView *rightPageView;
	UIView *spreadSceneView;
	
//	UIView *leftTextView;	
//	UIView *rightTextView;
	CAGradientLayer *leftPageShadow;
	CAGradientLayer *rightPageShadow;
	
	CGRect fullSpreadRect;
	CGRect rightHalfRect;
	CGRect leftHalfRect;
	
}

@property (nonatomic, retain) NSDictionary *section;

//@property (nonatomic, retain) SceneView *leftSceneView;
//@property (nonatomic, retain) SceneView *rightSceneView;
//@property (nonatomic, retain) SceneView *spreadSceneView;
//
//
//@property (nonatomic, retain) IBOutlet TextView *leftTextView;
//@property (nonatomic, retain) IBOutlet TextView *rightTextView;

@property (nonatomic, retain) UIView *leftPageView;
@property (nonatomic, retain) UIView *rightPageView;
@property (nonatomic, retain) UIView *spreadSceneView;

//@property (nonatomic, retain) IBOutlet UIView *leftTextView;
//@property (nonatomic, retain) IBOutlet UIView *rightTextView;


- (void) setupShadows;

@end
