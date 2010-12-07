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

- (id) init {
	if (self = [super init]) {
		
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
	
	return *(id *)wax_copyToObjc(wax_currentLuaState(), "@", -1, nil);
		//do i need to pop the object off the lua stack?

}


@end
