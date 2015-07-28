//
//  UIImage+Utils.m
//  OSKit
//
//  Created by Brody Robertson on 1/27/14.
//  Copyright (c) 2014 Outside Source Design. All rights reserved.
//

#import "UIImage+Utils.h"

@implementation UIImage (Utils)

+(id)imageWithColor:(UIColor *)color{
    
    return [UIImage imageWithColor:color size:CGSizeMake(1, 1)];
    
}

+(id)imageWithColor:(UIColor *)color size:(CGSize)size{
    
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
    
}


@end
