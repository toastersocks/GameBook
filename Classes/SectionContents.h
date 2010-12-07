//
//  PageContents.h
//  GameBook
//
//  Created by James Pamplona on 10/7/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RegexKitLite.h"


@interface SectionContents : NSObject {
	NSString *mainText;
	NSArray *images;
	NSMutableArray *options;
	
}

//+ (id) contentsFromPage: (NSString *) page
- (id) initWithSection:(NSString *)section;


// should make these readonly publicly, and implement private readwrite properties using a nameless extension in the implementation file. 
@property (retain, nonatomic) NSString *mainText; 
@property (retain, nonatomic) NSArray *images;
@property (retain, nonatomic) NSArray *options;


@end
