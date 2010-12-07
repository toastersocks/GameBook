//
//  OptionViewController.h
//  GameBook
//
//  Created by James Pamplona on 10/18/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

	//!!!: THIS CLASS IS NOT USED ANYMORE

@interface OptionViewController : NSObject {

	UIView *optionContainer;
	NSArray *options;
}

	//- (void) displayOptions:(NSArray *)options;

@property (retain, nonatomic) IBOutlet UIView *optionContainer;
@property (retain, nonatomic) NSArray *options;

@end
