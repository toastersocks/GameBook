//
//  SectionParser.h
//  GameBook
//
//  Created by James Pamplona on 11/16/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WaxLua;


@interface SectionParser : NSObject {
	NSArray *sectionLog;
	NSArray *keyEventLog;
	NSArray *inventoryLog;
	NSArray *databaseLog;
	
	WaxLua *parserEngine;

}
@property (retain, nonatomic) WaxLua *parserEngine;


@property (retain, nonatomic) NSArray *sectionLog;
@property (retain, nonatomic) NSArray *keyEventLog;
@property (retain, nonatomic) NSArray *inventoryLog;
@property (retain, nonatomic) NSArray *databaseLog;

- (NSDictionary *) contentsForSection: (NSString*)sectionIndex;
- (NSDictionary *) objectNamed: (NSString *)objectIndex;

- (id) initWithSectionLog: (NSArray *)sectionLog keyEventLog: (NSArray *)keyEventLog inventoryLog: (NSArray *)inventoryLog databaseLog: (NSArray *)inDatabaseLog;

@end
