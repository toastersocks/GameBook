    //
//  CoverViewController.m
//  GameBook
//
//  Created by James Pamplona on 10/23/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "CoverViewController.h"
#import "GameBookViewWithDelegate.h"


@implementation CoverViewController

//@synthesize delegate;
@synthesize coverButton;



- (IBAction) openCover: sender {
	if (self.delegate != NULL && [self.delegate respondsToSelector:@selector(openCover:)]) {
//		[self openAnimation];
		[self.delegate openCover: sender];
	} 	
	
}

- (void)openAnimation {
	
}




/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	NSLog(@"coverViewController.view loaded");
    [super viewDidLoad];
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Overriden to allow any orientation.
    return YES;
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}


- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
