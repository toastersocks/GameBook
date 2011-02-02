//
//  GBTouchable.h
//  GameBook
//
//  Created by James Pamplona on 2/2/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface GBTouchable : UIButton {
	NSDictionary *option;
}
@property (nonatomic, retain) NSDictionary *option;

@end
