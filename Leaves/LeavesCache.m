//
//  LeavesCache.m
//  Reader
//
//  Created by Tom Brow on 5/12/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

//#define LogImageData(domain, level, width, height, data)	LogImageDataF(__FILE__,__LINE__,__FUNCTION__,domain,level,width,height,data)

//#define LogMessage(domain, level, ...)	LogMessageF(__FILE__,__LINE__,__FUNCTION__,domain,level,__VA_ARGS__)


#import "LeavesCache.h"


@implementation LeavesCache

@synthesize dataSource, pageSize;

- (id) initWithPageSize:(CGSize)aPageSize
{
	if ([super init]) {
		pageSize = aPageSize;
		pageCache = [[NSMutableDictionary alloc] init];
	}
	return self;
}

- (void) dealloc
{
	[pageCache release];
	[super dealloc];
}



- (CGImageRef) imageForPageIndex:(NSString *)pageIndex {
	CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
	CGContextRef context = CGBitmapContextCreate(NULL, 
												 pageSize.width, 
												 pageSize.height, 
												 8,						/* bits per component*/
												 pageSize.width * 4, 	/* bytes per row */
												 colorSpace, 
												 kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
	CGColorSpaceRelease(colorSpace);
	CGContextClipToRect(context, CGRectMake(0, 0, pageSize.width, pageSize.height));
	
	[dataSource renderPageAtIndex: pageIndex inContext:context];
	
	CGImageRef image = CGBitmapContextCreateImage(context);
	CGContextRelease(context);
	
	LogImageData(@"leaves Cache", 2, 1024, 768, UIImagePNGRepresentation([UIImage imageWithCGImage:image]));

	
	CGImageRelease(image);
	
	return image;
}

- (CGImageRef) cachedImageForPageIndex:(NSString *)pageIndex {
		//NSNumber *pageIndexNumber = [NSNumber numberWithInt:pageIndex];
	UIImage *pageImage;
	@synchronized (pageCache) {
		pageImage = [pageCache objectForKey:pageIndex];
	}
	if (!pageImage) {
		CGImageRef pageCGImage = [self imageForPageIndex:pageIndex];
		pageImage = [UIImage imageWithCGImage:pageCGImage];
		@synchronized (pageCache) {
			[pageCache setObject:pageImage forKey:pageIndex];
		}
	}
	return pageImage.CGImage;
}

- (void) precacheImageForPageIndexNumber:(NSString *)pageIndex {
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	[self cachedImageForPageIndex: pageIndex];
	[pool release];
}

- (void) precacheImageForPageIndex:(NSString *)pageIndex {
	[self performSelectorInBackground: @selector(precacheImageForPageIndexNumber:)
						   withObject: pageIndex];
}

- (void) minimizeToPageIndex:(NSString *)pageIndex viewMode:(LeavesViewMode)viewMode {
	/* Uncache all pages except previous, current, and next. */
	@synchronized (pageCache) {
        int cutoffValueFromPageIndex = 2;
        if (viewMode == LeavesViewModeFacingPages) {
            cutoffValueFromPageIndex = 3;
        }
		for (NSString *key in [pageCache allKeys])
			if (ABS([key intValue] - (int)pageIndex) > cutoffValueFromPageIndex)
				[pageCache removeObjectForKey:key];
	}
}

- (void) flush {
	@synchronized (pageCache) {
		[pageCache removeAllObjects];
	}
}

#pragma mark accessors

- (void) setPageSize:(CGSize)value {
	pageSize = value;
	[self flush];
}

@end
