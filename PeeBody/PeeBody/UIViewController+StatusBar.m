//
//  UIViewController+StatusBar.m
//  PeeBody
//
//  Created by Anthony Michael Fennell on 6/2/15.
//  Copyright (c) 2015 Outside Source Design. All rights reserved.
//

#import "UIViewController+StatusBar.h"

@implementation UIViewController (StatusBar)

- (void)addStatusBarBackground {
    //for making the background of the UIStatus bar black
    UIView *statusBarView = [[UIView alloc] initWithFrame:CGRectMake(0, -20, [[self view] bounds].size.width, 22)];
    statusBarView.backgroundColor = [UIColor blackColor];
    [self.navigationController.navigationBar addSubview:statusBarView];
}

@end
