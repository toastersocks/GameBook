//
//  SectionParser.h
//  GameBook
//
//  Created by James Pamplona on 11/16/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WaxLua;
@class Section;


@interface SectionParser : NSObject {
	NSArray *sectionLog;
	NSArray *keyEventLog;
	NSArray *inventoryLog;
	NSArray *databaseLog;
	
	WaxLua *parserEngine;
	
	NSDictionary *section;
//	Section *section;

	NSDictionary *sceneObject;

}
@property (retain, nonatomic) WaxLua *parserEngine;


@property (retain, nonatomic) NSArray *sectionLog;
@property (retain, nonatomic) NSArray *keyEventLog;
@property (retain, nonatomic) NSArray *inventoryLog;
@property (retain, nonatomic) NSArray *databaseLog;

@property (retain, nonatomic) NSDictionary *section;
//@property (retain, nonatomic) Section *section;

@property (retain, nonatomic) NSDictionary *sceneObject;

- (NSDictionary *) contentsForSection: (NSString*)sectionIndex;
//- (Section *) contentsForSection: (NSString *)sectionIndex;

- (NSDictionary *) objectNamed: (NSString *)objectIndex;

- (id) initWithSectionLog: (NSArray *)sectionLog keyEventLog: (NSArray *)keyEventLog inventoryLog: (NSArray *)inventoryLog databaseLog: (NSArray *)inDatabaseLog;

@end
