//
//  SceneView.h
//  GameBook
//
//  Created by James Pamplona on 11/23/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SceneView : UIImageView {
	NSDictionary *scene;
	//UIImage *baseImage;
	NSArray *touchables;
		//UIImageView *background;

}

@property (retain, nonatomic) NSDictionary *scene;
//@property (retain, nonatomic) UIImage *baseImage;
@property (retain, nonatomic) NSArray *touchables;

@end
