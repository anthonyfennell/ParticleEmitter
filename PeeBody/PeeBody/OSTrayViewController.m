//
//  OSTrayViewController.m
//  OSKit
//
//  Created by Brody Robertson on 5/4/14.
//  Copyright (c) 2014 Outside Source Design. All rights reserved.
//

#import "OSTrayViewController.h"
#import "UIView+Position.h"

static float kDEFAULT_ANIMATION_DURATION = 0.25;

@interface OSTrayViewController ()

@property (nonatomic) NSInteger overlayX;
@property (nonatomic, strong) UIView *overlayView;

@end

@implementation OSTrayViewController {
    BOOL shouldUseDefaultMenuHeight;
    BOOL shouldUseDefaultMenuWidth;
    BOOL shouldUseDefaultMenuY;
}

@synthesize isMenuViewVisible=_isMenuViewVisible;
@synthesize menuView=_menuView;
@synthesize contentView=_contentView;

#pragma mark - Initialization
-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self){
        [self initializeWithTraySide:OSTrayViewLeftSide];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self initializeWithTraySide:OSTrayViewLeftSide];
    }
    return self;
}

- (instancetype)initWithTraySide:(OSTrayViewSide)traySide {
    if (self = [super init]) {
        [self initializeWithTraySide:traySide];
    }
    return self;
}

- (void)initializeWithTraySide:(OSTrayViewSide)traySide {
    self.menuAnimationDuration = kDEFAULT_ANIMATION_DURATION;
    self.shouldResizeContentView = YES;
    self.traySide = traySide;
    self.shouldDisplayButton = NO;
    shouldUseDefaultMenuY = YES;
    shouldUseDefaultMenuHeight = YES;
    shouldUseDefaultMenuWidth = YES;
    _menuY = -1;
    _menuWidth = -1;
    _menuHeight = -1;
}

-(void)loadView {
    [super loadView];
    
    /* Menu View setup */
    [self setUpMenuParameters];
    
    /* Overlay View setup */
    _overlayView = [[UIView alloc] initWithFrame:self.view.bounds];
    _overlayView.frameWidth = self.view.frameWidth;
    _overlayView.frameHeight = self.view.frameHeight;
    _overlayView.frameX = -_overlayView.frameWidth;
    _overlayView.frameY = self.menuY;
    _overlayView.backgroundColor = [UIColor yellowColor];
    _overlayView.alpha = 0.3;
    _overlayView.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleLeftMargin;
    
    UITapGestureRecognizer * tapRecog = [[UITapGestureRecognizer alloc]
                                         initWithTarget:self action:@selector(handleBackgroundTap:)];
    tapRecog.numberOfTapsRequired = 1;
    [self.overlayView addGestureRecognizer:tapRecog];
    


    
    /* Content View setup */
    _contentView = [[UIView alloc] initWithFrame:self.view.bounds];
    _contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    [self.view addSubview:self.contentView];
    [self.view addSubview:self.overlayView];
    [self.view addSubview:self.menuView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if([self respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)]){
        [self setNeedsStatusBarAppearanceUpdate];
    }
}



- (void)setUpMenuParameters
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        /* Device is iPad */
        if (shouldUseDefaultMenuWidth) {
            if (self.traySide == OSTrayViewLeftSide || self.traySide == OSTrayViewRightSide) {
                _menuWidth = 320;
            } else {
                _menuWidth = self.view.frameWidth;
            }
        }
        if (shouldUseDefaultMenuHeight) {
            if (self.traySide == OSTrayViewLeftSide || self.traySide == OSTrayViewRightSide) {
                _menuHeight = self.view.frameHeight;
            } else {
                _menuHeight = self.view.frameHeight / 2.0;
            }
        }
        if (shouldUseDefaultMenuY)
            _menuY = 64;
        
    } else {
        if (shouldUseDefaultMenuWidth)
            _menuWidth = self.view.frameWidth - 55;
        if (shouldUseDefaultMenuHeight)
            _menuHeight = self.view.frameWidth / 2.0;
        if (shouldUseDefaultMenuY)
            _menuY = 64;
    }
    
    _menuView = [[UIView alloc] initWithFrame:self.view.bounds];
    _menuView.frameWidth = _menuWidth;
    _menuView.frameHeight = _menuHeight - _menuY;
    UISwipeGestureRecognizer * swipeRecog = [[UISwipeGestureRecognizer alloc]
                                             initWithTarget:self action:@selector(handleSwipe:)];
    
    if (self.traySide == OSTrayViewLeftSide)
    {
        _menuView.frameX = -_menuWidth;
        _menuView.frameY = _menuY;

        _menuView.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleHeight;
        
        swipeRecog.direction = UISwipeGestureRecognizerDirectionLeft;
        [self.menuView addGestureRecognizer:swipeRecog];
    } else if (self.traySide == OSTrayViewRightSide)
    {
        _menuView.frameX = self.view.frameWidth;
        _menuView.frameY = _menuY;

        _menuView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleHeight;
        
        swipeRecog.direction = UISwipeGestureRecognizerDirectionRight;
        [self.menuView addGestureRecognizer:swipeRecog];
    } else if (self.traySide == OSTrayViewTopSide)
    {
        _menuView.frameX = 0;
        _menuView.frameY = -_menuView.frameHeight;
        _menuView.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth;

        swipeRecog.direction = UISwipeGestureRecognizerDirectionUp;
        [self.menuView addGestureRecognizer:swipeRecog];
    } else
    {// OSTrayViewBottomSide
        _menuView.frameX = 0;
        _menuView.frameY = self.view.frameHeight;
        _menuView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth;

        swipeRecog.direction = UISwipeGestureRecognizerDirectionDown;
        [self.menuView addGestureRecognizer:swipeRecog];
    }
}

