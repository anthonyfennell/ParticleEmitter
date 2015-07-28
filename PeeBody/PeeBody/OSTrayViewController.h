//
//  OSTrayViewController.h
//  OSKit
//
//  Created by Brody Robertson on 5/4/14.
//  Copyright (c) 2014 Outside Source Design. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum OSTrayViewSide : NSUInteger {
    OSTrayViewLeftSide,
    OSTrayViewRightSide,
    OSTrayViewTopSide,
    OSTrayViewBottomSide
}OSTrayViewSide;

@interface OSTrayViewController : UIViewController

@property (nonatomic) OSTrayViewSide traySide;
@property (nonatomic) NSInteger menuY;
@property (nonatomic) NSInteger menuWidth;
@property (nonatomic) NSInteger menuHeight;
@property (nonatomic) CGFloat menuAnimationDuration;

@property (nonatomic, readonly) BOOL isMenuViewVisible;
@property (nonatomic) BOOL shouldResizeContentView;
@property (nonatomic) BOOL shouldDisplayButton;

@property (nonatomic, strong) IBOutlet UIViewController *menuViewController;
@property (nonatomic, strong) IBOutlet UIViewController *contentViewController;
@property (nonatomic, strong) IBOutlet UIView *buttonView;

@property (nonatomic, readonly) IBOutlet UIView *menuView;
@property (nonatomic, readonly) IBOutlet UIView *contentView;

/// Designated initializer
- (instancetype)initWithTraySide:(OSTrayViewSide)traySide;

-(void)showHideMenuViewController;
-(void)showMenuViewController;
-(void)hideMenuViewController;

@end
