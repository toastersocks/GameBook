//
//  main.m
//  GameBook
//
//  Created by James Pamplona on 10/3/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


int main(int argc, char *argv[]) {
    
		//LoggerSetOptions(NULL, kLoggerOption_LogToConsole); // tells NSLogger to use the console
	
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
    int retVal = UIApplicationMain(argc, argv, nil, nil);
    [pool release];
    return retVal;
}
