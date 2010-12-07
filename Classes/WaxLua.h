//
//  WaxLua.h
//  waxFinalText
//
//  Created by James Pamplona on 11/16/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface WaxLua : NSObject {

}

- (void) setObject: (id)objectToBePushed asGlobalNamed: (const char *)luaVariableName;

- (id) getObjectFromGlobalNamed: (const char *) luaGlobalName;

- (void) doScript: (NSString *)script;

@end
