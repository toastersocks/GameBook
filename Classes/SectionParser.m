//
//  SectionParser.m
//  GameBook
//
//  Created by James Pamplona on 11/16/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "SectionParser.h"
#import "WaxLua.h"
#import "NSDictionary+Section.h"
	//#import "SectionContents.h"


@implementation SectionParser

@synthesize parserEngine;

@synthesize sectionLog;
@synthesize keyEventLog;
@synthesize inventoryLog;
@synthesize databaseLog;

@synthesize section;
@synthesize sceneObject;

- (id) init {
	if ((self = [super init])) {
//		self.sectionLog = sectionLog;
//		self.keyEventLog = keyEventLog;
//self.parserEngine = [[WaxLua alloc] init];
		
	}
	
	return [self initWithSectionLog: nil keyEventLog: nil inventoryLog: nil databaseLog: nil];
}

- (void)awakeFromNib {
	[self initWithSectionLog: nil keyEventLog: nil inventoryLog: nil databaseLog: nil];
}

- (id) initWithSectionLog:(NSArray *)inSectionLog keyEventLog:(NSArray *)inKeyEventLog inventoryLog:(NSArray *)inInventoryLog databaseLog: (NSArray *)inDatabaseLog {
	if ((self = [super init])) {
		
		self.sectionLog = inSectionLog;
		self.keyEventLog = inKeyEventLog;
		self.inventoryLog = inInventoryLog;
		self.databaseLog = inDatabaseLog;
		
		self.parserEngine = [[WaxLua alloc] init];
		
	}
	
	return self;
}

- (NSDictionary *) objectNamed: (NSString *)objectIndex { //gets a game "object" (touchable sprite objects)
		// Push the logs...
	[self.parserEngine setObject: self.sectionLog asGlobalNamed: "sectionLog"];
	[self.parserEngine setObject: self.keyEventLog asGlobalNamed: "keyEventLog"];
	[self.parserEngine setObject: self.inventoryLog asGlobalNamed: "inventoryLog"];
	[self.parserEngine setObject: self.databaseLog asGlobalNamed: "databaseLog"];
	
	NSLog(@"the objectIndex is %@",objectIndex);
	[self.parserEngine setObject: objectIndex asGlobalNamed: "objectIndex"];
	[self.parserEngine doScript: @"gameObjectHelper"];
	sceneObject = [self.parserEngine getObjectFromGlobalNamed: "sceneObject"];
		//return [sceneObject autorelease]; //release? return as autorelease?
	return self.sceneObject;
}

- (NSDictionary *) contentsForSection: (NSString*)sectionIndex {
		//NSLog(@"Getting contents for section %@", sectionIndex);
	NSString *sectionIndexWithPath = [[NSBundle mainBundle] pathForResource: sectionIndex 
																	 ofType:@"txt"];
		//NSLog(@"Instance%@: Full path for section is: %@", self, sectionIndexWithPath);
	
		// Push the logs...								  
	[self.parserEngine setObject: self.sectionLog asGlobalNamed: "sectionLog"];
	[self.parserEngine setObject: self.keyEventLog asGlobalNamed: "keyEventLog"];
	[self.parserEngine setObject: self.inventoryLog asGlobalNamed: "inventoryLog"];
	[self.parserEngine setObject: self.databaseLog asGlobalNamed: "databaseLog"];
	
	[self.parserEngine setObject: sectionIndexWithPath asGlobalNamed: "sectionIndex"];
	[self.parserEngine doScript: @"ParseHelper"];
	self.section = [self.parserEngine getObjectFromGlobalNamed: "section"];
		//self.section = [Section initWithSectionDictionary: [self.parserEngine getObjectFromGlobalNamed: "section"] ];
		//return [section autorelease]; //release? return as autorelease?
	return self.section;
}




@end
