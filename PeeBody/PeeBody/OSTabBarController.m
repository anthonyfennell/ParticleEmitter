//
//  OSTabBarController.m
//  PeeBody
//
//  Created by Anthony Michael Fennell on 6/5/15.
//  Copyright (c) 2015 Outside Source Design. All rights reserved.
//

#import "OSTabBarController.h"

@interface OSTabBarController () {
    UIView *tabBarView;
    UIView *contentView;
}

@end

@implementation OSTabBarController

- (instancetype)init {
    if (self = [super init]) {
        _tabBar = [[OSTabBar alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _tabBar.frame = CGRectMake(0, 0, self.view.bounds.size.width, _tabBar.tabBarHeight);
    _tabBar.delegate = self;
    
    contentView = [[UIView alloc] initWithFrame:CGRectMake(0, _tabBar.tabBarHeight, self.view.bounds.size.width, self.view.bounds.size.height - _tabBar.tabBarHeight)];
    contentView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeRight)];
    [swipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
    [self.view addGestureRecognizer:swipeRight];
    
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeLeft)];
    [swipeLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
    [self.view addGestureRecognizer:swipeLeft];
    
    [self.view addSubview:_tabBar];
    [self.view addSubview:contentView];
}




#pragma mark - Setters
- (void)setViewControllers:(NSArray *)viewControllers {
    if (_viewControllers != viewControllers) {
        _viewControllers = viewControllers;
        UIViewController *viewController = [self.viewControllers firstObject];
        [self addViewController:viewController toView:contentView];
        _selectedIndex = 0;
        
        NSMutableArray *items = [NSMutableArray new];
        for (UIViewController *viewController in viewControllers) {
            [items addObject:viewController.tabBarItem];
        }
        [_tabBar setItems:items];
    }
}








#pragma mark - Methods
-(void)addViewController:(UIViewController*)viewController toView:(UIView*)view
{
    [self addChildViewController:viewController];       // 1
    viewController.view.frame = view.bounds;            // 2
    [view addSubview:viewController.view];
    [viewController didMoveToParentViewController:self];// 3
}

- (void)removeViewController:(UIViewController*)viewController
{
    [viewController willMoveToParentViewController:nil];// 1
    [viewController.view removeFromSuperview];          // 2
    [viewController removeFromParentViewController];    // 3
}

- (void)showViewControllerAtIndex:(NSInteger)index
{
    if (index != self.selectedIndex) {
        [self removeViewController:[self.viewControllers objectAtIndex:self.selectedIndex]];
        [self addViewController:[self.viewControllers objectAtIndex:index] toView:contentView];
        self.selectedIndex = index;
    }
}




#pragma mark - Handlers
- (void)handleSwipeRight {
    if (self.selectedIndex != 0) {
        [self showViewControllerAtIndex:self.selectedIndex - 1];
    } else {
        [self showViewControllerAtIndex:self.viewControllers.count - 1];
    }
}

- (void)handleSwipeLeft {
    if (self.selectedIndex != self.viewControllers.count - 1) {
        [self showViewControllerAtIndex:self.selectedIndex + 1];
    } else {
        [self showViewControllerAtIndex:0];
    }
}



#pragma mark - OSTabBarDelegate
- (void)tabBar:(OSTabBar *)tabBar didSelectItem:(UITabBarItem *)item atIndex:(NSInteger)index {
    [self showViewControllerAtIndex:index];
}

@end













