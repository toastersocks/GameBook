//
//  LeavesCache.h
//  Reader
//
//  Created by Tom Brow on 5/12/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LeavesView.h"


@protocol LeavesViewDataSource;

@interface LeavesCache : NSObject {
	NSMutableDictionary *pageCache;
	id<LeavesViewDataSource> dataSource;
	CGSize pageSize;
}

@property (nonatomic, assign) CGSize pageSize;
@property (assign) id<LeavesViewDataSource> dataSource;

- (id) initWithPageSize:(CGSize)aPageSize;
- (CGImageRef) cachedImageForPageIndex:(NSString *)pageIndex;
- (void) precacheImageForPageIndex:(NSString *)pageIndex;
- (void) minimizeToPageIndex:(NSString *)pageIndex viewMode:(LeavesViewMode)viewMode;
- (void) flush;

@end
