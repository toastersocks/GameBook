//
//  GamebookLog.m
//  GameBook
//
//  Created by James Pamplona on 12/4/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "GamebookLog.h"


@implementation GamebookLog

	// the Logs...
@synthesize sectionLog;
@synthesize keyEventLog;
@synthesize inventoryLog;
@synthesize databaseLog;


- (id) init {
	if (self = [super init]) {
		
	}
	self.sectionLog = [NSMutableArray arrayWithCapacity: 2];
	self.keyEventLog = [NSMutableArray arrayWithCapacity: 2];
	self.inventoryLog = [NSMutableArray arrayWithCapacity: 2];
	self.databaseLog = [NSMutableArray arrayWithCapacity: 2];
	
	return self;
}


- (BOOL) logItem: (NSString *)newLogItem existsInLog: (NSArray *)log {
	duplicateFound = NO;
	for (NSString *loggedEntry in [log reverseObjectEnumerator]) { // iterating over the array backwards because duplicates are morelikely to be at the end.
		if ( [loggedEntry isEqualToString: newLogItem] ) {
			duplicateFound = YES;
			NSLog(@"%@ already exists in the databaseLog", newLogItem);
			break;
		}
		
	}
	return duplicateFound;
}


- (void) logSection: (NSString *) sectionIndex {
	[self.sectionLog addObject: sectionIndex];
}

- (void) logKeyEvent: (NSString *) newKeyEvent {
	if (![self logItem: newKeyEvent existsInLog: self.keyEventLog]) {
		NSLog(@"logging %@ to database", newKeyEvent);
		[self.keyEventLog addObject: newKeyEvent];
	} else {
		NSLog(@"Not adding %@ to database", newKeyEvent);
	}
	
}

- (void) logInventoryItem: (NSString *) inventoryItem {
	
}


- (void) logDatabaseEntry: (NSString *) newDatabaseEntry {

	if (![self logItem: newDatabaseEntry existsInLog: self.databaseLog]) {
		NSLog(@"logging %@ to database", newDatabaseEntry);
		[self.databaseLog addObject: newDatabaseEntry];
	} else {
		NSLog(@"Not adding %@ to database", newDatabaseEntry);
	}

}



@end
