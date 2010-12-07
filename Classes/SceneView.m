//
//  SceneView.m
//  GameBook
//
//  Created by James Pamplona on 11/23/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "SceneView.h"


@implementation SceneView

@synthesize scene;
	//@synthesize baseImage;
@synthesize touchables;



- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        // Initialization code
		self.userInteractionEnabled = YES;
    }
    return self;
}


- (void) setScene:(NSDictionary *) inScene {
	if (scene != inScene) {
		[scene release];
		scene = [inScene retain];
	}
		//NSLog(@"%@: setting scene:\n%@", self, scene);
	self.image = [scene valueForKey: @"baseImage"];
	
	if ([scene valueForKey: @"touchables"]) {
		self.touchables = [scene valueForKey: @"touchables"];

	}
}


- (void) setTouchables:(NSArray *) newTouchables {
	if (touchables != newTouchables) {
		[touchables release];
		touchables = [newTouchables retain];
	}
	
	//touchables = newTouchables;
	
	for (NSDictionary *touchable in touchables) {
		UIButton *button = [UIButton buttonWithType: UIButtonTypeCustom];
		
		
		[button setImage: [touchable valueForKey: @"sceneSprite"]  
				forState: UIControlStateNormal];
		
		button.frame = CGRectMake([ [touchable valueForKeyPath: @"position.x"] floatValue] * self.bounds.size.width,
								  [ [touchable valueForKeyPath: @"position.y"] floatValue] * self.bounds.size.height,
								  [ [touchable valueForKey: @"sceneSprite"] size].width, 
								  [ [touchable valueForKey: @"sceneSprite"] size].height);
		[button addTarget: NULL 
				   action: @selector(getChosenOption:) 
		 forControlEvents: UIControlEventTouchUpInside];
		
		[self addSubview: button];
	}
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)dealloc {
	[touchables release];
    [super dealloc];
}


@end
