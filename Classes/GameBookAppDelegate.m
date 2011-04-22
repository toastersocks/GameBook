//
//  GameBookAppDelegate.m
//  GameBook
//
//  Created by James Pamplona on 10/3/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "wax/wax.h"

#import "GameBookAppDelegate.h"
#import "BookController.h"
//#import "PagesViewController.h"
#import "GamebookLog.h"

//#import "WaxLua.h"
//#import "PageContents.h"



@implementation GameBookAppDelegate

@synthesize window;
//@synthesize pagesViewController;

@synthesize bookController;

	//@synthesize gamebookLog;




#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
//	WaxLua *testLua = [[WaxLua alloc] init];
//	[testLua doScript: @"ParseHelperTest"];
    
	// Override point for customization after app launch.
	NSLog(@"The app has finished launching");
	//wax_start();
//	[bookViewController.view setFrame:[[UIScreen mainScreen] applicationFrame]];
	[bookController.view setFrame: CGRectMake(0, 0, 1024, 768)];

	NSLog(@"applicationFrame is: %@", NSStringFromCGRect([[UIScreen mainScreen] applicationFrame]));
    [window addSubview: self.bookController.view];
    [window makeKeyAndVisible];
//	[self.bookViewController displayCover]; 
	
	return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}


- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     See also applicationDidEnterBackground:.
     */
		// TODO: Move this crap into the pagesViewController or bookViewController and call the method from here
		// Save the logs before quitting

	[[GamebookLog sharedGamebookLog] saveLogs];
//	[self.bookController saveLogs]; 
		//[[[self bookViewController] gamebookLog] saveLogs];

	
		//NSLog(@"The location of sectionLog.plist is: %@", sectionLog);
}


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}


- (void)dealloc {
    //[pagesViewController release];
    [window release];
    [super dealloc];
}


@end
