//
//  DWFParticleView.m
//  PeeBody
//
//  Created by Anthony Michael Fennell on 7/27/15.
//  Copyright (c) 2015 Outside Source Design. All rights reserved.
//

#import "DWFParticleView.h"
#import <QuartzCore/QuartzCore.h>
#import <QuartzCore/CoreAnimation.h>



@implementation DWFParticleView
{
    CAEmitterLayer *fireEmitter;
    NSNumber *fireworkVelocity;
    NSNumber *fireworkRange;
    NSNumber *fireworkVelocityRange;
    NSNumber *fireworkGravity;
    BOOL showFire;
    float fireBirthRate;
    float rocketBirthRate;
    EmitCell editCell;
    
    CAEmitterCell *smoke;
    CAEmitterCell *fire2;
    CAEmitterCell *fire3;
    CAEmitterCell *fire4;
}

- (void)awakeFromNib
{
    editCell = EmitCellSmoke;
    // set ref to the layer
    fireEmitter = (CAEmitterLayer*)self.layer;
    
    //configure the emitter layer
    fireEmitter.emitterPosition = CGPointMake(50, 100);
    // Specifies the center of the particle shape along the z-axis
    fireEmitter.emitterZPosition = 0;
    // Emitter shapes: Point, Line, Rectangle, Cuboid, Circle, Sphere
    fireEmitter.emitterShape = kCAEmitterLayerPoint;
    fireEmitter.emitterSize = CGSizeMake(50.0f, 50.0f);
    // Defines how the particle cells are rendered into the layer
    // Points, Outline, Surface, Volume
    fireEmitter.renderMode = kCAEmitterLayerOldestLast;
    // Emitter modes: Points, Outline, Surface, Volume
    fireEmitter.emitterMode = kCAEmitterLayerAdditive;
    // Defines whether the layer flattens the particles into its pane.
    fireEmitter.preservesDepth = YES;
    
    smoke = [CAEmitterCell emitterCell];
    smoke.birthRate = 10;
    smoke.lifetime = 6.0;
    smoke.lifetimeRange = 2.0;
    smoke.color = [[UIColor colorWithWhite:0.75 alpha:0.1] CGColor];
    smoke.contents = (id)[[UIImage imageNamed:@"fireTexture3"] CGImage];
    smoke.velocity = 12;
    smoke.velocityRange = 5;
    smoke.yAcceleration = -15;
    smoke.xAcceleration = 4;
    smoke.emissionRange = M_PI_2;
    smoke.scaleSpeed = 0.2;
    smoke.spin = 1.0;
    smoke.scale = 0.3;
    [smoke setName:@"smoke"];
    
    fire2 = [CAEmitterCell emitterCell];
    fire2.birthRate = 40;
    fire2.lifetime = 1.5;
    fire2.lifetimeRange = 0.7;
    fire2.color = [[UIColor colorWithRed:0.8 green:0.4 blue:0.2 alpha:0.1] CGColor];
    fire2.contents = (id)[[UIImage imageNamed:@"fireTexture2"] CGImage];
    fire2.velocity = 26;
    fire2.velocityRange = 10;
    fire2.yAcceleration = -25;
    fire2.xAcceleration = 5;
    fire2.emissionRange = M_PI_2;
    fire2.scaleSpeed = 0.1;
    fire2.spin = 0.1;
    fire2.scale = 0.3;
    
    [fire2 setName:@"fire2"];
    
    fire3 = [CAEmitterCell emitterCell];
    fire3.birthRate = 30;
    fire3.lifetime = 1.5;
    fire3.lifetimeRange = 0.7;
    fire3.color = [[UIColor colorWithRed:0.8 green:0.4 blue:0.2 alpha:0.1] CGColor];
    fire3.contents = (id)[[UIImage imageNamed:@"fireTexture4"] CGImage];
    fire3.velocity = 26;
    fire3.velocityRange = 10;
    fire3.yAcceleration = -25;
    fire3.xAcceleration = 5;
    fire3.emissionRange = M_PI_2;
    fire3.scaleSpeed = 0.1;
    fire3.spin = 0.1;
    fire3.scale = 0.3;
    
    [fire3 setName:@"fire3"];
    
    fire4 = [CAEmitterCell emitterCell];
    fire4.birthRate = 20;
    fire4.lifetime = 1.5;
    fire4.lifetimeRange = 0.7;
    fire4.color = [[UIColor colorWithRed:0.8 green:0.4 blue:0.2 alpha:0.1] CGColor];
    fire4.contents = (id)[[UIImage imageNamed:@"fireTexture3"] CGImage];
    fire4.velocity = 12;
    fire4.velocityRange = 10;
    fire4.yAcceleration = -25;
    fire4.xAcceleration = 5;
    fire4.emissionRange = M_PI_2;
    fire4.scale = 0.1;
    fire4.spin = 0.1;
    fire4.scale = 0.3;
    
    [fire4 setName:@"fire4"];
    self.selectedCell = smoke;
//    preSpark.emitterCells = @[spark];
//    rocket.emitterCells = @[flare, firework, preSpark];
    
    //add the cell to the layer and we're done
    fireEmitter.emitterCells = @[smoke, fire2, fire3, fire4];
}

