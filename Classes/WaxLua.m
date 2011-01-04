//
//  WaxLua.m
//  waxFinalText
//
//  Created by James Pamplona on 11/16/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "WaxLua.h"

#import "wax/wax.h"
#import "wax/lauxlib.h"
#import "wax/wax_helpers.h"


@implementation WaxLua

	//@synthesize fetchedLuaGlobal;

- (id) init {
	if ((self = [super init])) {
		
		wax_start();
		NSLog(@"WaxLua at %@ initted...", self);

	}
	return self;
}


- (void) doScript: (NSString *)script {
	NSLog(@"Doing script %@", script);
	
	NSString *fullScriptPath = [[NSBundle mainBundle] pathForResource: script 
													 ofType:@"lua"];
	
	fullScriptPath = [NSString stringWithFormat:@"%@%@", script, @".lua"];
	
	NSLog(@"WaxLua at%@: Doing script at %@", self, fullScriptPath);
	
	if (luaL_dofile(wax_currentLuaState(), [fullScriptPath cStringUsingEncoding:NSASCIIStringEncoding]) != 0) {
        fprintf(stderr,"Fatal error opening ParserHelper script: %s\n", lua_tostring(wax_currentLuaState(),-1));
    }

	
}


- (void) setObject: (id)objectToBePushed asGlobalNamed: (const char *)luaVariableName {
	
		//put the array into the luaState
	wax_fromInstance(wax_currentLuaState(), objectToBePushed);
	lua_setglobal(wax_currentLuaState(), luaVariableName);
		//end
}


- (id) getObjectFromGlobalNamed: (const char *) luaGlobalName {
	
	lua_getglobal(wax_currentLuaState(), luaGlobalName);
		//Do I need to release the returned object? See note in wax_helpers.m
//	fetchedLuaGlobal = *(id *)wax_copyToObjc(wax_currentLuaState(), "@", -1, nil);
//id *tempObjectPointer = wax_copyToObjc(wax_currentLuaState(), "@", -1, nil);
		//NSLog(@"tempObjectPointer retain count is: %i", [tempObjectPointer retainCount]);
	
	tempIDPointer = wax_copyToObjc(wax_currentLuaState(), "@", -1, nil); // this temp variable is nessesary in order to be able to free the pointer to the pointer to the returned object. otherwise it leaks because this function returns a double pointer.
	
	NSLog(@"tempIDPointer is at %p", tempIDPointer);
		//if (fetchedLuaGlobal != nil) {
			//[fetchedLuaGlobal release];
			//}
	fetchedLuaGlobal = *(id *)tempIDPointer;
		//[tempIDPointer release];
		//tempIDPointer = nil;
	free(tempIDPointer); // free the pointless pointer
		//fetchedLuaGlobal = &**tempObjectPointer;
		//tempObjectPointer = nil;
	NSLog(@"fetched object at %p is:\n%@", fetchedLuaGlobal, fetchedLuaGlobal);
		
		//[self.fetchedLuaGlobal release];
	NSLog(@"fetchedLuaGlobal retain count is: %i", [fetchedLuaGlobal retainCount]);
	
		return [fetchedLuaGlobal autorelease];
		//return fetchedLuaGlobal;
		//do i need to pop the object off the lua stack?

}


@end
