//
//  PageContents.m
//  GameBook
//
//  Created by James Pamplona on 10/7/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//


#import "SectionContents.h"
#import "RegexKitLite.h"
//#import "wax/wax.h"

// TODO: Have the images array be an array of UIImages instead of an array of filenames. This would better encapsulate the model so the controller doesn't have to touch the actual files at all. OR maybe not. since a UIImage object might not be able to be displayed by a different front-end view. I'll leave it for now.

@implementation SectionContents

- (id) init {
	if (self = [super init]) {
		
	}
	
	return [self initWithSection: nil];
}

	//better to init with each section and create and release a new instance of pageContents, or create one instance and call a method that returns a dictionary with all the section info?

- (id) initWithSection: (NSString *)section {
	
	Class PageLoader = NSClassFromString(@"PageLoader");
	//id pageLoader = [[PageLoader alloc] initWithSection: @"options-test"];
	id pageLoader = [[PageLoader alloc] init];
	[pageLoader getContentsForSection: @"options-test"];
		//NSLog(@"The pageLoader section options are:\n%@", [pageLoader getOptions]);
	
//	NSLog(@"Parsing page");
//	NSLog(@"\npage is: %@", page);
	
	
	//regexes
	NSString *optionsRegexString =[NSString stringWithString:@"(?is)\\s*\\[Options\\]\\s+(.*?(?=\\s*\\[|\\s*$))"];
	NSString *imageRegexString = [NSString stringWithString: @"(?is)\\s*\\[Images\\]\\s+(.*?(?=\\s*\\[|\\s*$))"];
	// TO DO: modify the mainText regex to capture tab characters after '[Main Text]' so paragraphs can be indented, if desired
		// UITextViews might not display tab characters. perhaps replace tabs with four spaces?
	NSString *mainTextRegexString = [NSString stringWithString: @"(?is)\\s*\\[Main Text\\]\\s+(.*?(?=\\s*\\[|\\s*$))"];									 
	
	//file to parse
	NSString *fileContents = [NSString stringWithContentsOfFile: [[NSBundle mainBundle] pathForResource: section 
																								 ofType:@"txt"] 
													   encoding: NSUTF8StringEncoding 
														  error: NULL];
	
		//NSLog(@"Page contents are:\n%@", fileContents);
	
	//grab the matches
	NSString *optionString = [fileContents stringByMatching: optionsRegexString capture: 1L]; 
	NSString *imageString = [fileContents stringByMatching: imageRegexString capture: 1L];
	self.mainText = [fileContents stringByMatching: mainTextRegexString capture: 1L];

//		NSLog(@"mainTextString is:\n%@", mainText);
//		NSLog(@"optionString is:\n%@", optionString);
//		NSLog(@"imageString is:\n%@", imageString);
	
	
	//split matches into arrays
	
	self.images = [imageString componentsSeparatedByRegex:@"\n"]; // using an array of filenames for self.images

//	NSArray *imageStringArray = [imageString componentsSeparatedByRegex:@"\n"]; // using an array of UIImages for self.images
//	for (NSString *imageName in imageStringArray) {
//		[self.images
//	}
	
	//NSArray * tempOptionsArray = [optionString componentsSeparatedByRegex:@"\n"];
	
	self.options = [NSMutableArray arrayWithCapacity: 1];
	
	for (NSString *optionAndLink in [optionString componentsSeparatedByRegex:@"\n"]) {
			//NSLog(@"Current optionAndLink is: %@", optionAndLink);
			//NSLog(@"%@", [optionAndLink componentsSeparatedByString: @"*"]);
		
		[options addObject: [optionAndLink componentsSeparatedByString: @"*"]];
		
			//NSLog(@"options array so far: %@", [options description]);
	}

//		NSLog(@"The array of images is:\n%@", images);
//		NSLog(@"The array of options is:\n%@", options);
//		NSLog(@"%@", [[options objectAtIndex: 1] class]);
	
	//shouldn't need these retains, but they are getting released by the NSPopAutoreleasePool for some reason and this is the only way to keep them alive until I can figure out what the heck is going on. FIXED--I think. changed properties to retain. Duh 
//	[options retain];
//	[mainText retain];
//	[images retain];

	return self;
	
}
	
- (NSString *) description {
	return [NSString stringWithFormat: @"Main Text:\n%@\nOptions:\n%@\nImages:\n%@", mainText, options, images];
		
	
	
}


- (void) dealloc {
	
	[options release];
	[mainText release];
	[images release];
}

//+ (id) contentsFromPage: (NSString *) page {
//	
//}





@synthesize mainText;
@synthesize images;
@synthesize options;

@end
