//
//  SBTabBarButton.m
//  SBI
//
//  Created by Anthony Michael Fennell on 6/3/15.
//  Copyright (c) 2015 Outside Source Design. All rights reserved.
//

#import "SBTabBarButton.h"

@implementation SBTabBarButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (instancetype)buttonWithType:(UIButtonType)buttonType
{
    SBTabBarButton *button = [super buttonWithType:buttonType];
    button.titleLabel.textAlignment = NSTextAlignmentCenter;
    button.imageView.contentMode = UIViewContentModeCenter;
    
    return button;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.titleLabel.frame = CGRectMake(0, self.frame.size.height/2 + 2, self.frame.size.width, 20);
    //self.titleLabel.frame = CGRectMake(0, self.frame.size.height - 30, self.frame.size.width, 30);
    //self.imageView.frame = self.bounds;
    self.imageView.frame = CGRectMake(self.bounds.size.width/2 - self.imageView.frame.size.width/2, self.bounds.size.height/2 - self.imageView.frame.size.height - 0, self.imageView.frame.size.width, self.imageView.frame.size.height);
//    if(self.selected){
//        
//    }else{
//        
//    }
    
}

@end