+ (Class)layerClass
{
    //configure the UIView to have emitter layer
    return [CAEmitterLayer class];
}



#pragma mark - Public methods

- (void)setEmitterPositionFromTouch:(UITouch *)t
{
    //change the emitter's position
    fireEmitter.emitterPosition = [t locationInView:self];
}

- (void)burnDownLine
{
    int x = self.frame.size.width / 2.0;
    CABasicAnimation *ba = [CABasicAnimation animationWithKeyPath:@"emitterPosition"];
    ba.fromValue = [NSValue valueWithCGPoint:CGPointMake(x, 0)];
    ba.toValue = [NSValue valueWithCGPoint:CGPointMake(x, self.frame.size.height - 50)];
    ba.duration = 3;
    ba.beginTime = CACurrentMediaTime();
    [fireEmitter addAnimation:ba forKey:nil];
    
    
    CABasicAnimation *ba2 = [CABasicAnimation animationWithKeyPath:@"emitterPosition2"];
    ba2.fromValue = [NSValue valueWithCGPoint:CGPointMake(x, self.frame.size.height - 50)];
    ba2.toValue = [NSValue valueWithCGPoint:CGPointMake(x, 0)];
    ba2.duration = 3;
    ba2.beginTime = CACurrentMediaTime() + 3;
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = [NSArray arrayWithObject:ba];
    group.duration = 6;
    
    [fireEmitter addAnimation:group forKey:nil];
}



- (void)setIsEmitting:(BOOL)isEmitting
{
    // turn on/off the emitting of particles
    //[fireEmitter setValue:[NSNumber numberWithInt:isEmitting?200:0] forKeyPath:@"emitterCells.fire.birthRate"];
    //[fireEmitter setValue:[NSNumber numberWithInt:isEmitting?100:0] forKeyPath:@"emitterCells.fire2.birthRate"];
//    [fireEmitter setValue:[NSNumber numberWithInt:isEmitting?200:0] forKeyPath:@"emitterCells.firework.birthRate"];
//
//    
//    [fireEmitter setValue:[NSNumber numberWithFloat:[fireworkRange floatValue] * M_PI / 4]
//          forKeyPath:@"emitterCells.firework.emissionRange"];
//    
//    [fireEmitter setValue:[NSNumber numberWithFloat:[fireworkVelocity floatValue]]
//          forKeyPath:@"emitterCells.firework.velocity"];
//    
//    [fireEmitter setValue:[NSNumber numberWithFloat:[fireworkVelocityRange floatValue]]
//          forKeyPath:@"emitterCells.firework.velocityRange"];
//    
//    [fireEmitter setValue:[NSNumber numberWithFloat:(-1 * [fireworkGravity floatValue])]
//          forKeyPath:@"emitterCells.firework.yAcceleration"];
}

- (NSString *)emitterCellString
{
    NSString *cell;
    switch (editCell) {
        case EmitCellSmoke:
            cell = @"smoke";
            break;
        case EmitCellTwo:
            cell = @"fire2";
            break;
        case EmitCellThree:
            cell = @"fire3";
            break;
        case EmitCellFour:
            cell = @"fire4";
            break;
        default:
            break;
    }
    
    return cell;
}

- (void)setSpin:(float)v
{
    
    [fireEmitter setValue:[NSNumber numberWithFloat:v]
            forKeyPath:[NSString stringWithFormat:@"emitterCells.%@.spin", [self emitterCellString]]];
}

- (void)setYAccel:(float)v
{
    [fireEmitter setValue:[NSNumber numberWithFloat:v]
               forKeyPath:[NSString stringWithFormat:@"emitterCells.%@.yAcceleration", [self emitterCellString]]];
}

- (void)setEmissionRange:(float)v
{
    [fireEmitter setValue:[NSNumber numberWithFloat:v * M_PI_4]
               forKeyPath:[NSString stringWithFormat:@"emitterCells.%@.emissionRange", [self emitterCellString]]];
}

- (void)setVelocity:(float)v
{
    [fireEmitter setValue:[NSNumber numberWithFloat:v]
               forKeyPath:[NSString stringWithFormat:@"emitterCells.%@.velocity", [self emitterCellString]]];
}

