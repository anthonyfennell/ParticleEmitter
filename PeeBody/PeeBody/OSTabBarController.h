//
//  OSTabBarControllerViewController.h
//  PeeBody
//
//  Created by Anthony Michael Fennell on 6/5/15.
//  Copyright (c) 2015 Outside Source Design. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OSTabBar.h"

/*!
 UITabBarController manages a button bar and transition view, for an application with multiple top-level modes.
 
 To use in your application, add its view to the view hierarchy, then add top-level view controllers in order.
 Most clients will not need to subclass UITabBarController.
 
 If more than five view controllers are added to a tab bar controller, only the first four will display.
 The rest will be accessible under an automatically generated More item.
 
 UITabBarController is rotatable if all of its view controllers are rotatable.
 */

@class UIView, UIImage, UINavigationController, UITabBarItem;
@class OSTabBar;
@protocol OSTabBarControllerDelegate;

@interface OSTabBarController : UIViewController <OSTabBarDelegate, NSCoding>

@property(nonatomic,copy) NSArray *viewControllers;
// If the number of view controllers is greater than the number displayable by a tab bar, a "More" navigation controller will automatically be shown.
// The "More" navigation controller will not be returned by -viewControllers, but it may be returned by -selectedViewController.
- (void)setViewControllers:(NSArray *)viewControllers animated:(BOOL)animated;

@property(nonatomic,assign) UIViewController *selectedViewController; // This may return the "More" navigation controller if it exists.
@property(nonatomic) NSUInteger selectedIndex;

@property(nonatomic,readonly) OSTabBar *tabBar NS_AVAILABLE_IOS(3_0); // Provided for -[UIActionSheet showFromTabBar:]. Attempting to modify the contents of the tab bar directly will throw an exception.

@property(nonatomic,assign) id<OSTabBarControllerDelegate> delegate;

@end

@protocol OSTabBarControllerDelegate <NSObject>
@optional
- (BOOL)tabBarController:(OSTabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController NS_AVAILABLE_IOS(3_0);
- (void)tabBarController:(OSTabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController;

@end
