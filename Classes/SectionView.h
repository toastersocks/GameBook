//
//  SectionView.h
//  GameBook
//
//  Created by James Pamplona on 11/26/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SceneView;
@class TextView;
//@class OptionViewController;

@interface SectionView : UIView {

	NSDictionary *section;
	SceneView *leftSceneView;
	SceneView *rightSceneView;
	SceneView *spreadSceneView;
	
	TextView *leftTextView;	
	TextView *rightTextView;
	
}

@property (nonatomic, retain) NSDictionary *section;
@property (nonatomic, retain) SceneView *leftSceneView;
@property (nonatomic, retain) SceneView *rightSceneView;
@property (nonatomic, retain) SceneView *spreadSceneView;


@property (nonatomic, retain) IBOutlet TextView *leftTextView;

@property (nonatomic, retain) IBOutlet TextView *rightTextView;

@end