- (void)setBirthRate:(float)v
{
    [fireEmitter setValue:[NSNumber numberWithFloat:v]
                forKeyPath:[NSString stringWithFormat:@"emitterCells.%@.birthRate", [self emitterCellString]]];
}

- (void)setScaleSpeed:(float)v
{
    [fireEmitter setValue:[NSNumber numberWithFloat:v]
               forKeyPath:[NSString stringWithFormat:@"emitterCells.%@.scaleSpeed", [self emitterCellString]]];
}

- (void)setLifetime:(float)v
{
    [fireEmitter setValue:[NSNumber numberWithFloat:v]
               forKeyPath:[NSString stringWithFormat:@"emitterCells.%@.lifetime", [self emitterCellString]]];
}

- (void)setVelocityRange:(float)v
{
    [fireEmitter setValue:[NSNumber numberWithFloat:v]
               forKeyPath:[NSString stringWithFormat:@"emitterCells.%@.velocityRange", [self emitterCellString]]];
}

- (void)setScale:(float)v
{
    [fireEmitter setValue:[NSNumber numberWithFloat:v]
               forKeyPath:[NSString stringWithFormat:@"emitterCells.%@.scale", [self emitterCellString]]];
}

- (void)setLifetimeRange:(float)v
{
    [fireEmitter setValue:[NSNumber numberWithFloat:v]
               forKeyPath:[NSString stringWithFormat:@"emitterCells.%@.lifetimeRange", [self emitterCellString]]];
}

- (void)setXAccel:(float)v
{
    [fireEmitter setValue:[NSNumber numberWithFloat:v]
               forKeyPath:[NSString stringWithFormat:@"emitterCells.%@.xAcceleration", [self emitterCellString]]];
}

- (void)setZAccel:(float)v
{
    [fireEmitter setValue:[NSNumber numberWithFloat:v]
               forKeyPath:[NSString stringWithFormat:@"emitterCells.%@.zAcceleration", [self emitterCellString]]];
}





/* Edit the emitter cell */

- (void)setEmitterMode:(DWFMode)mode
{
    switch (mode) {
        case DWFModePoints:
            fireEmitter.emitterMode = kCAEmitterLayerPoints;
            break;
        case DWFModeOutline:
            fireEmitter.emitterMode = kCAEmitterLayerOutline;
            break;
        case DWFModeSurface:
            fireEmitter.emitterMode = kCAEmitterLayerSurface;
            break;
        case DWFModeVolume:
            fireEmitter.emitterMode = kCAEmitterLayerVolume;
            break;
        default:
            break;
    }
}

- (void)setRenderMode:(DWFRenderMode)mode
{
    switch (mode) {
        case DWFRenderModeUndordered:
            [fireEmitter setRenderMode:kCAEmitterLayerUnordered];
            break;
        case DWFRenderModeOldestFirst:
            [fireEmitter setRenderMode:kCAEmitterLayerOldestFirst];
            break;
        case DWFRenderModeOldestLast:
            [fireEmitter setRenderMode:kCAEmitterLayerOldestLast];
            break;
        case DWFRenderModeBackToFront:
            [fireEmitter setRenderMode:kCAEmitterLayerBackToFront];
            break;
        case DWFRenderModeAdditive:
            [fireEmitter setRenderMode:kCAEmitterLayerAdditive];
            break;
        default:
            break;
    }
}

- (void)setShape:(DWFShape)shape
{
    switch (shape) {
        case DWFShapePoint:
            [fireEmitter setEmitterShape:kCAEmitterLayerPoint];
            break;
        case DWFShapeLine:
            [fireEmitter setEmitterShape:kCAEmitterLayerLine];
            break;
        case DWFShapeRectangle:
            [fireEmitter setEmitterShape:kCAEmitterLayerRectangle];
            break;
        case DWFShapeCuboid:
            [fireEmitter setEmitterShape:kCAEmitterLayerCuboid];
            break;
        case DWFShapeCircle:
            [fireEmitter setEmitterShape:kCAEmitterLayerCircle];
            break;
        case DWFShapeSphere:
            [fireEmitter setEmitterShape:kCAEmitterLayerSphere];
            break;
        default:
            break;
    }
}

- (void)selectEmitterCell:(EmitCell)cell
{
    switch (cell) {
        case EmitCellSmoke:
            editCell = EmitCellSmoke;
            self.selectedCell = smoke;
            break;
        case EmitCellTwo:
            editCell = EmitCellTwo;
            self.selectedCell = fire2;
            break;
        case EmitCellThree:
            editCell = EmitCellThree;
            self.selectedCell = fire3;
            break;
        case EmitCellFour:
            editCell = EmitCellFour;
            self.selectedCell = fire4;
            break;
        default:
            break;
    }
}

@end


























