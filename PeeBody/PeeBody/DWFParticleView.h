//
//  DWFParticleView.h
//  PeeBody
//
//  Created by Anthony Michael Fennell on 7/27/15.
//  Copyright (c) 2015 Outside Source Design. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM (NSUInteger, DWFMode) {
    DWFModePoints,
    DWFModeOutline,
    DWFModeSurface,
    DWFModeVolume
};

typedef NS_ENUM(NSUInteger, DWFRenderMode) {
    DWFRenderModeUndordered,
    DWFRenderModeOldestFirst,
    DWFRenderModeOldestLast,
    DWFRenderModeBackToFront,
    DWFRenderModeAdditive
};

typedef NS_ENUM (NSUInteger, DWFShape) {
    DWFShapePoint,
    DWFShapeLine,
    DWFShapeRectangle,
    DWFShapeCuboid,
    DWFShapeCircle,
    DWFShapeSphere
};



@interface DWFParticleView : UIView

- (void)setEmitterPositionFromTouch:(UITouch *)t;
- (void)setIsEmitting:(BOOL)isEmitting;

// Rotation velocity in radians/sec
- (void)setSpin:(float)v;
// Y component of acceleration
- (void)setYAccel:(float)v;
// Angle in radians, defining a cone around the emission range
- (void)setEmissionRange:(float)v;
// Initial velocity of cell
- (void)setVelocity:(float)v;
// Number of emitted objects / sec
- (void)setBirthRate:(float)v;
// The speed at which the scale changes over its lifetime
- (void)setScaleSpeed:(float)v;
// Lifetime of cell
- (void)setLifetime:(float)v;
// Amount the velocity can vary
- (void)setVelocityRange:(float)v;
// Scale factor of cell
- (void)setScale:(float)v;
// Amount the lifetime can vary
- (void)setLifetimeRange:(float)v;
// X component of acceleration
- (void)setXAccel:(float)v;
// Z component of acceleration
- (void)setZAccel:(float)v;


- (void)setEmitterMode:(DWFMode)mode;
- (void)setRenderMode:(DWFRenderMode)mode;
- (void)setShape:(DWFShape)shape;

- (void)burnDownLine;

- (void)showFire;
- (void)hideFire;

@end
