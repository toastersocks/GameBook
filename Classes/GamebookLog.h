//
//  GamebookLog.h
//  GameBook
//
//  Created by James Pamplona on 12/4/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface GamebookLog : NSObject {
	NSMutableArray *sectionLog;
	NSMutableArray *keyEventLog;
	NSMutableArray *inventoryLog;
	NSMutableArray *databaseLog;
	
	BOOL duplicateFound;

	
}
	// Logs...
@property (retain, nonatomic) NSMutableArray *sectionLog;
@property (retain, nonatomic) NSMutableArray *keyEventLog;
@property (retain, nonatomic) NSMutableArray *inventoryLog;
@property (retain, nonatomic) NSMutableArray *databaseLog;


- (void) logSection: (NSString *) sectionIndex;
- (void) logKeyEvent: (NSString *) newKeyEvent;
- (void) logInventoryItem: (NSString *) inventoryItem;
- (void) logDatabaseEntry: (NSString *) newDatabaseEntry;

- (BOOL) logItem: (NSString *)newLogItem existsInLog: (NSArray *)log;

@end
