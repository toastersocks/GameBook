//
//  GameBookAppDelegate.h
//  GameBook
//
//  Created by James Pamplona on 10/3/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

//@class PagesViewController;
//@class BookViewController;
@class BookController;
@class GamebookLog;



@interface GameBookAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
//    PagesViewController *pagesViewController;
//	BookViewController *bookViewController;
	BookController *bookController;
	
	GamebookLog *gamebookLog;		

	
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
//@property (nonatomic, retain) IBOutlet PagesViewController *pagesViewController;
@property (nonatomic, retain) IBOutlet BookController *bookController;

	//@property (nonatomic, retain) IBOutlet GamebookLog *gamebookLog;


@end