#pragma mark - Preferences
-(BOOL)prefersStatusBarHidden{
    return NO;
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}




#pragma mark - Methods
-(void)addViewController:(UIViewController*)viewController toView:(UIView*)view {
    
    [self addChildViewController:viewController];// 1
    viewController.view.frame = view.bounds;// 2
    [view addSubview:viewController.view];
    [viewController didMoveToParentViewController:self];// 3
    
}

- (void)removeViewController:(UIViewController*)viewController {
    
    [viewController willMoveToParentViewController:nil];// 1
    [viewController.view removeFromSuperview];// 2
    [viewController removeFromParentViewController];// 3
    
}

-(void)showHideMenuViewController {
    
    if(self.isMenuViewVisible){
        [self hideMenuViewController];
    }else{
        [self showMenuViewController];
    }
    
}

-(void)showMenuViewController
{
    _isMenuViewVisible = YES;
    
    [UIView animateWithDuration:self.menuAnimationDuration delay:kDEFAULT_ANIMATION_DURATION options:UIViewAnimationCurveEaseInOut|UIViewAnimationOptionBeginFromCurrentState|UIViewAnimationOptionLayoutSubviews animations:^{
        
        if (self.traySide == OSTrayViewLeftSide)
        {
            self.menuView.frameX = 0;

            if (self.shouldDisplayButton) {
                self.buttonView.frameX = self.menuView.frameWidth;
            }
        } else if (self.traySide == OSTrayViewRightSide)
        {
            self.menuView.frameX = self.view.frameWidth - self.menuView.frameWidth;
            
            if (self.shouldDisplayButton) {
                self.buttonView.frameX = self.view.frameWidth - self.menuView.frameWidth - self.buttonView.frameWidth;
            }
        } else if (self.traySide == OSTrayViewTopSide)
        {
            self.menuView.frameY = self.menuY;
            if (self.shouldDisplayButton) {
                self.buttonView.frameY = self.menuView.frameHeight + self.menuY;
            }
        } else
        { // OSTrayViewBottomSide
            self.menuView.frameY = self.view.frameHeight - self.menuHeight;
            if (self.shouldDisplayButton) {
                self.buttonView.frameY = self.view.frameHeight - self.menuHeight - self.buttonView.frameHeight;
            }
        }
        
        self.overlayView.frameX = 0;
        
        if(self.shouldResizeContentView){
            if (self.traySide == OSTrayViewLeftSide) {
                self.contentView.frameX = _menuWidth;
                self.contentView.frameWidth = self.view.frameWidth - _menuWidth;
            } else if (self.traySide == OSTrayViewRightSide) {
                self.contentView.frameWidth = self.view.frameWidth - _menuWidth;
            } else if (self.traySide == OSTrayViewTopSide) {
                self.contentView.frameY = self.menuY + self.menuView.frameHeight;
                self.contentView.frameHeight = self.view.frameHeight - self.menuY - self.menuView.frameHeight;
            } else {
                self.contentView.frameHeight = self.view.frameHeight - self.menuY - self.menuView.frameHeight;
            }
        }

    } completion:^(BOOL finished) {
        //self.contentView.hidden = YES;
    }];
}

