//
//  OSTabBar.h
//  PeeBody
//
//  Created by Anthony Michael Fennell on 6/5/15.
//  Copyright (c) 2015 Outside Source Design. All rights reserved.
//

#import <UIKit/UIKit.h>

@class OSTabBar;

@protocol OSTabBarDelegate<NSObject>
@optional
- (void)tabBar:(OSTabBar *)tabBar didSelectItem:(UITabBarItem *)item atIndex:(NSInteger)index;
@end




@interface OSTabBar : UIView

@property(nonatomic,assign) id<OSTabBarDelegate> delegate;
@property(nonatomic,copy)   NSArray             *items;        // get/set visible UITabBarItems. default is nil. changes not animated. shown in order
@property(nonatomic,assign) UITabBarItem        *selectedItem; // will show feedback based on mode. default is nil
@property(nonatomic,assign) Class buttonClass;

@property(nonatomic,retain) UIColor *tintColor NS_AVAILABLE_IOS(5_0);
@property(nonatomic,retain) UIColor *barTintColor NS_AVAILABLE_IOS(7_0) UI_APPEARANCE_SELECTOR;  // default is nil
@property(nonatomic,retain) UIColor *selectedImageTintColor NS_DEPRECATED_IOS(5_0,8_0,"Use tintColor") UI_APPEARANCE_SELECTOR;

/* The background image will be tiled to fit, even if it was not created via the UIImage resizableImage methods.
 */
@property(nonatomic,retain) UIImage *backgroundImage NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR;

/* The selection indicator image is drawn on top of the tab bar, behind the bar item icon.
 */
@property(nonatomic) UITabBarItemPositioning itemPositioning NS_AVAILABLE_IOS(7_0) UI_APPEARANCE_SELECTOR;

/*
 Set the itemWidth to a positive value to be used as the width for tab bar items
 when they are positioned as a centered group (as opposed to filling the tab bar).
 Default of 0 or values less than 0 will be interpreted as a system-defined width.
 */
@property(nonatomic) CGFloat itemWidth NS_AVAILABLE_IOS(7_0) UI_APPEARANCE_SELECTOR;

/*
 Set the itemSpacing to a positive value to be used between tab bar items
 when they are positioned as a centered group.
 Default of 0 or values less than 0 will be interpreted as a system-defined spacing.
 */
@property(nonatomic) CGFloat itemSpacing NS_AVAILABLE_IOS(7_0) UI_APPEARANCE_SELECTOR;
@property(nonatomic) NSInteger tabBarHeight;
/*
 Valid bar styles are UIBarStyleDefault (default) and UIBarStyleBlack.
 */
@property(nonatomic) UIBarStyle barStyle NS_AVAILABLE_IOS(7_0) UI_APPEARANCE_SELECTOR;

/*
 Default is YES.
 You may force an opaque background by setting the property to NO.
 If the tab bar has a custom background image, the default is inferred from the alpha
 values of the image—YES if it has any pixel with alpha < 1.0
 If you send setTranslucent:YES to a tab bar with an opaque custom background image
 the tab bar will apply a system opacity less than 1.0 to the image.
 If you send setTranslucent:NO to a tab bar with a translucent custom background image
 the tab bar will provide an opaque background for the image using the bar's barTintColor if defined, or black
 for UIBarStyleBlack or white for UIBarStyleDefault if barTintColor is nil.
 */
@property(nonatomic,getter=isTranslucent) BOOL translucent NS_AVAILABLE_IOS(7_0);
@end
