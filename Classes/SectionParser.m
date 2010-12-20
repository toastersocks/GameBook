//
//  SectionParser.m
//  GameBook
//
//  Created by James Pamplona on 11/16/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "SectionParser.h"
#import "WaxLua.h"
	//#import "SectionContents.h"


@implementation SectionParser

@synthesize parserEngine;

@synthesize sectionLog;
@synthesize keyEventLog;
@synthesize inventoryLog;
@synthesize databaseLog;


- (id) init {
	if (self = [super init]) {
//		self.sectionLog = sectionLog;
//		self.keyEventLog = keyEventLog;
//self.parserEngine = [[WaxLua alloc] init];
		
	}
	
	return [self initWithSectionLog: nil keyEventLog: nil inventoryLog: nil databaseLog: nil];
}

- (id) initWithSectionLog:(NSArray *)inSectionLog keyEventLog:(NSArray *)inKeyEventLog inventoryLog:(NSArray *)inInventoryLog databaseLog: (NSArray *)inDatabaseLog {
	if (self = [super init]) {
		
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
	NSDictionary *sceneObject = [self.parserEngine getObjectFromGlobalNamed: "sceneObject"];
	return sceneObject; //release? return as autorelease?
					//maintext? leftText? ... in lua script, left.text, left.option, left.option etc... right.image right.imageOption right.popup
	
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
	NSDictionary *section = [self.parserEngine getObjectFromGlobalNamed: "section"];
	return section; //release? return as autorelease?
		//maintext? leftText? ... in lua script, left.text, left.option, left.option etc... right.image right.imageOption right.popup

		//return [SectionContents sectionWith//??? maybe a dictionary as sectionContents instead of a custom object? 
}




@end
