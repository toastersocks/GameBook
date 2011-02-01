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

@interface SectionView : UIView {

	NSDictionary *section;
	
	UIView *leftPageView;
	UIView *rightPageView;
	UIView *spreadSceneView;
	
	CGRect fullSpreadRect;
	CGRect rightHalfRect;
	CGRect leftHalfRect;
	
}

@property (nonatomic, retain) NSDictionary *section;


@property (nonatomic, retain) UIView *leftPageView;
@property (nonatomic, retain) UIView *rightPageView;
@property (nonatomic, retain) UIView *spreadSceneView;



@end
