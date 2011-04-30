//
//  OrderedDictionary.h
//  OrderedDictionary
//
//  Created by Matt Gallagher on 19/12/08.
//  Copyright 2008 Matt Gallagher. All rights reserved.
//

	//#import <Cocoa/Cocoa.h>
#import <Foundation/Foundation.h>

@interface OrderedDictionary : NSMutableDictionary
{
	NSMutableDictionary *dictionary;
	NSMutableArray *array;
}

- (void)insertObject:(id)anObject forKey:(id)aKey atIndex:(NSUInteger)anIndex;
- (id)keyAtIndex:(NSUInteger)anIndex;
- (id)objectAtIndex:(NSUInteger)anIndex;
- (id)keyForObject: (id)aObject;
- (id)allKeysForObject: (id)aObject;
- (NSUInteger)indexForKey: (id)key;
- (NSEnumerator *)reverseKeyEnumerator;

@end
