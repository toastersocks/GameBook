//
//  Section.m
//  GameBook
//
//  Created by James Pamplona on 1/26/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "NSDictionary+Section.h"



@implementation NSDictionary (Section)

//@synthesize sectionDictionary;
//@synthesize touchables;
//@synthesize sectionLinks;
//
//- (id)initWithSectionDictionary: (NSDictionary *)newSectionDict {
//	if (self = [super init]) {
//		sectionDictionary = newSectionDict;
//	}
//	return self;
//}


- (NSArray *)touchables {
	NSMutableArray *touchables = [NSMutableArray arrayWithCapacity: 0];
	if ([self valueForKeyPath: @"spread.touchables"]) {
		[touchables addObjectsFromArray: [self valueForKeyPath: @"spread.touchables"]];
	} else {
		if ([self valueForKeyPath:@"right.options"]) {
			[touchables addObjectsFromArray: [self valueForKeyPath: @"right.options"]];

		} else if ([self valueForKeyPath:@"right.touchables"]) {
			[touchables addObjectsFromArray: [self valueForKeyPath: @"right.touchables"]];
		}
		
		if ([self valueForKeyPath:@"left.touchables"]) {
			[touchables addObjectsFromArray: [self valueForKeyPath: @"left.touchables"]];
		} else if ([self valueForKeyPath:@"left.options"]) {
			[touchables addObjectsFromArray: [self valueForKeyPath: @"left.options"]];
		}
	}
	return touchables;
}

- (NSArray *) sectionLinks {
	NSMutableArray *sectionLinks = [NSMutableArray arrayWithCapacity: 0];
	for (NSDictionary *currentChoice in [self touchables]) {
		if ([currentChoice objectForKey: @"load"]) {
			[sectionLinks addObject: [currentChoice objectForKey: @"load"]];
		}
	}
	return sectionLinks;		 
}

@end
