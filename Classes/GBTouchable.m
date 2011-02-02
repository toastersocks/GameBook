//
//  GBTouchable.m
//  GameBook
//
//  Created by James Pamplona on 2/2/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GBTouchable.h"


@implementation GBTouchable
@synthesize option;


- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code.
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code.
}
*/

- (void)dealloc {
    [super dealloc];
}


@end