-(void)hideMenuViewController
{
    _isMenuViewVisible = NO;
    
    [UIView animateWithDuration:self.menuAnimationDuration delay:kDEFAULT_ANIMATION_DURATION options:UIViewAnimationCurveEaseInOut|UIViewAnimationOptionBeginFromCurrentState|UIViewAnimationOptionLayoutSubviews animations:^{
        
        if (self.traySide == OSTrayViewLeftSide) {
            self.menuView.frameX = -_menuWidth;

            if (self.shouldDisplayButton) {
                self.buttonView.frameX = 0;
            }
        } else if (self.traySide == OSTrayViewRightSide)
        {
            self.menuView.frameX = self.view.frameWidth;
            
            if (self.shouldDisplayButton) {
                self.buttonView.frameX = self.view.frameWidth - self.buttonView.frameWidth;
            }
        } else if (self.traySide == OSTrayViewTopSide)
        {
            self.menuView.frameY = -self.menuHeight;
            if (self.shouldDisplayButton) {
                self.buttonView.frameY = self.menuY;
            }
        } else
        { // OSTrayViewBottomSide
            self.menuView.frameY = self.view.frameHeight;
            if (self.shouldDisplayButton) {
                self.buttonView.frameY = self.view.frameHeight - self.buttonView.frameHeight;
            }
        }
        
        self.overlayView.frameX = -_overlayView.frameWidth;

        
        if(self.shouldResizeContentView){
            if (self.traySide == OSTrayViewLeftSide) {
                self.contentView.frameX = 0;
                self.contentView.frameWidth = self.view.frameWidth;
            } else if (self.traySide == OSTrayViewRightSide) {
                self.contentView.frameWidth = self.view.frameWidth;
            } else if (self.traySide == OSTrayViewTopSide) {
                self.contentView.frameY = self.menuY;
                self.contentView.frameHeight = self.view.frameHeight - self.menuY;
            } else {
                self.contentView.frameHeight = self.view.frameHeight - self.menuY;
            }
        }
        
    } completion:^(BOOL finished) {
        //self.contentView.hidden = YES;
    }];
}



#pragma mark - Getters / Setters
-(UIView*)menuView {
    if(_menuView == nil){
        [self view];
    }
    return _menuView;
}

-(UIView*)contentView {
    if(_contentView == nil){
        [self view];
    }
    return _contentView;
}

-(void)setMenuViewController:(UIViewController *)menuViewController {
    if(_menuViewController != menuViewController){
        [self removeViewController:_menuViewController];
        _menuViewController = menuViewController;
        [self addViewController:_menuViewController toView:self.menuView];
    }
}

-(void)setContentViewController:(UIViewController *)contentViewController {
    if(_contentViewController != contentViewController){
        [self removeViewController:_contentViewController];
        _contentViewController = contentViewController;
        [self addViewController:_contentViewController toView:self.contentView];
    }
}

- (void)setButtonView:(UIView *)buttonView {
    _buttonView = buttonView;
    
    UITapGestureRecognizer * tapRecog = [[UITapGestureRecognizer alloc]
                                         initWithTarget:self action:@selector(handleButtonTap:)];
    tapRecog.numberOfTapsRequired = 1;
    [_buttonView addGestureRecognizer:tapRecog];
    
    if (self.traySide == OSTrayViewLeftSide)
    {
        self.buttonView.frameX = 0;
        self.buttonView.frameY = (self.view.frameHeight + self.buttonView.frameHeight) / 2.0;
        self.buttonView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin |
        UIViewAutoresizingFlexibleBottomMargin;
    } else if (self.traySide == OSTrayViewRightSide)
    {
        self.buttonView.frameX = self.view.frameWidth - self.buttonView.frameWidth;
        self.buttonView.frameY = (self.view.frameHeight + self.buttonView.frameHeight) / 2.0;
        self.buttonView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin |
        UIViewAutoresizingFlexibleBottomMargin;
    } else if (self.traySide == OSTrayViewTopSide)
    {
        self.buttonView.frameX = (self.view.frameWidth - self.buttonView.frameWidth) / 2.0;
        self.buttonView.frameY = self.menuY;
        self.buttonView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;

    } else
    {// OSTrayViewBottomSide
        self.buttonView.frameX = (self.view.frameWidth - self.buttonView.frameWidth) / 2.0;
        self.buttonView.frameY = self.view.frameHeight - self.buttonView.frameHeight;
        self.buttonView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;

    }
    
    [self.view addSubview:_buttonView];
}


- (void)setMenuHeight:(NSInteger)menuHeight {
    if (_menuHeight != menuHeight) {
        _menuHeight = menuHeight;
        shouldUseDefaultMenuHeight = NO;
    }
}

- (void)setMenuWidth:(NSInteger)menuWidth {
    if (_menuWidth != menuWidth) {
        _menuWidth = menuWidth;
        shouldUseDefaultMenuWidth = NO;
    }
}

- (void)setMenuY:(NSInteger)menuY {
    if (_menuY != menuY) {
        _menuY = menuY;
        shouldUseDefaultMenuY = NO;
    }
}


#pragma mark - Handler Gesture
- (void)handleBackgroundTap:(UITapGestureRecognizer *)sender {
    [self hideMenuViewController];
}

- (void)handleButtonTap:(UITapGestureRecognizer *)sender {
    [self showHideMenuViewController];
}

- (void)handleSwipe:(UISwipeGestureRecognizer *)sender {
    if (self.isMenuViewVisible) {
        [self hideMenuViewController];
    }
}


@end















