//
//  ViewSwitchProtocol.h
//  GameBook
//
//  Created by James Pamplona on 2/2/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol ViewSwitchProtocol <NSObject>
@optional
- (BOOL)shouldRemoveViewOnCompletion;
- (void)didTransitionToView: (UIView *)aView withID: (NSString *)viewID;
- (void)viewController: (UIViewController *)sender willTransitionToView: (UIView *)toView withID: (NSString *)viewID;
- (BOOL)viewController: (UIViewController *)sender shouldTransitionToView: (UIView *)toView withID: (NSString *)viewID;

@end

@protocol ViewSwitchDelegateProtocol <NSObject>
@optional
- (void)didTransitionToView: (UIView *)aView;
- (void)viewController: (UIViewController *)sender willTransitionToView: (UIView *)toView withID: (NSString *)viewID;
- (BOOL)viewController: (UIViewController *)sender shouldTransitionToView: (UIView *)toView withID: (NSString *)viewID;

@end