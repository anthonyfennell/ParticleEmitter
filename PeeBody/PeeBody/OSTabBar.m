//
//  OSTabBar.m
//  PeeBody
//
//  Created by Anthony Michael Fennell on 6/5/15.
//  Copyright (c) 2015 Outside Source Design. All rights reserved.
//

#import "OSTabBar.h"
#import "UIImage+Utils.h"
#import "SBTabBarButton.h"

@implementation OSTabBar {
    struct {
        unsigned int didSelectItem:1;
    }delegateRespondsTo;
    
    NSInteger selectedIndex;
    NSArray *tabBarButtons;
    
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.buttonClass = [UIButton class];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    NSMutableArray *buttons = [[NSMutableArray alloc] init];
    
    NSInteger buttonCount = [self.items count];

    //Assuming the buttons are centered
    float margin = (self.bounds.size.width - buttonCount * _itemWidth - (buttonCount - 1) * _itemSpacing) / 2.0;
    float x = margin;
    float y = 0.0;
    
    for (int i = 0; i < buttonCount; i++) {
        UITabBarItem *tabBarItem = [_items objectAtIndex:i];
        UIButton *button = [[_buttonClass alloc] initWithFrame:CGRectMake(x, y, _itemWidth, _tabBarHeight)];
        //button = [[UIButton alloc] initWithFrame:CGRectMake(x, y, _itemWidth, _tabBarHeight)];
        button.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin;
        [button setTitle:tabBarItem.title forState:UIControlStateNormal];
        [button setTitleColor:_tintColor  forState:UIControlStateNormal];
        [button setTitleColor:_barTintColor forState:UIControlStateSelected];
        [button setBackgroundImage:[UIImage imageWithColor:_tintColor] forState:UIControlStateSelected];
        [button setBackgroundImage:[UIImage imageWithColor:_barTintColor] forState:UIControlStateNormal];
        button.titleLabel.numberOfLines = 1;
        [button.titleLabel setFont:[UIFont systemFontOfSize:12]];

        
        button.tintColor = _barTintColor;
        [button setImage:tabBarItem.image forState:UIControlStateNormal];
        UIImage *selectedImage = [tabBarItem.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        [button setImage:selectedImage forState:UIControlStateSelected];
        
        button.tag = i;
        [button addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        x += _itemWidth + _itemSpacing;
        [buttons addObject:button];
    }
    tabBarButtons = buttons;
    
    UIButton *selectedButton = [tabBarButtons firstObject];
    [selectedButton setSelected:YES];
    selectedIndex = 0;
    
    [self setBackgroundColor:_barTintColor];
}







#pragma mark - Setters
- (void)setDelegate:(id<OSTabBarDelegate>)delegate {
    if (_delegate != delegate) {
        _delegate = delegate;
        delegateRespondsTo.didSelectItem = [delegate respondsToSelector:@selector(tabBar:didSelectItem:atIndex:)];
    }
}

- (void)setItems:(NSArray *)items {
    if (_items != items) {
        _items = [items copy];
    }
}

- (void)setSelectedItem:(UITabBarItem *)selectedItem {
    if (self.selectedItem != selectedItem) {
        UIButton *buttonDeselect = [tabBarButtons objectAtIndex:selectedIndex];
        [buttonDeselect setSelected:NO];
        
        NSInteger nextSelected = [self.items indexOfObject:selectedItem];
        UIButton *buttonSelect = [tabBarButtons objectAtIndex:nextSelected];
        [buttonSelect setSelected:YES];
        selectedIndex = nextSelected;
    }
}

//- (void)setButtonClass:(__unsafe_unretained Class *)buttonClass {
//    _buttonClass = buttonClass;
//}




#pragma mark - Get get getters
- (UITabBarItem *)selectedItem {
    return [self.items objectAtIndex:selectedIndex];
}


#pragma mark - Tab Button Taps
- (IBAction)buttonTapped:(id)sender {
    if (delegateRespondsTo.didSelectItem) {
        UIButton *button = (UIButton *)sender;
        UITabBarItem *item = _items[button.tag];
        [self setSelectedItem:item];
        [self.delegate tabBar:self didSelectItem:item atIndex:button.tag];
    }
}


@end










